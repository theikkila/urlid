 local redis = require "resty.redis"
 local red = redis:new()

red:set_timeout(1000) -- 1 sec

ok, err = red:connect("127.0.0.1", 6379)
if not ok then
    ngx.say("failed to connect: ", err)
    return  
end
local f = string.sub(ngx.var.request_uri, 2)
g, err = red:get("url:"..f)
if not g or g == ngx.null then
    ngx.status = ngx.HTTP_NOT_FOUND
    ngx.say("URL Not Found")
    return
end

return ngx.redirect(g, ngx.HTTP_MOVED_PERMANENTLY)
