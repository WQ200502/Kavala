#include "..\..\macro.h"
//  File: fn_adminTpPos.sqf
//	Author: Jesse "tkcjesse" Schultz

//	Description: Admin teleport to XYZ position

if(__GETC__(life_adminlevel) < 2) exitWith {hint "Insufficient Permissions";};

private _coords = ctrlText 1041;

_coords = _coords splitString "[,]";
_clean = [];
{_clean pushBack (parseNumber _x)} forEach _coords;

private _prevlocationPos = getPos player;

if !(_clean isEqualType []) exitWith {hint "You didn't enter the coordinates properly!";};
if !((count _clean) isEqualTo 3) exitWith {hint "You didn't enter the coordinates properly!";};

player setPos _clean;

[
  ["event", "ADMIN TP Pos"],
  ["player", name player],
  ["player_id", getPlayerUID player],
  ["position", _clean],
  ["prev_position", _prevlocationPos]
] call OEC_fnc_logIt;
