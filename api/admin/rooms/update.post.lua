-- description=新增房源信息
-- request=[
--   {"name": "json@id", "type": "int", "required": true},
--   {"name": "json@name", "type": "string"},
--   {"name": "json@room_count", "type": "int"},
--   {"name": "json@price", "type": "string"},
--   {"name": "json@status", "type": "int"},
--   {"name": "json@description", "type": "string"},
--   {"name": "json@cover_image", "type": "string"},
--   {"name": "json@features", "type": "string"},
--   {"name": "json@amentities", "type": "string"},
--   {"name": "json@slider_images", "type": "[]string"},
--   {"name": "json@area", "type": "int"},
--   {"name": "json@type", "type": "int"},
--   {"name": "json@capacity", "type": "int"}
-- ]
-- middlewares=jwt_admin@match,role,1|2|10

print(ctx.req("room_count"))
local res = state.orm()
    .table({"rooms"})
    .where({
        "id = ?", ctx.req("id")
    })
    .updates({
        {
            name=ctx.req("name"),
            room_count=ctx.req("room_count"),
            price=ctx.req("price"),
            status=ctx.req("status"),
            description=ctx.req("description"),
            cover_image=ctx.req("cover_image"),
            slider_images=ctx.req("slider_images"),
            area=ctx.req("area"),
            typeid=ctx.req("type"),
            capacity=ctx.req("capacity"),
            features=ctx.req("features"),
            amentities=ctx.req("amentities")
        }
    })
    .exec("base", false)

if res.err ~= nil then
    ctx.json(400, {msg="房间信息修改失败"})
    return
end

ctx.json(200, {
    msg="房间信息修改成功"
})