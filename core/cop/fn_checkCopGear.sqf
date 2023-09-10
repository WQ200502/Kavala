#include "..\..\macro.h"
//  File: fn_checkCopGear.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Description: Verifies the player has acceptable gear on them and/ or in cargo

if !(((player getvariable ["isInEvent",["no"]]) select 0) == "no") exitWith {};
private _allowedClothing = ["H_Helmet_Skate","U_C_Man_casual_3_F","U_B_Wetsuit","U_Rangemaster","U_C_Man_casual_3_F","H_Cap_police","H_MilCap_blue","H_MilCap_gry","H_Cap_Black_IDAP_F","V_RebreatherB","B_Carryall_oucamo","V_PlateCarrierSpec_blk","H_CrewHelmetHeli_B","H_PilotHelmetHeli_B","H_HelmetSpecB_blk","V_PlateCarrier2_blk","H_HelmetB_black","H_HelmetB_TI_tna_F","H_PilotHelmetFighter_B","V_TacVest_blk","V_PlateCarrier1_blk","U_I_CombatUniform","B_Kitbag_rgr","V_PlateCarrierGL_blk","U_Marshal","G_Respirator_blue_F","G_Respirator_white_F","G_AirPurifyingRespirator_02_black_F","G_AirPurifyingRespirator_01_F","G_RegulatorMask_F","V_Safety_yellow_F","V_Safety_blue_F","V_Rangemaster_belt","H_Bandanna_gry","U_I_pilotCoveralls"];
private _allowedWeapons = ["hgun_P07_F","arifle_SDAR_F","Binocular","Rangefinder","launch_Titan_F","arifle_MX_GL_Black_F","arifle_MXM_Black_F","arifle_SPAR_01_GL_blk_F","arifle_SPAR_02_blk_F","arifle_ARX_blk_F","srifle_DMR_07_blk_F","arifle_MX_SW_Black_F","srifle_DMR_02_F","srifle_DMR_03_F","arifle_SPAR_03_blk_F","hgun_Pistol_heavy_01_green_F","arifle_MX_Black_F","arifle_SPAR_01_blk_F","hgun_Pistol_heavy_02_F","SMG_03_TR_black","SMG_02_ACO_F","arifle_MSBS65_black_F","arifle_MSBS65_GL_black_F","arifle_MSBS65_Mark_black_F","arifle_AK12U_F","arifle_AK12_F","arifle_AK12_GL_F","arifle_RPK12_F","sgun_HunterShotgun_01_F","srifle_EBR_ACO_F", "LMG_03_Vehicle_F","hgun_Pistol_Signal_F","srifle_DMR_05_blk_F","srifle_DMR_02_F"];
private _allowedItems = ["FirstAidKit","ToolKit","ItemGPS","ItemMap","ItemCompass","MineDetector","Binocular","NVGoggles_OPFOR","NVGoggles_INDEP","O_NVGoggles_grn_F","Rangefinder","SmokeShell","SmokeShellBlue","Chemlight_red","Chemlight_green","Chemlight_blue","Titan_AA","SmokeShellOrange"];
private _allowedOptics = ["optic_Aco_smg","optic_ACO_grn_smg","optic_ERCO_blk_F","optic_Hamr","optic_Arco","optic_Arco_blk_F","optic_MRD_black","optic_MRD","optic_Holosight_blk_F","optic_Holosight_smg_blk_F","optic_Arco_AK_blk_F","optic_ico_01_black_f","optic_MRCO"];
private _donorClothingF = ["H_Cap_usblack", "H_Watchcap_blk", "H_Cap_White_IDAP_F", "H_EarProtectors_white_F", "H_EarProtectors_black_F"];
private _donorClothingO = ["H_HeadSet_white_F", "H_HeadSet_black_F", "G_Bandana_Sport", "G_Bandana_Beast", "G_Bandana_blk", "G_Bandana_Shades"];

private _donorClothing250 = ["U_C_Man_casual_2_F","U_B_GEN_Soldier_F","U_I_CombatUniform_shortsleeve","U_I_Wetsuit","H_Cap_headphones","H_Cap_grn","H_Cap_oli","H_Cap_grn_BI","H_Cap_oli_hs","H_Cap_khaki_specops_UK","H_MilCap_grn","H_MilCap_wdl","H_Watchcap_camo","H_Booniehat_oli","H_HelmetB","H_PASGT_basic_olive_F","H_HelmetB_plain_wdl","H_HelmetCrew_I","H_HelmetSpecB","H_HelmetSpecB_wdl","H_CrewHelmetHeli_O","H_PilotHelmetHeli_O","H_HelmetB_light_wdl","H_HelmetHBK_F","H_PilotHelmetFighter_O","G_AirPurifyingRespirator_02_olive_F","G_Balaclava_oli","V_PlateCarrierSpec_wdl","V_PlateCarrier1_wdl","V_PlateCarrier2_wdl","V_PlateCarrierGL_wdl","V_TacVest_oli"];

