#include "..\..\macro.h"
//	Author: Bryan "Tonic" Boardwine
//  File: fn_raidHouse.sqf
//	Description: Raids the players house? DESCRIPTIONEND

private["_cpRate","_cP","_title","_titleText","_ui","_houseInv"];

params [
	["_house",objNull,[objNull]]
];
if(isNull _house || !(_house isKindOf "House_F")) exitWith {};
if(isNil {(_house getVariable "house_owner")}) exitWith {hint localize "STR_House_Raid_NoOwner"};
private _uid = (_house getVariable "house_owner") select 0;
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
if !(_permKeysOnline) exitWith {hint "Nobody with keys to this house is online!"};

_houseInv = _house getVariable ["Trunk",[[],0]];
private _physicalInv = _house getVariable ["PhysicalTrunk",[[],0]];
if((_houseInv isEqualTo [[],0]) && (_physicalInv isEqualTo [[],0])) exitWith {hint localize "STR_House_Raid_Nothing"};
oev_action_inUse = true;
oev_interruptedTab = false;

//Setup the progress bar
disableSerialization;
_title = localize "STR_House_Raid_Searching";
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNamespace getVariable "life_progress";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;
_cpRate = 0.0075;

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
	if(player distance _house > 13) exitWith {};
	if (oev_interruptedTab) exitWith {};
};

//Kill the UI display and check for various states
5 cutText ["","PLAIN DOWN"];
if(player distance _house > 13) exitWith {oev_action_inUse = false; titleText[localize "STR_House_Raid_TooFar","PLAIN DOWN"]};
if(!alive player) exitWith {oev_action_inUse = false;};
if (oev_interruptedTab) exitWith {hint "You have interrupted the house raid."; oev_interruptedTab = false; 5 cutText ["","PLAIN DOWN"]; oev_action_inUse = false;};
oev_action_inUse = false;

_value = 0;
{
    _var = _x select 0;
    _val = _x select 1;

    _index = [_var,oev_illegal_items] call OEC_fnc_index;
    if(_index != -1) then {
        _marketprice = (((oev_illegal_items) select _index) select 1);
        if(_marketprice != -1) then {
            _value = _value + (_val * _marketprice);
        };
    };
} foreach (_houseInv select 0);
private _illegalCount = 0;
{
    _var = _x select 0;
    _val = _x select 1;

    if ((getNumber (missionConfigFile >> "CfgWeights" >> (_var)  >> "illegal")) isEqualTo 1) then {
    	_illegalCount = _illegalCount + _val;
    };
} foreach (_physicalInv select 0);

if(_value > 0 || _illegalCount > 0) then {
	[0,format["A house was raided for $%1 worth of drugs / contraband and %2 illegal items.",[_value] call OEC_fnc_numberText, _illegalCount]] remoteExec ["OEC_fnc_broadcast",-2,false];
} else {
	hint localize "STR_House_Raid_NoIllegal";
};
[
	["event","House Raid"],
	["player", name player],
	["player_id",getPlayerUID player],
	["target",_uid],
	["value",_value],
	["position",getPosATL player]
] call OEC_fnc_logIt;
uiSleep 1;
[_house] call OEC_fnc_openHouseInventory;
