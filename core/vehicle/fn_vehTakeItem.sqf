#include "..\..\macro.h"
//  File: fn_vehTakeItem.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Used in the vehicle trunk menu, takes the selected item and puts it in the players virtual inventory
//	if the player has room.
private["_ctrl","_num","_index","_data","_old","_value","_weight","_diff","_mods","_gangID"];
disableSerialization;
if(!oev_didServerRespond) exitWith {hint "Awaiting server response, try again in a few seconds..."};
if(isNull oev_trunk_vehicle || !alive oev_trunk_vehicle) exitWith {hint localize "STR_MISC_VehDoesntExist"};
if(!alive player) exitwith {closeDialog 0;};
if((lbCurSel 3502) == -1) exitWith {hint localize "STR_Global_NoSelection";};
_ctrl = getSelData(3502);
_num = ctrlText 3505;
if(!([_num] call OEC_fnc_isNumeric)) exitWith {hint localize "STR_MISC_WrongNumFormat";};
_num = parseNumber(_num);
if (_num isEqualTo 0) exitWith {hint "You need to enter an amount to take!";};
if(_num < 1) exitWith {hint localize "STR_MISC_Under1";};

_vehPlate = (oev_trunk_vehicle getVariable "dbInfo");
_plate = _vehPlate select 1;
private _vehPos = getPos oev_trunk_vehicle;
private _playerPos = getPos player;
_gangID = oev_trunk_vehicle getVariable ["gangID",0];
if (_vehPos distance _playerPos > 10) exitWith {hint "You are too far away!"; closeDialog 0;};

_index = [_ctrl,((oev_trunk_vehicle getVariable "Trunk") select 0)] call OEC_fnc_index;
_data = (oev_trunk_vehicle getVariable "Trunk") select 0;
_old = oev_trunk_vehicle getVariable "Trunk";
if(_index == -1) exitWith {};
_value = _data select _index select 1;
if(_num > _value) exitWith {hint localize "STR_MISC_NotEnough"};
_num = [_ctrl,_num,oev_carryWeight,oev_maxWeight] call OEC_fnc_calWeightDiff;
if(_num == 0) exitWith {hint localize "STR_NOTF_InvFull"};
_weight = ([_ctrl] call OEC_fnc_itemWeight) * _num;
if(_ctrl == "money") then {
	if(_num == _value) then {
		_data set[_index,-1];
		_data = _data - [-1];
	} else {
		_data set[_index,[_ctrl,(_value - _num)]];
	};

	oev_cash = oev_cash + _num;
	oev_cache_cash = oev_cache_cash + _num;
	_newWeight = (_old select 1) - _weight;
	if (_newWeight < 0) then {_newWeight = 0;};
	oev_trunk_vehicle setVariable["Trunk",[_data,_newWeight],true];
	[oev_trunk_vehicle] call OEC_fnc_vehInventory;
} else {
	if([true,_ctrl,_num] call OEC_fnc_handleInv) then {
		if(_num == _value) then {
			_data set[_index,-1];
			_data = _data - [-1];
		} else {
			_data set[_index,[_ctrl,(_value - _num)]];
		};

		_logEvent = "Took Item from Vehicle";
		if !(_gangID isEqualTo 0) then {
			_logEvent = "Took Item from Gang Vehicle";
		};
		[
			["event",_logEvent],
			["player_id", getPlayerUID player],
			["target", typeOf oev_trunk_vehicle],
			["item", _ctrl],
			["amount", getPos player],
			["location", _num],
			["plate", _plate]
		] call OEC_fnc_logIt;

		_newWeight = (_old select 1) - _weight;
		if (_newWeight < 0) then {_newWeight = 0;};
		oev_trunk_vehicle setVariable["Trunk",[_data,_newWeight],true];
		[oev_trunk_vehicle] call OEC_fnc_vehInventory;
	} else {
		hint localize "STR_NOTF_InvFull";
	};
};
