#include "..\..\macro.h"
//  File: fn_eventMenu.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Opens the event menu

if (__GETC__(life_adminlevel) < 1) exitWith {closeDialog 0;};
private["_display","_eventTypeList"];
disableSerialization;
waitUntil {!isNull (findDisplay 50000)};

[] spawn OEC_fnc_loadEventTypes;
[] spawn OEC_fnc_updateEventLocations;
[] spawn OEC_fnc_updateEventVehicles;
[] spawn OEC_fnc_loadEventActions;
[] spawn OEC_fnc_updateEventPlayers;