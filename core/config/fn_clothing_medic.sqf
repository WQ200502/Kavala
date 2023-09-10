#include "..\..\macro.h"
//  File: fn_clothing_medic.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Master config file for Medic clothing store.
private["_filter","_ret","_obtainPrice"];
_filter = param [0,0,[0]];
_obtainPrice = param [1,false,[false]];
//Classname, Custom Display name (use nil for Cfg->DisplayName, price
if !(_obtainPrice) then {
	//Shop Title Name
	ctrlSetText[3103,"Altis Rescue Shop"];
};
_ret = [];
switch (_filter) do {
	//Uniforms
	case 0: {
		_ret = [];
		if(__GETC__(life_medicLevel) >= 2) then {
			_ret pushBack ["U_I_Wetsuit","Rescue Wetsuit",500];
		};
		switch (__GETC__(life_medicLevel)) do {
			case 1: {
				_ret pushBack ["U_I_CombatUniform_shortsleeve","EMT Uniform",500];
			};
			case 2: {
				_ret pushBack ["U_I_CombatUniform_shortsleeve","Paramedic Uniform",500];
			};
			case 3: {
				_ret pushBack ["U_O_PilotCoveralls","Paramedic Coveralls",500];
			};
			case 4: {
				_ret pushBack ["U_O_PilotCoveralls","Medivac Uniform",500];
			};
			case 5: {
				_ret pushBack ["U_I_CombatUniform","Staff Medic Uniform",500];
			};
			case 6: {
				_ret pushBack ["U_O_PilotCoveralls","Supervisor Uniform",500];
			};
			case 7: {
				_ret pushBack ["U_O_PilotCoveralls","Coordinator Uniform",500];
			};
		};
		if((__GETC__(oev_donator) >= 100) && (__GETC__(life_medicLevel) >= 3)) then {
			_ret pushBack ["U_I_pilotCoveralls","Donator Uniform",500];
		};
		if((__GETC__(life_medicLevel) >= 4) && ((__GETC__(oev_designerlevel)) >= 2 || (__GETC__(oev_donator) >= 250))) then {
			_ret pushBack ["U_B_CBRN_Suit_01_MTP_F","Donator Fireman Uniform",500];
		};
	};

	//Hats
	case 1:	{
		_ret = [];
		if(__GETC__(life_medicLevel) >= 1) then {
			_ret pushBack ["H_Cap_blu","EMT Cap",500];
		};
		if(__GETC__(life_medicLevel) >= 2) then {
			_ret pushBack ["H_Cap_red","Paramedic Cap",500];
		};
		if(__GETC__(life_medicLevel) >= 3) then {
			_ret pushBack ["H_Cap_headphones","Rescue Cap",500];
			_ret pushBack ["H_PilotHelmetHeli_O","Sr. Pilot Helmet",500];
			_ret pushBack ["H_PilotHelmetFighter_I","Pilot Helmet [AAF]",15000];
		};
		if(__GETC__(life_medicLevel) >= 4) then {
			_ret pushBack ["H_Bandanna_surfer","Blue Wave Bandanna",500];
		};
		if(__GETC__(life_medicLevel) >= 5) then {
			_ret pushBack ["H_CrewHelmetHeli_O","Sr. Pilot Helmet (Face-Mask)",500];
			_ret pushBack ["H_PilotHelmetFighter_B","Black Pilot Helmet [NATO]",15000];
			_ret pushBack ["H_PilotHelmetHeli_B","Black Heli Pilot Helmet [NATO]",15000];
			_ret pushBack ["H_CrewHelmetHeli_B","Black Heli Crew Helmet [NATO]",15000];
		};
		if((__GETC__(oev_donator) >= 100) && (__GETC__(life_medicLevel) >= 3)) then {
			_ret pushBack ["H_PilotHelmetFighter_B","Black Pilot Helmet [NATO]",15000];
			_ret pushBack ["H_PilotHelmetHeli_B","Black Heli Pilot Helmet [NATO]",15000];
			_ret pushBack ["H_CrewHelmetHeli_B","Black Heli Crew Helmet [NATO]",15000];
		};
		if((__GETC__(life_medicLevel) >= 4) && ((__GETC__(oev_designerlevel)) >= 2 || (__GETC__(oev_donator) >= 250))) then {
			_ret pushBack ["H_Construction_headset_yellow_F","Donator Fire Helmet",500];
		};
	};

	//Glasses
	case 2: {
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
			["G_Spectacles_Tinted","Tinted Shades",500],
			["G_Respirator_blue_F",nil,300],
			["G_Respirator_white_F",nil,300],
			["G_Respirator_yellow_F",nil,300]
		];
		if(__GETC__(life_medicLevel) > 1) then {
			_ret pushBack ["G_B_Diving","Rescue Diving Goggles",500];
		};
		if(__GETC__(life_medicLevel) > 2) then {
			_ret pushBack ["G_Tactical_Clear","Clear Tactical Glasses",500];
			_ret pushBack ["G_Tactical_Black","Black Tactical Glasses",500];
		};
		if(__GETC__(life_medicLevel) >= 6) then {
			_ret pushBack ["G_Bandanna_aviator","Bandana (Aviator)",500];
			_ret pushBack ["G_Bandanna_beast","Bandana (Beast)",500];
			_ret pushBack ["G_Bandanna_blk","Bandana (Black)",500];
			_ret pushBack ["G_Bandanna_khk","Bandana (Khaki)",500];
			_ret pushBack ["G_Bandanna_oli","Bandana (Olive)",500];
			_ret pushBack ["G_Bandanna_shades","Bandana (Shades)",500];
			_ret pushBack ["G_Bandanna_sport","Bandana (Sport)",500];
			_ret pushBack ["G_Bandanna_tan","Bandana (Tan)",500];
		};
	 	if((__GETC__(life_medicLevel) >= 4) && ((__GETC__(oev_designerlevel)) >= 2 || (__GETC__(oev_donator) >= 250))) then {
			_ret pushBack ["G_RegulatorMask_F","Donator Fireman Regulator",500];
		};
	};

	//Vests
	case 3: {
		_ret = [];
		if(__GETC__(life_medicLevel) > 1) then {
			_ret pushBack ["V_RebreatherIA","Rescue Rebreather",500];
		};
		if(__GETC__(life_medicLevel) >= 4) then {
			_ret pushBack ["V_BandollierB_blk","Bandolier (Black)",500];
		};
		if((getPlayerUID player) isEqualTo "76561198144351505") then {
			_ret pushBack ["V_Rangemaster_belt","Rangemaster Belt",500];
		};
	};

	//Backpacks
	case 4: {
		_ret = [
			["B_Carryall_oucamo","Rescue Carryall",500]
		];
		if((__GETC__(life_medicLevel) >= 4) && ((__GETC__(oev_designerlevel)) >= 2 || (__GETC__(oev_donator) >= 250))) then {
			_ret pushBack ["B_SCBA_01_F","Donator Fireman Breating Apparatus",500];
		};
	};

	// Return all clothing
	case 7: {
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
			["G_Spectacles_Tinted","Tinted Shades",500],
			["G_Respirator_blue_F",nil,300],
			["G_Respirator_white_F",nil,300],
			["G_Respirator_yellow_F",nil,300],
			["B_Carryall_oucamo","Rescue Carryall",500]
		];
		switch (__GETC__(life_medicLevel)) do {
			case 1: {
				_ret pushBack ["U_I_CombatUniform_shortsleeve","EMT Uniform",500];
				_ret pushBack ["H_Cap_blu","EMT Cap",500];
			};
			case 2: {
				_ret pushBack ["U_I_CombatUniform_shortsleeve","Paramedic Uniform",500];
				_ret pushBack ["H_Cap_red","Paramedic Cap",500];
			};
			case 3: {
				_ret pushBack ["U_O_PilotCoveralls","Paramedic Coveralls",500];
			};
			case 4: {
				_ret pushBack ["U_O_PilotCoveralls","Medivac Uniform",500];
			};
			case 5: {
				_ret pushBack ["U_O_PilotCoveralls","Staff Medic Uniform",500];
			};
			case 6: {
				_ret pushBack ["U_O_PilotCoveralls","Supervisor Uniform",500];
			};
			case 7: {
				_ret pushBack ["U_O_PilotCoveralls","Coordinator Uniform",500];
			};
		};
		if(__GETC__(life_medicLevel) > 1) then {
			_ret pushBack ["U_I_Wetsuit","Rescue Wetsuit",500];
			_ret pushBack ["G_B_Diving","Rescue Diving Goggles",500];
			_ret pushBack ["V_RebreatherIA","Rescue Rebreather",500];
		};
		if(__GETC__(life_medicLevel) > 2) then {
			_ret pushBack ["H_PilotHelmetFighter_I","Pilot Helmet [AAF]",15000];
			_ret pushBack ["H_Cap_headphones","Rescue Cap",500];
			_ret pushBack ["H_PilotHelmetHeli_O","Sr. Pilot Helmet",500];
			_ret pushBack ["G_Tactical_Clear","Clear Tactical Glasses",500];
			_ret pushBack ["G_Tactical_Black","Black Tactical Glasses",500];
			if((__GETC__(oev_donator) >= 100)) then {
				_ret pushBack ["U_I_pilotCoveralls","Donator Uniform",500];
				_ret pushBack ["H_PilotHelmetFighter_B","Black Pilot Helmet [NATO]",15000];
				_ret pushBack ["H_PilotHelmetHeli_B","Black Heli Pilot Helmet [NATO]",15000];
				_ret pushBack ["H_CrewHelmetHeli_B","Black Heli Crew Helmet [NATO]",15000];
			};
		};
		if(__GETC__(life_medicLevel) > 3) then {
			_ret pushBack ["H_Bandanna_surfer","Blue Wave Bandanna",500];
		};
		if(__GETC__(life_medicLevel) > 4) then {
			_ret pushBack ["H_CrewHelmetHeli_O","Sr. Pilot Helmet (Face-Mask)",500];
			_ret pushBack ["H_PilotHelmetFighter_B","Black Pilot Helmet [NATO]",15000];
			_ret pushBack ["H_PilotHelmetHeli_B","Black Heli Pilot Helmet [NATO]",15000];
			_ret pushBack ["H_CrewHelmetHeli_B","Black Heli Crew Helmet [NATO]",15000];
		};
		if((getPlayerUID player) isEqualTo "76561198144351505") then {
			_ret pushBack ["V_Rangemaster_belt","Rangemaster Belt",500];
		};

		// fireman items
		if(__GETC__(life_medicLevel) >= 4) then {
			_ret pushBack ["V_BandollierB_blk","Bandolier (Black)",500];
		};
		if((__GETC__(life_medicLevel) >= 4) && ((__GETC__(oev_designerlevel)) >= 2 || (__GETC__(oev_donator) >= 250))) then {
			_ret pushBack ["U_B_CBRN_Suit_01_MTP_F","Donator Fireman Uniform",500];
			_ret pushBack ["H_Construction_headset_yellow_F","Donator Fire Helmet",500];
			_ret pushBack ["G_RegulatorMask_F","Donator Fireman Regulator",500];
			_ret pushBack ["B_SCBA_01_F","Donator Fireman Breating Apparatus",500];
		};
	};
};
_ret;
