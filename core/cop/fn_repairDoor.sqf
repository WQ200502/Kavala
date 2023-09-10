//	Author: Bryan "Tonic" Boardwine
//	Description: Re-locks the door mainly for the federal reserve structures.

private["_doors","_door","_cP","_cpRate","_ui","_title","_titleText"];
params [
	["_building",objNull,[objNull]]
];

if (isNull _building) exitWith {};
if !(_building isKindOf "House_F") exitWith {hint "You are not looking at a house door."};

if ((player distance (getMarkerPos "bw_marker") < 65) && {(typeOf _building isEqualTo "Land_Dome_Big_F")} && {_building getVariable ["chargeplaced",false]} && {!(_building getVariable ["safe_open",false])}) exitWith {
	hint "Bomb must be defused or blown before attempting to repair the door! Try a defuse kit instead!";
};

private _exit = false;

if (player distance (getMarkerPos "fed_reserve_1") < 65) then {
	if (typeOf _building isEqualTo "Land_Dome_Big_F") then {
		if (fed_bank getVariable ["chargeplaced",false]) exitWith {_exit = true; hint "You must defuse the bomb before attempting to repair the door!";};
		if (fed_bank getVariable ["safe_open",false]) exitWith {_exit = true; hint "You must lock the safe before attempting to repair the door!";};
	};

	if (typeOf _building isEqualTo "Land_Research_house_V1_F") then {
		if (fed_bank getVariable ["chargeplaced",false]) exitWith {_exit = true; hint "You must defuse the bomb before attempting to repair the door!";};
		if (fed_bank getVariable ["safe_open",false]) exitWith {_exit = true; hint "You must lock the safe before attempting to repair the door!";};
	};
};

if (_exit) exitWith {};

_doors = 1;
_doors = getNumber(configFile >> "CfgVehicles" >> (typeOf _building) >> "NumberOfDoors");

_door = 0;
//Find the nearest door
for "_i" from 1 to _doors do {
	_selPos = _building selectionPosition format["Door_%1_trigger",_i];
	_worldSpace = _building modelToWorld _selPos;
		if(player distance _worldSpace < 5) exitWith {_door = _i;};
};

if(_door == 0) exitWith {hint localize "STR_Cop_NotaDoor"}; //Not near a door to be broken into.
if((_building getVariable[format["bis_disabled_Door_%1",_door],0]) == 1) exitWith {hint localize "STR_House_Raid_DoorUnlocked"};
oev_action_inUse = true;

closeDialog 0;
//Setup the progress bar
disableSerialization;
_title = localize "STR_Cop_RepairingDoor";
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNamespace getVariable "life_progress";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;

switch (typeOf _building) do {
	case "Land_Dome_Big_F": {_cpRate = 0.008;};
	case "Land_Research_house_V1_F": {_cpRate = 0.005;};
	default {_cpRate = 0.08;};
};

["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;

while {true} do {
	uiSleep 0.26;
	if(isNull _ui) then {
		5 cutRsc ["life_progress","PLAIN DOWN"];
		_ui = uiNamespace getVariable "life_progress";
	};
	_cP = _cP + _cpRate;
	_progressBar progressSetPosition _cP;
	_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
	if(_cP >= 1 || !alive player) exitWith {};
	if(oev_interrupted) exitWith {};
};

//Kill the UI display and check for various states
5 cutText ["","PLAIN DOWN"];
[] spawn OEC_fnc_handleAnim;
if(!alive player) exitWith {oev_action_inUse = false;};
if(oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false;};
oev_action_inUse = false;
_building animate [format["door_%1_rot",_door],0];

if (player distance getMarkerPos ("fed_reserve_1") < 65) then {
	[[2],"OES_fnc_handleComplexMarker"] spawn OEC_fnc_MP;
};

if ((typeOf _building isEqualTo "Land_Dome_Big_F") && (player distance (getMarkerPos "bw_marker") < 65)) then {
	_building setVariable ["safe_open",false,true];
	for "_i" from 1 to 3 do {_building setVariable[format["bis_disabled_Door_%1",_i],1,true]; _building animate [format["Door_%1_rot",_i],0];};
	[[9],"OES_fnc_handleComplexMarker"] spawn OEC_fnc_MP;
} else {
	_building setVariable[format["bis_disabled_Door_%1",_door],1,true];
};