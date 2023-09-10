#include "..\..\macro.h"
//  File: fn_adminRestrain.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Retrains the target.
if(__GETC__(life_adminlevel) < 1) exitWith {hint "Insufficient Permissions";};
private["_unit"];


//_unit = cursorTarget;
_unit = lbData[2902,lbCurSel (2902)];
_unit = call compile format["%1", _unit];
if(isNil "_unit") exitwith {};
if(isNull _unit) exitWith {};
if(!isPlayer _unit) exitWith {};

if((_unit getVariable "restrained")) exitWith {};

[[], "OEC_fnc_closeMap", _unit, false] spawn OEC_fnc_MP;
uisleep 0.1;
_unit setVariable["restrained",true,true];

[[player], "OEC_fnc_restrain", _unit, false] spawn OEC_fnc_MP;

hint format["%1 restrained.", name _unit];

[
  ["event", "ADMIN Restrain"],
  ["player", name player],
  ["player_id", getPlayerUID player],
  ["target", name _unit],
  ["target_id", getPlayerUID _unit],
  ["player_position", getPos player],
  ["target_position", getpos _unit]
] call OEC_fnc_logIt;
