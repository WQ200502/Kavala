#include "..\..\macro.h"
//	File: fn_clientWireTransfer.sqf
//	Authors: Tonic (I think) and significant modifications by TheCmdrRex and snippets from Fusah
//	Description: Used to send money from bank to other players
params [
	["_val",-1,[0]],
	["_from",objNull,[objNull]],
	["_mode",0,[0]],
	["_fromID",-1,[0]],
	["_eventPay",false,[false]]
];

if (!([str(_val)] call OEC_fnc_isNumeric)) exitWith {};
if (_val isEqualTo -1) exitWith {};
if (isNull _from) exitWith {};
if (remoteExecutedOwner isEqualTo 0) exitWith {};
if (_fromID isEqualTo -1) exitWith {};
if (_from isEqualTo player && (__GETC__(life_adminlevel) < 1)) exitWith {[[3,_from,[format["Hacked Sender on Transfer | %1",_val]]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;};
if !(remoteExecutedOwner isEqualTo _fromID) exitWith {[[3,_from,[format["Hacked Sender on Transfer | %1",_val]]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;};

_log_event = "";

// Normal Bank Transfer (also used for admin and event wiring money)
if (_mode isEqualTo 0) then {
	// Check to make sure sender actually has what he sent
	if (_val > 999999) exitWith {[[3,_from,[format["Hacked Money Transfer | %1",_val]]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;};
	[0,_val,_eventPay] remoteExec ["OEC_fnc_checkFunds", _from, false];
	private _count = 0;
	private _bad = false;
	oev_status = false;
	waitUntil {
		uiSleep 0.5;
		_count = _count + 0.5;
		if (_count > 5) then {oev_status = true; _bad = true;};
		oev_status
	};
	if (_bad && (__GETC__(life_adminlevel) < 1)) exitWith {
		oev_wireFlag = oev_wireFlag + 1;
		if (oev_wireFlag > 3) then {[3,_from,[format["Money Transfer Flag: %2 | %1",_val, oev_wireFlag]]] remoteExec ["OES_fnc_handleDisc",2];};
	};
	oev_status = false;
	oev_atmcash = oev_atmcash + _val;
	oev_cache_atmcash = oev_cache_atmcash + _val;

	_log_event = "Received Wire Transfer";
	hint format["%1 has wire transferred $%2 to you.",name _from,[_val] call OEC_fnc_numberText];
};

// Dopamine Crate market purchase
if (_mode isEqualTo 1) then {
	// Needs price of Dopamine and items that can be bought. Currently bloodbags and dopamine are both 15000
	if (_val != 15000 || _val != 7500 || _val != 1500) exitWith {[3,_from,[format["Hacked Dope Crate Transfer | %1",_val]]] remoteExec ["OES_fnc_handleDisc",2];};
	oev_atmcash = oev_atmcash + _val;
	oev_cache_atmcash = oev_cache_atmcash + _val;

	systemChat format ["%1 has purchased %2 worth of medical supplies from your dopamine crate.",name _from,[_val] call OEC_fnc_numberText];
	_log_event = "Received Dope Crate $";
};

// Normal War Point Transfer
if (_mode isEqualto 2) then {
	// Check to make sure sender actually has what he sent
	if (_val > 999) exitWith {[3,_from,[format["Hacked WarPts Transfer | %1",_val]]] remoteExec ["OES_fnc_handleDisc",2];};
	[2,_val] remoteExec ["OEC_fnc_checkFunds", _from, false];
	private _count = 0;
	private _bad = false;
	oev_status = false;
	waitUntil {
		uiSleep 0.5;
		_count = _count + 0.5;
		if (_count > 5) then {oev_status = true; _bad = true;};
		oev_status
	};
	if (_bad) exitWith {
		oev_wireFlag = oev_wireFlag + 1;
		if (oev_wireFlag > 3) then {[3,_from,[format["WarPts Transfer Flag: %2 | %1",_val, oev_wireFlag]]]remoteExec["OES_fnc_handleDisc",2];};
	};
	oev_status = false;
	[1, (0 - _val), player] remoteExec ["OES_fnc_warGetSetPts", 2, false];

	_log_event = "Received WP Transfer";
	hint format ["%1 has wire transferred %2 war points to you.",name _from, [_val] call OEC_fnc_numberText];
};

[
	["event",_log_event],
	["player",name player],
	["player_id",getPlayerUID player],
	["sender",name _from],
	["sender_id",getPlayerUID _from],
	["amount",_val],
	["position",getPosATL player]
] call OEC_fnc_logIt;
