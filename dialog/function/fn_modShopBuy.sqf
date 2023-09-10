#include "..\..\macro.h"
//  File: fn_modShopBuy
//	Description: updates the mod shop display and stuff
private["_oldArray","_newArray","_vehicle","_turbo","_result","_defaultMass"];
_vehicle = param [0,ObjNull,[ObjNull]];

if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",getPlayerUID player],["target","null"],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]] call OEC_fnc_logIt;
	[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};
//checks
if(isNull _vehicle) exitWith {};
if!(modshop_vehicle isEqualTo _vehicle) exitWith {};
_oldArray = [modshop_old_storage,modshop_old_security,modshop_old_turbo,modshop_old_insurance,modshop_old_paintFinish];
_newArray = [modshop_storage,modshop_security,modshop_turbo,modshop_insurance,modshop_paintFinish];
if(format["%1",_newArray] == format["%1",_oldArray]) exitWith {};
if(modshop_price > oev_atmcash && modshop_price > oev_cash) exitWith {hint "You can't afford these modifications!"};

if(oev_cash >= modshop_price) then {
	oev_cash = oev_cash - modshop_price;
	oev_cache_cash = oev_cache_cash - modshop_price;
}else{
	oev_atmcash = oev_atmcash - modshop_price;
	oev_cache_atmcash = oev_cache_atmcash - modshop_price;
};

modshop_price = 0;
[1] call OEC_fnc_ClupdatePartial;

_defaultMass = _vehicle getVariable["defaultModMass",2000];
_turbo = 1;
switch (modshop_turbo) do {
	case 0: {_turbo = 1;};
	case 1: {_turbo = 1.22;};
	case 2: {_turbo = 1.44;};
	case 3: {_turbo = 1.66;};
	case 4: {_turbo = 1.88;};
};
if(_turbo > 0) then {
	if(typeof _vehicle in ["B_Heli_Light_01_F","O_Heli_Light_02_unarmed_F","I_Heli_Transport_02_F","B_Heli_Transport_01_F","B_Heli_Transport_01_camo_F","C_Heli_Light_01_civil_F","O_Heli_Transport_04_F","O_Heli_Transport_04_repair_F","O_Heli_Transport_04_bench_F","O_Heli_Transport_04_covered_F","O_Heli_Transport_04_medevac_F","B_Heli_Transport_03_unarmed_F","C_Plane_Civil_01_F","C_Plane_Civil_01_racing_F","B_T_VTOL_01_vehicle_F","B_T_VTOL_01_infantry_F","B_Heli_Transport_03_F","B_Heli_Transport_03_unarmed_green_F","O_Heli_Transport_04_fuel_F","I_Heli_light_03_unarmed_F","I_Heli_light_03_dynamicLoadout_F"]) then {
		_vehicle setMass (_defaultMass*(_turbo));
	} else {
		_vehicle setMass (_defaultMass/(_turbo));
	};
};

// Spawns the function that determines if the vehicle is heli and needs to land to repair, or if it is a car.
if !(player getVariable["buyAndMod",false]) then {
	[_vehicle] spawn OEC_fnc_serviceHeli;
} else {
	player setVariable["buyAndMod",false];
};

//_vehExceptionList = ["O_Heli_Light_02_unarmed_F","B_MRAP_01_F","I_MRAP_03_F"];
//if(((modshop_old_paintFinish select 0) == -1) && !((typeOf _vehicle) in _vehExceptionList)) then {
//	modshop_paintFinish set[0,-1];
//};
_mods = _vehicle getVariable ["modifications",[0,0,0,0,0,0,0,0]];
_mods set [0,modshop_turbo];
_mods set [1,modshop_storage];
_mods set [2,modshop_security];
[_vehicle,modshop_insurance,modshop_paintFinish,_mods] remoteExec ["OES_fnc_updateVehicleMods",2];

// paint or chrome changed
if (!((modshop_paintFinish select 0) isEqualTo (modshop_old_paintFinish select 0)) || !((modshop_paintFinish select 1) isEqualTo (modshop_old_paintFinish select 1))) then {
//	hint format ["Selected Finish: %1 | Old Finish: %2 | Skin changed: %3 | Material changed: %4", modshop_paintFinish, modshop_old_paintFinish, modshop_paintFinish select 0 != modshop_old_paintFinish select 0, modshop_paintFinish select 1 != modshop_old_paintFinish select 1];
	[[_vehicle,"oev_veh_color",modshop_paintFinish,true],"OES_fnc_setObjVar",false,false] spawn OEC_fnc_MP;
	[[_vehicle,modshop_paintFinish],"OEC_fnc_colorVehicle",true,false] spawn OEC_fnc_MP;
};

if (!(modshop_security isEqualTo modshop_old_security) && modshop_security >= 3) then {
	[_vehicle, false] call OEC_fnc_installTracker;
};

[[_vehicle,"modifications",[modshop_turbo,modshop_storage,modshop_security,0,0,0,0,0],true],"OES_fnc_setObjVar",false,false] spawn OEC_fnc_MP;
[[_vehicle,"insured",modshop_insurance,true],"OES_fnc_setObjVar",false,false] spawn OEC_fnc_MP;
