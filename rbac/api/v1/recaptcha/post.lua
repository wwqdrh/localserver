-- description=验证码
-- request=[
--   {"name": "json@token", "type": "string"}
-- ]

local captcha = "https://recaptchaenterprise.googleapis.com/v1/projects/wwqdrh/assessments?key="

local res, err = osx.fetch(captcha..osx.genv("NEXT_PUBLIC_RECAPTCHA_API_KEY"), "post", {
    json={
        event={
            token=ctx.req("token"),
            siteKey=osx.genv("NEXT_PUBLIC_RECAPTCHA_SITE_KEY")
        }
    }
})

if err ~= nil then
    ctx.json(400, {msg="验证失败", desc=err})
    return
end

local resJson, err = json.decode(res)
if err ~= nil then
    ctx.json(400, {msg="验证失败", desc=err})
    return
end
ctx.json(200, resJson)
