#include "..\..\macro.h"
//  File: fn_clothing_reb.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Master configuration file for Reb shop.
private["_filter","_ret","_obtainPrice"];
_filter = param [0,0,[0]];
_obtainPrice = param [1,false,[false]];
//Classname, Custom Display name (use nil for Cfg->DisplayName, price
if !(_obtainPrice) then {
	//Shop Title Name
	ctrlSetText[3103,"Mohammed's Jihadi Shop"];
};

_ret = [];
switch (_filter) do {
	//Uniforms
	case 0: {
		_ret = [
			["U_B_CombatUniform_mcam_worn","Rebel Uniform",250],
			["U_I_pilotCoveralls","Urban Coveralls",1500],
			["U_B_Wetsuit","Red Wetsuit",2000],
			["U_O_Wetsuit",nil,2000],
			["U_I_Wetsuit",nil,2000],
			["U_B_GhillieSuit","Ghillie Suit [NATO]",500],
			["U_I_GhillieSuit","Ghillie Suit [AAF]",500],
			["U_I_FullGhillie_ard",nil,2500],
			["U_I_FullGhillie_lsh","Full Ghillie [Black] [AAF]",2500],
			["U_I_FullGhillie_sard","Full Ghillie [Urban] [AAF]",2500],
			["U_B_FullGhillie_ard",nil,2500],
			["U_B_FullGhillie_lsh",nil,2500],
			["U_B_FullGhillie_sard",nil,2500],
			["U_BG_leader",nil,500],
			["U_OG_Guerilla3_1","Hunter Tan",500],
			["U_OG_Guerilla3_2","Hunter Green",500],
			["U_IG_Guerilla2_1","Buttonup Black",500],
			["U_IG_Guerilla2_2","Buttonup Checked",500],
			["U_IG_Guerilla2_3","Buttonup Navy",500],
			["U_I_OfficerUniform","Combat Fatigues [AAF] (Officer)",500],
			["U_B_CombatUniform_mcam_tshirt",nil,1000],
			["U_O_T_Officer_F",nil,1000],
			["U_O_OfficerUniform_ocamo",nil,1000],
			["U_B_CTRG_1",nil,1000],
			["U_B_CTRG_2",nil,1000],
			["U_B_CTRG_3",nil,1000],
			["U_B_survival_uniform",nil,1000],
			["U_C_CBRN_Suit_01_Blue_F","Blue Hazmat Suit",500],
			["U_B_CBRN_Suit_01_Tropic_F","Tropical Hazmat Suit",500],
			["U_C_CBRN_Suit_01_White_F","White Hazmat Suit",500],
			["U_B_CBRN_Suit_01_Wdl_F","Woodland Hazmat Suit",500],
			["U_I_CBRN_Suit_01_AAF_F","AAF Hazmat Suit",500],
			["U_I_E_CBRN_Suit_01_EAF_F","EAF Hazmat Suit",500],
			["U_I_E_Uniform_01_sweater_F","Rebel Sweater",500],
			["U_B_CombatUniform_mcam_wdl_f","Woodland Combat Fatigues",500],
			["U_B_CombatUniform_tshirt_mcam_wdL_f","Woodland Combat T-Shirt",500],
			["U_I_L_Uniform_01_camo_F","Deserter Jacket",500],
			["U_I_L_Uniform_01_deserter_F","Deserter",500],
			["U_B_CombatUniform_vest_mcam_wdl_f","Woodland Combat Uniform",500],
			["U_Tank_green_F","Tanker Coveralls",500],
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
			["U_C_Poloshirt_salmon","Versace",250],
			["U_C_Commoner1_1","Altis World",250],
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
			["U_C_Mechanic_01_F","Mechanic Clothes",500]
		];

		{
			_ret pushBack [_x,nil,500];
		}foreach ["U_B_T_Sniper_F","U_B_CTRG_Soldier_urb_2_F","U_B_CTRG_Soldier_urb_3_F","U_B_CTRG_Soldier_urb_1_F","U_B_CTRG_Soldier_2_F","U_B_CTRG_Soldier_3_F","U_B_T_Soldier_AR_F","U_B_T_Soldier_F","U_I_C_Soldier_Para_2_F","U_I_C_Soldier_Para_3_F","U_I_C_Soldier_Para_5_F","U_I_C_Soldier_Para_4_F","U_I_C_Soldier_Para_1_F","U_B_T_Soldier_SL_F"];

		{
			_ret pushBack [_x,nil,2500];
		}foreach ["U_B_T_FullGhillie_tna_F"];

		if(__GETC__(oev_donator) >= 15) then {
			_ret pushBack ["U_C_Driver_1_black","Black Racing Uniform",500];
			_ret pushBack ["U_C_Driver_1_blue","Blue Racing Uniform",500];
			_ret pushBack ["U_C_Driver_1_red","Red Racing Uniform",500];
			_ret pushBack ["U_C_Driver_1_orange","Orange Racing Uniform",500];
			_ret pushBack ["U_C_Driver_1_green","Green Racing Uniform",500];
			_ret pushBack ["U_C_Driver_1_white","White Racing Uniform",500];
			_ret pushBack ["U_C_Driver_1_yellow","White Racing Uniform",500];
			_ret pushBack ["U_C_Driver_2",nil,500];
			_ret pushBack ["U_C_Driver_1",nil,500];
			_ret pushBack ["U_C_Driver_3",nil,500];
			_ret pushBack ["U_C_Driver_4",nil,500];
		};
		if ((getPlayerUID player) isEqualTo "76561198010422149") then {
			_ret pushBack ["U_O_CombatUniform_ocamo","The Dili Special",500];
			_ret pushBack ["U_O_R_Gorka_01_black_F","Soup of the Day",500];
		};
		if (__GETC__(oev_donator) >= 15) then {
			_ret pushBack ["U_IG_Guerilla3_1","Supporter Outfit",500];
		};
		if (__GETC__(oev_donator) >= 50) then {
			_ret pushBack ["U_B_CBRN_Suit_01_MTP_F","Bank Hiest Hazmat",500];
		};
 		if (__GETC__(oev_donator) >= 1000) then {
			_ret pushBack ["U_I_Soldier_VR","Full Body Suit Green",500];
			_ret pushBack ["U_O_Soldier_VR","Full Body Suit Red",500];
			_ret pushBack ["U_B_Soldier_VR","Full Body Suit Blue",500];
			_ret pushBack ["U_C_Soldier_VR", "Full Body Suit Purple",500];
		};
		if ((__GETC__(oev_donator) >= 100) && (__GETC__(oev_donator) < 500)) then {
			_ret pushBack ["U_I_CombatUniform_shortsleeve","Elite Outfit",500];
		};
		if (__GETC__(oev_donator) >= 100) then {
			_ret pushBack ["U_C_Poloshirt_blue","Abibas Outfit",500];
			_ret pushBack ["U_B_CombatUniform_mcam_vest","Vanguard Combat Uniform",1000];
		};
		if (__GETC__(oev_donator) >= 500) then {
			_ret pushBack ["U_I_CombatUniform_shortsleeve","Legendary Outfit",500];
		};
		if (__GETC__(oev_civcouncil) > 0) then {
			_ret pushBack ["U_I_CombatUniform_tshirt","Civ Council Outfit",500];
		};
		if (__GETC__(life_supportlevel) > 0) then {
			_ret pushBack ["U_I_CombatUniform_tshirt","Support Team Outfit",500];
		};
		if (__GETC__(oev_designerlevel) > 1 || __GETC__(oev_developerlevel) > 1 || __GETC__(life_adminlevel) > 0) then {
			_ret pushBack ["U_I_CombatUniform_tshirt","Staff Uniform",500];
		};
		if((getPlayerUID player) in ["76561198050208572","76561198087694955","76561198192271806","76561198101157939","76561198261830571","76561198159764963","76561198152272555","76561198169326834","76561198131372705","76561198142378266","76561198341073463","76561198106617512"]) then {
			_ret pushBack ["U_I_Wetsuit","Gang Wars Uniform",500];
		};
		if((oev_gang_data select 0) in oev_gangUniforms) then {
			_ret pushBack ["U_I_CombatUniform_shortsleeve",format["%1 Gang Uniform",(oev_gang_data select 1)],500];
		};
		if((getPlayerUID player) in ["76561198123439780", "76561198216100232"]) then {
			_ret pushBack ["U_I_CombatUniform_shortsleeve","Mudiwa's Gang Uniform",500];
		};
		if(!isNil "oev_gang_data" && !isNil "life_conquestMonthly") then {
			if((oev_gang_data select 0) == life_conquestMonthly) then {
				_ret pushBack ["U_I_Wetsuit","Conquest Monthly Wetsuit",2000];
			};
		};
	};

	//Hats
	case 1:	{
		_ret = [
			["H_Shemag_khk","Shemag mask (Khaki)",500],
			["H_Shemag_tan","Shemag mask (Tan)",500],
			["H_Shemag_olive","Shemag (Olive)",500],
			["H_ShemagOpen_khk","Shemag (Khaki)",500],
			["H_ShemagOpen_tan","Shemag (Tan)",500],
			["H_Shemag_olive_hs","Shemag (Olive,Headset)",500],
			["H_Cap_red",nil,50],
			["H_Cap_blu",nil,50],
			["H_Cap_oli",nil,50],
			["H_Cap_grn",nil,50],
			["H_Cap_tan",nil,50],
			["H_Cap_blk",nil,50],
			["H_Cap_brn_SPECOPS",nil,50],
			["H_Cap_tan_specops_US",nil,50],
			["H_Cap_khaki_specops_UK",nil,50],
			["H_Cap_blk_Raven",nil,50],
			["H_Cap_usblack",nil,50],
			["H_Cap_blk_CMMG",nil,50],
			["H_Cap_blk_ION",nil,50],
			["H_Cap_surfer",nil,50],
			["H_Booniehat_grn",nil,50],
			["H_Booniehat_tan",nil,50],
			["H_Booniehat_dirty",nil,50],
			["H_Booniehat_khk",nil,50],
			["H_Booniehat_oli",nil,50],
			["H_Booniehat_mcamo",nil,50],
			["H_Booniehat_dgtl",nil,50],
			["H_Booniehat_khk_hs",nil,50],
			["H_Booniehat_tna_F",nil,50],
			["H_Booniehat_mgrn",nil,50],
			["H_Booniehat_taiga",nil,50],
			["H_Booniehat_wdl",nil,50],
			["H_Booniehat_eaf",nil,50],
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
			["H_Bandanna_surfer",nil,50],
			["H_Bandanna_khk",nil,50],
			["H_Bandanna_cbr",nil,50],
			["H_Bandanna_sgg",nil,50],
			["H_Bandanna_gry",nil,50],
			["H_StrawHat",nil,50],
			["H_StrawHat_dark",nil,50],
			["H_Hat_camo","Hat (Camo)", 500],
			["H_Hat_blue",nil,50],
			["H_Hat_brown",nil,50],
			["H_Hat_grey",nil,50],
			["H_Watchcap_blk",nil,50],
			["H_Watchcap_khk",nil,50],
			["H_Watchcap_sgg",nil,50],
			["H_Watchcap_camo",nil,50],
			["H_Hat_checker",nil,50],
			["H_Tank_black_F",nil,500],
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
			["H_CrewHelmetHeli_B",nil,15000],
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
			// LvL 4
			["H_HelmetSpecO_ghex_F",nil,20000],
			["H_HelmetB_Enh_tna_F",nil,20000],
			["H_PilotHelmetFighter_O","Pilot Helmet [CSAT]",15000],
			["H_PilotHelmetFighter_B","Pilot Helmet [NATO]",15000],
			["H_PilotHelmetFighter_I","Pilot Helmet [AAF]",15000]
		];

		if(__GETC__(oev_donator) >= 15) then {
			_ret pushBack ["H_RacingHelmet_1_black_F","Black Racing Helmet",500];
			_ret pushBack ["H_RacingHelmet_1_red_F","Red Racing Helmet",500];
			_ret pushBack ["H_RacingHelmet_1_white_F","White Racing Helmet",500];
			_ret pushBack ["H_RacingHelmet_1_blue_F","Blue Racing Helmet",500];
			_ret pushBack ["H_RacingHelmet_1_yellow_F","Yellow Racing Helmet",500];
			_ret pushBack ["H_RacingHelmet_1_green_F","Green Racing Helmet",500];
			_ret pushBack ["H_RacingHelmet_1_F",nil,500];
			_ret pushBack ["H_RacingHelmet_2_F",nil,500];
			_ret pushBack ["H_RacingHelmet_3_F",nil,500];
			_ret pushBack ["H_RacingHelmet_4_F",nil,500];
		};
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
			["G_Diving",nil,500],
			["G_RegulatorMask_F",nil,500],
			["G_AirPurifyingRespirator_01_F",nil,500],
			["G_AirPurifyingRespirator_02_sand_F",nil,500],
			["G_AirPurifyingRespirator_02_olive_F",nil,500]
		];

		if(__GETC__(oev_donator) >= 15) then {
			_ret pushBack ["G_Goggles_VR","VR Goggles",150];
		};
	};

	//Vest
	case 3: {
		_ret = [
			["V_SmershVest_01_F",nil,5000],
			["V_SmershVest_01_radio_F",nil,5000],
			["V_RebreatherB",nil,5000],
			["V_HarnessO_brn","TLBV Harness",20000],
			["V_TacVest_khk","Tactical Vest (Khaki)",10000],
			["V_TacVest_brn","Tactical Vest (Brown)",10000],
			["V_TacVest_oli","Tactical Vest (Olive)",10000],
			["V_TacVest_camo","Tactical Vest (Camo)",10000],
			["V_TacVest_brn","Tactical Vest (Brown)",10000],
			["V_TacVestIR_blk","Tactical Vest (Black)",10000],
			["V_I_G_resistanceLeader_F","Tactical Vest (Stavrou)",10000],
			["V_DeckCrew_blue_F","Deck Crew (Blue)",20000],
			["V_DeckCrew_brown_F","Deck Crew (Brown)",20000],
			["V_DeckCrew_green_F","Deck Crew (Green)",20000],
			["V_DeckCrew_red_F","Deck Crew (Red)",20000],
			["V_DeckCrew_violet_F","Deck Crew (Violet)",20000],
			["V_DeckCrew_white_F","Deck Crew (White)",20000],
			["V_DeckCrew_yellow_F","Deck Crew (Yellow)",20000],
			["V_CarrierRigKBT_01_Olive_F","Olive Combat Vest",30000],
			["V_CarrierRigKBT_01_EAF_F","EAF Combat Vest",30000],
			["V_PlateCarrier1_wdl","Woodland Carrier Lite",35000],
			["V_PlateCarrier1_blk",nil,35000],
			["V_PlateCarrier1_rgr","Green Carrier Lite",35000],
			["V_PlateCarrier1_rgr_noflag_F","Green Carrier Lite (No Flag)",35000],
			["V_PlateCarrier1_tna_F","Tropic Carrier Lite",35000],
			["V_PlateCarrierL_CTRG","CTRG Carrier Lite",35000],
			["V_CarrierRigKBT_01_light_Olive_F","Olive Combat Vest Lite",35000],
			//["V_CarrierRigKBT_01_light_EAF_F","EAF Combat Vest Lite",35000],
			//["V_PlateCarrierIA1_dgtl","GA Carrier Lite",35000],
			//["V_PlateCarrierIA2_dgtl","GA Carrier Rig",40000],
			//["V_EOD_blue_F","EOD Vest (Blue)",45000],
			//["V_EOD_coyote_F","EOD Vest (Coyote)",45000],
			//["V_CarrierRigKBT_01_Heavy_Olive_F","Olive Carrier Rig",50000],
			//["V_CarrierRigKBT_01_Heavy_EAF_F","EAF Carrier Rig",50000],
			//["V_PlateCarrierIAGL_dgtl","GA Carrier GL Rig (Digi)",50000],
			//["V_PlateCarrierIAGL_oli","GA Carrier GL Rig (Olive)",50000],
			//["V_PlateCarrierGL_rgr","Carrier GL Rig (Green)",55000],
			//["V_PlateCarrierGL_mtp","Carrier GL Rig (MTP)",55000],
			//["V_PlateCarrierGL_tna_F","Carrier GL Rig (Tropic)",55000],
			//["V_PlateCarrierGL_wdl","Carrier GL Rig (Woodland)",55000],
			//["V_PlateCarrierGL_blk","Carrier GL Rig (Black)",55000],
			["V_HarnessOGL_brn","Suicide Vest",2000000]
		];
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
			["B_Bergen_dgtl_F","Invis. Bergen",30000],
			["B_RadioBag_01_black_F",nil,3000],
			["B_RadioBag_01_eaf_F",nil,3000],
			["B_RadioBag_01_digi_F",nil,3000],
			["B_RadioBag_01_ghex_F",nil,3000],
			["B_RadioBag_01_hex_F",nil,3000],
			["B_RadioBag_01_oucamo_F",nil,3000],
			["B_RadioBag_01_mtp_F",nil,3000],
			["B_RadioBag_01_tropic_F",nil,3000]
		];
		if(__GETC__(oev_donator) >= 30) then {
			_ret pushBack ["B_Kitbag_mcamo","Donor Red",1500];
			_ret pushBack ["B_Kitbag_sgg","Donor Green",1500];
			_ret pushBack ["B_Kitbag_tan","Smile",1500];
		};
		if(__GETC__(oev_donator) >= 1000) then {
			_ret pushBack ["B_Carryall_ocamo","Founders Carryall",2500];
		};
		if(__GETC__(oev_donator) >= 100) then {
			_ret pushBack ["B_Messenger_Black_F","Abibas Messenger",1000];
		};
	};
	// All Items
	case 7: {
		_ret = [
			["U_B_CombatUniform_mcam_worn","Rebel Uniform",250],
			["U_I_pilotCoveralls","Urban Coveralls",1500],
			["U_B_Wetsuit","Bape Wetsuit",2000],
			["U_O_Wetsuit","Christmas Suit",2000],
			["U_I_Wetsuit",nil,2000],
			["U_B_GhillieSuit","Ghillie Suit [NATO]",500],
			["U_I_GhillieSuit","Ghillie Suit [AAF]",500],
			["U_I_FullGhillie_ard",nil,2500],
			["U_I_FullGhillie_lsh","Full Ghillie [Black] [AAF]",2500],
			["U_I_FullGhillie_sard","Full Ghillie [Urban] [AAF]",2500],
			["U_B_FullGhillie_ard",nil,2500],
			["U_B_FullGhillie_lsh",nil,2500],
			["U_B_FullGhillie_sard",nil,2500],
			["U_BG_leader",nil,500],
			["U_OG_Guerilla3_1","Hunter Tan",500],
			["U_OG_Guerilla3_2","Hunter Green",500],
			["U_IG_Guerilla2_1","Buttonup Black",500],
			["U_IG_Guerilla2_2","Buttonup Checked",500],
			["U_IG_Guerilla2_3","Buttonup Navy",500],
			["U_I_OfficerUniform","Combat Fatigues [AAF] (Officer)",500],
			["U_B_CombatUniform_mcam_tshirt",nil,1000],
			["U_B_CombatUniform_mcam_vest","Vanguard Combat Uniform",1000],
			["U_O_T_Officer_F",nil,1000],
			["U_O_OfficerUniform_ocamo",nil,1000],
			["U_B_CTRG_1",nil,1000],
			["U_B_CTRG_2",nil,1000],
			["U_B_CTRG_3",nil,1000],
			["U_B_survival_uniform",nil,1000],
			["U_C_CBRN_Suit_01_Blue_F","Blue Hazmat Suit",500],
			["U_B_CBRN_Suit_01_MTP_F","MTP Hazmat Suit",500],
			["U_B_CBRN_Suit_01_Tropic_F","Tropical Hazmat Suit",500],
			["U_C_CBRN_Suit_01_White_F","White Hazmat Suit",500],
			["U_B_CBRN_Suit_01_Wdl_F","Woodland Hazmat Suit",500],
			["U_I_CBRN_Suit_01_AAF_F","AAF Hazmat Suit",500],
			["U_I_E_CBRN_Suit_01_EAF_F","EAF Hazmat Suit",500],
			["U_I_E_Uniform_01_sweater_F","Rebel Sweater",500],
			["U_B_CombatUniform_mcam_wdl_f","Woodland Combat Fatigues",500],
			["U_B_CombatUniform_tshirt_mcam_wdL_f","Woodland Combat T-Shirt",500],
			["U_I_L_Uniform_01_camo_F","Deserter Jacket",500],
			["U_I_L_Uniform_01_deserter_F","Deserter",500],
			["U_B_CombatUniform_vest_mcam_wdl_f","Woodland Combat Uniform",500],
			["U_Tank_green_F","Tanker Coveralls",500],
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
			["U_C_Poloshirt_salmon","Versace",250],
			["U_C_Poloshirt_redwhite","versace Shirt",250],
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
			["U_C_Mechanic_01_F","Mechanic Clothes",500],
			["U_B_T_Sniper_F",nil,500],
			["U_B_CTRG_Soldier_urb_2_F",nil,500],
			["U_B_CTRG_Soldier_urb_3_F",nil,500],
			["U_B_CTRG_Soldier_urb_1_F",nil,500],
			["U_B_CTRG_Soldier_2_F",nil,500],
			["U_B_CTRG_Soldier_3_F",nil,500],
			["U_B_T_Soldier_AR_F",nil,500],
			["U_B_T_Soldier_F",nil,500],
			["U_I_C_Soldier_Para_2_F",nil,500],
			["U_I_C_Soldier_Para_3_F",nil,500],
			["U_I_C_Soldier_Para_5_F",nil,500],
			["U_I_C_Soldier_Para_4_F",nil,500],
			["U_I_C_Soldier_Para_1_F",nil,500],
			["U_B_T_Soldier_SL_F",nil,500],
			["U_B_T_FullGhillie_tna_F",nil,2500],
			["H_Shemag_khk","Shemag mask (Khaki)",500],
			["H_Shemag_tan","Shemag mask (Tan)",500],
			["H_Shemag_olive","Shemag (Olive)",500],
			["H_ShemagOpen_khk","Shemag (Khaki)",500],
			["H_ShemagOpen_tan","Shemag (Tan)",500],
			["H_Shemag_olive_hs","Shemag (Olive,Headset)",500],
			["H_Cap_red",nil,50],
			["H_Cap_blu",nil,50],
			["H_Cap_oli",nil,50],
			["H_Cap_grn",nil,50],
			["H_Cap_tan",nil,50],
			["H_Cap_blk",nil,50],
			["H_Cap_brn_SPECOPS",nil,50],
			["H_Cap_tan_specops_US",nil,50],
			["H_Cap_khaki_specops_UK",nil,50],
			["H_Cap_blk_Raven",nil,50],
			["H_Cap_usblack",nil,50],
			["H_Cap_blk_CMMG",nil,50],
			["H_Cap_blk_ION",nil,50],
			["H_Cap_surfer",nil,50],
			["H_Booniehat_grn",nil,50],
			["H_Booniehat_tan",nil,50],
			["H_Booniehat_dirty",nil,50],
			["H_Booniehat_khk",nil,50],
			["H_Booniehat_oli",nil,50],
			["H_Booniehat_mcamo",nil,50],
			["H_Booniehat_dgtl",nil,50],
			["H_Booniehat_khk_hs",nil,50],
			["H_Booniehat_tna_F",nil,50],
			["H_Booniehat_mgrn",nil,50],
			["H_Booniehat_taiga",nil,50],
			["H_Booniehat_wdl",nil,50],
			["H_Booniehat_eaf",nil,50],
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
			["H_Bandanna_surfer",nil,50],
			["H_Bandanna_khk",nil,50],
			["H_Bandanna_cbr",nil,50],
			["H_Bandanna_sgg",nil,50],
			["H_Bandanna_gry",nil,50],
			["H_StrawHat",nil,50],
			["H_StrawHat_dark",nil,50],
			["H_Hat_camo","Hat (Camo)", 500],
			["H_Hat_blue",nil,50],
			["H_Hat_brown",nil,50],
			["H_Hat_grey",nil,50],
			["H_Watchcap_blk",nil,50],
			["H_Watchcap_khk",nil,50],
			["H_Watchcap_sgg",nil,50],
			["H_Watchcap_camo",nil,50],
			["H_Hat_checker",nil,50],
			["H_Tank_black_F",nil,500],
			["H_Hat_Tinfoil_F",nil,5000],
			["H_HelmetB_light",nil,10000],
			["H_HelmetB_light_snakeskin",nil,10000],
			["H_HelmetB_light_desert",nil,10000],
			["H_HelmetB_light_sand",nil,10000],
			["H_HelmetB_Light_tna_F",nil,10000],
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
			["H_CrewHelmetHeli_B",nil,15000],
			["H_CrewHelmetHeli_O",nil,15000],
			["H_CrewHelmetHeli_I",nil,15000],
			["H_HelmetB_light_wdl",nil,15000],
			["H_HelmetSpecB_wdl",nil,15000],
			["H_HelmetHBK_headset_F",nil,15000],
			["H_HelmetHBK_chops_F",nil,15000],
			["H_HelmetHBK_ear_F",nil,15000],
			["H_HelmetB_plain_wdl",nil,15000],
			["H_HelmetHBK_F",nil,15000],
			["H_HelmetCrew_O_ghex_F",nil,17500],
			["H_HelmetO_ghex_F",nil,17500],
			["H_HelmetSpecO_ghex_F",nil,20000],
			["H_HelmetB_Enh_tna_F",nil,20000],
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
			["G_Diving",nil,500],
			["G_RegulatorMask_F",nil,500],
			["G_AirPurifyingRespirator_01_F",nil,500],
			["G_AirPurifyingRespirator_02_sand_F",nil,500],
			["G_AirPurifyingRespirator_02_olive_F",nil,500],
			["V_SmershVest_01_F",nil,5000],
			["V_SmershVest_01_radio_F",nil,5000],
			["V_RebreatherB",nil,5000],
			["V_HarnessO_brn","TLBV Harness",20000],
			["V_TacVest_khk","Tactical Vest (Khaki)",10000],
			["V_TacVest_brn","Tactical Vest (Brown)",10000],
			["V_TacVest_oli","Tactical Vest (Olive)",10000],
			["V_TacVest_camo","Tactical Vest (Camo)",10000],
			["V_TacVest_brn","Tactical Vest (Brown)",10000],
			["V_TacVestIR_blk","Tactical Vest (Black)",10000],
			["V_I_G_resistanceLeader_F","Tactical Vest (Stavrou)",10000],
			["V_DeckCrew_blue_F","Deck Crew (Blue)",20000],
			["V_DeckCrew_brown_F","Deck Crew (Brown)",20000],
			["V_DeckCrew_green_F","Deck Crew (Green)",20000],
			["V_DeckCrew_red_F","Deck Crew (Red)",20000],
			["V_DeckCrew_violet_F","Deck Crew (Violet)",20000],
			["V_DeckCrew_white_F","Deck Crew (White)",20000],
			["V_DeckCrew_yellow_F","Deck Crew (Yellow)",20000],
			["V_CarrierRigKBT_01_Olive_F","Olive Combat Vest",30000],
			["V_CarrierRigKBT_01_EAF_F","EAF Combat Vest",30000],
			["V_PlateCarrier1_wdl","Woodland Carrier Lite",35000],
			["V_PlateCarrier1_blk",nil,35000],
			["V_PlateCarrier1_rgr","Green Carrier Lite",35000],
			["V_PlateCarrier1_rgr_noflag_F","Green Carrier Lite (No Flag)",35000],
			["V_PlateCarrier1_tna_F","Tropic Carrier Lite",35000],
			["V_PlateCarrierL_CTRG","CTRG Carrier Lite",35000],
			["V_CarrierRigKBT_01_light_Olive_F","Olive Combat Vest Lite",35000],
			//["V_CarrierRigKBT_01_light_EAF_F","EAF Combat Vest Lite",35000],
			//["V_PlateCarrierIA1_dgtl","GA Carrier Lite",35000],
			//["V_PlateCarrierIA2_dgtl","GA Carrier Rig",40000],
		    //["V_EOD_blue_F","EOD Vest (Blue)",45000],
			//["V_EOD_coyote_F","EOD Vest (Coyote)",45000],
			//["V_CarrierRigKBT_01_Heavy_Olive_F","Olive Carrier Rig",50000],
			//["V_CarrierRigKBT_01_Heavy_EAF_F","EAF Carrier Rig",50000],
			//["V_PlateCarrierIAGL_dgtl","GA Carrier GL Rig (Digi)",50000],
			//["V_PlateCarrierIAGL_oli","GA Carrier GL Rig (Olive)",50000],
			//["V_PlateCarrierGL_rgr","Carrier GL Rig (Green)",55000],
			//["V_PlateCarrierGL_mtp","Carrier GL Rig (MTP)",55000],
			//["V_PlateCarrierGL_tna_F","Carrier GL Rig (Tropic)",55000],
			//["V_PlateCarrierGL_wdl","Carrier GL Rig (Woodland)",55000],
			//["V_PlateCarrierGL_blk","Carrier GL Rig (Black)",55000],
			["V_HarnessOGL_brn","Suicide Vest",2000000],
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
			["B_Kitbag_mcamo",nil,1500],
			["B_Kitbag_sgg",nil,1500],
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

		if(__GETC__(oev_donator) >= 15) then {
			_ret pushBack ["H_Cap_headphones","Hat with Headphones",500];
			_ret pushBack ["H_Cap_marshal","Hat with Headphones2",500];
			_ret pushBack ["H_Beret_blk","Beret (Black)",500];
			_ret pushBack ["G_Goggles_VR","VR Goggles",150];
			_ret pushBack ["U_IG_Guerilla3_1","Supporter Outfit",500];
		};


		if(__GETC__(oev_donator) >= 10) then {
			_ret pushBack ["U_C_Driver_1_black","Black Racing Uniform",500];
			_ret pushBack ["U_C_Driver_1_blue","Blue Racing Uniform",500];
			_ret pushBack ["U_C_Driver_1_red","Red Racing Uniform",500];
			_ret pushBack ["U_C_Driver_1_orange","Orange Racing Uniform",500];
			_ret pushBack ["U_C_Driver_1_green","Green Racing Uniform",500];
			_ret pushBack ["U_C_Driver_1_white","White Racing Uniform",500];
			_ret pushBack ["U_C_Driver_1_yellow","White Racing Uniform",500];
			_ret pushBack ["U_C_Driver_2",nil,500];
			_ret pushBack ["U_C_Driver_1",nil,500];
			_ret pushBack ["U_C_Driver_3",nil,500];
			_ret pushBack ["U_C_Driver_4",nil,500];
			_ret pushBack ["H_RacingHelmet_1_black_F","Black Racing Helmet",500];
			_ret pushBack ["H_RacingHelmet_1_red_F","Red Racing Helmet",500];
			_ret pushBack ["H_RacingHelmet_1_white_F","White Racing Helmet",500];
			_ret pushBack ["H_RacingHelmet_1_blue_F","Blue Racing Helmet",500];
			_ret pushBack ["H_RacingHelmet_1_yellow_F","Yellow Racing Helmet",500];
			_ret pushBack ["H_RacingHelmet_1_green_F","Green Racing Helmet",500];
			_ret pushBack ["H_RacingHelmet_1_F",nil,500];
			_ret pushBack ["H_RacingHelmet_2_F",nil,500];
			_ret pushBack ["H_RacingHelmet_3_F",nil,500];
			_ret pushBack ["H_RacingHelmet_4_F",nil,500];
		};

		if(__GETC__(oev_donator) >= 30) then {
			_ret pushBack ["B_Kitbag_mcamo","Donor Red",1500];
			_ret pushBack ["B_Kitbag_sgg","Donor Green",1500];
		};
		if ((getPlayerUID player) isEqualTo "76561198010422149") then {
			_ret pushBack ["U_O_CombatUniform_ocamo","The Dili Special",500];
			_ret pushBack ["U_O_R_Gorka_01_black_F","Soup of the Day",500];
		};
 		if (__GETC__(oev_donator) >= 1000) then {
			_ret pushBack ["U_I_Soldier_VR","Full Body Suit Green",500];
			_ret pushBack ["U_O_Soldier_VR","Full Body Suit Red",500];
			_ret pushBack ["U_B_Soldier_VR","Full Body Suit Blue",500];
			_ret pushBack ["U_C_Soldier_VR", "Full Body Suit Purple",500];
			_ret pushBack ["B_Carryall_ocamo","Founders Caryall",2500];
		};
		if (__GETC__(oev_donator) >= 100) then {
			_ret pushBack ["B_Messenger_Black_F","Abibas Messenger",1000];
			_ret pushBack ["U_C_Poloshirt_blue","Abibas Outfit",500];

		};
		if ((__GETC__(oev_donator) >= 100) && (__GETC__(oev_donator) < 500)) then {
			_ret pushBack ["U_I_CombatUniform_shortsleeve","Elite Outfit",500];
		};
		if (__GETC__(oev_donator) >= 500) then {
			_ret pushBack ["U_I_CombatUniform_shortsleeve","Legendary Outfit",500];
		};
		if (__GETC__(oev_civcouncil) > 0) then {
			_ret pushBack ["U_I_CombatUniform_tshirt","Civ Council Outfit",500];
		};
		if (__GETC__(oev_designerlevel) > 1 || __GETC__(oev_developerlevel) > 1 ||  __GETC__(life_adminlevel) > 0) then {
			_ret pushBack ["U_I_CombatUniform_tshirt","Staff Uniform",500];
		};
		if((oev_gang_data select 0) in oev_gangUniforms) then {
			_ret pushBack ["U_I_CombatUniform_shortsleeve",format["%1 Gang Uniform",(oev_gang_data select 1)],500];
		};
	};
};

_ret;
