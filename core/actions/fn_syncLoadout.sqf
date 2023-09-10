#include "..\..\macro.h"

if(scriptAvailable(30)) exitWith {hint "You need to wait 30 seconds between syncing your loadouts!"};

// Sync Gear locally

hint "Sync'd your loadout!";
[true] call OEC_fnc_saveGear;
life_gear_snapshot = life_gear;
