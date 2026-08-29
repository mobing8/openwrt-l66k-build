local m, s, o
local fs = require "nixio.fs"

m = Map("fan", translate("风扇控制"), translate("根据 CPU 温度自动控制风扇启停。L66K 风扇由 GPIO 6 控制，低电平有效。"))

-- 读取当前温度
local temp = 0
local temp_raw = fs.readfile("/sys/class/thermal/thermal_zone0/temp")
if temp_raw then
    temp = math.floor(tonumber(temp_raw) / 1000)
end

-- 读取风扇状态
local fan_state = "未知"
local gpio_val = fs.readfile("/sys/class/gpio/gpio6/value")
if gpio_val then
    local v = tonumber(gpio_val)
    -- active_low=1: 0=开, 1=关
    fan_state = (v == 0) and translate("运行中") or translate("已停止")
end

s = m:section(NamedSection, "config", "fan", translate("当前状态"))
s.anonymous = true
s.addremove = false

o = s:option(DummyValue, "_temp", translate("CPU 温度"))
o.value = temp .. " °C"

o = s:option(DummyValue, "_fan", translate("风扇状态"))
o.value = fan_state

s = m:section(NamedSection, "config", "fan", translate("温控设置"))
s.anonymous = true
s.addremove = false

o = s:option(Flag, "enabled", translate("启用温控风扇"))
o.default = "1"
o.rmempty = false

o = s:option(Value, "temp_on", translate("开启温度 (°C)"))
o.datatype = "range(30,100)"
o.default = "65"
o.rmempty = false
o.description = translate("CPU 温度达到此值时开启风扇")

o = s:option(Value, "temp_off", translate("关闭温度 (°C)"))
o.datatype = "range(20,90)"
o.default = "55"
o.rmempty = false
o.description = translate("CPU 温度低于此值时关闭风扇（需低于开启温度）")

o = s:option(Value, "interval", translate("检测间隔 (秒)"))
o.datatype = "range(5,300)"
o.default = "30"
o.rmempty = false

o = s:option(Value, "gpio", translate("GPIO 引脚"))
o.datatype = "uinteger"
o.default = "6"
o.rmempty = false
o.description = translate("L66K 默认为 GPIO 6")

o = s:option(Flag, "active_low", translate("低电平有效"))
o.default = "1"
o.rmempty = false
o.description = translate("勾选：写0=风扇开，写1=风扇关；L66K 默认勾选")

return m
