-- description=验证码
-- middlewares=jwt

local userInfo = ctx.middleware("jwt", "info").user
local res = state.orm()
    .table({"users"})
    .select({"users.*", "r.role_name role_name"})
    .joins({
        {"JOIN user_roles ur ON ur.user_id = users.user_id"},
        {"JOIN roles r ON r.role_id = ur.role_id"},
    })
    .where({
        "email = ?", userInfo.email
    })
    .find({{"combine", "role_name"}})
    .exec("base")

ctx.json(200, {
    id=res.res[1].id,
    name=res.res[1].username,
    imageUrl=res.res[1].avatar,
    email=res.res[1].email,
    role=res.res[1].role_name,
    isActive=true
})
