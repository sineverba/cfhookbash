# Let's Encrypt Cloudflare bash hook - V 0.1 BETA

CloudFlare Bash hook for dehydrated.

This is a hook for Let's Encrypt client [dehydrated](https://github.com/lukas2511/dehydrated) to use with Cloud Flare.

You can complete the DNS challenges (dns-01).

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
