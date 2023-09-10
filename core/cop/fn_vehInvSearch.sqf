#include "..\..\macro.h"
//  File: fn_vehInvSearch.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Searches the vehicle for illegal items.

private ["_vehicle","_vehicleInfo","_value","_invs","_illegal","_inv","_trunkContent","_trunkWeight","_gangID","_gangName"];
_vehicle = cursorTarget;
_player = player;
_targetName = "";
if(isNull _vehicle) exitWith {};
if(!((_vehicle isKindOf "Air") || (_vehicle isKindOf "Ship") || (_vehicle isKindOf "LandVehicle"))) exitWith {};
if !(alive _vehicle) exitWith {hint "这辆车被毁，无法搜索。";};
if (getDammage _vehicle >= .95) exitWith {hint "这辆车损坏得无法搜查。先修一下！";};

private _action = [
	format ["确定要搜索车辆清单吗？"],
	"Confirmation",
	"Yes",
	"No"
] call BIS_fnc_guiMessage;

if (_action) then {
	_vehicleInfo = _vehicle getVariable ["Trunk",[]];
	private _vehicleData = _vehicle getVariable["vehicle_info_owners",[]];
	if(count _vehicleInfo isEqualTo 0) exitWith {hint localize "STR_Cop_VehEmpty"};
	_gangID = _vehicle getVariable ["gangID",0];
	_gangName = _vehicle getVariable ["gangName",""];
	_value = 0;

	if (typeName ((_vehicleData select 0) select 1) isEqualTo "ARRAY") then {
		_targetName = ((_vehicleData select 0) select 1) select 0;
	} else {
		_targetName = ((_vehicleData select 0) select 1);
	};

	if (count _vehicleInfo isEqualTo 0) exitWith {
		if !(_gangID isEqualTo 0) then {
			[
				["event","APD Gang Veh Search"],
				["player",name player],
				["player_id",getPlayerUID player],
				["gang",_gangName],
				["gang_id",_gangID],
				["amount",[_value] call OEC_fnc_numberText],
				["position",getPosATL player]
			] call OEC_fnc_logIt;
		} else {
			[
				["event","APD Veh Search"],
				["player",name player],
				["player_id",getPlayerUID player],
				["target",_targetName],
				["target_id",((_vehicleData select 0) select 0)],
				["amount",[_value] call OEC_fnc_numberText],
				["position",getPosATL player]
			] call OEC_fnc_logIt;
		};
	};

	_invs = [];
	_trunkContent = _vehicleInfo select 0;
	_trunkWeight = _vehicleInfo select 1;
	{
		_var = _x select 0;
		_val = _x select 1;
		_index = [_var,oev_illegal_items] call OEC_fnc_index;

		if(_index != -1) then {
			_value = _value + (_val * (((oev_illegal_items) select _index) select 1));
			_trunkContent = _trunkContent - [_x];
			_trunkWeight = _trunkWeight - ([_var] call OEC_fnc_itemWeight) * _val;
			_invs pushBack [_x select 0,_val];
		};
	} foreach (_trunkContent);
//Scuffed
_officers = [];
_copSplits = [];
{
	if (side _x isEqualTo west && {_x distance _player < 150}) then {_officers pushBack _x;};
} forEach playableUnits;
_split = ceil _value;
if !(count _officers isEqualTo 0) then {
	_split = ceil(_split / count _officers);
};
{
	_copLevel = _x getVariable ["rank",0];
	_moneyReduction = switch (_copLevel) do {
		case 1: {0.4};
		case 2: {0.65};
		case 3: {0.85};
		default {1};
	};
	_split = _split * _moneyReduction;
	_copSplits pushback (compile (format['"player_id":"%1", "rank": %3, "value": %2',getPlayerUID _x, round _split, _copLevel]));
} forEach _officers;
	_illegal = 0;
	_inv = "";
	if(_value > 0) then {
		{
			_inv = _inv + format["%2 x%1<br/>",_x select 1,[([_x select 0,0] call OEC_fnc_varHandle)] call OEC_fnc_varToStr];
		} foreach _invs;

		hint parseText format["<t color='#FFD700'><t size='1.5'>" + (localize "STR_Cop_IllegalItems") + "</t></t><br/>%1",_inv];
		if !(_gangID isEqualTo 0) then {
			[
				["event","APD Gang Veh Search"],
				["player",name player],
				["player_id",getPlayerUID player],
				["gang",_gangName],
				["gang_id",_gangID],
				["amount",[_value] call OEC_fnc_numberText],
				["position",getPosATL player],
				["payouts",_copSplits]
			] call OEC_fnc_logIt;
		} else {
			[
				["event","APD Veh Search"],
				["player",name player],
				["player_id",getPlayerUID player],
				["target",_targetName],
				["target_id",((_vehicleData select 0) select 0)],
				["amount",[_value] call OEC_fnc_numberText],
				["position",getPosATL player],
				["payouts",_copSplits]
			] call OEC_fnc_logIt;
		};

		[player,_value,1,150,true] call OEC_fnc_splitPay;
		[0,"STR_NOTF_VehContraband",true,[[_value] call OEC_fnc_numberText]] remoteExec ["OEC_fnc_broadcast",-2];
		_vehicle setVariable["Trunk",[_trunkContent,_trunkWeight],true];
		[_vehicle] call OEC_fnc_vehInventory;
	} else {
		hint localize "STR_Cop_NoIllegalVeh";
		if !(_gangID isEqualTo 0) then {
			[
				["event","APD Gang Veh Search"],
				["player",name player],
				["player_id",getPlayerUID player],
				["gang",_gangName],
				["gang_id",_gangID],
				["amount",'0'],
				["position",getPosATL player]
			] call OEC_fnc_logIt;
		} else {
			[
				["event","APD Veh Search"],
				["player",name player],
				["player_id",getPlayerUID player],
				["target",_targetName],
				["target_id",((_vehicleData select 0) select 0)],
				["amount",'0'],
				["position",getPosATL player],
				["payouts",_copSplits]
			] call OEC_fnc_logIt;
		};
	};
};
