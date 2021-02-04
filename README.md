Cloudflare dns-01 challenge hook bash for dehydrated
====================================================

| CD / CI   |           |
| --------- | --------- |
| Semaphore CI | [![Build Status](https://sineverba.semaphoreci.com/badges/cfhookbash/branches/master.svg)](https://sineverba.semaphoreci.com/projects/cfhookbash) |

**If you like this project, or use it, please, star it!**

Cloudflare Bash hook for [dehydrated](https://github.com/lukas2511/dehydrated).

For Docker version usage, see [wiki](https://github.com/sineverba/cfhookbash/wiki/Docker-usage)


## Why Cloudflare? What is this script?

If you cannot solve the `HTTP-01` challenge, you need to solve the DNS-01 challenge. [Details here](https://letsencrypt.org/docs/challenge-types/).

With use of Cloudflare API (valid also on free plan!), this script will verify your domain putting a new record with a special token inside DNS zone.
At the end of Let's Encrypt validation, that record will be deleted.

Depends on `jq`: `sudo apt get install -y jq`

You only need:

1. Register on Cloudflare (it works also on free plan)
2. Change your domain DNS to manage them in Cloudflare (follow their guide).
3. Run `dehydrated` with this hook (or run Docker image, see below)

You will find the certificates in the folder of `dehydrated`.



### Classic mode: Prerequisites

`cfhookbash` has some prerequisites:

+ cURL
+ jq
+ Active account on Cloudflare (tested with free account)
+ Dehydrated ([follow the instructions on Github](https://github.com/dehydrated-io/dehydrated))

### Classic mode: Setup

``` shell
cd ~
git clone https://github.com/sineverba/cfhookbash.git
```


### Classic mode: Configuration

1. Create a file `domains.txt` **in the folder of `dehydrated`**
2. Put inside a list of domains that need certificates. Multiple (sub)domains on a single line will end up on a single certificate. 

``` shell
example.com www.example.com
home.example.net *.home.example.net
[...]
```
3. Move to the folder of `cfhookbash`
3. Copy `config.default.sh` to `config.sh`
4. Edit `config.sh`. To get values:

| Value          | Where to find | Deprecated? |
| -------------- | ------------- | ----------- |
| Zone ID        | Main page domain > Right Column > API section | N |
| API Token      | Account > My Profile > API Tokens > Create Token > API token templates > "Edit zone DNS" | N |
| Global API Key | Account > My Profile > API Tokens > Api Keys > Global API Key | Y, from 4.1.0  |

You can choose between using an **API token** and using your **global API key**. It is preferred to create a token, since tokens can be restricted to just the permission to edit DNS records in chosen zones (the `DNS:Edit` permission).

If you choose to use an API token, it must be filled into `api_token`. If you want to use your global API key, instead use `global_api_key` and `email`.

`Global API key` is deprecated and will be removed in future version.

### Classic mode: Usage

Make a first run with `CA="https://acme-staging-v02.api.letsencrypt.org/directory"` placed in a `config` file in root directory of `dehydrated`.

``` shell
./dehydrated -c -t dns-01 -k '${PATH_WHERE_YOU_CLONED_CFHOOKBASH}/cfhookbash/hook.sh'
```

You will find the certificates inside `~/dehydrated/certs/[your.domain.name]`.
If you are using dehydrated with a config file and, you can speed up the requests for certificates with multiple (sub)domains by using `HOOK_CHAIN="yes"`.


### Classic mode: Post deploy
You can find in `hook.sh` a recall to another file (`deploy.sh`).
Here you can write different operation to execute **AFTER** every successfull challenge.

There is a stub file `deploy.config.sh`.

Usage:

``` shell
cp deploy.config.sh deploy.sh && rm deploy.config.sh && nano deploy.sh
```

### Classic mode: Cronjob

Remember that some action require sudo privilege (start and stop webserver, e.g.).

Best is run as root and running in cronjob specify full paths.

Following script will run every monday at 4AM and will create a log in home folder.

`$ sudo crontab -e`

``` shell
0 4 * * 1 cd /home/YOUR_USER/dehydrated && /home/YOUR_USER/dehydrated/dehydrated -c -t dns-01 -k '/home/YOUR_USER/cfhookbash/hook.sh' >> /home/YOUR_USER/cfhookbash.log
```

#### Update / upgrade
+ Move to folder where you downloaded it
+ Type `git checkout master && git pull`

#### Commons error messages

| Error | Solution |
| ----- | -------- |
| Could not route to /zones/dns_records, perhaps your object identifier is invalid? No route for that URI | Check your `Zone ID` value. There probably is something wrong. |
| /home/YOUR_USER/cfhookbash/hook.sh: line XX: jq: command not found | Install `jq` (`sudo apt install jq`) and try again |
| {"code": 1001, "error": "method_not_allowed"} | Update this script by running `git pull` |

### Contributing
Everyone is welcome to contribute! See `CONTRIBUTING.md`

### Contributors, credits and bug discovery :)

+ YasharF
+ Ramblurr
+ Dav999-v
+ fallingcats

Inspired by
+ [https://www.splitbrain.org/blog/2017-08/10-homeassistant_duckdns_letsencrypt](https://www.splitbrain.org/blog/2017-08/10-homeassistant_duckdns_letsencrypt)
+ [https://github.com/kappataumu/letsencrypt-Cloudflare-hook](https://github.com/kappataumu/letsencrypt-Cloudflare-hook)
