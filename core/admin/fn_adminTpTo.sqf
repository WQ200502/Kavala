#include "..\..\macro.h"
//	Description: Tp To a selected player	DESCRIPTIONEND
//  File: fn_adminTpTo

if(__GETC__(life_adminlevel) < 2) exitWith {hint "Insufficient Permissions";};

private["_unit","_pos","_prevlocationPos"];
_prevlocationPos = getPos player;
_unit = lbData[2902,lbCurSel (2902)];
_unit = call compile format["%1", _unit];
if(isNil "_unit") exitwith {};
if(isNull _unit) exitWith {};
if(_unit distance2D (getMarkerPos "debug_island_marker") < 600) exitWith {hint "This player is more than likely on debug. Teleport them to you instead once they are off debug.";};
if !(isDamageAllowed player) then {
	_pos = getPos _unit;
	vehicle player setPos _pos;
	uiSleep 0.25;
	_pos = getPos _unit;
	vehicle player setPos _pos;
	hint format["Tped to %1.", name _unit];
	uiSleep 5;
} else {
	player allowDamage false;
	_pos = getPos _unit;
	vehicle player setPos _pos;
	uiSleep 0.25;
	_pos = getPos _unit;
	vehicle player setPos _pos;
	hint format["Tped to %1.", name _unit];
	uiSleep 5;
	player allowDamage true;
};

O_stats_teleports = O_stats_teleports + 1;

[
	["event", "ADMIN TP To"],
	["player", name player],
	["player_id", getPlayerUID player],
	["target", name _unit],
	["target_id", getPlayerUID _unit],
	["position", getPos player],
	["prev_location", _prevlocationPos]
]	call OEC_fnc_logIt;
