# Cloud Flare hook bash for dehydrated - DNS-01 Challenge Let's Encrypt
## v 2.3.1

## DNS-01 challenge solved for "pratically" every domain, thanks to Cloudflare and their API.

CloudFlare Bash hook for dehydrated.
This is a hook for Let's Encrypt client [dehydrated](https://github.com/lukas2511/dehydrated) to use with Cloud Flare.

## Why Cloud Flare? What is this script?

You have all (or some) these problems:

+ Your domain registrar doesn't have / dont' want give you API to write automatically new DNS record (for DNS-01 Challenge of Let's Encrypt)
+ Your ISP blocks 80/443 port
+ You cannot open one or both ports (e.g. several routers have management page only on 80 port)
+ Let's Encrypt needs to verify on both (80 and 443) to release / renew certificate

You only need:

1. Register on Cloudflare
2. Change your DNS to manage them in Cloudflare (follow their guide). This ATM is valid also for free user!
3. Run `dehydrated` with this hook.

Finish! Stop! End!

This bash hook will:

1. Contact Let's Encrpyt for DNS-01 challenge (no anymore need forwarded port)
2. Get the record to write in DNS
3. Call Cloudflare API and write record
4. Wait for LE answer
5. Create / renew the certificates

You will have the certificates in the folder of `dehydrated`).

In simple words: you can complete the DNS challenges (dns-01).

## Development
Everyone is welcome to contribute!
Create a `config` file in same folder of `./dehydrated` and put staging inside, to no hit Let's Encrypt limit.
**Warning! Use this ONLY during development, not in production!**

```
CA="https://acme-staging.api.letsencrypt.org/directory"
```

## Require
+ cURL
+ Active account on Cloud Flare (tested with free account)

## Setup
```
cd ~
git clone https://github.com/lukas2511/dehydrated
cd dehydrated
mkdir hooks
cd hooks
git clone https://github.com/sineverba/cfhookbash.git
cd ..
```

Or, in one line

```
cd ~ && git clone https://github.com/lukas2511/dehydrated && cd dehydrated && mkdir hooks && cd hooks && git clone https://github.com/sineverba/cfhookbash.git && cd ..
```


## Configuration

1. Create a file `domains.txt` **in the folder of `dehydrated`**
2. Put inside a list (one for line) of domain that you want secure.

```
www.example.com
home.example.net
...
```

3. Move inside `cfhookbash` folder
4. Copy `config.default.sh` to `config.sh`

```
cd ~/dehydrated/hooks/cfhookbash
cp config.default.sh config.sh && rm config.default.sh && nano config.sh
```

We need to edit `config.default.sh`. To get values for zones, login to your Cloudflare account, section "DNS" of your domain. Click the link API and you will get some example. Zones is the long string 

`POST https://api.cloudflare.com/client/v4/zones/THIS_IS_ZONES/dns_records`

**`global_api_key` is found under your account**

## Usage

### First start: need to accept terms
```
cd ~/dehydrated
./dehydrated --register --accept-terms
```

### Next start
```
./dehydrated -c -t dns-01 -k 'hooks/cfhookbash/hook.sh'
```

You will find the certificates inside `~/dehydrated/certs/www.example.com` (of course the domain name is your).

## Post deploy
You can find in `hook.sh` a recall to another file (`deploy.sh`).
Here you can write different operation to execute **AFTER** every successfull challenge.

There is a stub file `deploy.config.sh`.

Usage:
```
copy deploy.config.sh deploy.sh && rm deploy.config.sh && nano deploy.sh
```

## Cronjob (try renew every monday)

Remember that some action require sudo privilege (start and stop webserver, e.g.).

Best is run as root **in the dehydrated folder of your user**.

To run as cronjob specify full paths

```
sudo crontab -e
0 4 * * 1 cd /home/YOUR_USER/dehydrated && /home/YOUR_USER/dehydrated/dehydrated -c -t dns-01 -k '/home/YOUR_USER/dehydrated/hooks/cfhookbash/hook.sh' >> /home/YOUR_USER/cfhookbash.log
```
Execute every monday at 4AM. After the script execution, create also a log in your home.

## Update
+ Move to folder where script resides (tipically `~/dehydrated/hooks/cfhookbash`
+ Type `git checkout master && git pull`

##### Contributors, credits and bug discovery :)

+ YasharF
+ Ramblurr

Inspired by
+ [https://www.splitbrain.org/blog/2017-08/10-homeassistant_duckdns_letsencrypt](https://www.splitbrain.org/blog/2017-08/10-homeassistant_duckdns_letsencrypt)
+ [https://github.com/kappataumu/letsencrypt-cloudflare-hook](https://github.com/kappataumu/letsencrypt-cloudflare-hook)
