-- request=[
--   {"name": "query@key", "type": "string"},
--   {"name": "query@name", "type": "string"}
-- ]
-- mode=ws

ctx.wshub(ctx.req("key"))
ctx.wsbroadcast(ctx.req("name") .. "  加入了直播间")
while true do
    local msg = ctx.wsread()
    ctx.wswrite("receved: " .. msg)
end