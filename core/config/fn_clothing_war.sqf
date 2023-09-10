#include "..\..\macro.h"
//  File: fn_clothing_war.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Master configuration file for Reb shop.
private["_filter","_ret"];
_filter = param [0,0,[0]];

_acceptedID = ((call life_adminlevel) isEqualTo 4);
//Classname, Custom Display name (use nil for Cfg->DisplayName, price

//Shop Title Name
ctrlSetText[3103,"War Point Clothing"];
if (_acceptedID) then {
	ctrlSetText[3103,"Senior Staff Clothing"];
};
_ret = [];
switch (_filter) do {
	//Uniforms
	case 0: {
		switch(_acceptedID) do {
			case (true): {
				_ret = [
					["U_O_CombatUniform_oucamo",nil,1],
					["U_O_SpecopsUniform_ocamo",nil,1],
					["U_O_T_Soldier_F","Fatigues (Pink)",1],
					["U_O_CombatUniform_ocamo","Fatigues (Black)",1],
					["U_O_T_Sniper_F",nil,1],
					["U_O_GhillieSuit",nil,1],
					["U_O_T_FullGhillie_tna_F",nil,1],
					["U_O_FullGhillie_lsh",nil,1],
					["U_O_FullGhillie_sard",nil,1],
					["U_O_FullGhillie_ard",nil,1],
					["U_O_PilotCoveralls",nil,1],
					["U_O_R_Gorka_01_F",nil,1],
					["U_I_E_ParadeUniform_01_LDF_decorated_F",nil,1],					
					["U_O_R_Gorka_01_brown_F",nil,1],
					["U_O_R_Gorka_01_camo_F",nil,1],
					["U_C_FormalSuit_01_black_F",nil,1],
					["U_B_ParadeUniform_01_US_decorated_F",nil,1],
					["U_O_R_Gorka_01_black_F",nil,1]
				];
			};
			default {
				_ret = [
					["U_O_CombatUniform_oucamo",nil,5],
					["U_O_SpecopsUniform_ocamo",nil,5],
					["U_O_T_Soldier_F","Fatigues (Pink)",5],
					["U_O_CombatUniform_ocamo","Fatigues (Black)",5],
					["U_O_T_Sniper_F",nil,5],
					["U_O_GhillieSuit",nil,6],
					["U_O_T_FullGhillie_tna_F",nil,5],
					["U_O_FullGhillie_lsh",nil,5],
					["U_O_FullGhillie_sard",nil,5],
					["U_O_FullGhillie_ard",nil,5],
					["U_O_R_Gorka_01_F",nil,5],
					["U_O_R_Gorka_01_brown_F",nil,5],
					["U_O_R_Gorka_01_camo_F",nil,5],
					["U_O_R_Gorka_01_black_F",nil,5]
				];
			};
		};
	};
	//Hats
	case 1: {
		_ret = [
			["H_HelmetSpecO_blk",nil,2],
			["H_HelmetSpecO_ghex_F",nil,2],
			["H_HelmetSpecO_ocamo",nil,2],
			["H_HelmetAggressor_F",nil,2],
			["H_HelmetAggressor_cover_F",nil,2],
			["H_HelmetAggressor_cover_taiga_F",nil,2],
			["H_CrewHelmetHeli_O",nil,1],
			["H_Beret_EAF_01_F",nil,1],
			["H_CrewHelmetHeli_I",nil,1]
		];
	};

	//Glasses
	case 2: {
		_ret = [
			["G_Respirator_white_F",nil,1],
			["G_Bandanna_aviator",nil,1]
		];
	};

	//Vest
	case 3: {
		_ret = [
			["V_PlateCarrierIA1_dgtl",nil,2],
			["V_PlateCarrierL_CTRG",nil,2],
			["V_PlateCarrierIAGL_oli",nil,3]
		];
	};

	//Backpacks
	case 4: {
		_ret = [];
	};
};
_ret;
