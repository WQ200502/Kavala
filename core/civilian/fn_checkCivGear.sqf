#include "..\..\macro.h"
//  File: fn_checkCivGear.sqf
//	Author: Fusah
//	Description: If cops and medics get one why not CIVILIANS :D

if !(((player getvariable ["isInEvent",["no"]]) select 0) == "no") exitWith {};

private _save = false;
private _disallowedClothing = [];
private _disallowedWeapons = [];
private _disallowedItems = ["Medikit"];
private _disallowedOptics = [];

if !(primaryWeapon player isEqualTo "") then {
	if (primaryWeapon player in _disallowedWeapons) then {
		player removeWeapon primaryWeapon player;
		_save = true;
	};
};

if !(secondaryWeapon player isEqualTo "") then {
	if (secondaryWeapon player in _disallowedWeapons) then {
		player removeWeapon secondaryWeapon player;
		_save = true;
	};
};

if !(handgunWeapon player isEqualTo "") then {
	if (handgunWeapon player in _disallowedWeapons) then {
		player removeWeapon handgunWeapon player;
		_save = true;
	};
};

if !(uniform player isEqualTo "") then {
	if (uniform player in _disallowedClothing) then {
		removeUniform player;
		_save = true;
	};
};

if !(vest player isEqualTo "") then {
	if (vest player in _disallowedClothing) then {
		removeVest player;
		_save = true;
	};
};

if !(headgear player isEqualTo "") then {
	if (headgear player in _disallowedClothing) then {
		removeHeadgear player;
		_save = true;
	};
};

private _allDisallowed = _disallowedItems + _disallowedClothing + _disallowedWeapons + _disallowedOptics;
private _badItems = [];
{
	if (isClass (configFile >> "CfgMagazines" >> _x)) exitWith {};
	if (_x in _allDisallowed) then {_badItems pushBackUnique _x;};
} forEach (uniformItems player);

{
	if (isClass (configFile >> "CfgMagazines" >> _x)) exitWith {};
	if (_x in _allDisallowed) then {_badItems pushBackUnique _x;};
} forEach (backpackItems player);

{
	if (isClass (configFile >> "CfgMagazines" >> _x)) exitWith {};
	if (_x in _allDisallowed) then {_badItems pushBackUnique _x;};
} forEach (vestItems player);

if ((count _badItems) > 0) then {
	{
		player removeItems _x;
	} forEach _badItems;
	_save = true;
};

if (_save) then {
	[false] call OEC_fnc_saveGear;
};