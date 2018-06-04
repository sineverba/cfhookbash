# Cloud Flare hook bash for dehydrated - DNS-01 Challenge Let's Encrypt

CloudFlare Bash hook for dehydrated.

This is a hook for Let's Encrypt client [dehydrated](https://github.com/lukas2511/dehydrated) to use with Cloud Flare.

## Why Cloud Flare? What is this scrip?

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
```


## Configuration
```
cd ~/dehydrated/hooks/cfhookbash
nano hook.txt
cp hook.txt hook.sh
chmod 755 hook.sh
nano delete_txt.txt
cp delete_txt.txt delete_txt.sh
chmod 755 delete_txt.sh
```

## Usage

### First start: need to accept terms
```
cd ~/dehydrated
./dehydrated --register --accept-terms
```

### Next start
```
./dehydrated -c -d www.example.com -t dns-01 -k 'hooks/cfhookbash/hook.sh'
```

To run as cronjob specify full paths

```
crontab -e
0 4 * * 1 /home/YOUR_USER/dehydrated/dehydrated -c -d www.example.com -t dns-01 -k '/home/YOUR_USER/dehydrated/hooks/cfhookbash/hook.sh' >> /home/YOUR_USER/cfhookbash.log
```
Execute every monday at 4AM. After the script execution, `delete_txt.sh` is called to delete the DNS. Create also a log in your home.

##### Credits
Inspired by
+ [https://www.splitbrain.org/blog/2017-08/10-homeassistant_duckdns_letsencrypt](https://www.splitbrain.org/blog/2017-08/10-homeassistant_duckdns_letsencrypt)
+ [https://github.com/kappataumu/letsencrypt-cloudflare-hook](https://github.com/kappataumu/letsencrypt-cloudflare-hook)
