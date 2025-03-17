-- request=[
--    {"name": "query@page", "type": "int", "default": 1},
--    {"name": "query@pagesize", "type": "int", "default": 10}
-- ]
-- middlewares=jwt_admin@match,role,2|10

local res = state.orm()
    .table({"admins"})
    .where({
        "role=?", 1
    })
    .find({})
    .exec("base", false)

if res.err ~= nil then
    ctx.json(400, {msg="管理员列表查询失败"})
    return
end

ctx.json(200, {
    data=res.res
})