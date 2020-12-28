-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
DLGRP = {}
Tunnel.bindInterface("vrp_notifypush",DLGRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION CHECKPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function DLGRP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"policia.permissao")
end