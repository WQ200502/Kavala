//	Original Author: Kurt
//	File: fn_titleCheck.sqf
#include "..\..\macro.h"
params [
	["_title","",[""]]
];

private _nitroBoosters = [
	"76561198047889399",	// Rex
	"76561198060138036",	// Imthatguyhere
	"76561198274942270", 	// DashTonic
	"76561198050771282",	// Resonance
	"76561198176278707",	// Mike Lit
	"76561198364651473",	// Jonesy
	"76561198057133355"		// Mita
];

private _gangWarsWinners = [
	"76561198050208572",
	"76561198087694955",
	"76561198192271806",
	"76561198101157939",
	"76561198261830571",
	"76561198159764963",
	"76561198152272555",
	"76561198169326834",
	"76561198131372705",
	"76561198142378266",
	"76561198341073463",
	"76561198106617512"
];

private _titleArray = [false,0];
switch (_title) do {
	/////////////
	//   CIV   //
	/////////////

	case (G_CFGT("CfgTitleCiv","Novice")): {
		if ((O_stats_kills) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Novice" >> "value"))) then {
			_titleArray = [true, O_stats_kills];
		} else {
			_titleArray = [false, O_stats_kills];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Thug" >> "title")): {
		if ((O_stats_kills) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Thug" >> "value"))) then {
			_titleArray = [true, O_stats_kills];
		} else {
			_titleArray = [false, O_stats_kills];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Capo" >> "title")): {
		if ((O_stats_kills) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Capo" >> "value"))) then {
			_titleArray = [true, O_stats_kills];
		} else {
			_titleArray = [false, O_stats_kills];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Psychopath" >> "title")): {
		if ((O_stats_kills) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Psychopath" >> "value"))) then {
			_titleArray = [true, O_stats_kills];
		} else {
			_titleArray = [false, O_stats_kills];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Stormtrooper" >> "title")): {
		if ((O_stats_kills) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Stormtrooper" >> "value"))) then {
			_titleArray = [true, O_stats_kills];
		} else {
			_titleArray = [false, O_stats_kills];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Hitman" >> "title")): {
		if ((O_stats_kills) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Hitman" >> "value"))) then {
			_titleArray = [true, O_stats_kills];
		} else {
			_titleArray = [false, O_stats_kills];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Hitman" >> "title")): {
		if ((O_stats_kills) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Hitman" >> "value"))) then {
			_titleArray = [true, O_stats_kills];
		} else {
			_titleArray = [false, O_stats_kills];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Don" >> "title")): {
		if ((O_stats_kills) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Don" >> "value"))) then {
			_titleArray = [true, O_stats_kills];
		} else {
			_titleArray = [false, O_stats_kills];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Terminator" >> "title")): {
		if ((O_stats_kills) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Terminator" >> "value"))) then {
			_titleArray = [true, O_stats_kills];
		} else {
			_titleArray = [false, O_stats_kills];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Killtacular" >> "title")): {
		if ((O_stats_kills) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Killtacular" >> "value"))) then {
			_titleArray = [true, O_stats_kills];
		} else {
			_titleArray = [false, O_stats_kills];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Boss" >> "title")): {
		if ((O_stats_kills) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Boss" >> "value"))) then {
			_titleArray = [true, O_stats_kills];
		} else {
			_titleArray = [false, O_stats_kills];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Bot" >> "title")): {
		if ((oev_statsTable select 18) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Bot" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 18];
		} else {
			_titleArray = [false, oev_statsTable select 18];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Fighter" >> "title")): {
		if ((oev_statsTable select 18) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Fighter" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 18];
		} else {
			_titleArray = [false, oev_statsTable select 18];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Fighter" >> "title")): {
		if ((oev_statsTable select 18) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Fighter" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 18];
		} else {
			_titleArray = [false, oev_statsTable select 18];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Terrorist" >> "title")): {
		if ((oev_statsTable select 18) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Terrorist" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 18];
		} else {
			_titleArray = [false, oev_statsTable select 18];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Warmonger" >> "title")): {
		if ((oev_statsTable select 18) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Warmonger" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 18];
		} else {
			_titleArray = [false, oev_statsTable select 18];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Warlord" >> "title")): {
		if ((oev_statsTable select 18) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Warlord" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 18];
		} else {
			_titleArray = [false, oev_statsTable select 18];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "War_Chief" >> "title")): {
		if ((oev_statsTable select 18) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "War_Chief" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 18];
		} else {
			_titleArray = [false, oev_statsTable select 18];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Genocidal" >> "title")): {
		if ((oev_statsTable select 18) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Genocidal" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 18];
		} else {
			_titleArray = [false, oev_statsTable select 18];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Titan" >> "title")): {
		if ((oev_statsTable select 18) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Titan" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 18];
		} else {
			_titleArray = [false, oev_statsTable select 18];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Cop_Killer" >> "title")): {
		if ((oev_statsTable select 1) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Cop_Killer" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 1];
		} else {
			_titleArray = [false, oev_statsTable select 1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Danger_to_Society" >> "title")): {
		if ((oev_statsTable select 1) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Danger_to_Society" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 1];
		} else {
			_titleArray = [false, oev_statsTable select 1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Bandit" >> "title")): {
		if ((oev_statsTable select 1) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Bandit" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 1];
		} else {
			_titleArray = [false, oev_statsTable select 1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Outlaw" >> "title")): {
		if ((oev_statsTable select 1) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Outlaw" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 1];
		} else {
			_titleArray = [false, oev_statsTable select 1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Most_Wanted" >> "title")): {
		if ((oev_statsTable select 1) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Most_Wanted" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 1];
		} else {
			_titleArray = [false, oev_statsTable select 1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Blacklisted" >> "title")): {
		if ((oev_statsTable select 1) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Blacklisted" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 1];
		} else {
			_titleArray = [false, oev_statsTable select 1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Ghille_Warrior" >> "title")): {
		if ((oev_statsTable select 36) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Ghille_Warrior" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 36];
		} else {
			_titleArray = [false, oev_statsTable select 36];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Sharpsh00ter" >> "title")): {
		if ((oev_statsTable select 36) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Sharpsh00ter" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 36];
		} else {
			_titleArray = [false, oev_statsTable select 36];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Chris_Kyle" >> "title")): {
		if ((oev_statsTable select 36) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Chris_Kyle" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 36];
		} else {
			_titleArray = [false, oev_statsTable select 36];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Good_Samaritan" >> "title")): {
		if ((oev_statsTable select 2) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Good_Samaritan" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 2];
		} else {
			_titleArray = [false, oev_statsTable select 2];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Medicine_Man" >> "title")): {
		if ((oev_statsTable select 2) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Medicine_Man" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 2];
		} else {
			_titleArray = [false, oev_statsTable select 2];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "CPR_Certified" >> "title")): {
		if ((oev_statsTable select 2) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "CPR_Certified" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 2];
		} else {
			_titleArray = [false, oev_statsTable select 2];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Hijacker" >> "title")): {
		if ((oev_statsTable select 3) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Hijacker" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 3];
		} else {
			_titleArray = [false, oev_statsTable select 3];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Joyrider" >> "title")): {
		if ((oev_statsTable select 3) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Joyrider" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 3];
		} else {
			_titleArray = [false, oev_statsTable select 3];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Kleptomaniac" >> "title")): {
		if ((oev_statsTable select 3) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Kleptomaniac" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 3];
		} else {
			_titleArray = [false, oev_statsTable select 3];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Pickpocket" >> "title")): {
		if ((oev_statsTable select 4) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Pickpocket" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 4];
		} else {
			_titleArray = [false, oev_statsTable select 4];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Mugger" >> "title")): {
		if ((oev_statsTable select 4) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Mugger" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 4];
		} else {
			_titleArray = [false, oev_statsTable select 4];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Crook" >> "title")): {
		if ((oev_statsTable select 4) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Crook" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 4];
		} else {
			_titleArray = [false, oev_statsTable select 4];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Master_Thief" >> "title")): {
		if ((oev_statsTable select 4) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Master_Thief" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 4];
		} else {
			_titleArray = [false, oev_statsTable select 4];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Misdemeanor" >> "title")): {
		if ((oev_statsTable select 5) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Misdemeanor" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 5];
		} else {
			_titleArray = [false, oev_statsTable select 5];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Felon" >> "title")): {
		if ((oev_statsTable select 5) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Felon" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 5];
		} else {
			_titleArray = [false, oev_statsTable select 5];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Death_Row" >> "title")): {
		if ((oev_statsTable select 5) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Death_Row" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 5];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Martyr" >> "title")): {
		if ((oev_statsTable select 6) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Martyr" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 6];
		} else {
			_titleArray = [false, oev_statsTable select 6];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Jihadist" >> "title")): {
		if ((oev_statsTable select 6) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Jihadist" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 6];
		} else {
			_titleArray = [false, oev_statsTable select 6];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Dog_Fighter" >> "title")): {
		if ((oev_statsTable select 7) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Dog_Fighter" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 7];
		} else {
			_titleArray = [false, oev_statsTable select 7];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Ace" >> "title")): {
		if ((oev_statsTable select 7) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Ace" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 7];
		} else {
			_titleArray = [false, oev_statsTable select 7];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Red_Baron" >> "title")): {
		if ((oev_statsTable select 7) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Red_Baron" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 7];
		} else {
			_titleArray = [false, oev_statsTable select 7];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Cartel_Roach" >> "title")): {
		if ((oev_statsTable select 7) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Cartel_Roach" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 7];
		} else {
			_titleArray = [false, oev_statsTable select 7];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Ass_Clapper" >> "title")): {
		if ((oev_statsTable select 7) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Ass_Clapper" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 7];
		} else {
			_titleArray = [false, oev_statsTable select 7];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Dealer" >> "title")): {
		if ((oev_statsTable select 8) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Dealer" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 8];
		} else {
			_titleArray = [false, oev_statsTable select 8];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Distributor" >> "title")): {
		if ((oev_statsTable select 8) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Distributor" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 8];
		} else {
			_titleArray = [false, oev_statsTable select 8];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Narco" >> "title")): {
		if ((oev_statsTable select 8) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Narco" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 8];
		} else {
			_titleArray = [false, oev_statsTable select 8];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Firestarter" >> "title")): {
		if ((oev_statsTable select 9) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Firestarter" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 9];
		} else {
			_titleArray = [false, oev_statsTable select 9];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Demo_Man" >> "title")): {
		if ((oev_statsTable select 9) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Demo_Man" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 9];
		} else {
			_titleArray = [false, oev_statsTable select 9];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Bomber_Man" >> "title")): {
		if ((oev_statsTable select 9) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Bomber_Man" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 9];
		} else {
			_titleArray = [false, oev_statsTable select 9];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Script_Kiddie" >> "title")): {
		if ((oev_statsTable select 10) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Script_Kiddie" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 10];
		} else {
			_titleArray = [false, oev_statsTable select 10];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Hacker" >> "title")): {
		if ((oev_statsTable select 10) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Hacker" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 10];
		} else {
			_titleArray = [false, oev_statsTable select 10];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Cyber_Terrorist" >> "title")): {
		if ((oev_statsTable select 10) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Cyber_Terrorist" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 10];
		} else {
			_titleArray = [false, oev_statsTable select 10];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "A_whole_new_world" >> "title")): {
		if (O_stats_playtime_civ >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "A_whole_new_world" >> "value"))) then {
			_titleArray = [true, O_stats_playtime_civ];
		} else {
			_titleArray = [false, O_stats_playtime_civ];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Invested" >> "title")): {
		if (O_stats_playtime_civ >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Invested" >> "value"))) then {
			_titleArray = [true, O_stats_playtime_civ];
		} else {
			_titleArray = [false, O_stats_playtime_civ];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Dedicated" >> "title")): {
		if (O_stats_playtime_civ >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Dedicated" >> "value"))) then {
			_titleArray = [true, O_stats_playtime_civ];
		} else {
			_titleArray = [false, O_stats_playtime_civ];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Committed" >> "title")): {
		if (O_stats_playtime_civ >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Committed" >> "value"))) then {
			_titleArray = [true, O_stats_playtime_civ];
		} else {
			_titleArray = [false, O_stats_playtime_civ];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Addicted" >> "title")): {
		if (O_stats_playtime_civ >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Addicted" >> "value"))) then {
			_titleArray = [true, O_stats_playtime_civ];
		} else {
			_titleArray = [false, O_stats_playtime_civ];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Explorer" >> "title")): {
		if (round((O_stats_distanceFoot)/1000) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Explorer" >> "value"))) then {
			_titleArray = [true, round((O_stats_distanceFoot)/1000)];
		} else {
			_titleArray = [false, round((O_stats_distanceFoot)/1000)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Hiker" >> "title")): {
		if (round((O_stats_distanceFoot)/1000) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Hiker" >> "value"))) then {
			_titleArray = [true, round((O_stats_distanceFoot)/1000)];
		} else {
			_titleArray = [false, round((O_stats_distanceFoot)/1000)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Journeyor" >> "title")): {
		if (round((O_stats_distanceFoot)/1000) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Journeyor" >> "value"))) then {
			_titleArray = [true, round((O_stats_distanceFoot)/1000)];
		} else {
			_titleArray = [false, round((O_stats_distanceFoot)/1000)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "World_Travellor" >> "title")): {
		if (round((O_stats_distanceFoot)/1000) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "World_Travellor" >> "value"))) then {
			_titleArray = [true, round((O_stats_distanceFoot)/1000)];
		} else {
			_titleArray = [false, round((O_stats_distanceFoot)/1000)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Blooded" >> "title")): {
		if (O_stats_deaths >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Blooded" >> "value"))) then {
			_titleArray = [true, O_stats_deaths];
		} else {
			_titleArray = [false, O_stats_deaths];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Death_Finds_Me_Often" >> "title")): {
		if (O_stats_deaths >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Death_Finds_Me_Often" >> "value"))) then {
			_titleArray = [true, O_stats_deaths];
		} else {
			_titleArray = [false, O_stats_deaths];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Crippling_Depression" >> "title")): {
		if (O_stats_deaths >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Crippling_Depression" >> "value"))) then {
			_titleArray = [true, O_stats_deaths];
		} else {
			_titleArray = [false, O_stats_deaths];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Masochist" >> "title")): {
		if (O_stats_deaths >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Masochist" >> "value"))) then {
			_titleArray = [true, O_stats_deaths];
		} else {
			_titleArray = [false, O_stats_deaths];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Aims_With_Steering_Wheel" >> "title")): {
		if (O_stats_deaths >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Aims_With_Steering_Wheel" >> "value"))) then {
			_titleArray = [true, O_stats_deaths];
		} else {
			_titleArray = [false, O_stats_deaths];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Suicide_Artist" >> "title")): {
		if (O_stats_deaths >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Suicide_Artist" >> "value"))) then {
			_titleArray = [true, O_stats_deaths];
		} else {
			_titleArray = [false, O_stats_deaths];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Concerned_Citizen" >> "title")): {
		if ((oev_statsTable select 19) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Concerned_Citizen" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 19)];
		} else {
			_titleArray = [false, (oev_statsTable select 19)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Citizen_Police" >> "title")): {
		if ((oev_statsTable select 19) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Citizen_Police" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 19)];
		} else {
			_titleArray = [false, (oev_statsTable select 19)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Bail_Bondsman" >> "title")): {
		if ((oev_statsTable select 19) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Bail_Bondsman" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 19)];
		} else {
			_titleArray = [false, (oev_statsTable select 19)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Fugitive_Recovery_Agent" >> "title")): {
		if ((oev_statsTable select 19) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Fugitive_Recovery_Agent" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 19)];
		} else {
			_titleArray = [false, (oev_statsTable select 19)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Federal_Marshall" >> "title")): {
		if ((oev_statsTable select 19) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Federal_Marshall" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 19)];
		} else {
			_titleArray = [false, (oev_statsTable select 19)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Rebel_Camper" >> "title")): {
		if ((oev_statsTable select 19) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Rebel_Camper" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 19)];
		} else {
			_titleArray = [false, (oev_statsTable select 19)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Vigi_Scum" >> "title")): {
		if ((oev_statsTable select 19) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Vigi_Scum" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 19)];
		} else {
			_titleArray = [false, (oev_statsTable select 19)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Secret_Service" >> "title")): {
		if ((oev_statsTable select 19) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Secret_Service" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 19)];
		} else {
			_titleArray = [false, (oev_statsTable select 19)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Black_Red_Sweaty" >> "title")): {
		if ((oev_statsTable select 19) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Black_Red_Sweaty" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 19)];
		} else {
			_titleArray = [false, (oev_statsTable select 19)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Boba_Fett" >> "title")): {
		if ((oev_statsTable select 19) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Boba_Fett" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 19)];
		} else {
			_titleArray = [false, (oev_statsTable select 19)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Still_Not_A_Cop" >> "title")): {
		if ((oev_statsTable select 19) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Still_Not_A_Cop" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 19)];
		} else {
			_titleArray = [false, (oev_statsTable select 19)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Amateur_Driver" >> "title")): {
		if (((oev_statsTable select 20) < (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Amateur_Driver" >> "value"))) && ((oev_statsTable select 20) > 0)) then {
			_titleArray = [true, (oev_statsTable select 20)];
		} else {
			_titleArray = [false, (oev_statsTable select 20)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Tough_Competition" >> "title")): {
		if (((oev_statsTable select 20) < (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Tough_Competition" >> "value"))) && ((oev_statsTable select 20) > 0)) then {
			_titleArray = [true, (oev_statsTable select 20)];
		} else {
			_titleArray = [false, (oev_statsTable select 20)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Speed_Demon" >> "title")): {
		if (((oev_statsTable select 20) < (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Speed_Demon" >> "value"))) && ((oev_statsTable select 20) > 0)) then {
			_titleArray = [true, (oev_statsTable select 20)];
		} else {
			_titleArray = [false, (oev_statsTable select 20)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Anti_Air" >> "title")): {
		if ((oev_statsTable select 24) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Anti_Air" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 24)];
		} else {
			_titleArray = [false, (oev_statsTable select 24)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Personal_AA" >> "title")): {
		if ((oev_statsTable select 24) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Personal_AA" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 24)];
		} else {
			_titleArray = [false, (oev_statsTable select 24)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Balloon_Popper" >> "title")): {
		if ((oev_statsTable select 24) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Balloon_Popper" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 24)];
		} else {
			_titleArray = [false, (oev_statsTable select 24)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "The_Boom_Stick" >> "title")): {
		if ((oev_statsTable select 24) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "The_Boom_Stick" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 24)];
		} else {
			_titleArray = [false, (oev_statsTable select 24)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Fly_Swatter" >> "title")): {
		if ((oev_statsTable select 24) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Fly_Swatter" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 24)];
		} else {
			_titleArray = [false, (oev_statsTable select 24)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "The_Titan" >> "title")): {
		if ((oev_statsTable select 24) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "The_Titan" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 24)];
		} else {
			_titleArray = [false, (oev_statsTable select 24)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Assassin" >> "title")): {
		if ((oev_statsTable select 25) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Assassin" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 25)];
		} else {
			_titleArray = [false, (oev_statsTable select 25)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Hired_Gun" >> "title")): {
		if ((oev_statsTable select 25) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Hired_Gun" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 25)];
		} else {
			_titleArray = [false, (oev_statsTable select 25)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Gangster" >> "title")): {
		if ((oev_statsTable select 25) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Gangster" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 25)];
		} else {
			_titleArray = [false, (oev_statsTable select 25)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Contracted_killer" >> "title")): {
		if ((oev_statsTable select 25) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Contracted_killer" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 25)];
		} else {
			_titleArray = [false, (oev_statsTable select 25)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "John_Wick" >> "title")): {
		if ((oev_statsTable select 25) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "John_Wick" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 25)];
		} else {
			_titleArray = [false, (oev_statsTable select 25)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Hunted" >> "title")): {
		if ((oev_statsTable select 26) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Hunted" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 26)];
		} else {
			_titleArray = [false, (oev_statsTable select 26)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Hated" >> "title")): {
		if ((oev_statsTable select 26) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Hated" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 26)];
		} else {
			_titleArray = [false, (oev_statsTable select 26)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Walking_Target" >> "title")): {
		if ((oev_statsTable select 26) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Walking_Target" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 26)];
		} else {
			_titleArray = [false, (oev_statsTable select 26)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Lucky" >> "title")): {
		if ((oev_statsTable select 27) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Lucky" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 27)];
		} else {
			_titleArray = [false, (oev_statsTable select 27)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "High_roller" >> "title")): {
		if ((oev_statsTable select 27) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "High_roller" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 27)];
		} else {
			_titleArray = [false, (oev_statsTable select 27)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "On_the_Heater" >> "title")): {
		if ((oev_statsTable select 27) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "On_the_Heater" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 27)];
		} else {
			_titleArray = [false, (oev_statsTable select 27)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "What_are_runs" >> "title")): {
		if ((oev_statsTable select 27) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "What_are_runs" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 27)];
		} else {
			_titleArray = [false, (oev_statsTable select 27)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Iam_Casino" >> "title")): {
		if ((oev_statsTable select 27) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Iam_Casino" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 27)];
		} else {
			_titleArray = [false, (oev_statsTable select 27)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Card_Counter" >> "title")): {
		if ((oev_statsTable select 27) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Card_Counter" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 27)];
		} else {
			_titleArray = [false, (oev_statsTable select 27)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "poker_Champ" >> "title")): {
		if ((oev_statsTable select 27) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "poker_Champ" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 27)];
		} else {
			_titleArray = [false, (oev_statsTable select 27)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Rip_Money" >> "title")): {
		if ((oev_statsTable select 28) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Rip_Money" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 28)];
		} else {
			_titleArray = [false, (oev_statsTable select 28)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Lets_go_again" >> "title")): {
		if ((oev_statsTable select 28) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Lets_go_again" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 28)];
		} else {
			_titleArray = [false, (oev_statsTable select 28)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "My_money" >> "title")): {
		if ((oev_statsTable select 28) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "My_money" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 28)];
		} else {
			_titleArray = [false, (oev_statsTable select 28)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Get_loan" >> "title")): {
		if ((oev_statsTable select 28) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Get_loan" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 28)];
		} else {
			_titleArray = [false, (oev_statsTable select 28)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Cant_count" >> "title")): {
		if ((oev_statsTable select 28) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Cant_count" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 28)];
		} else {
			_titleArray = [false, (oev_statsTable select 28)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Gambling_Addict" >> "title")): {
		if ((oev_statsTable select 28) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Gambling_Addict" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 28)];
		} else {
			_titleArray = [false, (oev_statsTable select 28)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Need_help" >> "title")): {
		if ((oev_statsTable select 28) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Need_help" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 28)];
		} else {
			_titleArray = [false, (oev_statsTable select 28)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Better_Anonymous" >> "title")): {
		if ((oev_statsTable select 28) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Better_Anonymous" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 28)];
		} else {
			_titleArray = [false, (oev_statsTable select 28)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Winner" >> "title")): {
		if ((oev_statsTable select 40) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Winner" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 40)];
		} else {
			_titleArray = [false, (oev_statsTable select 40)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Rolling_In_Dough" >> "title")): {
		if ((oev_statsTable select 40) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Rolling_In_Dough" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 40)];
		} else {
			_titleArray = [false, (oev_statsTable select 40)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Kenny_Rogers" >> "title")): {
		if ((oev_statsTable select 40) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Kenny_Rogers" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 40)];
		} else {
			_titleArray = [false, (oev_statsTable select 40)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Maximum_Dopamine" >> "title")): {
		if ((oev_statsTable select 40) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Maximum_Dopamine" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 40)];
		} else {
			_titleArray = [false, (oev_statsTable select 40)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Casino_Scripter" >> "title")): {
		if ((oev_statsTable select 40) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Casino_Scripter" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 40)];
		} else {
			_titleArray = [false, (oev_statsTable select 40)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Loser" >> "title")): {
		if ((oev_statsTable select 41) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Loser" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 41)];
		} else {
			_titleArray = [false, (oev_statsTable select 41)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Double_Or_Nothing" >> "title")): {
		if ((oev_statsTable select 41) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Double_Or_Nothing" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 41)];
		} else {
			_titleArray = [false, (oev_statsTable select 41)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Cracked" >> "title")): {
		if ((oev_statsTable select 41) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Cracked" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 41)];
		} else {
			_titleArray = [false, (oev_statsTable select 41)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "RIGGED" >> "title")): {
		if ((oev_statsTable select 41) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "RIGGED" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 41)];
		} else {
			_titleArray = [false, (oev_statsTable select 41)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "o7" >> "title")): {
		if ((oev_statsTable select 41) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "o7" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 41)];
		} else {
			_titleArray = [false, (oev_statsTable select 41)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Dice_Roller" >> "title")): {
		if ((oev_statsTable select 42) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Dice_Roller" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 42)];
		} else {
			_titleArray = [false, (oev_statsTable select 42)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Mildly_Addicted" >> "title")): {
		if ((oev_statsTable select 42) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Mildly_Addicted" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 42)];
		} else {
			_titleArray = [false, (oev_statsTable select 42)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Loves_Losing_Money" >> "title")): {
		if ((oev_statsTable select 42) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Loves_Losing_Money" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 42)];
		} else {
			_titleArray = [false, (oev_statsTable select 42)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Retard" >> "title")): {
		if ((oev_statsTable select 42) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Retard" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 42)];
		} else {
			_titleArray = [false, (oev_statsTable select 42)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Dent_Head" >> "title")): {
		if ((oev_statsTable select 42) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Dent_Head" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 42)];
		} else {
			_titleArray = [false, (oev_statsTable select 42)];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Vein_Popper" >> "title")): {
		if ((oev_statsTable select 37) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Vein_Popper" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 37];
		} else {
			_titleArray = [false, oev_statsTable select 37];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Planned_Parenthood" >> "title")): {
		if ((oev_statsTable select 37) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Planned_Parenthood" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 37];
		} else {
			_titleArray = [false, oev_statsTable select 37];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Harmacist" >> "title")): {
		if ((oev_statsTable select 37) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Harmacist" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 37];
		} else {
			_titleArray = [false, oev_statsTable select 37];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCiv" >> "Touch_of_Death" >> "title")): {
		if ((oev_statsTable select 37) >= (getNumber(missionConfigFile >> "CfgTitleCiv" >> "Touch_of_Death" >> "value"))) then {
			_titleArray = [true, oev_statsTable select 37];
		} else {
			_titleArray = [false, oev_statsTable select 37];
		};
	};
	/////////////
	//   APD   //
	/////////////
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Deputy" >> "title")): {
		if (__GETC__(life_coplevel) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Deputy" >> "value"))) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Patrol_Officer" >> "title")): {
		if (__GETC__(life_coplevel) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Patrol_Officer" >> "value"))) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Corporal" >> "title")): {
		if (__GETC__(life_coplevel) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Corporal" >> "value"))) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Sergeant" >> "title")): {
		if (__GETC__(life_coplevel) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Sergeant" >> "value"))) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Lieutenant" >> "title")): {
		if (__GETC__(life_coplevel) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Lieutenant" >> "value"))) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Deputy_Chief_of_Police" >> "title")): {
		if (__GETC__(life_coplevel) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Deputy_Chief_of_Police" >> "value"))) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Chief_of_Police" >> "title")): {
		if (__GETC__(life_coplevel) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Chief_of_Police" >> "value"))) then {
				_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Mall_Cop" >> "title")): {
		if ((oev_statsTable select 17) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Mall_Cop" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 17)];
		} else {
			_titleArray = [false, oev_statsTable select 17];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Drug_Dog" >> "title")): {
		if ((oev_statsTable select 17) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Drug_Dog" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 17)];
		} else {
			_titleArray = [false, oev_statsTable select 17];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "DEA_Agent" >> "title")): {
		if ((oev_statsTable select 17) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "DEA_Agent" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 17)];
		} else {
			_titleArray = [false, oev_statsTable select 17];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Narcotics_Ninja" >> "title")): {
		if ((oev_statsTable select 17) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Narcotics_Ninja" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 17)];
		} else {
			_titleArray = [false, oev_statsTable select 17];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "The_Epitome_of_Escobar" >> "title")): {
		if ((oev_statsTable select 17) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "The_Epitome_of_Escobar" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 17)];
		} else {
			_titleArray = [false, oev_statsTable select 17];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Defender" >> "title")): {
		if ((oev_statsTable select 11) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Defender" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 11)];
		} else {
			_titleArray = [false, oev_statsTable select 11];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Enforcer" >> "title")): {
		if ((oev_statsTable select 11) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Enforcer" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 11)];
		} else {
			_titleArray = [false, oev_statsTable select 11];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Justicar" >> "title")): {
		if ((oev_statsTable select 11) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Justicar" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 11)];
		} else {
			_titleArray = [false, oev_statsTable select 11];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Sheriff_of_Slaying" >> "title")): {
		if ((oev_statsTable select 11) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Sheriff_of_Slaying" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 11)];
		} else {
			_titleArray = [false, oev_statsTable select 11];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "The_Bandit_in_Blue" >> "title")): {
		if ((oev_statsTable select 11) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "The_Bandit_in_Blue" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 11)];
		} else {
			_titleArray = [false, oev_statsTable select 11];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "The_Executioner" >> "title")): {
		if ((oev_statsTable select 11) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "The_Executioner" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 11)];
		} else {
			_titleArray = [false, oev_statsTable select 11];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Forgiving_Fuzz" >> "title")): {
		if ((oev_statsTable select 12) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Forgiving_Fuzz" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 12)];
		} else {
			_titleArray = [false, oev_statsTable select 12];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Merciful_Marshal" >> "title")): {
		if ((oev_statsTable select 12) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Merciful_Marshal" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 12)];
		} else {
			_titleArray = [false, oev_statsTable select 12];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Graceful_Gendarme" >> "title")): {
		if ((oev_statsTable select 12) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Graceful_Gendarme" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 12)];
		} else {
			_titleArray = [false, oev_statsTable select 12];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Amnesty_Agent" >> "title")): {
		if ((oev_statsTable select 12) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Amnesty_Agent" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 12)];
		} else {
			_titleArray = [false, oev_statsTable select 12];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Great_Man_Bad_Cop" >> "title")): {
		if ((oev_statsTable select 12) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Great_Man_Bad_Cop" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 12)];
		} else {
			_titleArray = [false, oev_statsTable select 12];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Rookie" >> "title")): {
		if ((oev_statsTable select 13) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Rookie" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 13)];
		} else {
			_titleArray = [false, oev_statsTable select 13];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Experienced_Officer" >> "title")): {
		if ((oev_statsTable select 13) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Experienced_Officer" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 13)];
		} else {
			_titleArray = [false, oev_statsTable select 13];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Veteran_Officer" >> "title")): {
		if ((oev_statsTable select 13) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Veteran_Officer" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 13)];
		} else {
			_titleArray = [false, oev_statsTable select 13];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Peacekeeper" >> "title")): {
		if ((oev_statsTable select 13) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Peacekeeper" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 13)];
		} else {
			_titleArray = [false, oev_statsTable select 13];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Altis_Finest" >> "title")): {
		if ((oev_statsTable select 13) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Altis_Finest" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 13)];
		} else {
			_titleArray = [false, oev_statsTable select 13];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Corrections_Constable" >> "title")): {
		if ((oev_statsTable select 13) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Corrections_Constable" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 13)];
		} else {
			_titleArray = [false, oev_statsTable select 13];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Robocop" >> "title")): {
		if ((oev_statsTable select 13) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Robocop" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 13)];
		} else {
			_titleArray = [false, oev_statsTable select 13];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Did_I_Do_That" >> "title")): {
		if ((oev_statsTable select 15) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Did_I_Do_That" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 15)];
		} else {
			_titleArray = [false, oev_statsTable select 15];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Vault_Guardian" >> "title")): {
		if ((oev_statsTable select 15) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Vault_Guardian" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 15)];
		} else {
			_titleArray = [false, oev_statsTable select 15];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "EOD_Specialist" >> "title")): {
		if ((oev_statsTable select 15) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "EOD_Specialist" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 15)];
		} else {
			_titleArray = [false, oev_statsTable select 15];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "The_Hurt_Locker" >> "title")): {
		if ((oev_statsTable select 15) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "The_Hurt_Locker" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 15)];
		} else {
			_titleArray = [false, oev_statsTable select 15];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Actual_Ninja" >> "title")): {
		if ((oev_statsTable select 15) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Actual_Ninja" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 15)];
		} else {
			_titleArray = [false, oev_statsTable select 15];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Cadet" >> "title")): {
		if (O_stats_playtime_cop >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Cadet" >> "value"))) then {
			_titleArray = [true, O_stats_playtime_cop];
		} else {
			_titleArray = [false, O_stats_playtime_cop];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Qualified" >> "title")): {
		if (O_stats_playtime_cop >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Qualified" >> "value"))) then {
			_titleArray = [true, O_stats_playtime_cop];
		} else {
			_titleArray = [false, O_stats_playtime_cop];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Seasoned_Veteran" >> "title")): {
		if (O_stats_playtime_cop >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Seasoned_Veteran" >> "value"))) then {
			_titleArray = [true, O_stats_playtime_cop];
		} else {
			_titleArray = [false, O_stats_playtime_cop];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Legendary_Tenure" >> "title")): {
		if (O_stats_playtime_cop >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Legendary_Tenure" >> "value"))) then {
			_titleArray = [true, O_stats_playtime_cop];
		} else {
			_titleArray = [false, O_stats_playtime_cop];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Career_Cop" >> "title")): {
		if (O_stats_playtime_cop >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Career_Cop" >> "value"))) then {
			_titleArray = [true, O_stats_playtime_cop];
		} else {
			_titleArray = [false, O_stats_playtime_cop];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Should_Be_Retired" >> "title")): {
		if (O_stats_playtime_cop >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Should_Be_Retired" >> "value"))) then {
			_titleArray = [true, O_stats_playtime_cop];
		} else {
			_titleArray = [false, O_stats_playtime_cop];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Meter_Maid" >> "title")): {
		if ((oev_statsTable select 14) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Meter_Maid" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 14)];
		} else {
			_titleArray = [false, oev_statsTable select 14];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Debt_Collector" >> "title")): {
		if ((oev_statsTable select 14) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Debt_Collector" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 14)];
		} else {
			_titleArray = [false, oev_statsTable select 14];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Budget_Balancer" >> "title")): {
		if ((oev_statsTable select 14) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Budget_Balancer" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 14)];
		} else {
			_titleArray = [false, oev_statsTable select 14];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Federal_Salesman" >> "title")): {
		if ((oev_statsTable select 14) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Federal_Salesman" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 14)];
		} else {
			_titleArray = [false, oev_statsTable select 14];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Walking_Courthouse" >> "title")): {
		if ((oev_statsTable select 14) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Walking_Courthouse" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 14)];
		} else {
			_titleArray = [false, oev_statsTable select 14];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Pig" >> "title")): {
		if ((oev_statsTable select 16) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Pig" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 16)];
		} else {
			_titleArray = [false, oev_statsTable select 16];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Paul_Blart" >> "title")): {
		if ((oev_statsTable select 16) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Paul_Blart" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 16)];
		} else {
			_titleArray = [false, oev_statsTable select 16];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Sir_Peter_Long" >> "title")): {
		if ((oev_statsTable select 16) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Sir_Peter_Long" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 16)];
		} else {
			_titleArray = [false, oev_statsTable select 16];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Geek_Squad" >> "title")): {
		if ((oev_statsTable select 22) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Geek_Squad" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 22)];
		} else {
			_titleArray = [false, oev_statsTable select 22];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Computer_Nerd" >> "title")): {
		if ((oev_statsTable select 22) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Computer_Nerd" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 22)];
		} else {
			_titleArray = [false, oev_statsTable select 22];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "NSA_Agent" >> "title")): {
		if ((oev_statsTable select 22) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "NSA_Agent" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 22)];
		} else {
			_titleArray = [false, oev_statsTable select 22];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Ghosthawk_Online" >> "title")): {
		if ((oev_statsTable select 22) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Ghosthawk_Online" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 22)];
		} else {
			_titleArray = [false, oev_statsTable select 22];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleCop" >> "Elite_Haxor" >> "title")): {
		if ((oev_statsTable select 22) >= (getNumber(missionConfigFile >> "CfgTitleCop" >> "Elite_Haxor" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 22)];
		} else {
			_titleArray = [false, oev_statsTable select 22];
		};
	};
	/////////////
	//   MED   //
	/////////////
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Intern" >> "title")): {
		if (O_stats_playtime_med >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Intern" >> "value"))) then {
			_titleArray = [true, O_stats_playtime_med];
		} else {
			_titleArray = [false, O_stats_playtime_med];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Resident" >> "title")): {
		if (O_stats_playtime_med >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Resident" >> "value"))) then {
			_titleArray = [true, O_stats_playtime_med];
		} else {
			_titleArray = [false, O_stats_playtime_med];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Technician" >> "title")): {
		if (O_stats_playtime_med >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Technician" >> "value"))) then {
			_titleArray = [true, O_stats_playtime_med];
		} else {
			_titleArray = [false, O_stats_playtime_med];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Aviator" >> "title")): {
		if (O_stats_playtime_med >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Aviator" >> "value"))) then {
			_titleArray = [true, O_stats_playtime_med];
		} else {
			_titleArray = [false, O_stats_playtime_med];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Greasemonkey" >> "title")): {
		if (O_stats_playtime_med >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Greasemonkey" >> "value"))) then {
			_titleArray = [true, O_stats_playtime_med];
		} else {
			_titleArray = [false, O_stats_playtime_med];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Surgeon" >> "title")): {
		if (O_stats_playtime_med >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Surgeon" >> "value"))) then {
			_titleArray = [true, O_stats_playtime_med];
		} else {
			_titleArray = [false, O_stats_playtime_med];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Superintendant" >> "title")): {
		if (O_stats_playtime_med >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Superintendant" >> "value"))) then {
			_titleArray = [true, O_stats_playtime_med];
		} else {
			_titleArray = [false, O_stats_playtime_med];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Extraordinaire" >> "title")): {
		if (O_stats_playtime_med >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Extraordinaire" >> "value"))) then {
			_titleArray = [true, O_stats_playtime_med];
		} else {
			_titleArray = [false, O_stats_playtime_med];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Favorite" >> "title")): {
		if (O_stats_playtime_med >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Favorite" >> "value"))) then {
			_titleArray = [true, O_stats_playtime_med];
		} else {
			_titleArray = [false, O_stats_playtime_med];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Nurse" >> "title")): {
		if (O_stats_revives >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Nurse" >> "value"))) then {
			_titleArray = [true, O_stats_revives];
		} else {
			_titleArray = [false, O_stats_revives];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Doctor" >> "title")): {
		if (O_stats_revives >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Doctor" >> "value"))) then {
			_titleArray = [true, O_stats_revives];
		} else {
			_titleArray = [false, O_stats_revives];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Corpsman" >> "title")): {
		if (O_stats_revives >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Corpsman" >> "value"))) then {
			_titleArray = [true, O_stats_revives];
		} else {
			_titleArray = [false, O_stats_revives];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Necromancer" >> "title")): {
		if (O_stats_revives >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Necromancer" >> "value"))) then {
			_titleArray = [true, O_stats_revives];
		} else {
			_titleArray = [false, O_stats_revives];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "GoldWindows" >> "title")): {
		if (O_stats_revives >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "GoldWindows" >> "value"))) then {
			_titleArray = [true, O_stats_revives];
		} else {
			_titleArray = [false, O_stats_revives];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Angel" >> "title")): {
		if (O_stats_revives >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Angel" >> "value"))) then {
			_titleArray = [true, O_stats_revives];
		} else {
			_titleArray = [false, O_stats_revives];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Savior" >> "title")): {
		if (O_stats_revives >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Savior" >> "value"))) then {
			_titleArray = [true, O_stats_revives];
		} else {
			_titleArray = [false, O_stats_revives];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Meter_Maids" >> "title")): {
		if ((oev_statsTable select 23) >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Meter_Maids" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 23)];
		} else {
			_titleArray = [false, oev_statsTable select 23];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Street_Cleaner" >> "title")): {
		if ((oev_statsTable select 23) >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Street_Cleaner" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 23)];
		} else {
			_titleArray = [false, oev_statsTable select 23];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Repo_Man" >> "title")): {
		if ((oev_statsTable select 23) >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Repo_Man" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 23)];
		} else {
			_titleArray = [false, oev_statsTable select 23];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Automobile_Magician" >> "title")): {
		if ((oev_statsTable select 23) >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Automobile_Magician" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 23)];
		} else {
			_titleArray = [false, oev_statsTable select 23];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Kavala_Cleanup_Crew" >> "title")): {
		if ((oev_statsTable select 23) >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Kavala_Cleanup_Crew" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 23)];
		} else {
			_titleArray = [false, oev_statsTable select 23];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Spark_Plug_Licker" >> "title")): {
		if ((oev_statsTable select 21) >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Spark_Plug_Licker" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 21)];
		} else {
			_titleArray = [false, oev_statsTable select 21];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Grease_Monkey" >> "title")): {
		if ((oev_statsTable select 21) >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Grease_Monkey" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 21)];
		} else {
			_titleArray = [false, oev_statsTable select 21];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Gear_Head" >> "title")): {
		if ((oev_statsTable select 21) >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Gear_Head" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 21)];
		} else {
			_titleArray = [false, oev_statsTable select 21];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Master_Technician" >> "title")): {
		if ((oev_statsTable select 21) >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Master_Technician" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 21)];
		} else {
			_titleArray = [false, oev_statsTable select 21];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Human_Toolkit" >> "title")): {
		if ((oev_statsTable select 21) >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Human_toolkit" >> "value"))) then {
			_titleArray = [true, (oev_statsTable select 21)];
		} else {
			_titleArray = [false, oev_statsTable select 21];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "EMT" >> "title")): {
		if (__GETC__(life_medicLevel) >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "EMT" >> "value"))) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Basic_Paramedic" >> "title")): {
		if (__GETC__(life_medicLevel) >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Basic_Paramedic" >> "value"))) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Advanced_Paramedic" >> "title")): {
		if (__GETC__(life_medicLevel) >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Advanced_Paramedic" >> "value"))) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "SNR" >> "title")): {
		if (__GETC__(life_medicLevel) >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "SNR" >> "value"))) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Supervisor" >> "title")): {
		if (__GETC__(life_medicLevel) >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Supervisor" >> "value"))) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Coordinator" >> "title")): {
		if (__GETC__(life_medicLevel) >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Coordinator" >> "value"))) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleMedic" >> "Director" >> "title")): {
		if (__GETC__(life_medicLevel) >= (getNumber(missionConfigFile >> "CfgTitleMedic" >> "Director" >> "value"))) then {
			if ((getplayerUID player) isEqualTo "76561198144351505") then {
				_titleArray = [true, -1];
			} else {
				_titleArray = [false, -1];
			};
		} else {
			_titleArray = [false, -1];
		};
	};
	/////////////
	//   SPC   //
	/////////////
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "The_Scat" >> "title")): {
		if ((getplayerUID player) isEqualTo '76561198274942270') then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "Tree_Wins_Again" >> "title")): {
		if ((getplayerUID player) isEqualTo '76561198020256720') then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "Hail_Tree" >> "title")): {
		if ((getplayerUID player) isEqualTo '76561198098008179') then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "Raise_Hell" >> "title")): {
		if ((getplayerUID player) isEqualTo '76561198256746704') then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "Norsk_Drittunge" >> "title")): {
		if ((getplayerUID player) isEqualTo '76561198056591362') then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "The_Shadow_Director" >> "title")): {
		if ((getplayerUID player) isEqualTo '76561198210914920') then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};


	/////////////
	//  STAFF  //
	/////////////
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "Lead_Developer" >> "title")): {
		if (__GETC__(oev_developerlevel) isEqualTo 4) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "Lead_Designer" >> "title")): {
		if (__GETC__(oev_designerlevel) isEqualTo 4) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "Senior_Designer" >> "title")): {
		if (__GETC__(oev_designerlevel) >= 3) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "Senior_Developer" >> "title")): {
		if (__GETC__(oev_developerlevel) >= 3) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "Developer" >> "title")): {
		if (__GETC__(oev_developerlevel) >= 2) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "Designer" >> "title")): {
		if (__GETC__(oev_designerlevel) >= 2) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "ModeratorOne" >> "title")): {
		if (__GETC__(life_adminlevel) >= 1) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "ModeratorOneLeader" >> "title")): {
		if ((getplayerUID player) isEqualTo '76561198068833340') then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "Civ_Council" >> "title")): {
		if (__GETC__(oev_civcouncil) > 0) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "Liaison" >> "title")): {
		if ((getplayerUID player) isEqualTo '76561198069862784') then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "Ticket_Whore" >> "title")): {
			if (__GETC__(life_supportlevel) >= 3) then {
				_titleArray = [true, -1];
			} else {
				_titleArray = [false, -1];
			};
		};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "Support_Team" >> "title")): {
		if (__GETC__(life_supportlevel) >= 1) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "Sr_Support_Team" >> "title")): {
		if (__GETC__(life_supportlevel) >= 5) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "Lead_Support" >> "title")): {
		if (__GETC__(life_supportlevel) >= 6) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	/////////////
//    GW   //
/////////////
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "Gang_Wars_Winner" >> "title")): {
		if ((getplayerUID player) in _gangWarsWinners) then {
			_titleArray = [true, -1];
			} else {
				_titleArray = [false, -1];
			};
		};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "ModeratorTwo" >> "title")): {
		if (__GETC__(life_adminlevel) >= 2) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "Administrator" >> "title")): {
		if (__GETC__(life_adminlevel) >= 3) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "Senior_Admin" >> "title")): {
		if (__GETC__(life_adminlevel) isEqualTo 4) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	/////////////
	//  DONOR  //
	/////////////
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "NitroDonators" >> "title")): {
		if ((getplayerUID player) in _nitroBoosters) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "Supporter" >> "title")): {
		if (__GETC__(oev_donator) >= 15) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "MVP" >> "title")): {
		if (__GETC__(oev_donator) >= 30) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "VIP" >> "title")): {
		if (__GETC__(oev_donator) >= 50) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "Elite" >> "title")): {
		if (__GETC__(oev_donator) >= 100) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "Champion" >> "title")): {
		if (__GETC__(oev_donator) >= 250) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleSpecial" >> "Legendary" >> "title")): {
		if (__GETC__(oev_donator) >= 500) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	/////////////
	//   SRV   //
	/////////////
	case (getText(missionConfigFile >> "CfgTitleServerBest" >> "Merchant_of_War" >> "title")): {
		if ((getplayerUID player) isEqualTo (oev_title_pid select 0)) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleServerBest" >> "Big_Daddy_Warbucks" >> "title")): {
		if ((getplayerUID player) isEqualTo (oev_title_pid select 1)) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleServerBest" >> "Merciless_Anarchist" >> "title")): {
		if ((getplayerUID player) isEqualTo (oev_title_pid select 2)) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleServerBest" >> "Hammer_Of_Justice" >> "title")): {
		if ((getplayerUID player) isEqualTo (oev_title_pid select 3)) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleServerBest" >> "Bullet_Bill" >> "title")): {
		if ((getplayerUID player) isEqualTo (oev_title_pid select 4)) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleServerBest" >> "God_of_War" >> "title")): {
		if ((getplayerUID player) isEqualTo (oev_title_pid select 6)) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleServerBest" >> "Cop_of_War" >> "title")): {
		if ((getplayerUID player) isEqualTo (oev_title_pid select 7)) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
	case (getText(missionConfigFile >> "CfgTitleServerBest" >> "God_of_Casino" >> "title")): {
		if ((getplayerUID player) in [(oev_title_pid select 8),"76561198120173072"]) then {
			_titleArray = [true, -1];
		} else {
			_titleArray = [false, -1];
		};
	};
};
if (__GETC__(life_adminlevel) isEqualTo 4) then {_titleArray = [true, -1]};
_titleArray;
