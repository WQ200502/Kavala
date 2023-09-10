#include "..\..\macro.h"
//  File: fn_unrestrain.sqf

if(__GETC__(life_adminlevel) < 1) exitWith {hint "Insufficient Permissions";};
private["_unit"];


//_unit = param [0,ObjNull,[ObjNull]];
_unit = lbData[2902,lbCurSel (2902)];
_unit = call compile format["%1", _unit];


if(isNull _unit || !(_unit getVariable["restrained",FALSE])) exitWith {}; //Error check?

_unit setVariable["restrained",FALSE,TRUE];
_unit setVariable["zipTied",FALSE,TRUE];
_unit setVariable["Escorting",FALSE,TRUE];
_unit setVariable["transporting",FALSE,TRUE];
detach _unit;

hint format["%1 un-restrained.", name _unit];

[
  ["event", "ADMIN Unrestrain"],
  ["player", name player],
  ["player_id", getPlayerUID player],
  ["target", name _unit],
  ["target_id", getPlayerUID _unit],
  ["player_position", getPos player]
] call OEC_fnc_logIt;
