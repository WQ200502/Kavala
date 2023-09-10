#include "..\..\macro.h"
//	Description: Master config for all vehicle information, this will create a simpler system for fetching vehicle skins, prices, availability, etc.
// fn_clothingSkins.sqf

private["_side","_skinsArray","_return","_copLevel","_medicLevel","_donatorLevel","_adminLevel","_staffLvl","_available","_highest"];
params [
	["_clothingName","",[""]],
	["_mode","",[""]],
	["_target",objNull,[objNull]]
];
_missionDir = "images\";
_return = [];

if(isNull _target) exitWith {_return};
private _civCouncilMembers = [];
if (__GETC__(oev_civcouncil) > 0) then {
	_civCouncilMembers = [getPlayerUID player];
};

private _supportUID = [];
if (__GETC__(life_supportlevel) > 0) then {
	_supportUID = [getPlayerUID player];
};

//format [clothing classname-0, [playersides]-1, copLevel-2, medicLevel-3, adminLevel-4, donatorLevel-5, [allowedPlayerIDs]-6, colorName-7, texture1-8, (texture2)-9, (texture3)10]
_skinsArray = [
	//random stuff
	["U_C_WorkerCoveralls", [civilian, west, independent], 0, 0, 0, 0, [], "Prisoner Uniform", _missionDir + "civ_clothes_prisoner.jpg"],
	["U_C_Poloshirt_burgundy", [civilian], 0, 0, 0, 0, [], "Louis Vuitton", _missionDir + "civ_clothes_14.jpg"],
	["U_C_Poloshirt_blue", [civilian], 0, 0, 0, 100, [], "Abibas Shirt", _missionDir + "civ_clothes_abibas.jpg"],
	["U_B_CombatUniform_mcam_worn", [civilian], 0, 0, 0, 0, [], "Rebel Outfit", _missionDir + "rebel.jpg"],
	["U_BG_Guerilla2_2", [civilian], 0, 0, 0, 0, [], "Lumberjack", _missionDir + "lumberjack.jpg"],
	["U_C_Poloshirt_salmon", [civilian], 0, 0, 0, 0, [], "Versace Uniform", _missionDir + "civ_clothes_suit.jpg"],
	["U_B_GEN_Commander_F", [civilian], 0, 0, 0, 0, [], "Vigi Uniform", _missionDir + "vigilante.jpg"],
	["U_IG_Guerilla3_1", [civilian], 0, 0, 0, 15, [], "Supporter Outfit", _missionDir + "donor_uni_supporter.jpg"],
	["B_Kitbag_sgg", [civilian], 0, 0, 0, 30, [], "Donor Backpack", _missionDir + "donor_pack_green.jpg"],
	["B_Kitbag_mcamo", [civilian], 0, 0, 0, 30, [], "Donor Backpack", _missionDir + "donor_pack_red.jpg"],
	["B_Carryall_ocamo", [civilian], 0, 0, 0, 1000, ["76561198134713503"], "Donor Backpack", _missionDir + "donor_pack_carryall.jpg"],
	["B_Messenger_Black_F", [civilian], 0, 0, 0, 100, [], "Abibas Bag", _missionDir + "civ_backpack_abibas.jpg"],
	["U_B_Wetsuit", [civilian], 0, 0, 0, 0, [], "Red Wetsuit", _missionDir + "civ_wetsuit_1.jpg"],
	["U_O_CombatUniform_ocamo", [civilian,west], 0, 0, 0, 0, [], "Fatigues (Black)", _missionDir + "civ_csats1.jpg", _missionDir + "civ_csats2.jpg"],
	["U_B_CombatUniform_mcam_vest", [civilian], 0, 0, 0, 100, [], "Vanguard Combat Uniform", _missionDir + "civ_clothes_donor_2.jpg"],
	["B_Kitbag_cbr", [civilian], 0, 0, 0, 0, [], "Black Kitbag", "A3\weapons_f\ammoboxes\bags\data\backpack_fast_blk_co.paa"],
	["B_Kitbag_rgr", [civilian,west], 0, 0, 0, 0, [], "Invis. Kitbag", ""],
	["B_Bergen_dgtl_F", [civilian,west], 0, 0, 0, 0, [], "Invis. Bergen", ""],
	["B_Carryall_mcamo", [civilian], 0, 0, 0, 0, [], "Black Carryall", "A3\weapons_f\ammoboxes\bags\data\backpack_tortila_blk_co.paa"],
	["U_I_CombatUniform_tshirt", [civilian], 0, 0, 1, 0, [], "Staff Uniform", _missionDir + "staff_uniform.jpg"],
	["U_C_E_LooterJacket_01_F", [civilian], 0, 0, 0, 0, [], "Ripper Jacket", _missionDir + "civ_clothes_15.jpg"],
	["B_Kitbag_tan", [civilian], 0, 0, 0, 30, [], "Smile", _missionDir + "civ_backpack_donor_3.jpg"],
	["U_B_CBRN_Suit_01_MTP_F", [civilian], 0, 0, 0, 50, [], "Bank Hiest Hazmat", _missionDir + "civ_red_cbrn.jpg"],
	["U_B_CBRN_Suit_01_MTP_F", [independent], 0, 0, 0, 50, [], "Donor Fireman Uniform", _missionDir + "rr_cbrn.jpg"],
	["U_O_T_Soldier_F", [civilian], 0, 0, 0, 0, [], "Fatigues (Pink)", _missionDir + "pinkcsat_0.jpg", _missionDir + "pinkcsat_1.jpg"],

	["U_I_FullGhillie_lsh", [civilian], 0, 0, 0, 0, [], "Black Ghillie", _missionDir + "blk_ghillie0.jpg", _missionDir + "blk_ghillie1.paa"],
	["U_I_FullGhillie_sard", [civilian], 0, 0, 0, 0, [], "Urban Ghillie", _missionDir + "urb_ghillie0.jpg", _missionDir + "urb_ghillie1.paa"],
	["U_I_FullGhillie_ard", [civilian], 0, 0, 0, 0, [], "Arid Ghillie", _missionDir + "chc_ghillie0.jpg", _missionDir + "chc_ghillie1.paa"],

	["U_I_pilotCoveralls", [civilian], 0, 0, 0, 0, [], "Urban Coveralls", _missionDir + "civ_pcov_urban.jpg"],

	//cop uniforms
	["U_Rangemaster", [west], 1, 0, 0, 0, [], "Deputy Uniform", _missionDir + "apd_uniform_1.jpg"],
	["U_C_Man_casual_3_F", [west], 0, 0, 0, 0, [], "Deputy Uniform", _missionDir + "apd_uniform_1.jpg"],
	["U_Rangemaster", [west, civilian], 2, 0, 0, 0, [], "P.O. Uniform", _missionDir + "apd_uniform_2.jpg"],
	["U_B_GEN_Commander_F",[west], 2, 0, 0, 0, ["76561198134713503"], "Donator Longsleeve Uniform", _missionDir + "apd_uniform_donor.jpg"],
	["U_C_Man_casual_1_F", [west, civilian], 3, 0, 0, 0, [], "Corporal Uniform", _missionDir + "apd_uniform_3.jpg"],
	["U_I_CombatUniform", [west], 3, 0, 0, 0, [], "Corporal Longsleeve Uniform", _missionDir + "apd_uniform_long.jpg"],
	["U_Marshal",[west, civilian], 3, 0, 0, 0, [], "AHP Uniform", _missionDir + "AHP_Trooper.jpg"],
	["U_B_CombatUniform_mcam", [west, civilian], 6, 0, 0, 0, [], "SAPD Upgraded Uniform", _missionDir + "SAPD_Uniform.jpg"],
	["U_I_CombatUniform", [west], 6, 0, 0, 0, [], "SGT Uniform", _missionDir + "SAPD_1.jpg"],
	["U_I_CombatUniform", [west, civilian], 7, 0, 0, 0, [], "LT Uniform", _missionDir + "SAPD_2.jpg"],
	["U_I_CombatUniform", [civilian,west,independent], 0, 0, 0, 0, ["76561198120173072"], "Chief Uniform", _missionDir + "SAPD_3.jpg"],
	["U_I_CombatUniform", [west], 8, 0, 0, 0, [], "Chief Uniform", _missionDir + "SAPD_3.jpg"],
	["B_Carryall_oucamo", [west,civilian], 0, 0, 0, 0, [], "B_Bergen_dgtl_F", ""],
	["U_I_pilotCoveralls", [west], 7, 0, 0, 0, [], "sAPD Coveralls", _missionDir + "SAPD_Uniform_Coveralls.jpg"],
	["U_I_E_ParadeUniform_01_LDF_decorated_F", [civilian], 0, 0, 0, 0, ["76561198371434650","76561198973252078"], "服主定制", _missionDir + "fzzlm.jpg"],
	//Cop Donor
	["U_C_Man_casual_2_F", [west, civilian], 2, 0, 0, 250, [], "State Police (Donor)", _missionDir + "APD_Uniform_Donor2.jpg"],
	["U_B_GEN_Soldier_F", [west], 3, 0, 0, 250, [], "State Trooper (Donor)", _missionDir + "APD_Uniform_Donor3_0.jpg", _missionDir + "APD_Uniform_Donor3_1.jpg"],
	["U_I_CombatUniform_shortsleeve" , [west], 4, 0, 0, 250, [],"Sr. State Police (Donor)", _missionDir + "SAPD_Uniform_Donor.jpg"],

	//medic uniforms
	["U_I_CombatUniform_shortsleeve", [independent], 0, 1, 0, 0, [], "Medic Uniform", _missionDir + "RR_EMT.jpg"],
	["U_I_CombatUniform_shortsleeve", [independent], 0, 2, 0, 0, [], "Medic Uniform", _missionDir + "RR_Paramedic.jpg"],
	["U_I_Wetsuit", [independent], 0, 2, 0, 0, [], "Medic Uniform", _missionDir + "rr_dive.jpg"],
	//["U_I_pilotCoveralls", [independent], 0, 3, 0, 0, [], "Medic Uniform", _missionDir + "RR_Coveralls_ADVPARA.jpg"],
	//["U_B_PilotCoveralls", [independent], 0, 3, 0, 0, [], "Medic Uniform", _missionDir + "RR_Coveralls_DONATOR.jpg"],
	//["U_I_pilotCoveralls", [independent], 0, 4, 0, 0, [], "Medic Uniform", _missionDir + "RR_Coveralls_SAR.jpg"],
	//["U_I_pilotCoveralls", [independent], 0, 5, 0, 0, [], "Medic Uniform", _missionDir + "RR_Coveralls_STAFF.jpg"],
	//["U_I_pilotCoveralls", [independent], 0, 6, 0, 0, [], "Medic Uniform", _missionDir + "RR_Coveralls_Supervisor.jpg"],
	//["U_I_pilotCoveralls", [independent], 0, 7, 0, 0, [], "Medic Uniform", _missionDir + "RR_Coveralls_COORD.jpg"],
	["U_O_PilotCoveralls", [independent], 0, 3, 0, 0, [], "Medic Uniform", _missionDir + "RR_Coveralls_ADVPARA.jpg"],
	["U_I_pilotCoveralls", [independent], 0, 3, 0, 0, [], "Medic Uniform", _missionDir + "RR_Coveralls_DONATOR.jpg"],
	["U_O_PilotCoveralls", [independent], 0, 4, 0, 0, [], "Medic Uniform", _missionDir + "RR_Coveralls_SAR.jpg"],
	["U_I_CombatUniform", [independent], 0, 5, 0, 0, [], "Medic Uniform", _missionDir + "RR_Coveralls_STAFF.jpg"],
	["U_O_PilotCoveralls", [independent], 0, 6, 0, 0, [], "Medic Uniform", _missionDir + "RR_Coveralls_Supervisor.jpg"],
	["U_O_PilotCoveralls", [independent], 0, 7, 0, 0, [], "Medic Uniform", _missionDir + "RR_Coveralls_COORD.jpg"],
	["B_Carryall_oucamo", [independent], 0, 0, 0, 0, [], "Medic Backpack", ""],

	//Gang wars
	["U_I_Wetsuit", [civilian], 0, 0, 0, 0, ["76561198050208572","76561198087694955","76561198192271806","76561198101157939","76561198261830571","76561198159764963","76561198152272555","76561198169326834","76561198131372705","76561198142378266","76561198341073463","76561198106617512"], "Gang Wars Uniform", _missionDir + "civ_gangwars.jpg"]
];

