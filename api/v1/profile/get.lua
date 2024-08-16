-- description=验证码
-- middlewares=jwt

local userInfo = ctx.middleware("jwt", "info").user
local res = state.orm()
    .table({"users"})
    .where({
        "email = ?", userInfo.email
    })
    .find()
    .exec("base")

ctx.json(200, {
    id=res.res[1].id,
    name=res.res[1].username,
    imageUrl=res.res[1].avatar,
    email=res.res[1].email,
    role="user",
    isActive=true
})
