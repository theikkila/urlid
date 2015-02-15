# Urlid
Simple url-shortener service written with lua for nginx (openresty)


## How to deploy?

```bash
git clone https://github.com/theikkila/urlid.git
cd urlid
docker build -t theikkila/urlid .
docker inspect `sudo docker run -d theikkila/urlid` |grep IPAddress

# You get something like:
"IPAddress": "172.17.0.58",
# There will be your shortener
```

## API


`GET /{id}[0-9a-z]`
Redirects with `301` if link found, otherwise returns `404`

`POST /shorten`
Creates new shortened link and returns id for it as `text/plain`
You must send the link in body (`link=http://www.looooonnnngguurrrllll.com/a/b/c`)
