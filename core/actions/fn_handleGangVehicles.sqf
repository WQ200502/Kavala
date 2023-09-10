//	File: fn_handleGangVehicles.sqf
//	Author: ikiled
//	Description: Handles opening of player gang garages via NPCs

if(oev_garageCooldown > time) exitWith {hint "请不要给你的车库发垃圾邮件。如果服务器负载过重，可能需要一点时间来展示您的车辆。";};
if !((count oev_gang_data) > 0) exitWith {hint "你必须加入帮派才能进入帮派车库。"};
if ((oev_gang_data select 2) < 2) exitWith {hint "你必须是帮派等级2或更高才能进入你的帮派车库。"};

params ["_type","_spawn"];

[[getPlayerUID player,playerSide,_type,player,true,(oev_gang_data select 0)],"OES_fnc_getVehicles",false,false] spawn OEC_fnc_MP;
["Life_impound_menu"] call OEC_fnc_createDialog;
disableSerialization;
ctrlSetText[2802,"Fetching Vehicles...."];
oev_garage_sp = _spawn;
oev_garage_type = _type;
oev_garageCooldown = time+5;