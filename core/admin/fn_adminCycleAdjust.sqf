#include "..\..\macro.h"
//  File: fn_adminCycleAdjust.sqf
//	Author: Bow
//	Description: Allows the restart buttons to have a dialog confirmation before adjusting the cycle.

params [
	["_mode",-1,[0]],
	["_player",objNull,[objNull]]
];

if ((__GETC__(life_adminlevel) < 3) && (__GETC__(oev_developerlevel) < 3)) exitWith {hint "Insufficient Permissions";};

private _action = [
	"You are about to adjust the server restart cycle",
	"Server cycle adjustment",
	"Confirm",
	"Cancel"
] call BIS_fnc_guiMessage;

if(!_action) exitWith {
	hint "Server cycle adjustment canceled";
};

[[_mode, _player],'OES_fnc_manageCycle',false,false] spawn OEC_fnc_MP;
