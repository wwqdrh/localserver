-- name=checkbook
-- entry=index
-- args=[
-- {"name": "start_date", "type": "string"},
-- {"name": "end_date", "type": "string"},
-- {"name": "roomid", "type": "number"}
-- ]

function index(start_date, end_date, roomid)
    res = state.orm()
        .table({"rooms"})
        .select({
            "rooms.*"
        })
        .joins({
            {"JOIN booking ON rooms.id = booking.roomid"}
        })
        .where({
            "rooms.id = ? AND booking.deleted_at IS NULL AND (\
                (booking.book_start < ? AND booking.book_end > ?)\
            )", roomid, end_date, start_date
        })
        .find({
            {"unique", "id"}
        })
        .exec("base", false)
    if res.err ~= nil or next(res.res) ~= nil then
        return "false"
    else
        return "true"
    end
end
