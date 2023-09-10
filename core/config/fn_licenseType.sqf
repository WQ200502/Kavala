//  File: fn_licenseType.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Returns the short-var of the license name to a long var and display name.
private ["_ret","_var"];
params [
	["_type","",[""]],
	["_mode",-1,[0]]
];
if(_type isEqualTo "" || _mode isEqualTo -1) exitWith {[]};

switch (_mode) do {
	case 0:	{
		switch (_type) do {
			case "driver": {_var = "license_civ_driver"}; //Drivers License cost
			case "boat": {_var = "license_civ_boat"}; //Boating license cost
			case "pilot": {_var = "license_civ_air"}; //Pilot/air license cost
			case "gun": {_var = "license_civ_gun"}; //Firearm/gun license cost
			case "wpl": {_var = "license_civ_wpl"}; //Advanced Firearm License
			case "dive": {_var = "license_civ_dive"}; //Diving license cost
			case "oil": {_var = "license_civ_oil"}; //Oil processing license cost
			case "cair": {_var = "license_cop_air"}; //Cop Pilot License cost
			case "swat": {_var = "license_cop_swat"}; //Swat License cost
			case "cg": {_var = "license_cop_cg"}; //Coast guard license cost
			case "mcg": {_var = "license_med_cg"}; //Medical Coast Guard license cost
			case "heroin": {_var = "license_civ_heroin"}; //Heroin processing license cost
			case "marijuana": {_var = "license_civ_marijuana"}; //Marijuana processing license cost
			case "medmarijuana": {_var = "license_civ_medmarijuana"}; //Medical Marijuana processing license cost
			case "gang": {_var = "license_civ_gang"}; //Gang license cost
			case "rebel": {_var = "license_civ_rebel"}; //Rebel License
			case "truck":{_var = "license_civ_truck"}; //Truck License
			case "diamond": {_var = "license_civ_diamond"};
			case "salt": {_var = "license_civ_salt"};
			case "cocaine": {_var = "license_civ_coke"};
			case "sand": {_var = "license_civ_sand"};
			case "iron": {_var = "license_civ_iron"};
			case "copper": {_var = "license_civ_copper"};
			case "cement": {_var = "license_civ_cement"};
			case "mair": {_var = "license_med_air"};
			case "home": {_var = "license_civ_home"};
			case "frog": {_var = "license_civ_frog"};
			case "crystalmeth": {_var = "license_civ_crystalmeth"};
			case "methu": {_var = "license_civ_methu"};
			case "moonshine": {_var = "license_civ_moonshine"};
			case "mashu": {_var = "license_civ_mashu"};
			case "platinum": {_var = "license_civ_platinum"};
			case "silver": {_var = "license_civ_silver"};
			case "vigilante": {_var = "license_civ_vigilante"};
			case "mushroom": {_var = "license_civ_mushroom"};

			case "lumber": {_var = "license_civ_lumber"};
			case "bananap": {_var = "license_civ_bananap"};
			case "topaz": {_var = "license_civ_topaz"};
			case "cocoap": {_var = "license_civ_cocoap"};
			case "bananaSplit": {_var = "license_civ_bananaSplit"};
			case "sugarp": {_var = "license_civ_sugarp"};

			default {_var = ""};
		};
	};

	case 1: {
		switch (_type) do {
			case "license_civ_driver": {_var = "driver"}; //Drivers License cost
			case "license_civ_boat": {_var = "boat"}; //Boating license cost
			case "license_civ_air": {_var = "pilot"}; //Pilot/air license cost
			case "license_civ_gun": {_var = "gun"}; //Firearm/gun license cost
			case "license_civ_wpl": {_var = "wpl"}; // WPL Firearm License
			case "license_civ_dive": {_var = "dive"}; //Diving license cost
			case "license_civ_oil": {_var = "oil"}; //Oil processing license cost
			case "license_cop_air": {_var = "cair"}; //Cop Pilot License cost
			case "license_cop_swat": {_var = "swat"}; //Swat License cost
			case "license_cop_cg": {_var = "cg"}; //Coast guard license cost
			case "license_med_cg": {_var = "mcg"}; //Medical Coast guard license cost
			case "license_civ_heroin": {_var = "heroin"}; //Heroin processing license cost
			case "license_civ_marijuana": {_var = "marijuana"}; //Marijuana processing license cost
			case "license_civ_medmarijuana": {_var = "medmarijuana"}; //Medical Marijuana processing license cost
			case "license_civ_gang": {_var = "gang"}; //Gang license cost
			case "license_civ_rebel": {_var = "rebel"}; //Rebel License
			case "license_civ_truck":{_var = "truck"}; //Truck License
			case "license_civ_diamond": {_var = "diamond"};
			case "license_civ_salt": {_var = "salt"};
			case "license_civ_coke": {_var = "cocaine"};
			case "license_civ_sand": {_var = "sand"};
			case "license_civ_iron": {_var = "iron"};
			case "license_civ_copper": {_var = "copper"};
			case "license_civ_cement": {_var = "cement"};
			case "license_med_air": {_var = "mair"};
			case "license_civ_home": {_var = "home"};
			case "license_civ_frog": {_var = "frog"};
			case "license_civ_crystalmeth": {_var = "crystalmeth"};
			case "license_civ_methu": {_var = "methu"};
			case "license_civ_moonshine": {_var = "moonshine"};
			case "license_civ_mashu": {_var = "mashu"};
			case "license_civ_platinum": {_var = "platinum"};
			case "license_civ_silver": {_var = "silver"};
			case "license_civ_vigilante": {_var = "vigilante"};

			case "license_civ_lumber": {_var = "lumber"};
			case "license_civ_bananap": {_var = "bananap"};
			case "license_civ_topaz": {_var = "topaz"};
			case "license_civ_cocoap": {_var = "cocoap"};
			case "license_civ_bananaSplit": {_var = "bananaSplit"};
			case "license_civ_sugarp": {_var = "sugarp"};

			default {_var = ""};
		};
	};
};

_ret = [_var,(if(_var != "") then {([_var] call OEC_fnc_varToStr)})];
_ret;