#include "..\..\macro.h"
// File: fn_compCrate.sqf
// Author: Jesse "tkcjesse" Schultz
// Description: Creates an admin compensation crate

params [
	["_playerid","",[""]]
];

if (true) exitWith {};
if (_playerid isEqualTo "") exitWith {};
if ((__GETC__(life_adminlevel) < 3) && (__GETC__(oev_developerlevel) < 3)) exitWith {hint "You are not approved for compensation yet. Contact a senior admin or developer.";};
if (player distance (getMarkerPos "admin_island") > 1200) exitWith {};
if (oev_adminHasCrate) exitWith {hint "You already have an active compensation crate active."};

private _staffList = [];

private _characterByte = toArray _playerid;
private _length = count (_characterByte);
private _allowed = toArray ("0123456789");
private _badCharacter = false;

if !(_length isEqualTo 17) exitWith {hint "The user id you entered doesn't contain 17 digits!";};

{
	if (!(_x in _allowed)) exitWith {_badCharacter = true;};
} forEach _characterByte;
if (_badCharacter) exitWith {hint "The user id you entered has illegal characters in it!";};

private _steamValidate = _playerid select [0,7];
if !(_steamValidate isEqualTo "7656119") exitWith {hint "You have entered an invalid player id!";};

oev_action_inUse = true;
oev_adminHasCrate = true;
closeDialog 0;
hint format ["Creating crate for UID: %1",_playerid];

[[player,_playerid],"OES_fnc_adminCreateComp",false,false] spawn OEC_fnc_MP;
