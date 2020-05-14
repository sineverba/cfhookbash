Cloudflare dns-01 challenge hook bash for dehydrated
====================================================

**If you like this project, or use it, please, star it!**

Cloudflare Bash hook for [dehydrated](https://github.com/lukas2511/dehydrated).

## Why Cloudflare? What is this script?

If you cannot solve the `HTTP-01` challenge, you need to solve the DNS-01 challenge. [Details here:](https://letsencrypt.org/docs/challenge-types/).

With use of Cloudflare API (valid also on free plan!), this script will verify your domain putting a new record with a special token inside DNS zone.
At the end of Let's Encrypt validation, that record will be deleted.

You only need:

1. Register on Cloudflare (it works also on free plan)
2. Change your domain DNS to manage them in Cloudflare (follow their guide).
3. Run `dehydrated` with this hook.

You will find the certificates in the folder of `dehydrated`.

### Require
+ cURL
+ Active account on Cloudflare (tested with free account)

### Setup
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


### Configuration

1. Create a file `domains.txt` **in the folder of `dehydrated`**
2. Put inside a list (one for line) of domain that you want secure.

``` shell
www.example.com
home.example.net
[...]
```

3. Move inside `cfhookbash` folder
4. Copy `config.default.sh` to `config.sh`

```
cd ~/dehydrated/hooks/cfhookbash
cp config.default.sh config.sh && rm config.default.sh && nano config.sh
```

We need to edit `config.sh`. To get values:

| Value          | Where to find |
| -------------- | ------------- |
| Zone ID        | Main page domain > Right Column > API section |
| Global API Key | Account > My Profile > API Tokens > Api Keys > Global API Key |

### Usage

``` shell
./dehydrated -c -t dns-01 -k 'hooks/cfhookbash/hook.sh'
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
