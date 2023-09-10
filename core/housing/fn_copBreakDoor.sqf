//	Author: Bryan "Tonic" Boardwine
//  Modified by: Fusah
//  File: fn_copBreakDoor
//	Description: Allows cops to 'kick' in the door? DESCRIPTIONEND

private["_door","_title","_titleText","_progressBar","_cpRate","_cP","_uid"];
params [
	["_house",objNull,[objNull]]
];
if(isNull _house || !(_house isKindOf "House_F")) exitWith {};
if(isNil {(_house getVariable "house_owner")}) exitWith {hint localize "STR_House_Raid_NoOwner"};

_uid = (_house getVariable "house_owner") select 0;
private _keys = _house getVariable ["keyPlayers",[]];
private _houseTempKeys = _house getVariable ["houseTempKeys",[]];

private _permKeysOnline = false;

//Check if the owner is online
if ([_uid] call OEC_fnc_isUIDActive) then {
	_permKeysOnline = true;
} else {
	//Check to see if a keyholder is online
	{
		if ((getPlayerUID _x in _keys) || (getPlayerUID _x in _houseTempKeys)) exitWith {_permKeysOnline = true};
	} forEach playableUnits;
};

//If no keyholder then exit out
//if !(_permKeysOnline) exitWith {hint "Nobody with keys to this house is online!"};

_door = [_house] call OEC_fnc_ClnearestDoor;
if(_door == 0) exitWith {hint localize "STR_Cop_NotaDoor"};
if((_house getVariable[format["bis_disabled_Door_%1",_door],0]) == 0) exitWith {hint localize "STR_House_Raid_DoorUnlocked"};

oev_action_inUse = true;

//Setup the progress bar
disableSerialization;
_title = localize "STR_House_Raid_Progress";
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNamespace getVariable "life_progress";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;
_cpRate = 0.0092;

[[2,"STR_House_Raid_NOTF",true,[(_house getVariable "house_owner") select 1]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;

while {true} do
{
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
_house animate [format["door_%1_rot",_door],1];
_house setVariable[format["disabled_Door_%1",_door],1,true]; //Sets door variable disabled for civ's if cops break it down.
_house setVariable[format["bis_disabled_Door_%1",_door],0,true]; //Unlock the door.

[
	["event", "Cop Boltcut Door"],
	["player", name player],
	["player_id", getPlayerUID player],
	["owner", (_house getVariable "house_owner") select 1],
	["owner_id", (_house getVariable "house_owner") select 0],
	["house_id", _house getVariable "house_id"],
	["position", getPos player]
] call OEC_fnc_logIt;
