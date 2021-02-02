Cloudflare dns-01 challenge hook bash for dehydrated
====================================================

**If you like this project, or use it, please, star it!**

Cloudflare Bash hook for [dehydrated](https://github.com/lukas2511/dehydrated).

| CI / CD | Status |
| ------- | ------ |
| Travis  | [![Build Status](https://travis-ci.com/sineverba/cfhookbash.svg?branch=master)](https://travis-ci.com/sineverba/cfhookbash) |
| Docker  | [![](https://images.microbadger.com/badges/image/sineverba/cfhookbash.svg)](https://microbadger.com/images/sineverba/cfhookbash "Get your own image badge on microbadger.com") |

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
2. Put inside a list (one for line) of domains that need certificates.

``` shell
www.example.com
home.example.net
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

### Classic mode: Post deploy
You can find in `hook.sh` a recall to another file (`deploy.sh`).
Here you can write different operation to execute **AFTER** every successfull challenge.

There is a stub file `deploy.config.sh`.

Usage:

``` shell
copy deploy.config.sh deploy.sh && rm deploy.config.sh && nano deploy.sh
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

| Error | Body | Solution |
| ----- | ---- | -------- |
| 7003  | `{ "code": 7003, "message": "Could not route to /zones/dns_records, perhaps your object identifier is invalid?" }, { "code": 7000, "message": "No route for that URI" }` | Check your `Zone ID` value. Probably is wrong.
| 1001  | `method_not_allowed` | Install `jq` (`sudo apt install jq`) and upgrade script (`git pull`) |

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

----------------------------------------------------

### Docker mode - beware! Not stable and under development!
+ Make a new dir (e.g. `mkdir -p /home/$USER/cfhookbashdocker`)
+ Create a `certs` folder
+ Create one or more folders with name of domain in `certs` (e.g. `certs/example.com` and `certs/test.example.com`)
+ Create a `config` folder
+ Create a `config.sh` file in `/config/` and fill it (see below how to get data)
+ Create a `domains.txt` file in `/config/` and insert a domain for every line
+ Make a first run in stage mode: create a `config` file under `/config` with this content `CA="https://acme-staging-v02.api.letsencrypt.org/directory"`

Run

``` shell
docker run -it \
  -v ${PWD}/certs:/certs \
  -v ${PWD}/config:/config \
  --name cfhookbash \
  sineverba/cfhookbash:latest
```

+ Certs will be available in `/certs`
+ Docker run a cronjob every minute

-------------------------------------------------------
