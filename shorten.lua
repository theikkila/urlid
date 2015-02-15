local post_args = ngx.req.get_post_args()
local link = post_args["link"]
local redis = require "resty.redis"
local red = redis:new()

if link == nil then
    ngx.say("Bad request, link not provided!")
    return
end

red:set_timeout(1000) -- 1 sec

ok, err = red:connect("127.0.0.1", 6379)
if not ok then
    ngx.say("failed to connect: ", err)
    return  
end

id, err = red:incr("urls")
if not id then
    ngx.say("Failed to get id for url: ", err)
    return
end
ok, err = red:set("url:"..string.format("%x", id), link)
if not ok then
    ngx.say(link)
    ngx.say("Error when saving url: ", err)
    return
end
ngx.say(string.format("%x", id))