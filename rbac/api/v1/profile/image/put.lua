-- description=修改用户头像
-- middlewares=jwt
-- request=[
--   {"name": "form@image", "type": "file"}
-- ]

local avatar = ctx.req("image")
local avatarExt = avatar:type() or ".jpg"
local fileName = "/upload/avatar/" .. mathx.random(10, 1) .. avatarExt

local err = avatar:save("utf8", "/public" .. fileName)
if err ~= nil then
    ctx.json(400, {msg="用户上传头像失败", detail=err})
    return
end

local userInfo = ctx.middleware("jwt", "info").user
local res = state.orm()
    .table({"users"})
    .where({
        "email = ?", userInfo.email,
    })
    .update({
        "avatar", fileName
    })
    .exec("base")
if res.err == nil then
    ctx.json(200, {msg="上传头像成功"})
else
    ctx.json(400, {msg="上传头像失败", detail=err})
end