local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local phoneProp = nil
local phoneModel = "prop_amb_phone"
local currentStatus = "out"
local lastDict = nil
local lastAnim = nil
local lastIsFreeze = false
local animName = nil
local camera = false

local ANIMS = {
	['cellphone@'] = {
		['out'] = {
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_call_listen_base',
		},
		['text'] = {
			['out'] = 'cellphone_text_out',
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_text_to_call',
		},
		['call'] = {
			['out'] = 'cellphone_call_out',
			['text'] = 'cellphone_call_to_text',
			['call'] = 'cellphone_text_to_call',
		}
	},
	['anim@cellphone@in_car@ps'] = {
		['out'] = {
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_call_in',
		},
		['text'] = {
			['out'] = 'cellphone_text_out',
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_text_to_call',
		},
		['call'] = {
			['out'] = 'cellphone_horizontal_exit',
			['text'] = 'cellphone_call_to_text',
			['call'] = 'cellphone_text_to_call',
		}
	}
}

RegisterNetEvent('startCamera')
AddEventHandler('startCamera',function()
	camera = not camera
end)

function newPhoneProp()
	deletePhone()

	local mhash = GetHashKey(phoneModel)

	RequestModel(mhash)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Citizen.Wait(10)
	end

	local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,0.0,-5.0)
	phoneProp = CreateObject(mhash,coords.x,coords.y,coords.z,true,true,false)
	AttachEntityToEntity(phoneProp,PlayerPedId(),GetPedBoneIndex(PlayerPedId(),28422),0.0,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
	SetEntityAsMissionEntity(phoneProp,true,true)
	SetModelAsNoLongerNeeded(mhash)

	NetworkRegisterEntityAsNetworked(phoneProp)
	local netid = ObjToNet(phoneProp)
	SetNetworkIdExistsOnAllMachines(netid,true)
	NetworkSetNetworkIdDynamic(netid,true)
	SetNetworkIdCanMigrate(netid,false)
	for _,i in ipairs(GetActivePlayers()) do
		SetNetworkIdSyncToPlayer(netid,i,true)
	end
end

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if not IsEntityPlayingAnim(ped,"cellphone@",animName,3) and phoneProp ~= nil and not camera then
			TaskPlayAnim(ped,"cellphone@",animName,3.0,3.0,-1,50,0,0,0,0)
		end
		Citizen.Wait(1)
	end
end)

function deletePhone()
	camera = false
	TriggerEvent("binoculos",false)
	if DoesEntityExist(phoneProp) then
		TriggerServerEvent("trydeleteobj",ObjToNet(phoneProp))
		phoneProp = nil
	end
	if IsPedInAnyVehicle(PlayerPedId()) then
        ClearPedSecondaryTask(PlayerPedId())
        ClearPedTasks(PlayerPedId())
    end
end

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(10)
	end
end

function PhonePlayAnim(status,freeze,force)
	if status ~= 'out' and currentStatus == 'out' then
		vRP._DeletarObjeto("one")
	end

	if currentStatus == status and force ~= true then
		return
	end

	local freeze = freeze or false

	local dict = "cellphone@"
	if IsPedInAnyVehicle(PlayerPedId(),false) then
		dict = "anim@cellphone@in_car@ps"
	end
	loadAnimDict(dict)

	local anim = ANIMS[dict][currentStatus][status]
	if currentStatus ~= 'out' then
		StopAnimTask(PlayerPedId(),lastDict,lastAnim,1.0)
	end

	local flag = 50
	if freeze == true then
		flag = 14
	end
	animName = anim
	vRP.stopAnimActived()
	TaskPlayAnim(PlayerPedId(),dict,anim,3.0,3.0,-1,flag,0,false,false,false)

	if status ~= 'out' and currentStatus == 'out' then
		Citizen.Wait(380)
		newPhoneProp()
		SetCurrentPedWeapon(PlayerPedId(),GetHashKey("WEAPON_UNARMED"),true)
	end

	lastDict = dict
	lastAnim = anim
	lastIsFreeze = freeze
	currentStatus = status

	if status == 'out' then
		--TriggerEvent("gcphoneVoip",false)
		TriggerEvent("status:celular",false)
		Citizen.Wait(180)
		deletePhone()
		StopAnimTask(PlayerPedId(),lastDict,lastAnim,1.0)
	end
end

function PhonePlayOut()
	if GetEntityHealth(PlayerPedId()) > 101 and not vRP.isHandcuffed() then
		PhonePlayAnim('out')
	end
end

function PhonePlayText()
	if GetEntityHealth(PlayerPedId()) > 101 and not vRP.isHandcuffed() then
		PhonePlayAnim('text')
	end
end

function PhonePlayCall()
	if GetEntityHealth(PlayerPedId()) > 101 and not vRP.isHandcuffed() then
		PhonePlayAnim('call')
	end
end

function PhonePlayIn()
	if currentStatus == 'out' and GetEntityHealth(PlayerPedId()) > 101 and not vRP.isHandcuffed() then
		PhonePlayText()
	end
end