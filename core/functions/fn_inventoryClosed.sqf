#include "..\..\macro.h"
//  File: fn_inventoryClosed.sqf
//	Author: Bryan "Tonic" Boardwine
//  Modifications: Jesse,Fusah
//	Description: Used for syncing house container data but when the inventory menu
//	is closed a sync request is sent off to the server.

private["_container"];
oev_action_inUse = false;
_container = param [1,ObjNull,[ObjNull]];
if(isNull _container) exitWith {}; //MEH

if((typeOf _container) in ["Box_IND_Ammo_F"]) exitWith {
	hint "running code";
	_container enableSimulation false;
	private "_atm";
	_atm = _conatiner getVariable ["atmObject",objNull];
	hint format ["container atm object %1",(typeOf _atm)];
	//if (isNull _atm) exitWith {};
	_atm enableSimulation false;
};

if ((typeOf _container) isEqualTo "IG_supplyCrate_F") exitWith {_container enableSimulation false;};

if !(uniform player isEqualTo "") then {
	if ((uniform player) in ['U_B_Soldier_VR','U_O_Soldier_VR','U_I_Soldier_VR','U_C_Soldier_VR']&& (__GETC__(oev_donator) < 1000)) then {
		removeUniform player;
		hint "The uniform you have equipped is for founders circle only and has been removed.";
		[false] call OEC_fnc_saveGear;
	};
};

switch(playerSide) do {
	case civilian: {[] call OEC_fnc_checkCopGear;};
	case west: {[] call OEC_fnc_checkCopGear;};
	case independent : {[] call OEC_fnc_checkMedGear;};
};
