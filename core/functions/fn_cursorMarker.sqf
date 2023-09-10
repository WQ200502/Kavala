// File: fn_cursorMarker.sqf
// Author: Matt "codeYeTi" Coffin
// Description: Creates a group chat marker at the player's cursor location.
private ["_pos","_markerName","_markerText"];
if (isNil "oev_cursorMarkerTime") then {
	oev_cursorMarkerTime = 0;
};
if (player getVariable ["restrained", false]) exitWith {};
if (time - oev_cursorMarkerTime < 15) exitWith { hint "You cannot spam target markers."; };
oev_cursorMarkerTime = time;

_markerName = format ["_USER_DEFINED %1_target", getPlayerUID player];
_pos = screenToWorld [0.5, 0.5];
_markerText = format ["%1's target", name player];
[_markerName, _pos, "ICON", "loc_ViewTower", _markerText] remoteExecCall ["OEC_fnc_createMarkerLocal", group player, false];
