//  File: fn_calcGearScore.sqf
//	Author: Jesse "tkcjesse" Schultz

//	Description: Calculates a players gear scores for computation.

params [
	["_primary","",[""]],
	["_secondary","",[""]],
	["_handgun","",[""]],
	["_uniform","",[""]],
	["_vest","",[""]],
	["_headgear","",[""]]
];

private _pS = 0;
private _sS = 0;
private _hgS = 0;
private _uS = 0;
private _vS = 0;
private _hS = 0;
private _return = 0;

if !(_primary isEqualTo "") then {
    _pS = switch (_primary) do {
        case "hgun_PDW2000_F":{1};
        case "SMG_05_F":{1};
				case "SMG_01_F":{1};
        case "arifle_SDAR_F":{1};
        case "arifle_Mk20C_F":{2};
        case "arifle_TRG21_F":{2};
        case "arifle_CTAR_blk_F":{3};
        case "arifle_CTARS_blk_F":{5};
        case "arifle_TRG20_F":{2};
        case "arifle_Katiba_F":{3};
				case "arifle_SPAR_01_khk_F":{3};
				case "arifle_SPAR_01_blk_F":{3};
				case "arifle_SPAR_01_sand_F":{3};
				case "arifle_SPAR_01_GL_blk_F":{3};
				case "arifle_SPAR_01_GL_sand_F":{3};
				case "arifle_SPAR_02_snd_F":{4};
				case "arifle_SPAR_02_khk_F":{4};
				case "arifle_SPAR_02_blk_F":{4};
        case "arifle_SPAR_03_khk_F":{6};
        case "arifle_ARX_hex_F":{4};
				case "arifle_ARX_ghex_F":{4};
				case "arifle_ARX_blk_F":{4};
        case "LMG_03_F":{5};
		    case "LMG_03_Vehicle_F":{5};
        case "srifle_DMR_03_khaki_F":{6};
				case "srifle_DMR_03_tan_F":{6};
				case "srifle_DMR_03_woodland_F":{6};
				case "srifle_DMR_03_multicam_F":{6};
        case "srifle_DMR_01_F":{5};
        case "srifle_EBR_F":{6};
        case "srifle_EBR_ACO_F":{6};
        case "srifle_DMR_06_camo_F":{5};
        case "srifle_DMR_06_olive_F":{5};
        case "srifle_DMR_06_hunter_F":{5};
        case "LMG_Mk200_F":{7};
        case "LMG_Mk200_black_F":{7};
        case "arifle_MX_F":{3};
				case "arifle_MX_black_F":{3};
        case "arifle_MX_khk_F":{3};
				case "arifle_MXC_F":{3};
				case "arifle_MXC_black_F":{3};
				case "arifle_MXC_khk_F":{3};
        case "arifle_MXM_F":{5};
				case "arifle_MXM_Black_F":{5};
        case "arifle_MXM_khk_F":{5};
        case "arifle_MX_SW_F":{6};
				case "arifle_MX_SW_black_F":{6};
        case "arifle_MX_SW_khk_F":{6};
        case "srifle_DMR_07_ghex_F":{4};
        case "srifle_DMR_07_hex_F":{4};
				case "srifle_DMR_07_blk_F":{4};
        case "srifle_DMR_02_camo_F":{7};
				case "srifle_DMR_02_F":{7};
        case "srifle_DMR_04_Tan_F":{7};
        case "SMG_03_TR_hex":{4};
				case "SMG_03_TR_black":{4};
        case "SMG_03_TR_camo":{4};
				case "SMG_03C_TR_camo":{4};
        case "LMG_Zafir_F":{7};
        case "arifle_AKS_F":{3};
        case "arifle_AKM_F":{4};
				case "arifle_AK12U_F":{5};
        case "arifle_AK12U_arid_F":{5};
        case "arifle_AK12U_lush_F":{5};
				case "arifle_AK12_F":{5};
        case "arifle_AK12_arid_F":{5};
        case "arifle_AK12_lush_F":{5};
        case "arifle_RPK12_arid_F":{6};
        case "arifle_RPK12_lush_F":{6};
				case "arifle_RPK12_F":{6};
        case "arifle_MSBS65_F":{3};
				case "arifle_MSBS65_black_F":{3};
        case "arifle_MSBS65_camo_F":{3};
        case "arifle_MSBS65_sand_F":{3};
        case "arifle_MSBS65_mark_F":{5};
				case "arifle_MSBS65_mark_black_F":{5};
        case "arifle_MSBS65_mark_camo_F":{5};
        case "arifle_MSBS65_mark_sand_F":{5};
        case "arifle_MSBS65_UBS_camo_F":{7};
        case "sgun_HunterShotgun_01_sawedoff_F":{4};
        case "sgun_HunterShotgun_01_F":{5};
        default {1};
    };
};

if !(_secondary isEqualTo "") then {
    _sS = switch (_secondary) do {
        case "launch_RPG32_F":{5};
        case "launch_RPG32_F":{5};
        case "launch_I_Titan_F":{5};
        case "launch_RPG7_F":{5};
        default {3};
    };
};

