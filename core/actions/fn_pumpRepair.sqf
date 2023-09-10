//  File: fn_pumpRepair.sqf
//	Description: Quick simple action that is only temp.
private["_method"];
if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[
		["event","Hacked Cash"],
		["player",name player],
		["player_id",getPlayerUID player],
		["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],
		["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)],
		["location",getPosATL player]
	] call OEC_fnc_logIt;
	[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};


if(oev_cash < 500) then {
	if(oev_atmcash < 500) exitWith {_method = 0;};
	_method = 2;
} else {
	_method = 1;
};

private _dam_obj = vehicle player;
switch (_method) do {
	case 0: {hint "你没有500元现金或存款。"};
	case 1: {_dam_obj setDamage 0; oev_cash = oev_cash - 500; oev_cache_cash = oev_cache_cash - 500; hint "你花了500元修好了你的车";};
	case 2: {_dam_obj setDamage 0; oev_atmcash = oev_atmcash - 500; oev_cache_atmcash = oev_cache_atmcash - 500; hint "你花了500元修好了你的车";};
};
