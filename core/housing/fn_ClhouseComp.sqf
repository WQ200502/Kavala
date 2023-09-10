#include "..\..\macro.h"
//Author: Fraali
//Usage: Handles client side of house compensation

if (scriptAvailable(300)) exitWith {hint "Please wait 5 minutes between compensation claiming attempts!"};

params [
	["_house",objNull,[objNull]]
];

if (isNull _house) exitWith {};
if !((_house getVariable["trunk_in_use",""]) isEqualTo "") exitWith {hint "You can't claim compensation if someone is accessing the house!"};

[player, _house] remoteExec ["OES_fnc_houseComp", 2];
