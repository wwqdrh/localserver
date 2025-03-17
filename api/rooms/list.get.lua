-- description=获取房源列表，可以指定筛选条件进行查询，提供分页功能
-- request=[
--   {"name": "query@start_date", "type": "date"},
--   {"name": "query@end_date", "type": "date"}
-- ]

if ctx.reqhas("start_date") and ctx.reqhas("end_date") then
    invalid_roomid_res = state.orm()
        .table({"rooms"})
        .select({
            "rooms.id", "rooms.room_count"
        })
        .joins({
            {"LEFT JOIN booking ON rooms.id = booking.roomid"}
        })
        .where({
            "booking.deleted_at IS NULL AND (\
                (booking.book_start < ? AND booking.book_end > ?)\
            )", ctx.req("end_date"), ctx.req("start_date")
        })
        .find({
            {"combine", "room_count"}
        })
        .exec("base", false)

    if invalid_roomid_res.err ~= nil then
        ctx.json(400, {msg="房间列表查询失败"})
        return
    end

    -- 查找room_count下的房间数量是否满足要求
    -- 用于统计每个 id 出现的次数
    local id_count = {}
    -- 遍历数据，统计每个 id 出现的次数
    for _, item in ipairs(invalid_roomid_res.res) do
        local id = item.id
        if id_count[id] then
            id_count[id] = id_count[id] + 1
        else
            id_count[id] = 1
        end
    end

    -- 用于存储符合条件的 id
    local result = {}
    -- 遍历 id_count，筛选出出现次数超过 room_count 的 id
    for id, count in pairs(id_count) do
        -- 找到对应的 room_count
        local room_count = nil
        for _, item in ipairs(invalid_roomid_res.res) do
            if item.id == id then
                room_count = item.room_count
                break
            end
        end
        -- 如果出现次数超过 room_count，则添加到结果中
        if count > room_count then
            table.insert(result, id)
        end
    end

    if #result > 0 then
        -- invalid_roomid_res是所有不能用的房间
        res = state.orm()
            .table({"rooms"})
            .where({
                "status=?", 1
            })
            .notin({
                result
            })
            .find({
                {"toArray", "slider_images"}
            })
            .exec("base", false)

        if res.err ~= nil then
            ctx.json(400, {msg="房间列表查询失败"})
            return
        end
    else
        res = state.orm()
        .table({"rooms"})
        .where({
            "status=?", 1
        })
        .find({
            {"toArray", "slider_images"}
        })
        .exec("base", false)

        if res.err ~= nil then
            ctx.json(400, {msg="房间列表查询失败"})
            return
        end
    end
else
    res = state.orm()
        .table({"rooms"})
        .where({
            "status=?", 1
        })
        .find({
            {"toArray", "slider_images"}
        })
        .exec("base", false)

    if res.err ~= nil then
        ctx.json(400, {msg="房间列表查询失败"})
        return
    end
end

ctx.json(200, {
    data=res.res
})