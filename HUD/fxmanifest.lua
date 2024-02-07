fx_version "adamant"
games { "gta5" }

author '9BLCK LEAKS'
description 'https://discord.gg/7YjrM4FaJs'

client_scripts {
	"client/client.lua",
}

server_scripts {
	"server/server.lua",
	
}

ui_page "html/index.html"

files {
	"html/index.html",
	"html/assets/**/*.*",
	"postal.json",
}

shared_script "@es_extended/imports.lua"