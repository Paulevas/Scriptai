ESX = exports["es_extended"]:getSharedObject()
local PlayerData = {}
local Postals = nil

--[[
   TriggerEvent("minera_notify", "SUCCESS TITLE", "MESSAGE TITLE", "success", 3000)
   TriggerEvent("minera_notify", "ERROR TITLE", "ERROR TITLE", "error", 3000)
   TriggerEvent("minera_notify", "WARNING TITLE", "WARNING TITLE", "warning", 3000)
   TriggerEvent("minera_notify", "TEAM TITLE", "TEAM TITLE", "team", 3000)

    TriggerEvent("minera_announce", "ANNOUNCE MESSAGE", 3000)
    exports["minera_hudierung"]:HelpNotify("E", "TEST")
]]

local muchKeys = {
    { name = '~INPUT_CONTEXT~', key = 'E' },
    { name = '~INPUT_NEXT_CAMERA~', key = 'V' },
    { name = '~INPUT_LOOK_LR~', key = 'RIGHT STICK' },
    { name = '~INPUT_LOOK_UD~', key = 'RIGHT STICK' },
    { name = '~INPUT_LOOK_UP_ONLY~', key = 'RIGHT STICK' },
    { name = '~INPUT_LOOK_DOWN_ONLY~', key = 'RIGHT STICK' },
    { name = '~INPUT_LOOK_LEFT_ONLY~', key = 'RIGHT STICK' },
    { name = '~INPUT_LOOK_RIGHT_ONLY~', key = 'RIGHT STICK' },
    { name = '~INPUT_CINEMATIC_SLOWMO~', key = 'R3' },
    { name = '~INPUT_SCRIPTED_FLY_UD~', key = 'LEFT STICK' },
    { name = '~INPUT_SCRIPTED_FLY_LR~', key = 'LEFT STICK' },
    { name = '~INPUT_SCRIPTED_FLY_ZUP~', key = 'LT' },
    { name = '~INPUT_SCRIPTED_FLY_ZDOWN~', key = 'RT' },
    { name = '~INPUT_WEAPON_WHEEL_UD~', key = 'RIGHT STICK' },
    { name = '~INPUT_WEAPON_WHEEL_LR~', key = 'RIGHT STICK' },
    { name = '~INPUT_WEAPON_WHEEL_NEXT~', key = 'DPAD RIGHT' },
    { name = '~INPUT_WEAPON_WHEEL_PREV~', key = 'DPAD LEFT' },
    { name = '~INPUT_SELECT_NEXT_WEAPON~', key = 'DPAD RIGHT' },
    { name = '~INPUT_SELECT_PREV_WEAPON~', key = 'DPAD LEFT' },
    { name = '~INPUT_SKIP_CUTSCENE~', key = 'A' },
    { name = '~INPUT_CHARACTER_WHEEL~', key = 'DPAD DOWN' },
    { name = '~INPUT_MULTIPLAYER_INFO~', key = 'DPAD DOWN' },
    { name = '~INPUT_SPRINT~', key = 'A' },
    { name = '~INPUT_JUMP~', key = 'X' },
    { name = '~INPUT_ENTER~', key = 'Y' },
    { name = '~INPUT_ATTACK~', key = 'RT' },
    { name = '~INPUT_AIM~', key = 'LT' },
    { name = '~INPUT_LOOK_BEHIND~', key = 'R3' },
    { name = '~INPUT_PHONE~', key = 'DPAD UP' },
    { name = '~INPUT_SPECIAL_ABILITY~', key = 'L3' },
    { name = '~INPUT_SPECIAL_ABILITY_SECONDARY~', key = 'R3' },
    { name = '~INPUT_MOVE_LR~', key = 'LEFT STICK' },
    { name = '~INPUT_MOVE_UD~', key = 'LEFT STICK' },
    { name = '~INPUT_MOVE_UP_ONLY~', key = 'LEFT STICK' },
    { name = '~INPUT_MOVE_DOWN_ONLY~', key = 'LEFT STICK' },
    { name = '~INPUT_MOVE_LEFT_ONLY~', key = 'LEFT STICK' },
    { name = '~INPUT_MOVE_RIGHT_ONLY~', key = 'LEFT STICK' },
    { name = '~INPUT_DUCK~', key = 'L3' },
    { name = '~INPUT_SELECT_WEAPON~', key = 'LB' },
    { name = '~INPUT_PICKUP~', key = 'LB' },
    { name = '~INPUT_SNIPER_ZOOM~', key = 'LEFT STICK' },
    { name = '~INPUT_SNIPER_ZOOM_IN_ONLY~', key = 'LEFT STICK' },
    { name = '~INPUT_SNIPER_ZOOM_OUT_ONLY~', key = 'LEFT STICK' },
    { name = '~INPUT_SNIPER_ZOOM_IN_SECONDARY~', key = 'DPAD UP' },
    { name = '~INPUT_SNIPER_ZOOM_OUT_SECONDARY~', key = 'DPAD DOWN' },
    { name = '~INPUT_COVER~', key = 'RB' },
    { name = '~INPUT_RELOAD~', key = 'B' },
    { name = '~INPUT_TALK~', key = 'DPAD RIGHT' },
    { name = '~INPUT_DETONATE~', key = 'DPAD LEFT' },
    { name = '~INPUT_HUD_SPECIAL~', key = 'DPAD DOWN' },
    { name = '~INPUT_ARREST~', key = 'Y' },
    { name = '~INPUT_ACCURATE_AIM~', key = 'R3' },
    { name = '~INPUT_CONTEXT~', key = 'DPAD RIGHT' },
    { name = '~INPUT_CONTEXT_SECONDARY~', key = 'DPAD LEFT' },
    { name = '~INPUT_WEAPON_SPECIAL~', key = 'Y' },
    { name = '~INPUT_WEAPON_SPECIAL_TWO~', key = 'DPAD RIGHT' },
    { name = '~INPUT_DIVE~', key = 'RB' },
    { name = '~INPUT_DROP_WEAPON~', key = 'Y' },
    { name = '~INPUT_DROP_AMMO~', key = 'B' },
    { name = '~INPUT_THROW_GRENADE~', key = 'DPAD LEFT' },
    { name = '~INPUT_VEH_MOVE_LR~', key = 'LEFT STICK' },
    { name = '~INPUT_VEH_MOVE_UD~', key = 'LEFT STICK' },
    { name = '~INPUT_VEH_MOVE_UP_ONLY~', key = 'LEFT STICK' },
    { name = '~INPUT_VEH_MOVE_DOWN_ONLY~', key = 'LEFT STICK' },
    { name = '~INPUT_VEH_MOVE_LEFT_ONLY~', key = 'LEFT STICK' },
    { name = '~INPUT_VEH_MOVE_RIGHT_ONLY~', key = 'LEFT STICK' },
    { name = '~INPUT_VEH_SPECIAL~', key = '(NONE)' },
    { name = '~INPUT_VEH_GUN_LR~', key = 'RIGHT STICK' },
    { name = '~INPUT_VEH_GUN_UD~', key = 'RIGHT STICK' },
    { name = '~INPUT_VEH_AIM~', key = 'LB' },
    { name = '~INPUT_VEH_ATTACK~', key = 'RB' },
    { name = '~INPUT_VEH_ATTACK2~', key = 'A' },
    { name = '~INPUT_VEH_ACCELERATE~', key = 'RT' },
    { name = '~INPUT_VEH_BRAKE~', key = 'LT' },
    { name = '~INPUT_VEH_DUCK~', key = 'A' },
    { name = '~INPUT_VEH_HEADLIGHT~', key = 'DPAD RIGHT' },
    { name = '~INPUT_VEH_EXIT~', key = 'Y' },
    { name = '~INPUT_VEH_HANDBRAKE~', key = 'RB' },
    { name = '~INPUT_VEH_HOTWIRE_LEFT~', key = 'LT' },
    { name = '~INPUT_VEH_HOTWIRE_RIGHT~', key = 'RT' },
    { name = '~INPUT_VEH_LOOK_BEHIND~', key = 'R3' },
    { name = '~INPUT_VEH_CIN_CAM~', key = 'B' },
    { name = '~INPUT_VEH_NEXT_RADIO~', key = '(NONE)' },
    { name = '~INPUT_VEH_PREV_RADIO~', key = '(NONE)' },
    { name = '~INPUT_VEH_NEXT_RADIO_TRACK~', key = '(NONE)' },
    { name = '~INPUT_VEH_PREV_RADIO_TRACK~', key = '(NONE)' },
    { name = '~INPUT_VEH_RADIO_WHEEL~', key = 'DPAD LEFT' },
    { name = '~INPUT_VEH_HORN~', key = 'L3' },
    { name = '~INPUT_VEH_FLY_THROTTLE_UP~', key = 'RT' },
    { name = '~INPUT_VEH_FLY_THROTTLE_DOWN~', key = 'LT' },
    { name = '~INPUT_VEH_FLY_YAW_LEFT~', key = 'LB' },
    { name = '~INPUT_VEH_FLY_YAW_RIGHT~', key = 'RB' },
    { name = '~INPUT_VEH_PASSENGER_AIM~', key = 'LT' },
    { name = '~INPUT_VEH_PASSENGER_ATTACK~', key = 'RT' },
    { name = '~INPUT_VEH_SPECIAL_ABILITY_FRANKLIN~', key = 'R3' },
    { name = '~INPUT_VEH_STUNT_UD~', key = '(NONE)' },
    { name = '~INPUT_VEH_CINEMATIC_UD~', key = 'RIGHT STICK' },
    { name = '~INPUT_VEH_CINEMATIC_UP_ONLY~', key = '(NONE)' },
    { name = '~INPUT_VEH_CINEMATIC_DOWN_ONLY~', key = '(NONE)' },
    { name = '~INPUT_VEH_CINEMATIC_LR~', key = 'RIGHT STICK' },
    { name = '~INPUT_VEH_SELECT_NEXT_WEAPON~', key = 'X' },
    { name = '~INPUT_VEH_SELECT_PREV_WEAPON~', key = '(NONE)' },
    { name = '~INPUT_VEH_ROOF~', key = 'DPAD RIGHT' },
    { name = '~INPUT_VEH_JUMP~', key = 'RB' },
    { name = '~INPUT_VEH_GRAPPLING_HOOK~', key = 'DPAD RIGHT' },
    { name = '~INPUT_VEH_SHUFFLE~', key = 'DPAD RIGHT' },
    { name = '~INPUT_VEH_DROP_PROJECTILE~', key = 'A' },
    { name = '~INPUT_VEH_MOUSE_CONTROL_OVERRIDE~', key = '(NONE)' },
    { name = '~INPUT_VEH_FLY_ROLL_LR~', key = 'LEFT STICK' },
    { name = '~INPUT_VEH_FLY_ROLL_LEFT_ONLY~', key = 'LEFT STICK' },
    { name = '~INPUT_VEH_FLY_ROLL_RIGHT_ONLY~', key = 'LEFT STICK' },
    { name = '~INPUT_VEH_FLY_PITCH_UD~', key = 'LEFT STICK' },
    { name = '~INPUT_VEH_FLY_PITCH_UP_ONLY~', key = 'LEFT STICK' },
    { name = '~INPUT_VEH_FLY_PITCH_DOWN_ONLY~', key = 'LEFT STICK' },
    { name = '~INPUT_VEH_FLY_UNDERCARRIAGE~', key = 'L3' },
    { name = '~INPUT_VEH_FLY_ATTACK~', key = 'A' },
    { name = '~INPUT_VEH_FLY_SELECT_NEXT_WEAPON~', key = 'DPAD LEFT' },
    { name = '~INPUT_VEH_FLY_SELECT_PREV_WEAPON~', key = '(NONE)' },
    { name = '~INPUT_VEH_FLY_SELECT_TARGET_LEFT~', key = 'LB' },
    { name = '~INPUT_VEH_FLY_SELECT_TARGET_RIGHT~', key = 'RB' },
    { name = '~INPUT_VEH_FLY_VERTICAL_FLIGHT_MODE~', key = 'DPAD RIGHT' },
    { name = '~INPUT_VEH_FLY_DUCK~', key = 'A' },
    { name = '~INPUT_VEH_FLY_ATTACK_CAMERA~', key = 'R3' },
    { name = '~INPUT_VEH_FLY_MOUSE_CONTROL_OVERRIDE~', key = '(NONE)' },
    { name = '~INPUT_VEH_SUB_TURN_LR~', key = 'LEFT STICK' },
    { name = '~INPUT_VEH_SUB_TURN_LEFT_ONLY~', key = 'LEFT STICK' },
    { name = '~INPUT_VEH_SUB_TURN_RIGHT_ONLY~', key = 'LEFT STICK' },
    { name = '~INPUT_VEH_SUB_PITCH_UD~', key = 'LEFT STICK' },
    { name = '~INPUT_VEH_SUB_PITCH_UP_ONLY~', key = 'LEFT STICK' },
    { name = '~INPUT_VEH_SUB_PITCH_DOWN_ONLY~', key = 'LEFT STICK' },
    { name = '~INPUT_VEH_SUB_THROTTLE_UP~', key = 'RT' },
    { name = '~INPUT_VEH_SUB_THROTTLE_DOWN~', key = 'LT' },
    { name = '~INPUT_VEH_SUB_ASCEND~', key = 'RB' },
    { name = '~INPUT_VEH_SUB_DESCEND~', key = 'LB' },
    { name = '~INPUT_VEH_SUB_TURN_HARD_LEFT~', key = 'A' },
    { name = '~INPUT_VEH_SUB_TURN_HARD_RIGHT~', key = 'Y' },
    { name = '~INPUT_VEH_SUB_MOUSE_CONTROL_OVERRIDE~', key = '(NONE)' },
    { name = '~INPUT_VEH_PUSHBIKE_PEDAL~', key = 'RT' },
    { name = '~INPUT_VEH_PUSHBIKE_SPRINT~', key = 'A' },
    { name = '~INPUT_VEH_PUSHBIKE_FRONT_BRAKE~', key = 'LT' },
    { name = '~INPUT_VEH_PUSHBIKE_REAR_BRAKE~', key = 'LB' },
    { name = '~INPUT_MELEE_ATTACK_LIGHT~', key = 'X' },
    { name = '~INPUT_MELEE_ATTACK_HEAVY~', key = 'B' },
    { name = '~INPUT_MELEE_ATTACK_ALTERNATE~', key = 'Y' },
    { name = '~INPUT_SPECIAL_ABILITY_PC~', key = 'CAPS LOCK' },
    { name = '~INPUT_PHONE_UP~', key = 'DPAD UP' },
    { name = '~INPUT_PHONE_DOWN~', key = 'DPAD DOWN' },
    { name = '~INPUT_PHONE_LEFT~', key = 'DPAD LEFT' },
    { name = '~INPUT_PHONE_RIGHT~', key = 'DPAD RIGHT' },
    { name = '~INPUT_PHONE_SELECT~', key = 'E' },
    { name = '~INPUT_PHONE_CANCEL~', key = 'BACKSPACE' },
    { name = '~INPUT_PHONE_OPTION~', key = 'SPACEBAR' },
    { name = '~INPUT_PHONE_EXTRA_OPTION~', key = 'LEFT SHIFT' },
    { name = '~INPUT_PHONE_SCROLL_FORWARD~', key = 'UP' },
    { name = '~INPUT_PHONE_SCROLL_BACKWARD~', key = 'DOWN' },
    { name = '~INPUT_PHONE_CAMERA_FOCUS_LOCK~', key = 'NUMPAD 5' },
    { name = '~INPUT_PHONE_CAMERA_GRID~', key = 'NUMPAD 0' },
    { name = '~INPUT_PHONE_CAMERA_SELFIE~', key = 'NUMPAD 3' },
    { name = '~INPUT_PHONE_CAMERA_DOF~', key = 'NUMPAD 1' },
    { name = '~INPUT_PHONE_CAMERA_EXPRESSION~', key = 'NUMPAD 2' },
    { name = '~INPUT_FRONTEND_DOWN~', key = 'DOWN' },
    { name = '~INPUT_FRONTEND_UP~', key = 'UP' },
    { name = '~INPUT_FRONTEND_LEFT~', key = 'LEFT' },
    { name = '~INPUT_FRONTEND_LS~', key = 'LEFT' },
    { name = '~INPUT_FRONTEND_RIGHT~', key = 'RIGHT' },
    { name = '~INPUT_FRONTEND_RDOWN~', key = 'NUMPAD 2' },
    { name = '~INPUT_FRONTEND_RUP~', key = 'NUMPAD 8' },
    { name = '~INPUT_FRONTEND_RLEFT~', key = 'NUMPAD 4' },
    { name = '~INPUT_FRONTEND_RRIGHT~', key = 'NUMPAD 6' },
    { name = '~INPUT_FRONTEND_AXIS_X~', key = 'RIGHT STICK' },
    { name = '~INPUT_FRONTEND_AXIS_Y~', key = 'RIGHT STICK' },
    { name = '~INPUT_FRONTEND_RIGHT_AXIS_X~', key = 'RIGHT STICK' },
    { name = '~INPUT_FRONTEND_RIGHT_AXIS_Y~', key = 'RIGHT STICK' },
    { name = '~INPUT_FRONTEND_PAUSE~', key = 'ENTER' },
    { name = '~INPUT_FRONTEND_PAUSE_ALTERNATE~', key = 'P' },
    { name = '~INPUT_FRONTEND_ACCEPT~', key = 'ENTER' },
    { name = '~INPUT_FRONTEND_CANCEL~', key = 'BACKSPACE' },
    { name = '~INPUT_FRONTEND_X~', key = 'E' },
    { name = '~INPUT_FRONTEND_Y~', key = 'R' },
    { name = '~INPUT_FRONTEND_LB~', key = 'Q' },
    { name = '~INPUT_FRONTEND_RB~', key = 'W' },
    { name = '~INPUT_FRONTEND_LT~', key = 'A' },
    { name = '~INPUT_FRONTEND_RT~', key = 'S' },
    { name = '~INPUT_SATCHEL~', key = 'G' },
    { name = '~INPUT_SATCHEL_SECONDARY~', key = 'F' },
    { name = '~INPUT_HIDE_HUD~', key = 'F7' },
    { name = '~INPUT_TOGGLE_PLAYER_BLIP~', key = 'F11' },
    { name = '~INPUT_MAP_POI~', key = 'CAPS LOCK' },
    { name = '~INPUT_CONSOLE~', key = 'TILDE' },
    { name = '~INPUT_CURSOR_SCROLL_UP~', key = 'NUMPAD +' },
    { name = '~INPUT_CURSOR_SCROLL_DOWN~', key = 'NUMPAD -' },
    { name = '~INPUT_ENTER_CHEAT_CODE~', key = 'TILDE' },
    { name = '~INPUT_INTERACTION_MENU~', key = 'M' },
    { name = '~INPUT_MP_TEXT_CHAT_ALL~', key = 'Y' },
    { name = '~INPUT_MP_TEXT_CHAT_TEAM~', key = 'U' },
    { name = '~INPUT_MP_TEXT_CHAT_FRIENDS~', key = 'I' },
    { name = '~INPUT_MP_TEXT_CHAT_CREW~', key = 'O' },
    { name = '~INPUT_PUSH_TO_TALK~', key = 'N' },
    { name = '~INPUT_CREATOR_LS~', key = 'W' },
    { name = '~INPUT_CREATOR_RS~', key = 'S' },
    { name = '~INPUT_CREATOR_LT~', key = 'A' },
    { name = '~INPUT_CREATOR_RT~', key = 'D' },
    { name = '~INPUT_CREATOR_MENU_TOGGLE~', key = 'SPACEBAR' },
    { name = '~INPUT_CREATOR_ACCEPT~', key = 'ENTER' },
    { name = '~INPUT_CREATOR_DELETE~', key = 'DELETE' },
    { name = '~INPUT_ATTACK2~', key = 'LB' },
    { name = '~INPUT_RAPPEL_JUMP~', key = 'A' },
    { name = '~INPUT_RAPPEL_LONG_JUMP~', key = 'Y' },
    { name = '~INPUT_RAPPEL_SMASH_WINDOW~', key = 'X' },
    { name = '~INPUT_PREV_WEAPON~', key = 'Q' },
    { name = '~INPUT_NEXT_WEAPON~', key = 'E' },
    { name = '~INPUT_MELEE_ATTACK1~', key = 'LEFT MOUSE BUTTON' },
    { name = '~INPUT_MELEE_ATTACK2~', key = 'RIGHT MOUSE BUTTON' },
    { name = '~INPUT_WHISTLE~', key = 'LEFT ALT' },
    { name = '~INPUT_WHISTLE_ANIMAL~', key = 'CAPS LOCK' },
    { name = '~INPUT_PHONE_PDA~', key = 'P' },
    { name = '~INPUT_PHONE_MUMBOSS_TEXT~', key = 'UP' },
    { name = '~INPUT_PHONE_MUMBOSS_INTERNET~', key = 'DOWN' },
    { name = '~INPUT_PHONE_CALL~', key = 'SPACEBAR' },
    { name = '~INPUT_PHONE_ANSWER~', key = 'SPACEBAR' },
    { name = '~INPUT_PHONE_HANG_UP~', key = 'BACKSPACE' },
    { name = '~INPUT_PHONE_PUT_AWAY~', key = 'BACKSPACE' },
    { name = '~INPUT_PHONE_CANCEL~', key = 'BACKSPACE' },
    { name = '~INPUT_PHONE_SCROLL_BACKWARD~', key = 'DOWN' },
    { name = '~INPUT_PHONE_SCROLL_FORWARD~', key = 'UP' },
    { name = '~INPUT_FRONTEND_AXIS_X~', key = 'RIGHT STICK' },
    { name = '~INPUT_FRONTEND_AXIS_Y~', key = 'RIGHT STICK' },
    { name = '~INPUT_FRONTEND_RIGHT_AXIS_X~', key = 'RIGHT STICK' },
    { name = '~INPUT_FRONTEND_RIGHT_AXIS_Y~', key = 'RIGHT STICK' },
    { name = '~INPUT_FRONTEND_PAUSE~', key = 'ENTER' },
    { name = '~INPUT_FRONTEND_PAUSE_ALTERNATE~', key = 'P' },
    { name = '~INPUT_FRONTEND_ACCEPT~', key = 'ENTER' },
    { name = '~INPUT_FRONTEND_CANCEL~', key = 'BACKSPACE' },
    { name = '~INPUT_FRONTEND_X~', key = 'E' },
    { name = '~INPUT_FRONTEND_Y~', key = 'R' },
    { name = '~INPUT_FRONTEND_LB~', key = 'Q' },
    { name = '~INPUT_FRONTEND_RB~', key = 'W' },
    { name = '~INPUT_FRONTEND_LT~', key = 'A' },
    { name = '~INPUT_FRONTEND_RT~', key = 'S' },
    { name = '~INPUT_SATCHEL~', key = 'G' },
    { name = '~INPUT_SATCHEL_SECONDARY~', key = 'F' },
    { name = '~INPUT_HIDE_HUD~', key = 'F7' },
    { name = '~INPUT_TOGGLE_PLAYER_BLIP~', key = 'F11' },
    { name = '~INPUT_MAP_POI~', key = 'CAPS LOCK' },
    { name = '~INPUT_CONSOLE~', key = 'TILDE' },
    { name = '~INPUT_CURSOR_SCROLL_UP~', key = 'NUMPAD +' },
    { name = '~INPUT_CURSOR_SCROLL_DOWN~', key = 'NUMPAD -' },
    { name = '~INPUT_ENTER_CHEAT_CODE~', key = 'TILDE' },
    { name = '~INPUT_INTERACTION_MENU~', key = 'M' },
    { name = '~INPUT_MP_TEXT_CHAT_ALL~', key = 'Y' },
    { name = '~INPUT_MP_TEXT_CHAT_TEAM~', key = 'U' },
    { name = '~INPUT_MP_TEXT_CHAT_FRIENDS~', key = 'I' },
    { name = '~INPUT_MP_TEXT_CHAT_CREW~', key = 'O' },
    { name = '~INPUT_PUSH_TO_TALK~', key = 'N' },
    { name = '~INPUT_CREATOR_LS~', key = 'W' },
    { name = '~INPUT_CREATOR_RS~', key = 'S' },
    { name = '~INPUT_CREATOR_LT~', key = 'A' },
    { name = '~INPUT_CREATOR_RT~', key = 'D' },
    { name = '~INPUT_CREATOR_MENU_TOGGLE~', key = 'SPACEBAR' },
    { name = '~INPUT_CREATOR_ACCEPT~', key = 'ENTER' },
    { name = '~INPUT_CREATOR_DELETE~', key = 'DELETE' },
    { name = '~INPUT_ATTACK2~', key = 'LB' },
    { name = '~INPUT_RAPPEL_JUMP~', key = 'A' },
    { name = '~INPUT_RAPPEL_LONG_JUMP~', key = 'Y' },
    { name = '~INPUT_RAPPEL_SMASH_WINDOW~', key = 'X' },
    { name = '~INPUT_PREV_WEAPON~', key = 'Q' },
    { name = '~INPUT_NEXT_WEAPON~', key = 'E' },
    { name = '~INPUT_MELEE_ATTACK1~', key = 'LEFT MOUSE BUTTON' },
    { name = '~INPUT_MELEE_ATTACK2~', key = 'RIGHT MOUSE BUTTON' },
    { name = '~INPUT_WHISTLE~', key = 'LEFT ALT' },
    { name = '~INPUT_WHISTLE_ANIMAL~', key = 'CAPS LOCK' },
    { name = '~INPUT_PHONE_PDA~', key = 'P' },
    { name = '~INPUT_PHONE_MUMBOSS_TEXT~', key = 'UP' },
    { name = '~INPUT_PHONE_MUMBOSS_INTERNET~', key = 'DOWN' },
    { name = '~INPUT_PHONE_CALL~', key = 'SPACEBAR' },
    { name = '~INPUT_PHONE_ANSWER~', key = 'SPACEBAR' },
    { name = '~INPUT_PHONE_HANG_UP~', key = 'BACKSPACE' },
    { name = '~INPUT_PHONE_PUT_AWAY~', key = 'BACKSPACE' },
    { name = '~INPUT_PHONE_CANCEL~', key = 'BACKSPACE' },
    { name = '~INPUT_PHONE_SCROLL_BACKWARD~', key = 'DOWN' },
    { name = '~INPUT_PHONE_SCROLL_FORWARD~', key = 'UP' },
}