private _save = false;
private _copLevel = 0;

_copLevel = (__GETC__(life_coplevel));
_donorLevel = (__GETC__(oev_donator));
_staffLevel = (__GETC__(life_adminlevel));

if (_donorLevel >= 50) then{
	_allowedClothing append _donorClothingF;
};
if (_donorLevel >= 100) then{
	_allowedClothing append _donorClothingO;
	if (_copLevel >= 2) then {
		_allowedClothing append ["U_B_GEN_Commander_F"];
	};
	if (_copLevel >= 3) then {
		_allowedClothing append ["H_Beret_gen_F"];
		_allowedClothing append ["H_Beret_EAF_01_F"];
	};
};

if (_donorLevel >= 15) then{
	_allowedClothing append _donorClothingO;
	if (_copLevel >= 1) then{
		_allowedClothing append ["H_HelmetO_ViperSP_ghex_F"];
};

if (_donorLevel >= 250) then {
	_allowedClothing append _donorClothing250;
};

if (_donorLevel >= 250 && _copLevel >= 3) then{
	_allowedClothing append _donorClothingO;
};

if (_copLevel >= 2) then {
	_allowedClothing append ["V_TacVest_blk_POLICE"];
	_allowedItems append ["HandGrenade_Stone","acc_flashlight","acc_flashlight_pistol", "acc_pointer_IR"];
};

if (_copLevel >= 3) then {
	_allowedClothing append ["U_Marshal","H_Beret_blk_POLICE","H_Beret_Colonel","U_Competitor","U_C_Man_casual_1_F"];
	{
		_allowedItems pushBack (format ["1Rnd_Smoke%1_Grenade_shell", _x]);
		_allowedItems pushBack (format ["3Rnd_Smoke%1_Grenade_shell", _x]);
	} forEach ["Orange", "Blue"];
	_allowedItems append ["bipod_02_F_blk","bipod_01_F_blk","bipod_03_F_blk"];
};

if (_copLevel >= 4) then {
	_allowedClothing append ["U_B_CombatUniform_mcam","H_Beret_02","H_PASGT_basic_black_F","H_Bandanna_gry"];
	_allowedItems append ["muzzle_snds_acp"];
	_allowedItems append ["muzzle_snds_L"];
	_allowedItems append ["B_Bergen_dgtl_F"];
};

if ((getPlayerUID player) isEqualTo "76561198010422149") then {
	_allowedClothing append ["U_O_CombatUniform_ocamo"];
};

if (_copLevel >= 8) then {
	_allowedItems append ["muzzle_snds_65_TI_blk_F"];
	_allowedItems append ["muzzle_snds_H"];
};

if ((getPlayerUID player isEqualTo "76561198371289799") || (__GETC__(oev_developerlevel) >= 3)) then {
	_allowedItems append ["muzzle_snds_B"];
	_allowedoptics append ["optic_DMS"];
};

if (_staffLevel > 3) exitWith {};

if !(primaryWeapon player isEqualTo "") then {
	if !(primaryWeapon player in _allowedWeapons) then {
		player removeWeapon primaryWeapon player;
		_save = true;
	};
};
//6.5消音
if (603 in life_loot) then {
	_allowedItems append ["muzzle_snds_H_khk_F"];
	_allowedItems append ["muzzle_snds_H_snd_F"];
};	
//脚架
if (601 in life_loot) then {
	_allowedItems append ["bipod_01_F_snd  "];
	_allowedItems append ["bipod_01_F_mtp"];
};
//5.8消音
if (602 in life_loot) then {
	_allowedItems append ["muzzle_snds_58_hex_F"];
};
//5.56消音
if (601 in life_loot) then {
	_allowedItems append ["muzzle_snds_m_khk_F "];
};	
//7.62消音
if (604 in life_loot) then {
	_allowedItems append ["muzzle_snds_B_khk_F"];
	_allowedItems append ["muzzle_snds_B_snd_F"];
};
private _primaryAttch = primaryWeaponItems player;

if !(_copLevel isEqualTo 8 || getPlayerUID player isEqualTo "76561198068537683") then {
	if !((_primaryAttch select 0) in _allowedItems) then {
		player removePrimaryWeaponItem (_primaryAttch select 0);
		_save = true;
	};
};

if !((_primaryAttch select 2) in _allowedOptics) then {
	player removePrimaryWeaponItem (_primaryAttch select 2);
	_save = true;
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

if (!(missionNamespace getVariable ["oev_bait_active", false])) then {
	private _bcRemoteVar = ["bcremote", 0] call OEC_fnc_varHandle;
	private _bcRemoteCount = missionNamespace getVariable [_bcRemoteVar, 0];
	if (_bcRemoteCount > 0) then {
		[false, "bcremote", _bcRemoteCount] call OEC_fnc_handleInv;
	};
};
