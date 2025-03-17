-- request=[
--   {"name": "query@start_date", "type": "date"},
--   {"name": "query@end_date", "type": "date"},
--   {"name": "query@roomid", "type": "int"}
-- ]

local res = state.orm()
    .table({"rooms"})
    .select({
        "rooms.*"
    })
    .joins({
        {"LEFT JOIN booking ON rooms.id = booking.roomid"}
    })
    .where({
        "booking.roomid = ? AND booking.deleted_at IS NULL AND (\
            (booking.book_start < ? AND booking.book_end > ?)\
        )", ctx.req("roomid"), ctx.req("end_date"), ctx.req("start_date")
    })
    .find({})
    .exec("base", false)

if res.err ~= nil then
    ctx.json(400, {
        msg=res.err
    })
    return
end

if next(res.res) == nil or #res.res < res.res[1].room_count then
    ctx.json(200, {
        msg="ok",
        data=res.res
    })
end