Citizen.CreateThread(function()
    while true do -- Exists so it runs every frame (while true means all the time, basically)
    DisplayAmmoThisFrame(false) -- Using the native to disable it 
    Citizen.Wait(0) -- Waiting 0ms to make the loop run every single frame with no exceptions
    end
    end)




CreateThread(function()
    PlayerData = ESX.GetPlayerData()
    Citizen.Wait(2500)

    Postals = json.decode(LoadResourceFile(GetCurrentResourceName(), "postal.json"))

    for i, postal in ipairs(Postals) do 
        Postals[i] = {vec(postal.x, postal.y), code = postal.code} 
    end
end)

RegisterNetEvent("esx:playerLoaded", function(data)
    PlayerData = data
end)

RegisterNetEvent("esx:setJob", function(job)
    PlayerData.job = job
end)

RegisterNetEvent("esx:setAccountMoney")
AddEventHandler("esx:setAccountMoney", function(account)
    for k,v in pairs(PlayerData.accounts) do
        if v.name == account.name then
            PlayerData.accounts[k] = account
        end        
    end
end)

RegisterNetEvent("minera_notify")
AddEventHandler("minera_notify", function(title, message, type, timeout)
    PlaySoundFrontend(-1, 'ATM_WINDOW', 'HUD_FRONTEND_DEFAULT_SOUNDSET', 1)
    SendNUIMessage({
        action = "Notify",
        title = title,
        message = message,
        type = type or "error",
        timeout = timeout or 3000,
    })
end)

