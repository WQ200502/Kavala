#include "..\..\macro.h"
//  File: fn_payDeathFee.sqf
//	Author: TheCmdrRex
//	Description: Issues fee upon respawn, forcing cops to pay for their loadout


private ["_loadout","_fee"];
// Check on shit
if !(oev_copDeathPay) exitWith {};
if !(playerSide isEqualTo west) exitWith {};
if (__GETC__(life_coplevel) < 2) exitWith {};
_loadout = getUnitLoadout player;
_rank = (__GETC__(life_coplevel));
_fee = ([_loadout, "cop_basic"] call OEC_fnc_obtainPrice)*0.75; //75% of cop loadout
_fee = floor _fee;

if (oev_atmcash < _fee) then {_fee = oev_atmcash;};

oev_atmcash = oev_atmcash - _fee;
oev_cache_atmcash = oev_cache_atmcash - _fee;
[1] call OEC_fnc_ClupdatePartial;

titleText [format["You were forced to pay $%1 for dying in warzone",[_fee] call OEC_fnc_numberText],"PLAIN DOWN"];
[
	["event", "APD Death Fee"],
	["player", name player],
	["player_id", getPlayerUID player],
	["fee", _fee],
	["rank", _rank]
]	call OEC_fnc_logIt;

oev_copDeathPay = false;
