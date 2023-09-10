#include "..\..\macro.h"
//  File: fn_checkMedGear.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Description: Verifies the player has acceptable gear on them and/ or in cargo

if !(((player getvariable ["isInEvent",["no"]]) select 0) == "no") exitWith {};
private _allowedClothing = ["U_I_Wetsuit","U_I_CombatUniform_shortsleeve","H_Cap_blu","V_RebreatherIA","B_Carryall_oucamo","V_Rangemaster_belt"];
private _allowedWeapons = ["Binocular","Rangefinder"];
private _allowedItems = ["ItemGPS","ItemMap","ItemWatch","Binocular","Rangefinder","ToolKit","Medikit","Chemlight_yellow","NVGoggles_INDEP","SmokeShellYellow","Chemlight_red","Chemlight_green","Chemlight_blue","FirstAidKit","6Rnd_GreenSignal_F","6Rnd_RedSignal_F","NVGoggles_OPFOR"];
private _allowedOptics = [];
private _save = false;
private _medLevel = 0;
_medLevel = (__GETC__(life_medicLevel));
private _donorLevel = (__GETC__(oev_donator));

if (_medLevel >= 2) then {
	_allowedClothing append ["H_Cap_red"];
};

if (_medLevel >= 3) then {
	_allowedClothing append ["U_O_PilotCoveralls","H_Cap_headphones","H_PilotHelmetHeli_O","H_PilotHelmetFighter_I"];
	if (_donorLevel >= 100) then {
		_allowedClothing append ["U_I_pilotCoveralls","H_PilotHelmetHeli_B","H_CrewHelmetHeli_B","H_PilotHelmetFighter_B"];
	};
};

if (_medLevel >= 4) then {
	_allowedClothing pushBack "H_PilotHelmetFighter_I";
	_allowedClothing append ["V_BandollierB_blk","U_B_CBRN_Suit_01_MTP_F","H_Construction_headset_yellow_F","G_RegulatorMask_F","B_SCBA_01_F", "H_Bandanna_surfer"];
};

if (_medLevel >= 5) then {
	_allowedClothing append ["H_CrewHelmetHeli_O","H_PilotHelmetHeli_B","H_CrewHelmetHeli_B","H_PilotHelmetFighter_B","U_I_CombatUniform"];
	_allowedWeapons append ["hgun_Pistol_Signal_F"];
};

if (_medLevel >= 6) then {
	_allowedClothing append ["G_Bandanna_aviator","G_Bandanna_beast","G_Bandanna_blk","G_Bandanna_khk","G_Bandanna_oli","G_Bandanna_shades","G_Bandanna_sport","G_Bandanna_tan"];
};

if (_medLevel >= 7) then {
	_allowedClothing append ["H_HelmetB_black","H_HelmetB_TI_tna_F","H_PilotHelmetFighter_B","H_PilotHelmetHeli_B"];
	_allowedItems append ["NVGogglesB_gry_F"];
};



if !(primaryWeapon player isEqualTo "") then {
	if !(primaryWeapon player in _allowedWeapons) then {
		player removeWeapon primaryWeapon player;
		_save = true;
	};
};

if !(secondaryWeapon player isEqualTo "") then {
	if !(secondaryWeapon player in _allowedWeapons) then {
		player removeWeapon secondaryWeapon player;
		_save = true;
	};
};
if !(handgunWeapon player isEqualTo "") then {
	if !(handgunWeapon player in _allowedWeapons) then {
		player removeWeapon handgunWeapon player;
		_save = true;
	};
};
if !(uniform player isEqualTo "") then {
	if !(uniform player in _allowedClothing) then {
		removeUniform player;
		_save = true;
	};
};

if !(vest player isEqualTo "") then {
	if !(vest player in _allowedClothing) then {
		removeVest player;
		_save = true;
	};
};

if !(headgear player isEqualTo "") then {
	if !(headgear player in _allowedClothing) then {
		removeHeadgear player;
		_save = true;
	};
};

private _allAllowed = _allowedItems + _allowedClothing + _allowedWeapons + _allowedOptics;
private _badItems = [];
{
	if (isClass (configFile >> "CfgMagazines" >> _x)) exitWith {};
	if !(_x in _allAllowed) then {_badItems pushBackUnique _x;};
} forEach (uniformItems player);

{
	if (isClass (configFile >> "CfgMagazines" >> _x)) exitWith {};
	if !(_x in _allAllowed) then {_badItems pushBackUnique _x;};
} forEach (backpackItems player);

{
	if (isClass (configFile >> "CfgMagazines" >> _x)) exitWith {};
	if !(_x in _allAllowed) then {_badItems pushBackUnique _x;};
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