RegisterNetEvent("minera_announce")
AddEventHandler("minera_announce", function(message, timeout)
    SendNUIMessage({
        action = "Announce",
        message = message,
        timeout = timeout or 3000,
    })
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(800)
      
        if PlayerData ~= nil and PlayerData.job ~= nil and Postals ~= nil then 
            local ped = PlayerPedId()
            local pedcoords = GetEntityCoords(ped)
            local postalindex, postaldistance
  
            SendNUIMessage({
                action = "SetPlayerData",
                data = {
                    money = GetMoney("money", PlayerData.accounts),
                    bank = GetMoney("bank", PlayerData.accounts),
                    source = GetPlayerServerId(PlayerId()),
                    online = "15",
                    job = {
                        label = PlayerData.job.label,
                        rank = PlayerData.job.grade_label,
                    }
                },
            })
    
            -- TriggerEvent("esx_status:getStatus", "hunger", function(status)
            --     SendNUIMessage({action = "SetFood", status = math.floor(status.val / 1000000 * 100)})
            -- end)
    
            -- TriggerEvent("esx_status:getStatus", "thirst", function(status)
            --     SendNUIMessage({action = "SetWater", status = math.floor(status.val / 1000000 * 100)})
            -- end)
    
            if IsPauseMenuActive() then
                SendNUIMessage({action = "SetHudState", state = false})
            elseif not IsPauseMenuActive() then
                SendNUIMessage({action = "SetHudState", state = true})
            end

            for i = 1, #Postals do
                local distance = #(vec(pedcoords[1], pedcoords[2]) - Postals[i][1])

                if not postaldistance or distance < postaldistance then
                    postalindex = i
                    postaldistance = distance
                end
            end
    
            SendNUIMessage({
                action = "SetPostal",
                postal = Postals[postalindex].code,
            })
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)
        
        local ped = PlayerPedId()

        if IsPedArmed(ped, 6) then
            local _, weapon = GetCurrentPedWeapon(ped)
            local _, clipammo = GetAmmoInClip(ped, weapon)
            local ammo = GetAmmoInPedWeapon(ped, weapon)

            SendNUIMessage({
                action = "SetAmmo",
                state = true,
                data = {
                    ammo = ammo,
                    clip = clipammo,
                }
            })
        else
            SendNUIMessage({action = "SetAmmo", state = false})
            Citizen.Wait(500)
        end
    end
