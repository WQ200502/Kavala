#include "..\..\macro.h"
if(scriptAvailable(180)) exitWith {hint "You cannot spam the clothing bug fix! Please wait 3 minutes!";};
//  File: fn_clothingBugFix.sqf
//	Author: TheCmdrRex
//	Description: Fixes clothing bug where server side has player lose close (essentially uses clothing store method)

private ["_currentClothes","_uniform","_backpack","_vest","_glasses","_hat","_magazines","_uniformItems","_vestItems","_backpackItems"];

hint "Fixing clothes....";
_currentClothes = getUnitLoadout player;
uiSleep random(10);
if (!alive player) exitWith {};
if (isNull player) exitWith {};
if (vehicle player != player) exitWith {};
if !(_currentClothes isEqualTo (getUnitLoadout player)) exitWith {hint "Your loadout is not the same as before!";};
player setUnitLoadout _currentClothes;
hint "Your clothes have been re-applied!";

[
  ["event","Refreshed Clothes"],
  ["player",name player],
  ["player_id",getPlayerUID player],
  ["loadout_before",_currentClothes],
  ["loadout_after",getUnitLoadout player],
  ["position",getPosATL player]
] call OEC_fnc_logIt;