// mudiwa
if((getPlayerUID _target) in ["76561198123439780", "76561198216100232"]) then {
	_skinsArray pushBack ["U_I_CombatUniform_shortsleeve", [civilian], 0, 0, 0, 0, ["76561198123439780", "76561198216100232"],"Mudiwa Gang Uniform", _missionDir + "gang_uniform_31170.jpg"];
};

// gang uniform
if (((_target getVariable ["gang_data",[0,"",0]]) select 0) in oev_gangUniforms) then {
	_skinsArray pushBack ["U_I_CombatUniform_shortsleeve", [civilian], 0, 0, 0, 0, [getPlayerUID _target], format["%1 Gang Uniform",_target getVariable ["gangName",0]], _missionDir + format["gang_uniform_%1.jpg",((_target getVariable ["gang_data",[0,"",0]]) select 0)]];
};

if ((_target getVariable ["civcouncil",0]) > 0) then {
	_skinsArray pushBack ["U_I_CombatUniform_tshirt", [civilian], 0, 0, 0, 0, [getPlayerUID _target], "Civilian Council", _missionDir + "civ_council_uniform.jpg"];
};

if ((_target getVariable ["supportteam",0]) > 0) then {
	_skinsArray pushBack ["U_I_CombatUniform_tshirt", [civilian], 0, 0, 0, 0, [getPlayerUID _target], "Support Team", _missionDir + "civ_uniform_support.jpg"];
};