end)

CreateThread(function()
    while true do
        ESX.TriggerServerCallback("minera_hud:getOnlinePlayers", function(cb)
            SendNUIMessage({
                action = "SetOnline",
                online = cb.online.."/"..cb.max,
            })
        end)
        Wait(3000)
    end
end)

CreateThread(function()
    while true do
        Wait(70)
        local ped = PlayerPedId()

        if IsPedInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(ped, false)    
            local speed = math.ceil(GetEntitySpeed(vehicle) * 3.6)
            local fuel = math.floor(GetVehicleFuelLevel(vehicle))        
  
            SendNUIMessage({
                action = "Speedo",
                state = true,
                data = {
                    maxspeed = 300,
                    speed = speed,
                    fuel = fuel,
                    engine = GetIsVehicleEngineRunning(vehicle),
                    key = GetVehicleDoorLockStatus(vehicle),
                    belt = false, -- Add Own Export
                },
            })
        else
            SendNUIMessage({action = "Speedo", state = false})
            Wait(500)
        end
    end
end)

function GetMoney(acctype, accounts)
    if accounts ~= nil then
        for _, account in pairs(accounts) do 
            if account.name == acctype then 
                return account.money or 0
            end
        end
    else
        return 0
    end
end

exports("HelpNotify", function(button, message)
    if not active then
        start = GetGameTimer()
        active = true

        for index, current in pairs(muchKeys) do
            if (string.find(message, current.name)) then message = string.gsub(message, current.name, current.key) end
        end

        SendNUIMessage({
            action = "HelpNotify",
            state = true,
            button = button or "E",
            message = message or "GARAGE",
        })
        
        Citizen.CreateThread(function()
            while start + 100 >= GetGameTimer() do
                Citizen.Wait(1500)
            end

            active = false
            Citizen.Wait(200)

            if not active then
                SendNUIMessage({action = "HelpNotify", state = false})
            end
        end)
    end
end)

