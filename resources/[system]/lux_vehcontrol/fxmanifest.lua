fx_version "bodacious"
game "gta5"

ui_page_preload "yes"
ui_page "web-side/index.html"

client_script {
    "client-side/*"
}

server_script {
    "server-side/*"
}

files {
	"web-side/*",
	"web-side/**/*"
}