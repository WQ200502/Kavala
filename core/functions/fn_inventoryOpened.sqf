#include "..\..\macro.h"
#include <zmacro.h>

if(scriptAvailable(1)) exitWith {
	true
};

//	Author: Bryan "Tonic" Boardwine
//	Description: For the mean time it blocks the player from opening another persons backpack
private["_container","_unit"];
if(count _this isEqualTo 1) exitWith {false};
_unit = _this select 0;
_container = _this select 1;

if(oev_action_inUse) exitWith {
	hint "You're already performing another action.";
	true
};

if(typeOf _container isEqualTo "B_CargoNet_01_ammo_F" && {playerSide isEqualTo west}) exitWith {true};

if (typeOf _container isEqualTo "B_Slingload_01_Cargo_F" && {_container getVariable ["locked",false]}) exitWith {
	hint "This inventory has been sealed by the APD.";
	true
};

if (typeOf _container isEqualTo "B_Slingload_01_Cargo_F" && {!(playerSide isEqualTo civilian)}) exitWith {
	hint "Only civilians can open this container.";
	true
};

if (_container getVariable ["apdEscort",false] && (playerSide isEqualTo west) && player getVariable ["rank",-1] < 5) exitWith {
	hint "Only senior APD can access the APD escort inventory.";
	true
};

//oev_action_inUse = true;

if(((_container getVariable ["gear_in_use",["",0]]) select 0) != (getPlayerUID player) && ((_container getVariable ["gear_in_use",["",0]]) select 0) != "" && (((_container getVariable ["gear_in_use",["",0]]) select 1) > serverTime)) exitWith {
	hint "This inventory is already being used by someone.";
	oev_action_inUse = false;
	true
};

_container setVariable["gear_in_use",[(getPlayerUID player),(serverTime + 180)],true];

_container spawn{
	private["_gearInUse","_container"];
	_container = _this;
	waitUntil{!isNull (findDisplay 602)};

	while{true} do {
		uiSleep 0.25;
		if(isNull (findDisplay 602)) exitWith {};
		if(isNull _container) exitWith {};

		_gearInUse = (_container getVariable ["gear_in_use",["",0]]);

		if((_gearInUse select 0) isEqualTo "") exitWith {};
		if(_container getVariable["trunkLocked",false]) exitWith {hint "This container is being saved and cannot be accessed.";};
		if((_gearInUse select 0) != (getPlayerUID player) && (_gearInUse select 0) != "") exitWith {hint "Someone else has somehow opened the inventory, only one player may use the inventory at a time.";};
		if((_gearInUse select 0) isEqualTo (getPlayerUID player) && (_gearInUse select 1) < (serverTime + 10)) then {
			_container setVariable["gear_in_use",[(getPlayerUID player),(serverTime + 180)],true];
		};
	};

	_container setVariable["gear_in_use",nil,true];

	while{!isNull (findDisplay 602)} do {
		closeDialog 0;
		sleep 0.1;
	};
};

_isPack = getNumber(configFile >> "CfgVehicles" >> (typeOf _container) >> "isBackpack");
if(_isPack isEqualTo 1) exitWith {
	if((__GETC__(life_adminlevel) < 2) && (__GETC__(life_coplevel) < 2) && ((__GETC__(life_medicLevel) < 6) || (side (objectParent _container) != independent))) then {
		hint localize "STR_MISC_Backpack";
		oev_action_inUse = false;
		true
	};
};

if((typeOf _container) in ["Box_IND_Ammo_F"]) exitWith {
	_container enableSimulation true;
	private "_atm";
	_atm = _container getVariable ["atmObject",objNull];
	if (_atm isEqualTo objNull) exitWith {};
	_atm enableSimulation true;
};

if(typeOf _container isEqualTo "IG_supplyCrate_F") exitWith {
	if ((((_container getVariable ["owner",["",""]]) select 1) isEqualTo (getPlayerUID player)) || (((_container getVariable ["owner",["",""]]) select 0) isEqualTo (getPlayerUID player)) || (__GETC__(life_adminlevel) >= 1)) then {
		if ((((_container getVariable ["owner",["",""]]) select 1) isEqualTo (getPlayerUID player)) || (__GETC__(life_adminlevel) >= 1)) then {
			_container enableSimulation true;
		} else {
			_container enableSimulation false;
		};
	} else {
		hint "You are not the intended recipient of this compensation crate.";
		_container enableSimulation false;
		oev_action_inUse = false;
		true
	};
};

if(_container isKindOf "LandVehicle" || _container isKindOf "Ship" || _container isKindOf "Air") exitWith {
	if(_vehicle getVariable["unused",false]) then {
		_vehicle setVariable["unused",nil,true];
	};
	if(!(_container in oev_vehicles) && {(locked _container) isEqualTo 2} && !(playerSide isEqualTo west) && (__GETC__(life_adminlevel) < 2)) exitWith {
		hint localize "STR_MISC_VehInventory";
		oev_action_inUse = false;
		true
	};
};

if(_container isKindOf "Man" && !alive _container) exitWith {
	hint localize "STR_NOTF_NoLootingPerson";
	oev_action_inUse = false;
	true
};
