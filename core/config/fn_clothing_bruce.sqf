#include "..\..\macro.h"
//  File: fn_clothing_bruce.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Master configuration file for Bruce's Outback Outfits.
private["_filter","_ret"];
_filter = param [0,0,[0]];
//Classname, Custom Display name (use nil for Cfg->DisplayName, price

private _blackMarkets = ["bmOne","bmTwo","bmThree","bmFour"];
private _isBlackMarket = false;
{
	if ((player distance (getMarkerPos _x)) < 75) then {
		_isBlackMarket = true;
	};
} forEach _blackMarkets;

//Shop Title Name
ctrlSetText[3103,"Bruce's Outback Outfits"];

switch (_filter) do {
	//Uniforms
	case 0:	{
		_ret = [
			["U_C_Poloshirt_blue","Blue Poloshirt",250],
			["U_C_Poloshirt_redwhite","Redwhite Poloshirt",250],
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
			["U_C_Mechanic_01_F","Mechanic Clothes",500],
			["U_C_Uniform_Farmer_01_F","Farmer Clothes",500],
			["U_C_E_LooterJacket_01_F","Ripper Jacket",500],
			["U_I_L_Uniform_01_tshirt_black_F","Black T-Shirt",500],
			["U_I_L_Uniform_01_tshirt_olive_F","Hunter Clothes",500],
			["U_I_L_Uniform_01_tshirt_skull_F","Edgy T-Shirt",500],
			["U_I_L_Uniform_01_tshirt_sport_F","Sports T-Shirt",500],
			["U_C_Uniform_Scientist_01_formal_F","Nerd Clothes",500],
			["U_C_Uniform_Scientist_01_F","Periodic Professor",500],
			["U_C_Uniform_Scientist_02_formal_F","Atomic T-Shirt",500],
			["U_C_Uniform_Scientist_02_F","Believer Shirt",500]
		];

		if(__GETC__(oev_donator) >= 15) then {
			_ret pushBack ["U_C_Driver_1_black","Black Racing Uniform",500];
			_ret pushBack ["U_C_Driver_1_blue","Blue Racing Uniform",500];
			_ret pushBack ["U_C_Driver_1_red","Red Racing Uniform",500];
			_ret pushBack ["U_C_Driver_1_orange","Orange Racing Uniform",500];
			_ret pushBack ["U_C_Driver_1_green","Green Racing Uniform",500];
			_ret pushBack ["U_C_Driver_1_white","White Racing Uniform",500];
			_ret pushBack ["U_C_Driver_1_yellow","White Racing Uniform",500];
			_ret pushBack ["U_I_E_ParadeUniform_01_LDF_decorated_F","定制服装模板",5000];
			_ret pushBack ["U_C_Driver_2",nil,500];
			_ret pushBack ["U_C_Driver_1",nil,500];
			_ret pushBack ["U_C_Driver_3",nil,500];
			_ret pushBack ["U_C_Driver_4",nil,500];
		};

		{
			_ret pushBack [_x,nil,400];
		} forEach ["U_C_Man_casual_3_F","U_C_Man_casual_2_F","U_I_C_Soldier_Bandit_3_F","U_I_C_Soldier_Bandit_5_F","U_I_C_Soldier_Bandit_2_F","U_I_C_Soldier_Bandit_1_F","U_I_C_Soldier_Bandit_4_F","U_C_man_sport_1_F","U_C_man_sport_3_F","U_C_man_sport_2_F","U_C_Man_casual_6_F","U_C_Man_casual_4_F","U_C_Man_casual_5_F"];

		if ((getPlayerUID player) isEqualTo "76561198010422149") then {
			_ret pushBack ["U_O_CombatUniform_ocamo","The Dili Special",500];
			_ret pushBack ["U_O_R_Gorka_01_black_F","Soup of the Day",500];
		};
		if ((getPlayerUID player) isEqualTo "76561198120173072") then {
			_ret pushBack ["U_I_CombatUniform","I hope no one notices o.o",500];
		};

		
		if (101 in life_loot) then {
			_ret pushBack ["U_C_FormalSuit_01_blue_F","1234",500];
		};

		if (__GETC__(oev_donator) >= 15) then {
			_ret pushBack ["U_IG_Guerilla3_1","Supporter Outfit",500];
		};

		if ((__GETC__(oev_donator) >= 100) && (__GETC__(oev_donator) < 500)) then {
			_ret pushBack ["U_I_CombatUniform_shortsleeve","Elite Outfit",500];
		};
		if (__GETC__(oev_donator) >= 100) then {
			_ret deleteAt 0;
			_ret pushBack ["U_C_Poloshirt_blue","Abibas Outfit",500];
		};

		if (__GETC__(oev_donator) >= 500) then {
			_ret pushBack ["U_I_CombatUniform_shortsleeve","Legendary Outfit",500];
		};

		if (__GETC__(oev_donator) >= 1000) then {
			_ret pushBack ["U_I_Soldier_VR","Full Body Suit Green",500];
			_ret pushBack ["U_O_Soldier_VR","Full Body Suit Red",500];
			_ret pushBack ["U_B_Soldier_VR","Full Body Suit Blue",500];
			_ret pushBack ["U_C_Soldier_VR", "Full Body Suit Purple",500];
		};

		if (__GETC__(oev_civcouncil) > 0) then {
			_ret pushBack ["U_I_CombatUniform_tshirt","Civ Council Outfit",500];
		};
		if (__GETC__(life_supportlevel) > 0) then {
			_ret pushBack ["U_I_CombatUniform_tshirt","Support Team Outfit",500];
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
	};

	//Hats
	case 1: {
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
			["H_Cap_Black_IDAP_F",nil,50],
			["H_Cap_Orange_IDAP_F",nil,50],
			["H_Cap_White_IDAP_F",nil,50],
			["H_Cap_surfer",nil,50],
			["H_Cap_usblack",nil,50],
			["H_EarProtectors_black_F",nil,50],
			["H_EarProtectors_orange_F",nil,50],
			["H_EarProtectors_red_F",nil,50],
			["H_EarProtectors_white_F",nil,50],
			["H_EarProtectors_yellow_F",nil,50],
			["H_Construction_basic_black_F",nil,50],
			["H_Construction_basic_orange_F",nil,50],
			["H_Construction_basic_red_F",nil,50],
			["H_Construction_basic_white_F",nil,50],
			["H_Construction_basic_yellow_F",nil,50],
			["H_HeadSet_black_F",nil,50],
			["H_HeadSet_orange_F",nil,50],
			["H_HeadSet_red_F",nil,50],
			["H_HeadSet_white_F",nil,50],
			["H_HeadSet_yellow_F",nil,50],
			["H_Hat_Safari_olive_F",nil,50],
			["H_Hat_Safari_sand_F",nil,50],
			["H_Hat_Tinfoil_F","Tinfoil Hat",5000],
			["H_PilotHelmetFighter_O","Pilot Helmet [CSAT]",15000]
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

		{
			_ret pushBack [_x,nil,100];
		} forEach ["H_Booniehat_tna_F","H_MilCap_ghex_F","H_MilCap_tna_F","H_Helmet_Skate"];

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
			["G_WirelessEarpiece_F",nil,55],
			["G_Spectacles_Tinted","Tinted Spectacles",55]
		];
		if (_isBlackMarket) then{
			_ret pushBack ["G_Balaclava_blk",nil,500];
			_ret pushBack ["G_Balaclava_combat",nil,500];
			_ret pushBack ["G_Balaclava_lowprofile",nil,500];
			_ret pushBack ["G_Balaclava_oli",nil,500];
			_ret pushBack ["G_Balaclava_TI_blk_F",nil,500];
			_ret pushBack ["G_Balaclava_TI_G_blk_F",nil,500];
			_ret pushBack ["G_Balaclava_TI_tna_F",nil,500];
			_ret pushBack ["G_Balaclava_TI_G_tna_F",nil,500];
		};

		if(__GETC__(oev_donator) >= 15) then{
			_ret pushBack ["G_Goggles_VR","VR Goggles",150];
		};
	};

	//Vest
	case 3: {
		_ret = [
			["V_Rangemaster_belt",nil,4500],
			["V_BandollierB_khk",nil,4500],
			["V_BandollierB_cbr",nil,4500],
			["V_BandollierB_rgr",nil,4500],
			["V_BandollierB_blk",nil,4500],
			["V_BandollierB_oli",nil,4500],
			["V_Chestrig_khk","Chest Rig (Khaki)",6000],
			["V_Chestrig_rgr","Chest Rig (Green)",6000],
			["V_Chestrig_oli","Chest Rig (Olive)",6000],
			["V_Chestrig_blk","Chest Rig (Black)",6000],
			["V_LegStrapBag_black_F","Leg Strap (Black)",5000],
			["V_LegStrapBag_coyote_F","Leg Strap (Coyote)",5000],
			["V_LegStrapBag_olive_F","Leg Strap (Olive)",5000],
			["V_Pocketed_black_F","Multi-Pocket Vest (Black)",5000],
			["V_Pocketed_coyote_F","Multi-Pocket Vest (Coyote)",5000],
			["V_Pocketed_olive_F","Multi-Pocket Vest (Olive)",5000],
			["V_Safety_blue_F","Safety Vest (Blue)",3000],
			["V_Safety_orange_F","Safety Vest (Orange)",3000],
			["V_Safety_yellow_F","Safety Vest (Yellow)",3000]
		];

		if (license_civ_wpl || _isBlackMarket) then {
			_ret pushBack ["V_TacVest_khk","Tactical Vest (Khaki)",10000];
			_ret pushBack ["V_TacVest_brn","Tactical Vest (Brown)",10000];
			_ret pushBack ["V_TacVest_oli","Tactical Vest (Olive)",10000];
			_ret pushBack ["V_TacVest_camo","Tactical Vest (Camo)",10000];
			_ret pushBack ["V_TacVest_brn","Tactical Vest (Brown)",10000];
			_ret pushBack ["V_TacVestIR_blk","Tactical Vest (Black)",10000];
			_ret pushBack ["V_DeckCrew_blue_F","Deck Crew (Blue)",20000];
			_ret pushBack ["V_DeckCrew_brown_F","Deck Crew (Brown)",20000];
			_ret pushBack ["V_DeckCrew_green_F","Deck Crew (Green)",20000];
			_ret pushBack ["V_DeckCrew_red_F","Deck Crew (Red)",20000];
			_ret pushBack ["V_DeckCrew_violet_F","Deck Crew (Violet)",20000];
			_ret pushBack ["V_DeckCrew_white_F","Deck Crew (White)",20000];
			_ret pushBack ["V_DeckCrew_yellow_F","Deck Crew (Yellow)",20000];
			_ret pushBack ["V_I_G_resistanceLeader_F","Tactical Vest (Stavrou)",25000];
		};

		if (missionNamespace getVariable ["license_civ_wpl", false]) then {
			_ret pushBack ["V_PlateCarrier1_blk", nil, 35000];
		};
	};

	//Backpacks
	case 4: {
		if (__GETC__(oev_donator) >= 1000) then {
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
				["B_Messenger_Black_F","Abibas Messenger",1000],
				["B_FieldPack_oucamo",nil,1000],
				["B_TacticalPack_blk",nil,1250],
				["B_TacticalPack_rgr",nil,1250],
				["B_TacticalPack_ocamo",nil,1250],
				["B_TacticalPack_mcamo",nil,1250],
				["B_TacticalPack_oli",nil,1250],
				["B_Kitbag_tan","Smile",1500],
				["B_Kitbag_mcamo","Donor Red",1500],
				["B_Kitbag_sgg","Donor Green",1500],
				["B_Kitbag_cbr","Kitbag (Black)",1500],
				["B_Carryall_ocamo","Founders Caryall",2500],
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
		} else {
			if (__GETC__(oev_donator) >= 100) then {
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
					["B_Messenger_Black_F","Abibas Messenger",1000],
					["B_TacticalPack_blk",nil,1250],
					["B_TacticalPack_rgr",nil,1250],
					["B_TacticalPack_ocamo",nil,1250],
					["B_TacticalPack_mcamo",nil,1250],
					["B_TacticalPack_oli",nil,1250],
					["B_Kitbag_tan","Smile",1500],
					["B_Kitbag_mcamo","Donor Red",1500],
					["B_Kitbag_sgg","Donor Green",1500],
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
			}	else {
				if (__GETC__(oev_donator) >= 50) then {
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
						["B_Kitbag_tan","Smile",1500],
						["B_Kitbag_mcamo","Donor Red",1500],
						["B_Kitbag_sgg","Donor Green",1500],
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
				} else {
					if (__GETC__(oev_donator) >= 30) then {
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
							["B_Kitbag_tan","Smile",1500],
							["B_Kitbag_mcamo","Donor Red",1500],
							["B_Kitbag_sgg","Donor Green",1500],
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
					} else {
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
							["B_Kitbag_tan",nil,1500],
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
					};
				};
			};
		};
	};
};

_ret;
