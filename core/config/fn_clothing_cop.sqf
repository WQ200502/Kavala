#include "..\..\macro.h"
//  File: fn_clothing_cop.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Master config file for Cop clothing store.

params [
	["_filter",0,[0]],
	["_obtainPrice",false,[false]]
];

private _ret = [];
if !(_obtainPrice) then {
	//Shop Title Name
	ctrlSetText[3103,"阿尔蒂斯警察局商店"];
};
switch (_filter) do {
	//Uniforms
	case 0:	{
		_ret = [
			["U_B_Wetsuit","Wetsuit",500]
		];
		if ((__GETC__(life_coplevel) >= 1) && (__GETC__(life_coplevel) < 3)) then {
			_ret pushBack ["U_Rangemaster",oev_copForce + " Uniform",500];
		};
		if ((__GETC__(life_coplevel) >= 2) && (__GETC__(oev_donator) >= 100)) then {
			_ret pushBack ["U_B_GEN_Commander_F","Longsleeve Donator Uniform",500];
		};
		if((__GETC__(life_coplevel) >= 2) && (__GETC__(oev_donator) >= 250)) then {
			_ret pushBack ["U_C_Man_casual_2_F","State Police",500];
		};
		if ((__GETC__(life_coplevel) >= 3) && (__GETC__(life_coplevel) < 6)) then {
			_ret pushBack ["U_I_CombatUniform","Corporal Longsleeve Uniform",500];
		};
		if((__GETC__(life_coplevel) >= 3) && (__GETC__(oev_donator) >= 250)) then {
			_ret pushBack ["U_B_GEN_Soldier_F","State Trooper",500];
		};
		if (__GETC__(life_coplevel) >= 3) then {
			_ret pushBack ["U_C_Man_casual_1_F",oev_copForce + " Uniform",500];
			_ret pushBack ["U_Marshal",oev_copHighway + " Uniform",500];
		};
		if((__GETC__(life_coplevel) >= 4) && (__GETC__(oev_donator) >= 250)) then {
			_ret pushBack ["U_I_CombatUniform_shortsleeve","SRT Uniform",500];
			_ret pushBack ["U_I_Wetsuit","Green Wetsuit",500];
		};
		if (__GETC__(life_coplevel) >= 5) then {
			_ret pushBack ["U_Rangemaster","Junior APD Uniform",500];
			_ret pushBack ["U_C_Man_casual_3_F","Deputy Uniform",500];
		};
		if (__GETC__(life_coplevel) >= 6) then {
			_ret pushBack ["U_B_CombatUniform_mcam","Upgraded "+oev_copForce+" Uniform",500];
			_ret pushBack ["U_I_CombatUniform","Senior Uniform",500];
		};
		if (__GETC__(life_coplevel) >= 7) then {
			_ret pushBack ["U_I_pilotCoveralls","sAPD Coveralls",500];
		};
		if ((getPlayerUID player) isEqualTo "76561198010422149") then {
			_ret pushBack ["U_O_CombatUniform_ocamo","The Dili Special",500];
			_ret pushBack ["U_O_R_Gorka_01_black_F","Soup of the Day",500];
		};
	};

	//Hats
	case 1:	{
		_ret = [
			["H_Cap_police","Police Cap",500],
			["H_MilCap_blue","Cop Blue Hat",500],
			["H_MilCap_gry","Cop Grey Hat",500]
		];
		if(__GETC__(life_coplevel) > 1) then {
			_ret pushBack ["H_Helmet_Skate","Skater Bro",500];
		};
		if(__GETC__(life_coplevel) > 2) then {
			_ret pushBack ["H_Beret_blk_POLICE","Beret",500];
			_ret pushBack ["H_Beret_Colonel","Beret [Colonel]",500];
			_ret pushBack ["H_Cap_Black_IDAP_F",nil,500];
			_ret pushBack ["H_Bandanna_gry","The Rag",500];
		};
		if((__GETC__(life_coplevel) >= 2) && (__GETC__(oev_donator) >= 250)) then {
			_ret pushBack ["H_Cap_headphones","Hat w/Headphones",500];
			_ret pushBack ["H_Cap_grn","Green Cap",500];
			_ret pushBack ["H_Cap_oli","Olive Cap",500];
			_ret pushBack ["H_MilCap_grn","Military Cap (Green)",500];
		};
		if(__GETC__(life_coplevel) > 3) then {
			_ret pushBack ["H_Beret_02","Beret [NATO]",500];
			_ret pushBack ["H_PilotHelmetHeli_B","Sergeant Hat",500];
			_ret pushBack ["H_HelmetSpecB_blk","Stahlhelm",500];
			_ret pushBack ["H_PASGT_basic_black_F",nil,500];
			_ret pushBack ["H_PilotHelmetFighter_B","Pilot Helmet [NATO]",15000];
		};
		if((__GETC__(life_coplevel) >= 3) && (__GETC__(oev_donator) >= 250)) then {
			_ret pushBack ["H_Cap_grn_BI","Green Cap (BI)",500];
			_ret pushBack ["H_Cap_oli_hs","Olive Cap (HS)",500];
		};
		if((__GETC__(life_coplevel) >= 4) && (__GETC__(oev_donator) >= 250)) then {
			_ret pushBack ["H_Cap_khaki_specops_UK","Green Cap (Spec)",500];
			_ret pushBack ["H_MilCap_wdl","Military Cap (Woodland)",500];
			_ret pushBack ["H_Watchcap_camo","Green Beanie (HS)",500];

			_ret pushBack ["H_Booniehat_oli","Booniehat (Olive)",500];

			_ret pushBack ["H_HelmetB","Combat Helmet (Green)",500];
			_ret pushBack ["H_PASGT_basic_olive_F","Basic Helmet (Olive)",500];
			_ret pushBack ["H_HelmetB_plain_wdl","Combat Helmet (Woodland)",500];
			_ret pushBack ["H_HelmetCrew_I","Crew Helmet",500];
			_ret pushBack ["H_HelmetSpecB","Advanced Combat Helmet (Green)",500];
			_ret pushBack ["H_HelmetSpecB_wdl","Advanced Combat Helmet (Woodland)",500];
			_ret pushBack ["H_PilotHelmetHeli_O","Heli Pilot Helmet (Green)",500];
			_ret pushBack ["H_HelmetB_light_black" ,"Light Combat Helmet (Black)",500];
			_ret pushBack ["H_HelmetB_light_wdl","Light Combat Helmet (Woodland)",500];
			_ret pushBack ["H_HelmetHBK_F","Advanced Modular Helmet (Green)",500];
			_ret pushBack ["H_PilotHelmetFighter_O","Pilot Helmet (Green)",15000];
		};
		if((__GETC__(life_coplevel) >= 6) && (__GETC__(oev_donator) >= 250)) then {
			_ret pushBack ["H_CrewHelmetHeli_O","Heli Crew Helmet (Green)",500];
		};
		if(__GETC__(life_coplevel) >= 7) then {
			_ret pushBack ["H_CrewHelmetHeli_B","Alternative Captain Hat",500];
		};
		if(__GETC__(life_coplevel) >= 8) then {
			_ret pushBack ["H_HelmetB_black",nil,500];
			_ret pushBack ["H_HelmetB_TI_tna_F",nil,500];
		};
		if (__GETC__(oev_donator) >= 50) then {
			_ret pushBack ["H_Cap_usblack","Black US Cap",500];
			_ret pushBack ["H_Watchcap_blk","Blue Beanie",500];
			_ret pushBack ["H_Cap_White_IDAP_F","IDAP White Hat",500];
			_ret pushBack ["H_EarProtectors_white_F","Ear Protectors White",500];
			_ret pushBack ["H_EarProtectors_black_F","Ear Protectors Black",500];
		};
		if (__GETC__(oev_donator) >= 100) then {
			if (__GETC__(life_coplevel) >= 3) then { // Corporal+
				_ret pushBack ["H_Beret_gen_F","Gendarmerie Beret",500];
				_ret pushBack ["H_Beret_EAF_01_F","Wolf Beret",500];
			};
			_ret pushBack ["H_Headset_White_F","Headset White",500];
			_ret pushBack ["H_Headset_Black_F","Headset Black",500];
		};
	};

	//Glasses
	case 2:	{
		_ret = [
			["G_Shades_Black","Black Shades",500],
			["G_Shades_Blue","Blue Shades",500],
			["G_Sport_Blackred","Black Red Shades",500],
			["G_Sport_Checkered","Checkered Shades",500],
			["G_Sport_Blackyellow","Black Yellow Shades",500],
			["G_Sport_BlackWhite","Black White Shades",500],
			["G_Aviator","Aviators",500],
			["G_Squares","Square Glasses",500],
			["G_Lowprofile","Lowprofile Glasses",500],
			["G_Combat","Combat Goggles",500],
			["G_B_Diving","Police Diving Goggles",500],
			["G_Balaclava_combat","Teargas Mask 1",500],
			["G_Balaclava_lowprofile","Teargas Mask 2",500],
			["G_Respirator_blue_F","Blue Teargas Mask ",300],
			["G_Respirator_white_F","White Teargas Mask ",500],
			["G_AirPurifyingRespirator_02_black_F","Black Full Respirator",500],
			["G_AirPurifyingRespirator_01_F","Full Respirator",500],
			["G_RegulatorMask_F","Full Face Gas Mask",500]
		];
		if(__GETC__(life_coplevel) > 2) then {
			_ret pushBack ["G_Tactical_Clear","Clear Tactical Glasses",500];
			_ret pushBack ["G_Tactical_Black","Black Tactical Glasses",500];
		};

		if((__GETC__(life_coplevel) >= 2) && (__GETC__(oev_donator) >= 250)) then {
			_ret pushBack ["G_AirPurifyingRespirator_02_olive_F","Olive Respirator",500];
			_ret pushBack ["G_Balaclava_oli","Olive Balaclava",500];
		};
		if(__GETC__(life_coplevel) >= 4) then {
			_ret pushBack ["G_Lady_Mirror",nil,500];
			_ret pushBack ["G_Lady_Dark",nil,500];
			_ret pushBack ["G_Lady_Blue",nil,500];
			_ret pushBack ["G_Bandanna_aviator",nil,500];
			_ret pushBack ["G_Balaclava_TI_blk_F",nil,500];
			_ret pushBack ["G_Balaclava_TI_G_blk_F",nil,500];
		};
		if((__GETC__(life_coplevel) >= 4) && (__GETC__(oev_donator) >= 250)) then {
			//No bandannas
		};
		if(__GETC__(life_coplevel) > 6) then {
			_ret pushBack ["G_Goggles_VR","Captain Goggles",500];
			_ret pushBack ["G_Bandanna_aviator","Captain Mask",500];
		};
		if (__GETC__(oev_donator) >= 100) then {
			_ret pushBack ["G_Bandanna_sport","Bandana Sport",500];
			_ret pushBack ["G_Bandanna_beast","Bandana Beast",500];
			_ret pushBack ["G_Bandanna_blk","Bandana Black",500];
			_ret pushBack ["G_Bandanna_shades","Bandana Shades",500];
		};
	};

	//Vest
	case 3: {
		_ret = [
			["V_RebreatherB","Rebreather", 500],
			["V_TacVest_blk","Cardboard Vest",500],
			["V_Safety_yellow_F","Safety Vest (Yellow)",500],
			["V_Rangemaster_belt","Rangemaster Belt",500]
		];
		if (__GETC__(life_coplevel) >= 2) then {
			_ret pushBack ["V_TacVest_blk_POLICE","APD Tactical Vest",500];
			_ret pushBack ["V_Safety_blue_F","Safety Vest (Blue)",500];
		};
		if((__GETC__(life_coplevel) >= 2) && (__GETC__(oev_donator) >= 250)) then {
			_ret pushBack ["V_TacVest_oli","APD Tactical Vest (Olive)",500];
		};
		if (__GETC__(life_coplevel) >= 4) then {
			_ret pushBack ["V_PlateCarrier1_blk","APD Carrier Lite",28000];
		};
		if (__GETC__(life_coplevel) >= 4 && (__GETC__(oev_donator) >= 250)) then {
			_ret pushBack ["V_PlateCarrier1_wdl","APD Carrier Lite (Woodland)",28000];
		};
		if (__GETC__(life_coplevel) >= 6) then {
			_ret pushBack ["V_PlateCarrier2_blk","APD Carrier Rig",35000];
			_ret pushBack ["V_PlateCarrierGL_blk","APD Carrier GL Rig (Black)",44000];
		};
		if (__GETC__(life_coplevel) >= 6 && (__GETC__(oev_donator) >= 250)) then {
			_ret pushBack ["V_PlateCarrier2_wdl","APD Carrier Rig (Woodland)",35000];
			_ret pushBack ["V_PlateCarrierGL_wdl","APD Carrier GL Rig (Woodland)",44000];
		};
		/* if(__GETC__(life_coplevel) >= 7) then {
			_ret pushBack ["V_PlateCarrierGL_blk","APD Carrier GL Rig (Black)",44000];
		}; */

		if(__GETC__(life_coplevel) >= 9) then {
			_ret pushBack ["V_PlateCarrierSpec_blk","APD Carrier Special Rig",60000];
			_ret pushBack ["V_PlateCarrierSpec_wdl","APD Carrier Special Rig (Woodland)",60000];
		};
	};

	//Backpacks
	case 4:	{
		_ret = [
			["B_Carryall_oucamo","Invis. Carryall",500],
			["B_Kitbag_rgr","Invis. Kitbag",500]
		];
		if (__GETC__(life_coplevel) >= 4) then {
			_ret pushBack ["B_Bergen_dgtl_F","Invis. Bergen",5000];
		};
	};

	//Return all clothing -- THESE ARE CASE-SENSITIVE, CLASS NAME MUST MATCH EXACTLY
	case 7: {
		_ret = [
			["U_B_Wetsuit","Wetsuit",500],
			["H_Cap_police","Police Cap",500],
			["H_MilCap_blue","Cop Blue Hat",500],
			["H_MilCap_gry","Cop Grey Hat",500],
			["G_Shades_Black","Black Shades",500],
			["G_Shades_Blue","Blue Shades",500],
			["G_Sport_Blackred","Black Red Shades",500],
			["G_Sport_Checkered","Checkered Shades",500],
			["G_Sport_Blackyellow","Black Yellow Shades",500],
			["G_Sport_BlackWhite","Black White Shades",500],
			["G_Aviator","Aviators",500],
			["G_Squares","Square Glasses",500],
			["G_Lowprofile","Lowprofile Glasses",500],
			["G_Combat","Combat Goggles",500],
			["G_B_Diving","Police Diving Goggles",500],
			["G_Balaclava_combat","Teargas Mask 1",500],
			["G_Balaclava_lowprofile","Teargas Mask 2",500],
			["G_Respirator_blue_F","Blue Teargas Mask ",300],
			["G_Respirator_white_F","White Teargas Mask ",500],
			["G_AirPurifyingRespirator_02_black_F","Black Full Respirator",500],
			["G_AirPurifyingRespirator_01_F","Full Respirator",500],
			["G_RegulatorMask_F","Full Face Gas Mask",500],
			["V_RebreatherB","Rebreather", 500],
			["V_TacVest_blk","Cardboard Vest",500],
			["V_Safety_yellow_F","Safety Vest (Yellow)",500],
			["V_Safety_blue_F","Safety Vest (Blue)",500],
			["B_Carryall_oucamo","Invis. Carryall",500],
			["B_Kitbag_rgr","Invis. Kitbag",500],
			["V_Rangemaster_belt","Rangemaster Belt",500]
		];
		if ((__GETC__(life_coplevel) >= 1) && (__GETC__(life_coplevel) < 3)) then {
			_ret pushBack ["U_Rangemaster",oev_copForce + " Uniform",500];
		};
		if (__GETC__(life_coplevel) > 1) then {
			_ret pushBack ["V_TacVest_blk_POLICE","APD Tactical Vest",500];
			_ret pushBack ["G_Lady_Mirror",nil,500];
			_ret pushBack ["G_Lady_Dark",nil,500];
			_ret pushBack ["G_Lady_Blue",nil,500];
			_ret pushBack ["G_Bandanna_aviator",nil,500];
			_ret pushBack ["G_Balaclava_TI_blk_F",nil,500];
			_ret pushBack ["G_Balaclava_TI_G_blk_F",nil,500];
			_ret pushBack ["G_Tactical_Clear","Clear Tactical Glasses",500];
			_ret pushBack ["G_Tactical_Black","Black Tactical Glasses",500];
			_ret pushBack ["H_Helmet_Skate","Skater Bro",500];
			if (__GETC__(oev_donator) >= 100) then {
				_ret pushBack ["U_B_GEN_Commander_F","Longsleeve Donator Uniform",500];
			};
		};
		if (__GETC__(life_coplevel) > 2) then {
			_ret pushBack ["V_PlateCarrier1_blk","APD Carrier Lite",28000];
			_ret pushBack ["H_Beret_blk_POLICE","Beret",500];
			_ret pushBack ["H_Beret_Colonel","Beret [Colonel]",500];
			_ret pushBack ["H_Cap_Black_IDAP_F",nil,500];
			_ret pushBack ["U_Marshal",oev_copHighway + " Uniform",500];
			_ret pushBack ["U_Competitor","Red Corporal Uniform",500];
			_ret pushBack ["U_C_Man_casual_1_F",oev_copForce + " Uniform",500];
			if (__GETC__(oev_donator) >= 100) then {
				_ret pushBack ["H_Beret_gen_F","Donor Beret",500];
				_ret pushBack ["H_Beret_EAF_01_F","Donor Beret 2",500];
			};
		};
		if ((__GETC__(life_coplevel) >= 3) && (__GETC__(life_coplevel) < 6)) then {
			_ret pushBack ["U_I_CombatUniform","Corporal Longsleeve Uniform",500];
		};
		if (__GETC__(life_coplevel) > 3) then {
			_ret pushBack ["V_PlateCarrier2_blk","Improved Senior Vest",35000];
			_ret pushBack ["H_Beret_02","Beret [NATO]",500];
			_ret pushBack ["H_PilotHelmetHeli_B","Sergeant Hat",500];
			_ret pushBack ["H_HelmetSpecB_blk","Stahlhelm",500];
			_ret pushBack ["H_PASGT_basic_black_F",nil,500];
			_ret pushBack ["H_PilotHelmetFighter_B","Pilot Helmet [NATO]",15000];
			_ret pushBack ["H_Bandanna_gry","The Rag",500];
			_ret pushBack ["B_Bergen_dgtl_F","Invis. Bergen",5000];
		};
		if (__GETC__(life_coplevel) > 5) then {
			_ret pushBack ["U_B_CombatUniform_mcam","Upgraded "+oev_copForce+" Uniform",500];
			_ret pushBack ["U_I_CombatUniform","Senior Uniform",500];
			_ret pushBack ["U_Rangemaster","Junior APD Uniform",500];
			_ret pushBack ["V_PlateCarrierGL_blk","APD Carrier GL Rig (Black)",44000];
			_ret pushBack ["U_C_Man_casual_3_F","Deputy Uniform",500];
		};
		if(__GETC__(life_coplevel) > 6) then {
			_ret pushBack ["V_PlateCarrierSpec_blk","Improved Tactical Vest V2",60000];
			_ret pushBack ["H_CrewHelmetHeli_B","Alternative Captain Hat",500];
		};
		if(__GETC__(life_coplevel) > 7) then {
			_ret pushBack ["H_HelmetB_black",nil,500];
			_ret pushBack ["H_HelmetB_TI_tna_F",nil,500];
			_ret pushBack ["G_Goggles_VR","Captain Goggles",500];
			_ret pushBack ["G_Bandanna_aviator","Captain Mask",500];
			_ret pushBack ["U_I_pilotCoveralls","sAPD Coveralls",500];
		};
		if ((getPlayerUID player) isEqualTo "76561198010422149") then {
			_ret pushBack ["U_O_CombatUniform_ocamo","The Dili Special",500];
			_ret pushBack ["U_O_R_Gorka_01_black_F","Soup of the Day",500];
		};
		if (__GETC__(oev_donator) >= 50) then {
			_ret pushBack ["H_Cap_usblack","Black US Cap",500];
			_ret pushBack ["H_Watchcap_blk","Blue Beanie",500];
			_ret pushBack ["H_Cap_White_IDAP_F","IDAP White Hat",500];
			_ret pushBack ["H_EarProtectors_white_F","Ear Protectors White",500];
			_ret pushBack ["H_EarProtectors_black_F","Ear Protectors Black",500];
		};
		if (__GETC__(oev_donator) >= 100) then {
			_ret pushBack ["H_HeadSet_white_F","Headset White",500];
			_ret pushBack ["H_HeadSet_black_F","Headset Black",500];
			_ret pushBack ["G_Bandanna_sport","Bandana Sport",500];
			_ret pushBack ["G_Bandanna_beast","Bandana Beast",500];
			_ret pushBack ["G_Bandanna_blk","Bandana Black",500];
			_ret pushBack ["G_Bandanna_shades","Bandana Shades",500];
		};
		if (__GETC__(oev_donator) >= 250) then {
			_ret pushBack ["U_C_Man_casual_2_F","State Police",500];
			_ret pushBack ["U_B_GEN_Soldier_F","State Trooper",500];
			_ret pushBack ["U_I_CombatUniform_shortsleeve","Sr. State Police",500];
			_ret pushBack ["U_I_Wetsuit","Wetsuit",500];
			_ret pushBack ["H_Cap_headphones","Hat Headphones",500];
			_ret pushBack ["H_Cap_grn","Green Cap",500];
			_ret pushBack ["H_Cap_oli","Olive Cap",500];
			_ret pushBack ["H_Cap_grn_BI","Green Cap (BI)",500];
			_ret pushBack ["H_Cap_oli_hs","Olive Cap (HS)",500];
			_ret pushBack ["H_Booniehat_oli","Booniehat (Olive)",500];
			_ret pushBack ["H_HelmetB_light_black" ,"Light Combat Helmet (Black)",500];

			_ret pushBack ["H_HelmetCrew_I","Crew Helmet",500];
			_ret pushBack ["G_AirPurifyingRespirator_02_olive_F","Respirator",500];
			_ret pushBack ["G_Balaclava_oli","Olive Balaclava",500];

			_ret pushBack ["V_TacVest_oli","APD Tactical Vest (Olive)",500];
			_ret pushBack ["V_PlateCarrier1_wdl","APD Carrier Lite (Woodland)",28000];
			_ret pushBack ["V_PlateCarrier2_wdl","APD Carrier Rig (Woodland)",35000];
			_ret pushBack ["V_PlateCarrierGL_wdl","APD Carrier GL (Woodland)",44000];
			_ret pushBack ["V_PlateCarrierSpec_wdl","APD Carrier Special Rig (Woodland)",60000];

			_ret pushBack ["H_Cap_khaki_specops_UK" ,"Green Cap (Spec)",500];
			_ret pushBack ["H_MilCap_grn","Military Cap (Green)",500];
			_ret pushBack ["H_MilCap_wdl","Military Cap (Woodland)",500];
			_ret pushBack ["H_Watchcap_camo","Green Beanie (HS)",500];

			_ret pushBack ["H_HelmetB","Combat Helmet (Green)",500];
			_ret pushBack ["H_PASGT_basic_olive_F","Basic Helmet (Olive)",500];
			_ret pushBack ["H_HelmetB_plain_wdl","Combat Helmet (Woodland)",500];
			_ret pushBack ["H_HelmetCrew_I","Crew Helmet",500];
			_ret pushBack ["H_HelmetSpecB","Advanced Combat Helmet (Green)",500];
			_ret pushBack ["H_HelmetSpecB_wdl","Advanced Combat Helmet (Woodland)",500];
			_ret pushBack ["H_CrewHelmetHeli_O","Heli Crew Helmet (Green)",500];
			_ret pushBack ["H_PilotHelmetHeli_O","Heli Pilot Helmet (Green)",500];
			_ret pushBack ["H_HelmetB_light_wdl","Light Combat Helmet (Woodland)",500];
			_ret pushBack ["H_HelmetHBK_F","Advanced Modular Helmet (Green)",500];
			_ret pushBack ["H_PilotHelmetFighter_O" ,"Pilot Helmet (Green)",15000];
		};
	};
};

_ret;
