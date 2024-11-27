-- description=添加用户
-- request=[
--   {"name": "json@username", "type": "string"},
--   {"name": "json@password", "type": "string"},
--   {"name": "json@email", "type": "string"}
-- ]

local res = state.orm()
    .table({"users"})
    .create({{
        username=ctx.req("username"),
        password=ctx.req("password"),
        email=ctx.req("email"),
    }})
    .exec("base")

if res.err == nil then
    ctx.json(200, {msg="添加用户成功"})
else
    ctx.json(400, {msg="添加用户失败"})
end
