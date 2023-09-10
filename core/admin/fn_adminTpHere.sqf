#include "..\..\macro.h"
//	Description: Tp a selected player to you
//  File: fn_adminTpHere.sqf

if(__GETC__(life_adminlevel) < 2) exitWith {hint "Insufficient Permissions";};
private["_unit","_myPos","_targetprevPos"];

O_stats_teleports = O_stats_teleports + 1;

_myPos = getPosASL player;
_unit = lbData[2902,lbCurSel (2902)];
_unit = call compile format["%1", _unit];
_targetprevPos = getPos _unit; //To get location before teleport for logging purposes
if(isNil "_unit") exitwith {};
if(isNull vehicle _unit) exitWith {};

if(vehicle _unit == _unit) then {
	hint format ["Bringing %1 to you.", name _unit];
	uiSleep 1;
} else {
	hint format ["Bringing %1 and their vehicle %2 to you.", name _unit, typeOf vehicle _unit];
	uiSleep 1;
};

vehicle _unit attachTo [vehicle player, [2, 2, 0]];
uiSleep 1;
detach vehicle _unit;
uiSleep 0.05;
vehicle _unit setPosASL _myPos;

hint format["%1 brought to you.", name _unit];

[
	["event", "ADMIN TP Here"],
	["player", name player],
	["player_id", getPlayerUID player],
	["target", name _unit],
	["target_id", getPlayerUID _unit],
	["position", getPos player],
	["prev_position_target", _targetprevPos]
] call OEC_fnc_logIt;
