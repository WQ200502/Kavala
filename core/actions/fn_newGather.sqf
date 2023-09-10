#include <zmacro.h>
if(scriptAvailable(2.25)) exitWith {};
// File: fn_newGather.sqf
// Author: Jesse "tkcjesse" Schultz
// Based off old gather script and AsYet gather/mine scripts. Meant to handle new random item procs that can come with gathering.

if (oev_action_inUse) exitWith {};
if !(isNull objectParent player) exitWith {};
if (player getVariable ["restrained",false]) exitWith {};
if (player getVariable ["playerSurrender",false]) exitWith {};
if (oev_action_gathering < 0) then {oev_action_gathering = 0;};
if (oev_action_gathering > 0) exitWith {};
if !(playerSide isEqualTo civilian) exitWith {};

closeDialog 0; // Closes dialog to prevent being in menu while picking.

oev_action_gathering = oev_action_gathering + 1;
oev_action_inUse = true;

private ["_zone","_requiredItem","_curConfig","_zoneSize","_resourceZones","_restricted","_exit","_requiredItem","_requiredQty","_itemName","_itemQty","_item","_checkFull","_dice"];
_zone = "";
_requiredItem = "";

for "_i" from 0 to (count(missionConfigFile >> "CfgGather" >> "Resources")-1) do {
	_curConfig = ((missionConfigFile >> "CfgGather" >> "Resources") select _i);
	_zoneSize = getNumber(_curConfig >> "zoneSize");
	_resourceZones = getArray(_curConfig >> "zones");
	_restricted = getNumber(_curConfig >> "restricted");

	{
		if ((player distance (getMarkerPos _x)) < _zoneSize) exitWith {_zone = _x;};
	} forEach _resourceZones;

	if !(_zone isEqualTo "") exitWith {};
};
if (_zone isEqualTo "") exitWith {oev_action_inUse = false; oev_action_gathering = 0;};

if (_restricted isEqualTo 1 && license_civ_wpl) exitWith {hint "请到叛军前哨购买叛军训练后收集此项目。";oev_action_inUse = false; oev_action_gathering = 0;};

private _primaryItem = configName _curConfig;
private _primaryName = [([_primaryItem,0] call OEC_fnc_varHandle)] call OEC_fnc_varToStr;
private _secondaries = getArray(_curConfig >> "secondaryItems");
_requiredItem = getText(_curConfig >> "requiredItem");
private _primaryAmt = getNumber(_curConfig >> "amount");
private _delay = (getNumber(_curConfig >> "delay") / 2);

_exit = false;
if !(_requiredItem isEqualTo "") then {
	_requiredQty = missionNamespace getVariable (format ["life_inv_%1",_requiredItem]);
	if (_requiredQty < 1) exitWith {_exit = true;};
};
if (_exit) exitWith {oev_action_inUse = false; oev_action_gathering = 0;};

private _canHold = [_primaryItem,200,oev_carryWeight,oev_maxWeight] call OEC_fnc_calWeightDiff;
if (_canHold < 1) exitWith {hint localize "STR_NOTF_InvFull"; oev_interruptedTab = false; oev_interruptGather = false; oev_action_inUse = false; oev_action_gathering = 0;};
_origDelay = _delay;

while {true} do {
	_simplePos = [round(getPos player select 0), round(getPos player select 1)];
	if (oev_action_gathering > 1) exitWith {};
	if(_delay == _origDelay) then {
		player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
	};
	uiSleep _delay;
	if (oev_interruptGather || oev_interruptedTab) exitWith {_exit = true;};
	uiSleep _delay;
	if (oev_interruptGather || oev_interruptedTab) exitWith {_exit = true;};

	if !(_simplePos isEqualTo [round(getPos player select 0), round(getPos player select 1)]) then {
		if(_delay == _origDelay) then {
			_delay = _delay - (_delay * .20);
		};
	} else {
		_delay = _origDelay;
	};

	_checkFull = [_primaryItem,_primaryAmt,oev_carryWeight,oev_maxWeight] call OEC_fnc_calWeightDiff;
	if (_checkFull < 1) exitWith {hint localize "STR_NOTF_InvFull"; oev_interruptGather = false; oev_interruptedTab = false; oev_action_inUse = false; oev_action_gathering = 0;};

	if (player distance2d (getMarkerPos _zone) > _zoneSize) exitWith {_exit = true;};
	if !(alive player) exitWith {_exit = true;};

	if ([true,_primaryItem,_primaryAmt] call OEC_fnc_handleInv) then {titleText [format ["You have gathered %1 %2.",_primaryAmt,_primaryName],"PLAIN DOWN"];};

	_checkFull = [_primaryItem,_primaryAmt,oev_carryWeight,oev_maxWeight] call OEC_fnc_calWeightDiff;
	if (_checkFull < 1) exitWith {hint localize "STR_NOTF_InvFull"; oev_interruptGather = false;  oev_interruptedTab = false; oev_action_inUse = false; oev_action_gathering = 0;};

	if !(count _secondaries isEqualTo 0) then {
		{
			_item = _x select 0;
			_dice = floor(random(100));
			if (_dice > (_x select 2)) then {
				_itemQty = _x select 1;
				_checkFull = [_item,_itemQty,oev_carryWeight,oev_maxWeight] call OEC_fnc_calWeightDiff;
				if (_checkFull < 1) exitWith {};
				_itemName = [([_item,0] call OEC_fnc_varHandle)] call OEC_fnc_varToStr;
				[true,_item,_itemQty] call OEC_fnc_handleInv;
				systemChat format ["您在收集时找到%1%2。",_itemQty,_itemName];
			};
		} forEach _secondaries;
	};

	if (vehicle player != player) exitWith {_exit = true;};
	if (oev_interruptGather || oev_interruptedTab) exitWith {_exit = true;};
};
if (_exit) exitWith {titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false; oev_interruptedTab = false; oev_action_gathering = 0; oev_interruptGather = false;};
