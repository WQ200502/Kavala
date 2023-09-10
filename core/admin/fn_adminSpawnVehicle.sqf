#include "..\..\macro.h"
// File: fn_adminSpawnVehicle.sqf

if(__GETC__(life_adminlevel) < 3) exitWith {hint "Insufficient Permissions";};

disableSerialization;
private _unit = lbData[1501,lbCurSel (1501)];
if (isNil "_unit") exitWith {};

hint "Sending request to server to create vehicle...";
[_unit,(position player)] remoteExec ["OES_fnc_createAdminVeh",2];

[
  ["event", "ADMIN Vehicle Spawn"],
  ["player", name player],
  ["player_id", getPlayerUID player],
  ["vehicle", _unit],
  ["position", getPos player]
] call OEC_fnc_logIt;
