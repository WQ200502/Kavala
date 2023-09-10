//  File: fn_updateWantedCharge.sqf
//  Author: Fusah
//	Description: Updates players crime list for **REMOVALS**

params [
	["_crime","",[""]],
	["_uid","",[""]]
];

private _crimeNumber = [_crime] call OEC_fnc_crimeName2Number;

if !(_uid isEqualTo getPlayerUID player) exitWith {};
if !(playerside isEqualTo civilian) exitWith {};

if(_crimeNumber < 1 || _crimeNumber > oev_totalCrimes) exitWith {};

_currentBounty = O_stats_crimes select 0;
_selectedCrime = O_stats_crimes select _crimeNumber;

if (_selectedCrime == 0) exitWith {}; // we dnt wanna go neg

_price = switch(_crimeNumber) do {
	case 1: {35000};								//Vehicular Manslaughter
	case 2: {30000};								//Manslaughter
	case 3: {56000};								//Escaping Jail
	case 4: {500};									//Assault
	case 5: {3000};									//Attempted Rape (WTF??)
	case 6: {5000};									//Attempted Grand Theft Auto
	case 7: {8000};									//Use of illegal explosives
	case 8: {30000};								//Robbery
	case 9: {11250};								//Kidnapping
	case 10: {4000};								//Attempted Kidnapping
	case 11: {17500};								//Grand Theft Auto
	case 12: {7000};								//Petty Theft
	case 13: {7500};								//Hit and Run
	case 14: {31500};								//Possession of Contraband
	case 15: {45000};								//Drug Possession
	case 16: {34000};								//Drug Trafficking
	case 17: {175000};							//Burglary
	case 18: {17000};								//Organ Dealing
	case 19: {6250};								//Driving w/o license
	case 20: {2000};								//Driving w/o lights
	case 21: {8000};								//Attp. Robbery
	case 22: {17500};								//Veh. Theft
	case 23: {5000};								//Attp. Veh. Theft
	case 24: {26250};								//Attp. Manslaughter
	case 25: {1500};								//Speeding
	case 26: {3000};								//Reckless Driving
	case 27: {25500};								//Pos. of APD Equip.
	case 28: {48750};								//Ilg. Aerial Veh. Landing
	case 29: {31500};								//Operating an ilg. veh.
	case 30: {7500};								//Hit and Run
	case 31: {16500};								//Resisting Arrest
	case 32: {8000};								//Verbal Threats
	case 33: {3000};								//Verbal Insults
	case 34: {6000};								//Entering a Police Area
	case 35: {63750};								//Destruction of property
	case 36: {11000};								//Pos. of firearms w/o license
	case 37: {12000};								//Pos. of an ilg. weapon
	case 38: {5000};								//Use of firearms within city
	case 39: {86500};								//Hostage Situation
	case 40: {93750};								//Terrorist Acts
	case 41: {15000};								//Flying/Hovering below 150m
	case 42: {86000};								//Aiding in jail break
	case 43: {10500};								//Flying w/o a pilot license
	case 44: {112500};							//Aiding in Reserve Robbery
	case 45: {82500};								//Attp. Reserve Robbery
	case 46: {1500};								//Insurance Fraud
	case 47: {8000};								//Disobeying an Officer
	case 48: {4625};								//Obstruction of Traffic
	case 49: {15125};								//Weapon Trafficking
	case 50: {30000};								//Avoiding a Checkpoint
	case 51: {10000};								//Usage of Drugs in Public
	case 52: {1125};								//Disturbing the Peace
	case 53: {37500};								//LEO Manslaughter
	case 54: {30000};								//Gov't Cyber Attack
	case 55: {63750};								//Destruction of Gov't Property
	case 56: {15000};								//Party to a Crime
	case 57: {15750};								//Obstruction of Justice
	case 58: {40000};								//Misuse of Emergency System
	case 59: {112500};							//Aiding in BW Robbery
	case 60: {18750};								//Gas Station Robbery
	case 61: {11250};								//Organ Harvesting
	case 62: {22500};								//Pos. of Illegal Organ
	case 63: {15000};								//Gang Homicide
	case 64: {30000};								//Unlawful Taser Usage
	case 65: {82500};								//Attp. BW Robbery
	case 66: {63750};								//Attp. Jail Break
	case 67: {92750};								//Kidnapping Gov't Official
	case 68: {40000};								//Aiding in Pharm. Robbery
	case 69: {30000};								//Pos. of Explosives
	case 70: {2000};								//Flying w/o Collision Lights
	case 71: {32500};								//Attempted Bank Robbery
	case 72: {81250};								//Aiding in Bank Robbery
	case 73: {15000};								//Pos of Illegal Equipment
	case 74: {2500};							  //Public Urination
	case 75: {15000};								//Titan Hit
	default {0};
};

O_stats_crimes set[0,_currentBounty - _price];
O_stats_crimes set[_crimeNumber, _selectedCrime - 1];

_currentBounty = O_stats_crimes select 0;
if (_currentBounty < 0) then {O_stats_crimes set[0,0]}; // Prevent bounty from being pardoned below zero if custom bounty was ever set ^___^

player setVariable["statBounty",O_stats_crimes select 0,true];
[10] call OEC_fnc_ClupdatePartial;
[] call OEC_fnc_hudUpdate;
