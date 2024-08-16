-- description=修改用户信息
-- middlewares=jwt
-- request=[
--   {"name": "json@name", "type": "string"}
-- ]

local userInfo = ctx.middleware("jwt", "info").user
if not userInfo.email then
    ctx.json(400, {msg="token不合法", detail="没有email"})
    return
end
local res = state.orm()
    .table({"users"})
    .where({
        "email = ?", userInfo.email
    })
    .update({
        "username", ctx.req("name")
    })
    .exec("base")
if res.err == nil then
    ctx.json(200, {msg="修改用户名成功"})
else
    ctx.json(400, {msg="修改用户名失败"})
end