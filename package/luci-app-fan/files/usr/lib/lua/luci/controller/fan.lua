module("luci.controller.fan", package.seeall)

function index()
    if not nixio.fs.access("/etc/config/fan") then
        return
    end
    entry({"admin", "services", "fan"}, cbi("fan"), _("风扇控制"), 80).dependent = true
end
