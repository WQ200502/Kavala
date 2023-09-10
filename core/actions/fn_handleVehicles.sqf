//	File: fn_handleVehicles.sqf
//	Author: Fusah
//	Description: Handles opening of player garages.

if(oev_garageCooldown > time) exitWith {hint "请不要给你的车库发垃圾邮件。如果服务器负载过重，可能需要一点时间来展示您的车辆。";};

params ["_type","_spawn"];

[[getPlayerUID player,playerSide,_type,player],"OES_fnc_getVehicles",false,false] spawn OEC_fnc_MP;
["Life_impound_menu"] call OEC_fnc_createDialog;
disableSerialization;
ctrlSetText[2802,"Fetching Vehicles...."];
oev_garage_sp = _spawn;
oev_garage_type = _type;
oev_garageCooldown = time+5;