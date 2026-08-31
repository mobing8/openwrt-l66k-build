require("nixio.fs")

m = Map("syncthing", "Syncthing 同步工具")

m:section(SimpleSection).template  = "syncthing/syncthing_status"

s = m:section(NamedSection, "syncthing", "syncthing", "设置")
s.anonymous = true

s:option(Flag, "enabled", "启用")

s:option(Value, "gui_address", "GUI 监听地址").default = "127.0.0.1:8384"

return m
