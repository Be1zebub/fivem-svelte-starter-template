fx_version("cerulean")
game("gta5")

author("https://github.com/Be1zebub")
description("fivem-svelte-starter-template")
version("1.0.0")

client_scripts({
	"client/ui/init.lua"
})

ui_page("web/dist/index.html")

files({
	"web/dist/index.html",
	"web/dist/**/*"
})
