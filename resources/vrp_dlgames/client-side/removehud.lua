Citizen.CreateThread(function()
	AddTextEntry("FE_THDR_GTAO","~g~DL GAMES RP ~r~v2.0 ~w~| ~q~DISCORD.GG/GkqtTHe")
	StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
	while true do
		N_0xf4f2c0d4ee209e20()
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_KNUCKLE"),0.2)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_WRENCH"),0.4)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_HAMMER"),0.4)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_GOLFCLUB"),0.4)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_CROWBAR"),0.4)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_FLASHLIGHT"),0.4)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BAT"),0.4)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_POOLCUE"),0.4)	
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"),0.4)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_KNIFE"),0.5)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_DAGGER"),0.5)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MACHETE"),0.5)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_HATCHET"),0.5)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BOTTLE"),0.5)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BATTLEAXE"),0.5)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SWITCHBLADE"),0.5)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_STONE_HATCHET"),0.5)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_RAYPISTOL"),0.0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL_MK2"),0.85)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_REVOLVER_MK2"),0.3)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),5.0)
		DisablePlayerVehicleRewards(PlayerId())
		SetPedInfiniteAmmo(PlayerPedId(),true,GetHashKey("WEAPON_FIREEXTINGUISHER"))
		SetAudioFlag("PoliceScannerDisabled",true)
		ForceAmbientSiren(false)
		SetVehicleModelIsSuppressed(GetHashKey("AKUMA"),true)

		HideHudComponentThisFrame(1)
        HideHudComponentThisFrame(2)
        HideHudComponentThisFrame(3)
        HideHudComponentThisFrame(4)
        HideHudComponentThisFrame(5)
        HideHudComponentThisFrame(6)
        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(8)
        HideHudComponentThisFrame(9)
        HideHudComponentThisFrame(10)
        HideHudComponentThisFrame(11)
        HideHudComponentThisFrame(12)
        HideHudComponentThisFrame(13)
		HideHudComponentThisFrame(20)

		DisableControlAction(0,44,true)
		
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_PISTOL"))
        RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_MINISMG"))
        RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_PUMPSHOTGUN"))
        RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_CARBINERIFLE"))

		if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_SNOWBALL') or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_BALL') then
            SetPlayerWeaponDamageModifier(PlayerId(),0.0)
		end
		
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		RemoveVehiclesFromGeneratorsInArea(x-9999.0,y-9999.0,z-9999.0,x+9999.0,y+9999.0,z+9999.0)

		Citizen.Wait(1)
	end
end)