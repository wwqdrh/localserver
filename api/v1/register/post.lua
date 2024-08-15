-- description=用户注册
-- request=[
--   {"name": "json@email", "type": "string"},
--   {"name": "json@password", "type": "string"},
--   {"name": "json@name", "type": "string"}
-- ]

local res = state.orm()
    .table({"users"})
    .create({{
        username=ctx.req("name"),
        password=ctx.req("password"),
        email=ctx.req("email"),
    }})
    .exec("base")

if res.err == nil then
    ctx.json(200, {msg="注册成功"})
else
    ctx.json(400, {msg="注册用户失败"})
end
