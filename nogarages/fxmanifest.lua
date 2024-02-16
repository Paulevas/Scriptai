fx_version 'adamant'

author 'Pablito'

description 'A garage, with no garages.'

game 'gta5'

client_scripts {
    "client/client.lua",
    "config.lua"
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "server/server.lua",
    "config.lua"
}

shared_script '@es_extended/imports.lua'
