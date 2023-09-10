//  File: fn_territoryGarage.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Description: Handles spawning vehicles at cartels

if(oev_garageCooldown > time) exitWith {hint "Please do not spam your garage. It may take a bit to show your vehicles if the server is under heavy load.";};

private _object = _this select 0;

private _locID = _object getVariable ["cartel_num",-1];
if (_locID isEqualTo -1) exitWith {hint "An error occured...";};

private _spawns = switch (_locID) do {
	case 1: {["cartel_1","cartel_2"]};
	case 2: {["cartel_3","cartel_4"]};
	case 3: {["cartel_5","cartel_6"]};
	case 4: {["cartel_7","cartel_8"]};
	//case 5: {["cartel_9","cartel_10"]};
	default {[]};
};

if (count _spawns < 1) exitWith {hint "An error occured...";};
[[getPlayerUID player,playerSide,"Car",player],"OES_fnc_getVehicles",false,false] spawn OEC_fnc_MP;
["Life_impound_menu"] call OEC_fnc_createDialog;
disableSerialization;
ctrlSetText[2802,"Fetching Vehicles...."];
oev_garage_sp = _spawns;
oev_garage_type = "Car";
oev_garageCooldown = time+5;