RegisterNetEvent("ms_hud:notify", function(type, msg)
    TriggerEvent("minera_notify", "INFINITY-RP", msg, type, 5000)
end)

RegisterNetEvent("ms_hud:annouce", function(msg)
    TriggerEvent("minera_announce", msg, 10000)
end)

local voiceModes = {}
local currentThread = false
local lastThread = nil
local tickTime = 500
local timer = 0

TriggerEvent('pma-voice:settingsCallback', function(voiceSettings)
    local voiceTable = voiceSettings.voiceModes

    for i = 1, #voiceTable do
        voiceModes[i] = voiceTable[i][1]
    end

    while (not HUDLoaded) do
        Wait(0)
    end

    local samuispro = GetConvar('voice_useNativeAudio', 'false') == 'true' and
        voiceModes[tonumber(GetConvar('voice_defaultVoiceMode', 2))] * 3 or
        voiceModes[tonumber(GetConvar('voice_defaultVoiceMode', 2))]
end)

AddEventHandler('pma-voice:setTalkingMode', function(newTalkingRange)
    local range = voiceModes[newTalkingRange]

    currentThread = false
    CreateThread(function()
        currentThread = true
        lastThread = GetGameTimer()
        local currentOpacity = 0.0

        while currentThread do
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local range2 = tonumber(range)
            if IsPedInAnyVehicle(playerPed, false) then
                DrawMarker(1, playerCoords.x, playerCoords.y, playerCoords.z - 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, range2, range2, 0.5, 0, 153, 255, currentOpacity, false, false, 2, false, nil, nil, false)
            else
                DrawMarker(1, playerCoords.x, playerCoords.y, playerCoords.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, range2, range2, 0.5, 0, 153, 255, currentOpacity, false, false, 2, false, nil, nil, false)
            end

            if (GetGameTimer() - lastThread > (tickTime / 2)) then
                currentOpacity = currentOpacity - 0.0125
            end

            if (GetGameTimer() - lastThread < (tickTime / 2)) then
                currentOpacity = currentOpacity + 0.0125
            end

            if (GetGameTimer() - lastThread > tickTime) then
                currentThread = false
            end
            Wait(0)
        end
    end)

    TriggerEvent('minera_notify', 'INFINITY-RP', 'Jūsų kalbų diapazonas dabar yra ' .. range .. ' Metrai', 'success', 5000)
end)

RegisterNetEvent('pma-voice:setTalkingMode', function(newTalkingRange)
    SendNUIMessage({action = "SetRange", range = newTalkingRange})
end)

CreateThread(function()
    while true do
        SendNUIMessage({
            action = "SetMicTalking",
            talking = NetworkIsPlayerTalking(PlayerId())
        })
        Wait(500)
    end
end)