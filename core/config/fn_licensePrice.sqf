//  File: fn_licensePrice.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Returns the license price.
private["_type"];
_type = param [0,"",[""]];
if(_type == "") exitWith {-1};

switch (_type) do
{
	case "driver": {10000}; //Drivers License cost
	case "boat": {5000}; //Boating license cost
	case "pilot": {50000}; //Pilot/air license cost
	case "gun": {25000}; //Firearm/gun license cost
	case "wpl": {50000}; //Advanced Firearm/gun license cost
	case "dive": {3000}; //Diving license cost
	case "oil": {10000}; //Oil processing license cost
	case "cair": {15000}; //Cop Pilot License cost
	case "swat": {35000}; //Swat License cost
	case "cg": {8000}; //Coast guard license cost
	case "mcg"; {8000}; // Medical Coast Guard License Cost
	case "heroin": {25000}; //Heroin processing license cost
	case "marijuana": {17500}; //Marijuana processing license cost
	case "medmarijuana": {1500}; //Medical Marijuana processing license cost
	case "gang": {0}; //Gang license cost
	case "rebel": {75000}; //Rebel license cost
	case "truck": {20000}; //Truck license cost
	case "diamond": {35000};
	case "salt": {12000};
	case "cocaine": {30000};
	case "sand": {14500};
	case "iron": {9500};
	case "copper": {8000};
	case "cement": {6500};
	case "mair": {15000};
    case "home": {100000};
	case "frog": {24000};
	case "crystalmeth": {55000};
	case "methu": {30000};
	case "moonshine": {54000};
	case "mashu": {29000};
	case "platinum": {10000};
	case "silver": {9000};
	case "vigilante": {
		//if !(license_civ_rebel) then {60000} else {120000};
		if (oev_vigiarrests == 0) then {2000000000} else {120000};
	};
	case "mushroom": {35000};
	case "ccocaine": {40000};

	case "lumber": {15000};
	case "bananap": {25000};
	case "topaz": {30000};
	case "cocoap": {25000};
	case "bananaSplit": {35000};
	case "sugarp": {25000};
};