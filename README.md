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

You only need:

1. Register on Cloudflare (it works also on free plan)
2. Change your domain DNS to manage them in Cloudflare (follow their guide).
3. Run `dehydrated` with this hook.

You will find the certificates in the folder of `dehydrated`.

### Docker
+ Clone the project
+ Create (if they not exists) two folders: `/docker/app/certs` and `/docker/app/config`
+ Copy config.default.sh in `/docker/app/config/config.sh` and edit it
+ Create a `domains.txt` file in `/app/config`, a domain for every line
+ To **run in production**, delete file "config" under `/app/config`



### Prerequisites

`cfhookbash` has some prerequisites:

+ cURL
+ Active account on Cloudflare (tested with free account)
+ Dehydrated ([follow the instructions on Github](https://github.com/dehydrated-io/dehydrated))

### Setup

``` shell
cd ~
git clone https://github.com/sineverba/cfhookbash.git
```


### Configuration

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

| Value          | Where to find |
| -------------- | ------------- |
| Zone ID        | Main page domain > Right Column > API section |
| Global API Key | Account > My Profile > API Tokens > Api Keys > Global API Key |

### Usage

Make a first run with `CA="https://acme-staging-v02.api.letsencrypt.org/directory"` placed in a `config` file in root directory of `dehydrated`.

``` shell
./dehydrated -c -t dns-01 -k '${PATH_WHERE_YOU_CLONED_CFHOOKBASH}/cfhookbash/hook.sh'
```

You will find the certificates inside `~/dehydrated/certs/[your.domain.name`.

### Post deploy
You can find in `hook.sh` a recall to another file (`deploy.sh`).
Here you can write different operation to execute **AFTER** every successfull challenge.

There is a stub file `deploy.config.sh`.

Usage:

``` shell
copy deploy.config.sh deploy.sh && rm deploy.config.sh && nano deploy.sh
```

### Cronjob

Remember that some action require sudo privilege (start and stop webserver, e.g.).

Best is run as root and running in cronjob specify full paths.

Following script will run every monday at 4AM and will create a log in home folder.

`$ sudo crontab -e`

``` shell
0 4 * * 1 cd /home/YOUR_USER/dehydrated && /home/YOUR_USER/dehydrated/dehydrated -c -t dns-01 -k '/home/YOUR_USER/dehydrated/hooks/cfhookbash/hook.sh' >> /home/YOUR_USER/cfhookbash.log
```

#### Update
+ Move to folder where you downloaded it
+ Type `git checkout master && git pull`

#### Commons error messages

| Error | Body | Solution |
| ----- | ---- | -------- |
| 7003  | `{ "code": 7003, "message": "Could not route to /zones/dns_records, perhaps your object identifier is invalid?" }, { "code": 7000, "message": "No route for that URI" }` | Check your `Zone ID` value. Probably is wrong.

### Contributing
Everyone is welcome to contribute! See `CONTRIBUTING.md`

### Contributors, credits and bug discovery :)

+ YasharF
+ Ramblurr

Inspired by
+ [https://www.splitbrain.org/blog/2017-08/10-homeassistant_duckdns_letsencrypt](https://www.splitbrain.org/blog/2017-08/10-homeassistant_duckdns_letsencrypt)
+ [https://github.com/kappataumu/letsencrypt-Cloudflare-hook](https://github.com/kappataumu/letsencrypt-Cloudflare-hook)
