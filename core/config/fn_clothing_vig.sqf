#include "..\..\macro.h"
//  File: fn_clothing_vig.sqf
//	Author: [OS] REDACTED

//	Description: Master config file for Vigilante clothing store.
private["_filter","_ret","_obtainPrice"];
_filter = param [0,0,[0]];
_obtainPrice = param [1,false,[false]];
//Classname, Custom Display name (use nil for Cfg->DisplayName, price

if !(_obtainPrice) then {
	//Shop Title Name
	ctrlSetText[3103,"Vigilante Gear Shop"];
};
_ret = [];
switch (_filter) do {
	//Uniforms
	case 0:	{
		_ret = [
			["U_B_GEN_Commander_F","Vigilante Uniform",500],
			["U_C_Poloshirt_blue","Blue Poloshirt",500],
			["U_C_Poloshirt_redwhite","Redwhite Poloshirt",500],
			["U_C_Poloshirt_salmon","Versace",250],
			["U_C_Commoner1_1","Poloshirt Stripped",250],
			["U_C_Poloshirt_burgundy","Louis Vuitton",25000],
			["U_BG_Guerilla2_2","Lumberjack",500],
			["U_C_Poloshirt_stripped","Poloshirt Stripped",250],
			["U_C_Poloshirt_tricolour","Poloshirt Tricolour",250],
			["U_C_Poor_1","Shirt Blue",250],
			["U_I_G_Story_Protagonist_F","Buttonup Black Camo",500],
			["U_I_G_resistanceLeader_F","Combat T Green",500],
			["U_NikosBody","Buttonup Red Dragon",500],
			["U_OrestesBody","Surfing On Land",500],
			["U_C_HunterBody_grn","Hunter Cream",500],
			["U_OG_Guerilla3_1","Hunter Tan",500],
			["U_OG_Guerilla3_2","Hunter Green",500],
			["U_IG_Guerilla2_1","Buttonup Black",500],
			["U_IG_Guerilla2_2","Buttonup Checked",500],
			["U_IG_Guerilla2_3","Buttonup Navy",500],
			["U_NikosAgedBody","Suit Uniform",1000],
			["U_B_Protagonist_VR","VR Suit Blue",10000],
			["U_O_Protagonist_VR","VR Suit Red",10000],
			["U_I_Protagonist_VR","VR Suit Green",10000],
			["U_C_Protagonist_VR","VR Suit Purple",10000],
			["U_C_IDAP_Man_cargo_F","Aid Worker Clothes (Cargo)",500],
			["U_C_IDAP_Man_Jeans_F","Aid Worker Clothes (Jeans)",500],
			["U_C_IDAP_Man_casual_F","Aid Worker Clothes (Polo)",500],
			["U_C_IDAP_Man_Tee_F","Aid Worker Clothes (Tee)",500],
			["U_C_IDAP_Man_TeeShorts_F","Aid Worker Clothes (Tee, Shorts)",500],
			["U_C_ConstructionCoverall_Black_F","Construction Coveralls (Black)",500],
			["U_C_ConstructionCoverall_Blue_F","Construction Coveralls (Blue)",500],
			["U_C_ConstructionCoverall_Red_F","Construction Coveralls (Red)",500],
			["U_C_Uniform_Farmer_01_F","Farmer Clothes",500],
			["U_C_E_LooterJacket_01_F","Ripper Jacket",500],
			["U_I_L_Uniform_01_tshirt_black_F","Black T-Shirt",500],
			["U_I_L_Uniform_01_tshirt_olive_F","Hunter Clothes",500],
			["U_I_L_Uniform_01_tshirt_skull_F","Edgy T-Shirt",500],
			["U_I_L_Uniform_01_tshirt_sport_F","Sports T-Shirt",500],
			["U_C_Uniform_Scientist_01_formal_F","Nerd Clothes",500],
			["U_C_Uniform_Scientist_01_F","Periodic Professor",500],
			["U_C_Uniform_Scientist_02_formal_F","Atomic T-Shirt",500],
			["U_C_Uniform_Scientist_02_F","Believer Shirt",500],
			["U_I_E_Uniform_01_sweater_F","Rebel Sweater",500],
			["U_B_CombatUniform_mcam_wdl_f","Woodland Combat Fatigues",500],
			["U_B_CombatUniform_tshirt_mcam_wdL_f","Woodland Combat T-Shirt",500],
			["U_I_L_Uniform_01_camo_F","Deserter Jacket",500],
			["U_I_L_Uniform_01_deserter_F","Deserter",500],
			["U_B_CombatUniform_vest_mcam_wdl_f","Woodland Combat Uniform",500],
			["U_Tank_green_F","Tanker Coveralls",500],
			["U_C_Mechanic_01_F","Mechanic Clothes",500],
			["U_C_Driver_1_black","Black Racing Uniform",500],
			["U_C_Driver_1_blue","Blue Racing Uniform",500],
			["U_C_Driver_1_red","Red Racing Uniform",500],
			["U_C_Driver_1_orange","Orange Racing Uniform",500],
			["U_C_Driver_1_green","Green Racing Uniform",500],
			["U_C_Driver_1_white","White Racing Uniform",500],
			["U_C_Driver_1_yellow","White Racing Uniform",500],
			["U_C_Driver_1",nil,500],
			["U_C_Driver_2",nil,500],
			["U_C_Driver_3",nil,500],
			["U_C_Driver_4",nil,500]
		];

		if ((getPlayerUID player) isEqualTo "76561198010422149") then {
			_ret pushBack ["U_O_CombatUniform_ocamo","The Dili Special",500];
			_ret pushBack ["U_O_R_Gorka_01_black_F","Soup of the Day",500];
		};
		if (__GETC__(oev_donator) >= 15) then {
			_ret pushBack ["U_IG_Guerilla3_1","Supporter Outfit",500];
		};

		if ((__GETC__(oev_donator) >= 100) && (__GETC__(oev_donator) < 500)) then {
			_ret pushBack ["U_I_CombatUniform_shortsleeve","Elite Outfit",500];
		};

		if (__GETC__(oev_donator) >= 100) then {
			_ret pushBack ["U_C_Poloshirt_blue","Abibas Outfit",500];
		};

		if (__GETC__(oev_donator) >= 500) then {
			_ret pushBack ["U_I_CombatUniform_shortsleeve","Legendary Outfit",500];
		};

		if((getPlayerUID player) in ["76561198050208572","76561198087694955","76561198192271806","76561198101157939","76561198261830571","76561198159764963","76561198152272555","76561198169326834","76561198131372705","76561198142378266","76561198341073463","76561198106617512"]) then {
			_ret pushBack ["U_I_Wetsuit","Gang Wars Uniform",500];
		};

		// Mudiwa
		if((getPlayerUID _target) in ["76561198123439780", "76561198216100232"]) then {
			_skinsArray pushBack ["U_I_CombatUniform_shortsleeve", [civilian], 0, 0, 0, 0, ["76561198123439780", "76561198216100232"],"Mudiwa Gang Uniform", _missionDir + "gang_uniform_31170.jpg"];
		};

		if((oev_gang_data select 0) in oev_gangUniforms) then {
			_ret pushBack ["U_I_CombatUniform_shortsleeve",format["%1 Gang Uniform",(oev_gang_data select 1)],500];
		};
		if (__GETC__(oev_civcouncil) > 0) then {
			_ret pushBack ["U_I_CombatUniform_tshirt","Civ Council Outfit",500];
		};
	};

	//Hats
	case 1:	{
		_ret = [
			["H_Cap_red",nil,50],
			["H_Cap_blu",nil,50],
			["H_Cap_oli",nil,50],
			["H_Cap_grn",nil,50],
			["H_Cap_tan",nil,50],
			["H_Cap_blk",nil,50],
			["H_Cap_blk_CMMG",nil,50],
			["H_Cap_blk_ION",nil,50],
			["H_Booniehat_grn",nil,50],
			["H_Booniehat_tan",nil,50],
			["H_Booniehat_dirty",nil,50],
			["H_Bandanna_surfer",nil,50],
			["H_Bandanna_khk",nil,50],
			["H_Bandanna_cbr",nil,50],
			["H_Bandanna_sgg",nil,50],
			["H_Bandanna_gry",nil,50],
			["H_StrawHat",nil,50],
			["H_StrawHat_dark",nil,50],
			["H_Hat_blue",nil,50],
			["H_Hat_brown",nil,50],
			["H_Hat_grey",nil,50],
			["H_Watchcap_blk",nil,50],
			["H_Watchcap_khk",nil,50],
			["H_Watchcap_sgg",nil,50],
			["H_Watchcap_camo",nil,50],
			["H_Hat_checker",nil,50],
			["H_MilCap_ocamo",nil,50],
			["H_MilCap_mcamo",nil,50],
			["H_MilCap_oucamo",nil,50],
			["H_MilCap_rucamo",nil,50],
			["H_MilCap_gry",nil,50],
			["H_MilCap_dgtl",nil,50],
			["H_MilCap_blue",nil,50],
			["H_MilCap_grn",nil,50],
			["H_MilCap_taiga",nil,50],
			["H_MilCap_wdl",nil,50],
			["H_MilCap_eaf",nil,50],
			["H_Tank_black_F",nil,50],
			["H_Booniehat_mgrn",nil,50],
			["H_Booniehat_taiga",nil,50],
			["H_Booniehat_wdl",nil,50],
			["H_Booniehat_eaf",nil,50],
			["H_Hat_Tinfoil_F",nil,5000],
			// Lvl 1
			["H_HelmetB_light",nil,10000],
			["H_HelmetB_light_snakeskin",nil,10000],
			["H_HelmetB_light_desert",nil,10000],
			["H_HelmetB_light_sand",nil,10000],
			["H_HelmetB_Light_tna_F",nil,10000],
			// Lvl 2
			["H_HelmetB",nil,15000],
			["H_HelmetB_camo",nil,15000],
			["H_HelmetB_paint",nil,15000],
			["H_HelmetB_plain_mcamo",nil,15000],
			["H_HelmetB_grass",nil,15000],
			["H_HelmetB_snakeskin",nil,15000],
			["H_HelmetB_desert",nil,15000],
			["H_HelmetB_sand",nil,15000],
			["H_HelmetB_TI_tna_F",nil,15000],
			["H_HelmetB_tna_F",nil,15000],
			["H_HelmetIA",nil,15000],
			["H_CrewHelmetHeli_O",nil,15000],
			["H_CrewHelmetHeli_I",nil,15000],
			["H_HelmetB_light_wdl",nil,15000],
			["H_HelmetSpecB_wdl",nil,15000],
			["H_HelmetHBK_headset_F",nil,15000],
			["H_HelmetHBK_chops_F",nil,15000],
			["H_HelmetHBK_ear_F",nil,15000],
			["H_HelmetB_plain_wdl",nil,15000],
			["H_HelmetHBK_F",nil,15000],
			// Lvl 3
			["H_HelmetCrew_O_ghex_F",nil,17500],
			["H_HelmetO_ghex_F",nil,17500],
			["H_PilotHelmetFighter_O","Pilot Helmet [CSAT]",15000],
			["H_PilotHelmetFighter_B","Pilot Helmet [NATO]",15000],
			["H_PilotHelmetFighter_I","Pilot Helmet [AAF]",15000]
		];

		if(__GETC__(oev_donator) >= 15) then {
			_ret pushBack ["H_Cap_headphones","Hat with Headphones",500];
			_ret pushBack ["H_Cap_marshal","Hat with Headphones2",500];
			_ret pushBack ["H_Beret_blk","Beret (Black)",500];
		};
	};

	//Glasses
	case 2:	{
		_ret = [
			["G_Shades_Black",nil,25],
			["G_Shades_Blue",nil,20],
			["G_Sport_Blackred",nil,20],
			["G_Sport_Checkered",nil,20],
			["G_Sport_Blackyellow",nil,20],
			["G_Sport_BlackWhite",nil,20],
			["G_Sport_Red",nil,20],
			["G_Sport_Greenblack",nil,20],
			["G_Squares",nil,10],
			["G_Aviator",nil,100],
			["G_Lady_Mirror",nil,150],
			["G_Lady_Dark",nil,150],
			["G_Lady_Blue",nil,150],
			["G_Lowprofile",nil,30],
			["G_Combat",nil,55],
			["G_Spectacles_Tinted","Tinted Spectacles",55]
		];

		if (oev_vigiarrests >= 1) then {
			_ret pushBack ["G_Balaclava_blk",nil,500];
			_ret pushBack ["G_Balaclava_combat",nil,500];
			_ret pushBack ["G_Balaclava_lowprofile",nil,500];
			_ret pushBack ["G_Balaclava_oli",nil,500];
			_ret pushBack ["G_Balaclava_TI_blk_F",nil,500];
			_ret pushBack ["G_Balaclava_TI_G_blk_F",nil,500];
			_ret pushBack ["G_Balaclava_TI_tna_F",nil,500];
			_ret pushBack ["G_Balaclava_TI_G_tna_F",nil,500];
			_ret pushBack ["G_Bandanna_aviator",nil,500];
			_ret pushBack ["G_Bandanna_beast",nil,500];
			_ret pushBack ["G_Bandanna_blk",nil,500];
			_ret pushBack ["G_Bandanna_khk",nil,500];
			_ret pushBack ["G_Bandanna_oli",nil,500];
			_ret pushBack ["G_Bandanna_shades",nil,500];
			_ret pushBack ["G_Bandanna_sport",nil,500];
			_ret pushBack ["G_Bandanna_tan",nil,500];
			_ret pushBack ["G_RegulatorMask_F","Gas Mask",500];
			_ret pushBack ["G_AirPurifyingRespirator_01_F","Respirator Mask",500];
			_ret pushBack ["G_AirPurifyingRespirator_02_sand_F","Brown Gas Mask",500];
			_ret pushBack ["G_AirPurifyingRespirator_02_olive_F","Olive Gas Mask",500];
		};
	};


	//Vest
	case 3:	{
		_ret = [
			["V_TacVestIR_blk","Weak Vigilante Vest",25000]
		];

		if (oev_vigiarrests >= 1) then {
			_ret pushBack ["V_PlateCarrier1_blk","Vigilante Vest",25000];
		};
	};

	//Backpacks
	case 4: {
		_ret = [
			["B_AssaultPack_blk",nil,600],
			["B_AssaultPack_cbr",nil,600],
			["B_AssaultPack_khk",nil,600],
			["B_AssaultPack_sgg",nil,600],
			["B_AssaultPack_rgr",nil,600],
			["B_FieldPack_cbr",nil,1000],
			["B_FieldPack_blk",nil,1000],
			["B_FieldPack_ghex_F",nil,1000],
			["B_FieldPack_ocamo",nil,1000],
			["B_FieldPack_khk",nil,1000],
			["B_FieldPack_oli",nil,1000],
			["B_FieldPack_oucamo",nil,1000],
			["B_TacticalPack_blk",nil,1250],
			["B_TacticalPack_rgr",nil,1250],
			["B_TacticalPack_ocamo",nil,1250],
			["B_TacticalPack_mcamo",nil,1250],
			["B_TacticalPack_oli",nil,1250],
			["B_Kitbag_cbr","Kitbag (Black)",1500],
			["B_Carryall_ocamo",nil,2500],
			["B_Carryall_mcamo","Carryall Backpack (Black)",2500],
			["B_Carryall_khk",nil,2500],
			["B_Carryall_cbr",nil,2500],
			["B_Carryall_oli",nil,2500],
			["B_Carryall_ghex_F",nil,2500],
			["B_ViperLightHarness_ghex_F",nil,3000],
			["B_ViperLightHarness_blk_F",nil,3000],
			["B_ViperLightHarness_hex_F",nil,3000],
			["B_ViperHarness_blk_F",nil,3000],
			["B_ViperHarness_ghex_F",nil,3000],
			["B_ViperHarness_hex_F",nil,3000],
			["B_ViperHarness_khk_F",nil,3000],
			["B_ViperHarness_oli_F",nil,3000],
			["B_ViperLightHarness_khk_F",nil,3000],
			["B_ViperLightHarness_oli_F",nil,3000],
			["B_Bergen_hex_F",nil,15000],
			["B_Bergen_tna_F",nil,15000],
			["B_Bergen_mcamo_F",nil,15000],
			["B_Kitbag_rgr","Invis. Kitbag",1500],
			["B_Carryall_oucamo","Invis. Carryall",5000],
			["B_Bergen_dgtl_F","Invis. Bergen",30000]
		];
		if(__GETC__(oev_donator) >= 30) then {
			_ret pushBack ["B_Kitbag_mcamo","Donor Red",1500];
			_ret pushBack ["B_Kitbag_sgg","Donor Green",1500];
			_ret pushBack ["B_Kitbag_tan","Smile",1500];
		};

		if(__GETC__(oev_donator) >= 100) then {
			_ret pushBack ["B_Messenger_Black_F","Abibas Messenger",1000];
		};

		if(__GETC__(oev_donator) >= 1000) then {
			_ret pushBack ["B_Carryall_ocamo","Founders Carryall",2500];
		};
	};

	// Return all clothing
	case 7: {
		_ret = [
			["U_B_GEN_Commander_F","Vigilante Uniform",500],
			["U_C_Poloshirt_salmon","Polo Suit",250],
			["U_C_Poloshirt_redwhite","Dab Shirt",250],
			["U_C_Poloshirt_burgundy","Louis Vuitton",25000],
			["U_BG_Guerilla2_2","Lumberjack",500],
			["U_C_Poloshirt_stripped","Poloshirt Stripped",250],
			["U_C_Poloshirt_tricolour","Poloshirt Tricolour",250],
			["U_C_Poor_1","Shirt Blue",250],
			["U_I_G_Story_Protagonist_F","Buttonup Black Camo",500],
			["U_I_G_resistanceLeader_F","Combat T Green",500],
			["U_NikosBody","Buttonup Red Dragon",500],
			["U_OrestesBody","Surfing On Land",500],
			["U_C_HunterBody_grn","Hunter Cream",500],
			["U_OG_Guerilla3_1","Hunter Tan",500],
			["U_OG_Guerilla3_2","Hunter Green",500],
			["U_IG_Guerilla2_1","Buttonup Black",500],
			["U_IG_Guerilla2_2","Buttonup Checked",500],
			["U_IG_Guerilla2_3","Buttonup Navy",500],
			["U_NikosAgedBody","Suit Uniform",1000],
			["U_B_Protagonist_VR","VR Suit Blue",10000],
			["U_O_Protagonist_VR","VR Suit Red",10000],
			["U_I_Protagonist_VR","VR Suit Green",10000],
			["U_C_Protagonist_VR","VR Suit Purple",10000],
			["U_C_IDAP_Man_cargo_F","Aid Worker Clothes (Cargo)",500],
			["U_C_IDAP_Man_Jeans_F","Aid Worker Clothes (Jeans)",500],
			["U_C_IDAP_Man_casual_F","Aid Worker Clothes (Polo)",500],
			["U_C_IDAP_Man_Tee_F","Aid Worker Clothes (Tee)",500],
			["U_C_IDAP_Man_TeeShorts_F","Aid Worker Clothes (Tee, Shorts)",500],
			["U_C_ConstructionCoverall_Black_F","Construction Coveralls (Black)",500],
			["U_C_ConstructionCoverall_Blue_F","Construction Coveralls (Blue)",500],
			["U_C_ConstructionCoverall_Red_F","Construction Coveralls (Red)",500],
			["U_C_Uniform_Farmer_01_F","Farmer Clothes",500],
			["U_C_E_LooterJacket_01_F","Ripper Jacket",500],
			["U_I_L_Uniform_01_tshirt_black_F","Black T-Shirt",500],
			["U_I_L_Uniform_01_tshirt_olive_F","Hunter Clothes",500],
			["U_I_L_Uniform_01_tshirt_skull_F","Edgy T-Shirt",500],
			["U_I_L_Uniform_01_tshirt_sport_F","Sports T-Shirt",500],
			["U_C_Uniform_Scientist_01_formal_F","Nerd Clothes",500],
			["U_C_Uniform_Scientist_01_F","Periodic Professor",500],
			["U_C_Uniform_Scientist_02_formal_F","Atomic T-Shirt",500],
			["U_C_Uniform_Scientist_02_F","Believer Shirt",500],
			["U_I_E_Uniform_01_sweater_F","Rebel Sweater",500],
			["U_B_CombatUniform_mcam_wdl_f","Woodland Combat Fatigues",500],
			["U_B_CombatUniform_tshirt_mcam_wdL_f","Woodland Combat T-Shirt",500],
			["U_I_L_Uniform_01_camo_F","Deserter Jacket",500],
			["U_I_L_Uniform_01_deserter_F","Deserter",500],
			["U_B_CombatUniform_vest_mcam_wdl_f","Woodland Combat Uniform",500],
			["U_Tank_green_F","Tanker Coveralls",500],
			["U_C_Mechanic_01_F","Mechanic Clothes",500],
			["U_C_Driver_1_black","Black Racing Uniform",500],
			["U_C_Driver_1_blue","Blue Racing Uniform",500],
			["U_C_Driver_1_red","Red Racing Uniform",500],
			["U_C_Driver_1_orange","Orange Racing Uniform",500],
			["U_C_Driver_1_green","Green Racing Uniform",500],
			["U_C_Driver_1_white","White Racing Uniform",500],
			["U_C_Driver_1_yellow","White Racing Uniform",500],
			["U_C_Driver_1",nil,500],
			["U_C_Driver_2",nil,500],
			["U_C_Driver_3",nil,500],
			["U_C_Driver_4",nil,500],
			["H_Cap_red",nil,50],
			["H_Cap_blu",nil,50],
			["H_Cap_oli",nil,50],
			["H_Cap_grn",nil,50],
			["H_Cap_tan",nil,50],
			["H_Cap_blk",nil,50],
			["H_Cap_blk_CMMG",nil,50],
			["H_Cap_blk_ION",nil,50],
			["H_Booniehat_grn",nil,50],
			["H_Booniehat_tan",nil,50],
			["H_Booniehat_dirty",nil,50],
			["H_Bandanna_surfer",nil,50],
			["H_Bandanna_khk",nil,50],
			["H_Bandanna_cbr",nil,50],
			["H_Bandanna_sgg",nil,50],
			["H_Bandanna_gry",nil,50],
			["H_StrawHat",nil,50],
			["H_StrawHat_dark",nil,50],
			["H_Hat_blue",nil,50],
			["H_Hat_brown",nil,50],
			["H_Hat_grey",nil,50],
			["H_Watchcap_blk",nil,50],
			["H_Watchcap_khk",nil,50],
			["H_Watchcap_sgg",nil,50],
			["H_Watchcap_camo",nil,50],
			["H_Hat_checker",nil,50],
			["H_MilCap_ocamo",nil,50],
			["H_MilCap_mcamo",nil,50],
			["H_MilCap_oucamo",nil,50],
			["H_MilCap_rucamo",nil,50],
			["H_MilCap_gry",nil,50],
			["H_MilCap_dgtl",nil,50],
			["H_MilCap_blue",nil,50],
			["H_MilCap_grn",nil,50],
			["H_MilCap_taiga",nil,50],
			["H_MilCap_wdl",nil,50],
			["H_MilCap_eaf",nil,50],
			["H_Tank_black_F",nil,50],
			["H_Booniehat_mgrn",nil,50],
			["H_Booniehat_taiga",nil,50],
			["H_Booniehat_wdl",nil,50],
			["H_Booniehat_eaf",nil,50],
			["H_Hat_Tinfoil_F",nil,5000],
			// Lvl 1
			["H_HelmetB_light",nil,10000],
			["H_HelmetB_light_snakeskin",nil,10000],
			["H_HelmetB_light_desert",nil,10000],
			["H_HelmetB_light_sand",nil,10000],
			["H_HelmetB_Light_tna_F",nil,10000],
			// Lvl 2
			["H_HelmetB",nil,15000],
			["H_HelmetB_camo",nil,15000],
			["H_HelmetB_paint",nil,15000],
			["H_HelmetB_plain_mcamo",nil,15000],
			["H_HelmetB_grass",nil,15000],
			["H_HelmetB_snakeskin",nil,15000],
			["H_HelmetB_desert",nil,15000],
			["H_HelmetB_sand",nil,15000],
			["H_HelmetB_TI_tna_F",nil,15000],
			["H_HelmetB_tna_F",nil,15000],
			["H_HelmetIA",nil,15000],
			["H_CrewHelmetHeli_O",nil,15000],
			["H_CrewHelmetHeli_I",nil,15000],
			["H_HelmetB_light_wdl",nil,15000],
			["H_HelmetSpecB_wdl",nil,15000],
			["H_HelmetHBK_headset_F",nil,15000],
			["H_HelmetHBK_chops_F",nil,15000],
			["H_HelmetHBK_ear_F",nil,15000],
			["H_HelmetB_plain_wdl",nil,15000],
			["H_HelmetHBK_F",nil,15000],
			// Lvl 3
			["H_HelmetCrew_O_ghex_F",nil,17500],
			["H_HelmetO_ghex_F",nil,17500],
			["H_PilotHelmetFighter_O","Pilot Helmet [CSAT]",15000],
			["H_PilotHelmetFighter_B","Pilot Helmet [NATO]",15000],
			["H_PilotHelmetFighter_I","Pilot Helmet [AAF]",15000],
			["G_Shades_Black",nil,25],
			["G_Shades_Blue",nil,20],
			["G_Sport_Blackred",nil,20],
			["G_Sport_Checkered",nil,20],
			["G_Sport_Blackyellow",nil,20],
			["G_Sport_BlackWhite",nil,20],
			["G_Sport_Red",nil,20],
			["G_Sport_Greenblack",nil,20],
			["G_Squares",nil,10],
			["G_Aviator",nil,100],
			["G_Lady_Mirror",nil,150],
			["G_Lady_Dark",nil,150],
			["G_Lady_Blue",nil,150],
			["G_Lowprofile",nil,30],
			["G_Combat",nil,55],
			["G_Spectacles_Tinted","Tinted Spectacles",55],
			["G_Balaclava_blk",nil,500],
			["G_Balaclava_combat",nil,500],
			["G_Balaclava_lowprofile",nil,500],
			["G_Balaclava_oli",nil,500],
			["G_Balaclava_TI_blk_F",nil,500],
			["G_Balaclava_TI_G_blk_F",nil,500],
			["G_Balaclava_TI_tna_F",nil,500],
			["G_Balaclava_TI_G_tna_F",nil,500],
			["G_Bandanna_aviator",nil,500],
			["G_Bandanna_beast",nil,500],
			["G_Bandanna_blk",nil,500],
			["G_Bandanna_khk",nil,500],
			["G_Bandanna_oli",nil,500],
			["G_Bandanna_shades",nil,500],
			["G_Bandanna_sport",nil,500],
			["G_Bandanna_tan",nil,500],
			["G_RegulatorMask_F","Gas Mask",500],
			["G_AirPurifyingRespirator_01_F","Respirator Mask",500],
			["G_AirPurifyingRespirator_02_sand_F","Brown Gas Mask",500],
			["G_AirPurifyingRespirator_02_olive_F","Olive Gas Mask",500],
			["V_TacVestIR_blk","Weak Vigilante Vest",25000],
			["B_AssaultPack_blk",nil,600],
			["B_AssaultPack_cbr",nil,600],
			["B_AssaultPack_khk",nil,600],
			["B_AssaultPack_sgg",nil,600],
			["B_AssaultPack_rgr",nil,600],
			["B_FieldPack_cbr",nil,1000],
			["B_FieldPack_blk",nil,1000],
			["B_FieldPack_ghex_F",nil,1000],
			["B_FieldPack_ocamo",nil,1000],
			["B_FieldPack_khk",nil,1000],
			["B_FieldPack_oli",nil,1000],
			["B_FieldPack_oucamo",nil,1000],
			["B_TacticalPack_blk",nil,1250],
			["B_TacticalPack_rgr",nil,1250],
			["B_TacticalPack_ocamo",nil,1250],
			["B_TacticalPack_mcamo",nil,1250],
			["B_TacticalPack_oli",nil,1250],
			["B_Kitbag_cbr","Kitbag (Black)",1500],
			["B_Carryall_ocamo",nil,2500],
			["B_Carryall_mcamo","Carryall Backpack (Black)",2500],
			["B_Carryall_khk",nil,2500],
			["B_Carryall_cbr",nil,2500],
			["B_Carryall_oli",nil,2500],
			["B_Carryall_ghex_F",nil,2500],
			["B_ViperLightHarness_ghex_F",nil,3000],
			["B_ViperLightHarness_blk_F",nil,3000],
			["B_ViperLightHarness_hex_F",nil,3000],
			["B_ViperHarness_blk_F",nil,3000],
			["B_ViperHarness_ghex_F",nil,3000],
			["B_ViperHarness_hex_F",nil,3000],
			["B_ViperHarness_khk_F",nil,3000],
			["B_ViperHarness_oli_F",nil,3000],
			["B_ViperLightHarness_khk_F",nil,3000],
			["B_ViperLightHarness_oli_F",nil,3000],
			["B_Bergen_hex_F",nil,15000],
			["B_Bergen_tna_F",nil,15000],
			["B_Bergen_mcamo_F",nil,15000],
			["B_Kitbag_rgr","Invis. Kitbag",1500],
			["B_Carryall_oucamo","Invis. Carryall",5000],
			["B_Bergen_dgtl_F","Invis. Bergen",30000]
		];
		if (__GETC__(oev_civcouncil) > 0) then {
			_ret pushBack ["U_I_CombatUniform_tshirt","Civ Council Outfit",500];
		};
		if (oev_vigiarrests >= 1) then {
			_ret pushBack ["V_PlateCarrier1_blk","Vigilante Vest",25000];
		};
		if (oev_vigiarrests >= 1) then {
			_ret pushBack ["G_Balaclava_blk",nil,500];
			_ret pushBack ["G_Balaclava_combat",nil,500];
			_ret pushBack ["G_Balaclava_lowprofile",nil,500];
			_ret pushBack ["G_Balaclava_oli",nil,500];
			_ret pushBack ["G_Balaclava_TI_blk_F",nil,500];
			_ret pushBack ["G_Balaclava_TI_G_blk_F",nil,500];
			_ret pushBack ["G_Balaclava_TI_tna_F",nil,500];
			_ret pushBack ["G_Balaclava_TI_G_tna_F",nil,500];
			_ret pushBack ["G_Bandanna_aviator",nil,500];
			_ret pushBack ["G_Bandanna_beast",nil,500];
			_ret pushBack ["G_Bandanna_blk",nil,500];
			_ret pushBack ["G_Bandanna_khk",nil,500];
			_ret pushBack ["G_Bandanna_oli",nil,500];
			_ret pushBack ["G_Bandanna_shades",nil,500];
			_ret pushBack ["G_Bandanna_sport",nil,500];
			_ret pushBack ["G_Bandanna_tan",nil,500];
			_ret pushBack ["G_RegulatorMask_F","Gas Mask",500];
			_ret pushBack ["G_AirPurifyingRespirator_01_F","Respirator Mask",500];
			_ret pushBack ["G_AirPurifyingRespirator_02_sand_F","Brown Gas Mask",500];
			_ret pushBack ["G_AirPurifyingRespirator_02_olive_F","Olive Gas Mask",500];
		};

		if ((getPlayerUID player) isEqualTo "76561198010422149") then {
			_ret pushBack ["U_O_CombatUniform_ocamo","The Dili Special",500];
			_ret pushBack ["U_O_R_Gorka_01_black_F","Soup of the Day",500];
		};
		if (__GETC__(oev_donator) >= 15) then {
			_ret pushBack ["U_IG_Guerilla3_1","Supporter Outfit",500];
			_ret pushBack ["H_Cap_headphones","Hat with Headphones",500];
			_ret pushBack ["H_Cap_marshal","Hat with Headphones2",500];
			_ret pushBack ["H_Beret_blk","Beret (Black)",500];
		};
		if(__GETC__(oev_donator) >= 30) then {
			_ret pushBack ["B_Kitbag_mcamo","Donor Red",1500];
			_ret pushBack ["B_Kitbag_sgg","Donor Green",1500];
		};
		if ((__GETC__(oev_donator) >= 100) && (__GETC__(oev_donator) < 500)) then {
			_ret pushBack ["U_I_CombatUniform_shortsleeve","Elite Outfit",500];
		};
		if(__GETC__(oev_donator) >= 100) then {
			_ret pushBack ["U_C_Poloshirt_blue","Abibas Outfit",500];
			_ret pushBack ["B_Messenger_Black_F","Abibas Messenger",1000];
		};
		if (__GETC__(oev_donator) >= 500) then {
			_ret pushBack ["U_I_CombatUniform_shortsleeve","Legendary Outfit",500];
		};
		if(__GETC__(oev_donator) >= 1000) then {
			_ret pushBack ["B_Carryall_ocamo","Founders Carryall",2500];
		};
		if((oev_gang_data select 0) in oev_gangUniforms) then {
			_ret pushBack ["U_I_CombatUniform_shortsleeve",format["%1 Gang Uniform",(oev_gang_data select 1)],500];
		};
	};
};

_ret;
