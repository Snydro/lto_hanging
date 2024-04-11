local VORPcore = exports.vorp_core:GetCore()
local ishanging = false
local PlayerHang = false

RegisterCommand('hang', function(source, args, rawCommand)
    local playerpos = GetEntityCoords(PlayerPedId())
    for k,v in pairs(Config.Hang) do
        local distance = GetDistanceBetweenCoords(playerpos, v, true)
        if distance <= 8 then
            if ishanging == false then
	            local target_id = args[1]
                TriggerServerEvent('lto_pendu:jobcheck', target_id)
                ishanging = true
            else
                VORPcore.NotifyRightTip(Config.TooFar ,4000)
                ishanging = false
            end
	    end
    end
end)

RegisterNetEvent("lto_pendu:sethang", function()
    local ped = PlayerPedId()

    for k,v in pairs(Config.Hang) do
        if not PlayerHang then
            SetEntityCoords(ped, v.x,v.y,v.z-0.35)
            SetEntityHeading(ped, v.h)
            FreezeEntityPosition(ped, true)
			SetEnableHandcuffs(ped, true)
			PlayAnimationM(ped, "script_re@public_hanging@criminal_male", "death_a")

            PlayerHang = true
            Wait(1000)
            TriggerEvent('lto_pendu:killhang')
        end
    end
end)

RegisterNetEvent("lto_pendu:AnimLevier", function()
    local ped = PlayerPedId()
	PlayAnimationL(ped, "script_re@public_hanging@lever", "pull_lever_deputy_v2")
end)

RegisterNetEvent("lto_pendu:killhang", function(target_id)
    local ped = PlayerPedId()
    DoScreenFadeOut(Config.Wait.HangedScreenFade * 1000)
    Wait(Config.Wait.TimeToHang * 1000) -- Time before dead
    ApplyDamageToPed(ped, 500000, false, true, true)
    DoScreenFadeIn(3000)
    PlayerHang = false
    FreezeEntityPosition(ped, false)
end)

CreateThread(function()
	while true do
		Wait(0)
		local ped = PlayerPedId()

		if isHandcuffed or isHandcuffed2 or isHandcuffed3 then
		
			DisableControlAction(0, 0xB2F377E8, true) -- Attack
			DisableControlAction(0, 0xC1989F95, true) -- Attack 2
			DisableControlAction(0, 0x07CE1E61, true) -- Melee Attack 1
			DisableControlAction(0, 0xF84FA74F, true) -- MOUSE2
			DisableControlAction(0, 0xCEE12B50, true) -- MOUSE3
			DisableControlAction(0, 0x8FFC75D6, true) -- Shift
			DisableControlAction(0, 0xD9D0E1C0, true) -- SPACE
            DisableControlAction(0, 0xCEFD9220, true) -- E
            DisableControlAction(0, 0xF3830D8E, true) -- J
            DisableControlAction(0, 0x760A9C6F, true) -- G
            DisableControlAction(0, 0x80F28E95, true) -- L
            DisableControlAction(0, 0xDB096B85, true) -- CTRL
            DisableControlAction(0, 0xE30CD707, true) -- R
		    DisablePlayerFiring(ped, true)
			SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			
		else
			Wait(500)
		end
	end
end)

CreateThread(function ()
    while true do
        if PlayerHang then
            DrawTxt(Config.Text, 0.3, 0.85, 0.5, 0.5, true, 255, 255, 255, 150, false)
        end
        Wait(0)
    end
end)

function PlayAnimationM(ped, dict, name)
    if not DoesAnimDictExist(dict) then
      return
    end
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
    Citizen.Wait(0)
    end
    TaskPlayAnim(ped, dict, name, -1.0, -0.5, -1, 1, 0, true, 0, false, 0, false)
    RemoveAnimDict(dict)
end

function PlayAnimationL(ped, dict, name)
    if not DoesAnimDictExist(dict) then
      return
    end
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
    Citizen.Wait(0)
    end
    TaskPlayAnim(ped, dict, name, -1.0, -0.5, 1500, 1, 0, true, 0, false, 0, false)
    RemoveAnimDict(dict)
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end