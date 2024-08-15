-- description=验证码
-- middlewares=jwt

ctx.json(200, ctx.middleware("jwt", "info").user)