if !(_handgun isEqualTo "") then {
    _hgS = switch (_handgun) do {
        case "hgun_Rook40_F":{1};
        case "hgun_Pistol_01_F":{1};
        case "hgun_Pistol_heavy_01_F":{1};
        case "hgun_Pistol_heavy_02_F":{1};

        case "hgun_ACPC2_F":{1};
        case "hgun_P07_khk_F":{1};
        default {1};
    };
};

if !(_uniform isEqualTo "") then {
    _uS = switch (_uniform) do {
        case "U_O_CombatUniform_ocamo":{2};
        case "U_O_CombatUniform_oucamo":{2};
        case "U_O_SpecopsUniform_ocamo":{2};
        case "U_O_T_Soldier_F":{2};
        case "U_O_T_Sniper_F":{3};
        case "U_O_PilotCoveralls":{3};
        case "U_O_T_FullGhillie_tna_F":{3};
        case "U_O_FullGhillie_ard":{3};
        case "U_O_FullGhillie_sard":{3};
        case "U_O_FullGhillie_lsh":{3};
        case "U_O_GhillieSuit":{3};
        case "U_B_Protagonist_VR":{0};
        case "U_I_Protagonist_VR":{0};
        case "U_O_Protagonist_VR":{0};
        case "U_O_R_Gorka_01_F":{2};
        case "U_O_R_Gorka_01_black_F":{2};
        case "U_O_R_Gorka_01_camo_F":{2};
        case "U_O_R_Gorka_01_brown_F":{2};
        default {1};
    };
};

if !(_vest isEqualTo "") then {
    _vS = switch (_vest) do {
        case "V_HarnessOGL_brn":{5};
        case "V_PlateCarrierSpec_rgr":{5};
        case "V_PlateCarrierSpec_blk":{5};
        case "V_TacVest_khk":{1};
        case "V_TacVest_brn":{1};
        case "V_TacVest_oli":{1};
        case "V_TacVest_camo":{1};
        case "V_TacVest_brn":{1};
        case "V_TacVest_blk":{1};
        case "V_TacVestIR_blk":{1};
        case "V_I_G_resistanceLeader_F":{1};
        case "V_TacVest_blk_POLICE":{2};
        case "V_DeckCrew_blue_F":{2};
        case "V_DeckCrew_brown_F":{2};
        case "V_DeckCrew_green_F":{2};
        case "V_DeckCrew_red_F":{2};
        case "V_DeckCrew_violet_F":{2};
        case "V_DeckCrew_white_F":{2};
        case "V_DeckCrew_yellow_F":{2};
        case "V_EOD_blue_F":{3};
        case "V_EOD_coyote_F":{3};
        case "V_EOD_olive_F":{3};
        case "V_CarrierRigKBT_01_Olive_F":{3};
        case "V_CarrierRigKBT_01_EAF_F":{3};
        case "V_CarrierRigKBT_01_light_Olive_F":{3};
        case "V_CarrierRigKBT_01_light_EAF_F":{3};
        case "V_PlateCarrierL_CTRG":{3};
        case "V_PlateCarrier1_rgr":{3};
        case "V_PlateCarrier1_rgr_noflag_F":{3};
        case "V_PlateCarrier1_tna_F":{3};
        case "V_PlateCarrier1_blk":{3};
        case "V_PlateCarrier1_wdl":{3};
        case "V_PlateCarrierIA1_dgtl":{3};
        case "V_CarrierRigKBT_01_Heavy_EAF_F":{4};
        case "V_CarrierRigKBT_01_Heavy_Olive_F":{4};
        case "V_PlateCarrierIAGL_dgtl":{4};
        case "V_PlateCarrierIAGL_oli":{4};
        case "V_PlateCarrierGL_wdl":{4};
        case "V_PlateCarrierGL_mtp":{4};
        case "V_PlateCarrierGL_rgr":{4};
        case "V_PlateCarrierGL_blk":{4};
        case "V_PlateCarrier2_blk":{4};
        case "V_PlateCarrierH_CTRG":{4};
        default {1};
    };
};

if !(_headgear isEqualTo "") then {
    _hS = switch (_headgear) do {
        case "H_HelmetO_ViperSP_ghex_F":{5};
        case "H_HelmetO_ViperSP_hex_F":{5};
        case "H_HelmetSpecO_blk":{2};
        case "H_HelmetSpecO_ghex_F":{2};
        case "H_HelmetSpecO_ocamo":{2};
        case "H_HelmetSpecO_ocamo":{2};
        case "H_HelmetAggressor_F":{2};
        case "H_HelmetAggressor_cover_F":{2};
        case "H_HelmetAggressor_taiga_F":{2};
        case "H_PilotHelmetFighter_I":{1};
        case "H_PilotHelmetFighter_B":{1};
        case "H_PilotHelmetFighter_O":{1};
        default {0};
    };
};

_return = (_pS + _sS + _hgS + _uS + _vS + _hS);
_return;