//Monthly conquest wetsuit for gay fellas
if(!isNil "oev_gang_data" && !isNil "life_conquestMonthly") then {
	if(count oev_gang_data > 0) then {
		if((oev_gang_data select 0) == life_conquestMonthly) then {
			_skinsArray pushBack ["U_I_Wetsuit", [civilian], 0, 0, 0, 0, [getPlayerUID player], "Conquest Monthly Wetsuit", _missionDir + "conqmonthly.jpg"]
		};
	};
};

_skinsArray pushBack ["U_I_CombatUniform_shortsleeve", [civilian], 0, 0, 0, 500, [], "Legendary Outfit", _missionDir + "donor_uni_legendary.jpg"];
_skinsArray pushBack ["U_I_CombatUniform_shortsleeve", [civilian], 0, 0, 0, 100, [], "Elite Outfit", _missionDir + "donor_uni_elite.jpg"];

switch(_mode) do {
	case "allSkins": {
		// this is useless don't bother adjusting.... as of 9-6-18 - JESSE
		{
			if(_clothingName == (_x select 0)) then {
				_return pushBack _x;
			};
		}foreach _skinsArray;
	};

	case "availableSkins": {
		// code this at some point to return all available skins, and let a player choose one maybe
		// this is useless don't bother adjusting.... as of 9-6-18 - JESSE
		_target = player;
		_copLevel = __GETC__(life_coplevel);
		_medicLevel = __GETC__(life_medicLevel);
		_side = playerSide;

		{
			if(_clothingName == (_x select 0)) then {
				if(_side in (_x select 1)) then {
					switch(_side) do {
						case civilian: {
							if(count (_x select 6) == 0 || getplayeruid _target in (_x select 6)) then {
								_return pushBack _x;
							};
						};
						case west: {
							if(_copLevel >= (_x select 2)) then {
								_return pushBack _x;
							};
						};
						case independent: {
							if(_medicLevel >= (_x select 3)) then {
								_return pushBack _x;
							};
						};
						default {};
					};
				};
			};
		}foreach _skinsArray;
	};

	default {
		if(player == _target) then {
			_copLevel = __GETC__(life_coplevel);
			_medicLevel = __GETC__(life_medicLevel);
			_donatorLevel = __GETC__(oev_donator);
			_staffLvl = (__GETC__(life_adminlevel) max __GETC__(oev_developerlevel)) max __GETC__(oev_designerlevel);
			_side = playerSide;
		} else {
			_copLevel = _target getVariable ["rank",0];
			_medicLevel = _target getVariable ["rank",0];
			_donatorLevel = _target getVariable ["donlevel",0];
			_side = side _target;
			_staffLvl = ((_target getVariable ["devlvl",0]) max (_target getVariable ["adminlvl",0])) max (_target getVariable ["deslvl",0]);
		};

		_highestRank = 0;
		_available = [];

		{
			if(_clothingName == (_x select 0)) then {
				if(_side in (_x select 1)) then {
					switch(_side) do {
						case civilian: {
							if(((count (_x select 6) isEqualTo 0) && ((_x select 5) isEqualTo 0) && (_x select 4) isEqualTo 0) || ((_x select 4) > 0 && (_staffLvl >= (_x select 4))) || ((_x select 5 > 0) && (_donatorLevel >= _x select 5)) || (getplayeruid _target in (_x select 6))) then {
								_available pushBack _x;
							};
						};
						case west: {
							if(_copLevel >= (_x select 2)) then {
								if((_x select 2) >= _highestRank) then {
									_highestRank = (_x select 2);
								};
								_available pushBack _x;
							};
						};
						case independent: {
							if(_medicLevel >= (_x select 3)) then {
								if((_x select 3) >= _highestRank) then {
									_highestRank = (_x select 3);
								};
								_available pushBack _x;
							};
						};
						default {};
					};
				};
			};
		} forEach _skinsArray;

		{
			switch(_side) do {
				case west: {
					if((_x select 2) == _highestRank) then {
						_return pushBack _x;
					};
				};
				case independent: {
					if((_x select 3) == _highestRank) then {
						_return pushBack _x;
					};
				};
				default {_return pushBack _x;};
			};

			if(count _return != 0) exitWith {};
		} forEach _available;
	};
};

_return;
