#include "..\..\macro.h"
//  File: fn_checkFunds.sqf
//	Author: Fusah
//	Modifications: TheCmdrRex
//	Description: Checks if player has funds for transfer (anti-cheat)

params [
	["_mode",-1,[0]],
	["_value",-1,[0]],
	["_eventPay",false,[false]]
];

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",name player],["player_id",getPlayerUID player],["hacked_cash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hacked_bank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)],["position",getPosATL player]] call OEC_fnc_logIt;
	[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]] remoteExec ["OEC_fnc_notifyAdmins",-2];
	[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]] remoteExec ["OES_fnc_handleDisc",2];
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

private _ret = false;

if (_mode < 0 || _value < 0) exitWith {};

private _tax = 0;
if (_mode == 0) then {
	_tax = [_value] call OEC_fnc_taxRate;
	_value = _value + _tax;
};

switch (_mode) do {
	case 0: {
		//Bank
		if (_eventPay && (__GETC__(life_adminlevel) >= 1)) exitWith {
			_ret = true;
		};
		if (oev_atmcash >= _value) exitWith {
			_ret = true;
			oev_atmcash = oev_atmcash - _value;
			oev_cache_atmcash = oev_cache_atmcash - _value;
			[1] call OEC_fnc_ClupdatePartial;
		};
	};
	case 1: {
		//Cash -- Not used
		if (oev_cash >= _value) exitWith {
			_ret = true;
			oev_cash = oev_cash - _value;
			oev_cache_cash = oev_cache_cash - _value;
			[0] call OEC_fnc_ClupdatePartial;
		};
	};
	case 2: {
		//Warpoints
		oev_warpts_count = -999;
		[0,0,player] remoteExec ["OES_fnc_warGetSetPts",2];
		waitUntil {!(oev_warpts_count isEqualTo -999)};
		uiSleep 0.5;
		if (_eventPay && (__GETC__(life_adminlevel) >= 1)) exitWith {
			_ret = true;
		};
		if (oev_warpts_count >= _value) exitWith {
			_ret = true;
			oev_warpts_count = oev_warpts_count - _value;
			[13] call OEC_fnc_ClupdatePartial;
		};
	};
};

if !(isNull (finddisplay 2700)) then {
	[objNull, objNull, -1, "", oev_bankMode] call OEC_fnc_atmMenu;
	ctrlEnable[2705,true];
};

if(__GETC__(life_adminlevel) >= 1) then {_ret = true;};

if (remoteExecutedOwner isEqualTo 0) exitWith {};
["oev_status", _ret] remoteExec ["OEC_fnc_netSetVar", remoteExecutedOwner,false];
