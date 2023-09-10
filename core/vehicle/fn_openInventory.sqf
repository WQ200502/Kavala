//  File: fn_openInventory.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Starts the initialization of vehicle virtual inventory menu.

if (dialog) exitWith {};
params [
	["_vehicle",objNull,[objNull]]
];
private _exit = false;

if (isNull _vehicle || !(("Land_Wreck_Traw_F" == typeOf _vehicle) || ("Land_Wreck_Traw2_F" == typeOf _vehicle) || (typeOf _vehicle isEqualTo "IG_supplyCrate_F") || _vehicle isKindOf "Car" || _vehicle isKindOf "Air" || _vehicle isKindOf "Ship" || _vehicle isKindOf "House_F" || _vehicle isKindOF "Box")) exitWith {}; //Either a null or invalid vehicle type.
if (oev_is_processing) exitWith {hint "You cannot access trunk inventory while processing."};
if (_vehicle getVariable ["trunkLocked",false]) exitWith {hint "Inventory is being saved, you cannot access it.";};
if (_vehicle getVariable ["bldg_locked",false]) exitWith {hint "Recruit more gang members to unlock your building!"};
if !(typeOf _vehicle isEqualTo "Land_i_Shed_Ind_F") then {
	if ((_vehicle isKindOf "House_F") && isNil {_vehicle getVariable "house_owner"}) then {_exit = true;};
};
if (((_vehicle getVariable ["trunk_in_use",""]) != (getPlayerUID player)) && ([_vehicle getVariable ["trunk_in_use",""]] call OEC_fnc_isUIDActive) && ((_vehicle getVariable ["trunk_in_use",""]) != "")) exitWith {hint localize "STR_MISC_VehInvUse"}; //Check if user is logged in and allow bugged user back in to inventory
_vehicle setVariable["trunk_in_use",(getPlayerUID player),true];
if (_exit) exitWith	{};

//Internet check to make sure no lagswitch
oev_didServerRespond = false;
[[player],"OES_fnc_internetCheck",false,false] spawn OEC_fnc_MP;
private _maxDelayTime = time + 5;
waitUntil{time > _maxDelayTime || oev_didServerRespond};
if(time > _maxDelayTime) exitWith {hint "Access to inventory failed, try again.";};

//Create the dialog
["TrunkMenu"] call OEC_fnc_createDialog;
if(_vehicle getVariable["unused",false]) then {
	_vehicle setVariable["unused",nil,true];
};

[_vehicle] spawn{
//fixes exploit where multiple players try to open trunk at same time to dupe items.
	_vehicle = (_this select 0);
	while {!(isNull (findDisplay 3500)) || (_vehicle getVariable["trunk_in_use",""] isEqualTo (getPlayerUID player))} do {
		uiSleep 0.25;
		if(isNull _vehicle) exitWith {while{dialog} do {closeDialog 0;};};
		if !(alive player) exitWith {_vehicle setVariable["trunk_in_use","",true]};
		if(((_vehicle getVariable ["trunk_in_use",""]) != (getPlayerUID player) && (_vehicle getVariable ["trunk_in_use",""]) != "")) exitWith {hint "Someone else has somehow opened the trunk, only one player may use the trunk at a time."; while{dialog} do {closeDialog 0;}; _vehicle setVariable["trunk_in_use","",true];};
		if((_vehicle getVariable ["trunk_in_use",""]) == "") exitWith {while{dialog} do {closeDialog 0;}; _vehicle setVariable["trunk_in_use","",true];};
		if(_vehicle getVariable["trunkLocked",false]) exitWith {while{dialog} do {closeDialog 0;}; _vehicle setVariable["trunk_in_use","",true]; hint "Inventory is being saved, you cannot access it.";};
	};
};

disableSerialization;

private "_veh_data";
if(_vehicle isKindOf "House_F") then {
	private "_mWeight";
	if !(typeOf _vehicle isEqualTo "Land_i_Shed_Ind_F") then {
		ctrlSetText[3501,format["House Storage - %1",_vehicle getVariable ["house_id",-1]]];
		_mWeight = _vehicle getVariable ["storageCapacity",100];
	} else {
		ctrlSetText[3501,format["Gang Storage - %1",_vehicle getVariable ["bldg_id",-1]]];
		_mWeight = _vehicle getVariable ["storageCapacity",1000];
	};

	_veh_data = [_mWeight,(_vehicle getVariable["Trunk",[[],0]]) select 1];
} else {
	ctrlSetText[3501,format[(localize "STR_MISC_VehStorage")+ " - %1",getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName")]];
	_veh_data = [_vehicle] call OEC_fnc_vehicle1Weight;
};

if(_veh_data select 0 == -1 && {!(_vehicle isKindOf "House_F")}) exitWith {closeDialog 0; _vehicle setVariable["trunk_in_use","",true]; hint localize "STR_MISC_NoStorageVeh";};

ctrlSetText[3504,format[(localize "STR_MISC_Weight")+ " %1/%2",_veh_data select 1,_veh_data select 0]];
[_vehicle] call OEC_fnc_vehInventory;
oev_trunk_vehicle = _vehicle;

if !(typeOf _vehicle isEqualTo "Land_i_Shed_Ind_F") then {
	(findDisplay 3500) displayAddEventHandler ["unload", "oev_trunk_vehicle setVariable[""trunk_in_use"","""",true]; if(oev_trunk_vehicle isKindOf ""House_F"") then { [[oev_trunk_vehicle],""OES_fnc_updateHouseTrunk"",false,false] spawn OEC_fnc_MP;};"];
} else {
	(findDisplay 3500) displayAddEventHandler ["unload", "oev_trunk_vehicle setVariable[""trunk_in_use"","""",true]; if(oev_trunk_vehicle isKindOf ""House_F"") then { [[oev_trunk_vehicle],""OES_fnc_updateGangTrunk"",false,false] spawn OEC_fnc_MP;};"];
};