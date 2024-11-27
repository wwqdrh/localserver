-- description=用户登录
-- request=[
--   {"name": "json@email", "type": "string"},
--   {"name": "json@password", "type": "string"}
-- ]

local res = state.orm()
    .table({"users"})
    .where({
        "email = ?", ctx.req("email")
    })
    .find({})
    .exec("base")

if res.err ~= nil then
    ctx.json(400, {msg="用户登录失败"})
    return
elseif #res.res == 0 then
    ctx.json(400, {msg="用户名不存在"})
    return
elseif res.res[1].password ~= ctx.req("password") then
    ctx.json(400, {msg="密码错误"})
    return
end

local tokenData, err = ctx.middleware("jwt", "token", {
    user={
        id=res.res[1].id,
        name=res.res[1].username,
        imageUrl=res.res[1].avatar,
        email=res.res[1].email,
        role="user",
        isActive=true
    }
})
if err ~= nil then
    ctx.json(500, {msg="获取token失败", desc=err})
    return
end

ctx.json(200, {
    msg="登录成功",
    accessToken=tokenData.token,
    refreshToken=tokenData.refreshToken,
    idToken=tokenData.token
})
