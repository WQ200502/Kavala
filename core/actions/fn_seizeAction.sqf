#include "..\..\macro.h"
//  File: fn_seizeAction.sqf
//	Author: Bryan "Tonic" Boardwine
//  Modifications: Fusah
//	Description: Seizing Vehicles
private["_vehicle","_time","_price","_vehicleData","_upp","_ui","_progress","_pgText","_cP","_vehicleDetails","_preSeizeATM","_gangID"];

_vehicle = cursorTarget;
if(player distance _vehicle > 10) exitWith {};
if !(alive _vehicle) exitWith {};
if(!((_vehicle isKindOf "Car") || (_vehicle isKindOf "Air") || (_vehicle isKindOf "Ship"))) exitWith {};
if (typeOf _vehicle in ["O_Truck_03_repair_F","O_Truck_03_ammo_F","B_Truck_01_ammo_F","O_LSV_02_armed_F"]) exitWith {[_vehicle] spawn OEC_fnc_seizeEscort;};
_gangID = _vehicle getVariable ["gangID",0];
_vehicleData = _vehicle getVariable["vehicle_info_owners",[]];
if((count _vehicleData == 0) && (_gangID isEqualTo 0)) exitWith {deleteVehicle _vehicle}; //Bad vehicle.
_gangName = _vehicle getVariable ["gangName",""];
_vehSkin = _vehicle getVariable ["oev_veh_color",[""]] select 0;
_preSeizeATM = 0;
_ownerName = if(_vehicle getVariable ["isBlackwater",false]) then [{""}, {(_vehicleData select 0) select 1}];

_vehName = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
_customName = _vehicle getVariable["customName",""];

//Form the seize systemChat
_prefix = "";
_body = "";
_suffix = "";
if !(_gangID isEqualTo 0) then {
	_prefix = format["%1 your gang's ",_gangName];
} else {
	_prefix = format["%1 your ",_ownerName];
};
if !(_customName isEqualTo "") then {
	_body = format['"%1" (%2)正在被警察扣押。',_customName,_vehName];
} else {
	_body = format["%1正在被警察扣押。",_vehName];
};


if !(_vehicle getVariable ["isBlackwater",false]) then {
	[0,format["%1%2",_prefix,_body]] remoteExec ["OEC_fnc_broadcast",-2];
	oev_action_inUse = true;
	oev_interruptedTab = false;

	_upp = "Seizing Vehicle";
	//Setup our progress bar.
	disableSerialization;
	5 cutRsc ["life_progress","PLAIN DOWN"];
	_ui = uiNameSpace getVariable "life_progress";
	_progress = _ui displayCtrl 38201;
	_pgText = _ui displayCtrl 38202;
	_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
	_progress progressSetPosition 0.01;
	_cP = 0.01;
	while {true} do {
		uiSleep 0.09;
		_cP = _cP + 0.01;
		_progress progressSetPosition _cP;
		_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
		if(_cP >= 1) exitWith {};
		if(player distance _vehicle > 10) exitWith {};
		if(!alive player) exitWith {};
		if (oev_interruptedTab) exitWith {};
	};
	5 cutText ["","PLAIN DOWN"];

	if(player distance _vehicle > 10) exitWith {hint "扣押取消。"; oev_action_inUse = false;};
	if(!alive player) exitWith {oev_action_inUse = false;};
	if (oev_interruptedTab) exitWith {hint "你已经中断了车辆扣押。"; oev_interruptedTab = false; 5 cutText ["","PLAIN DOWN"]; oev_action_inUse = false;};

	if({alive _x} count (crew _vehicle) == 0) then {
		if(!((_vehicle isKindOf "Car") || (_vehicle isKindOf "Air") || (_vehicle isKindOf "Ship"))) exitWith {oev_action_inUse = false;};
		switch (true) do {
			case (_vehicle isKindOf "Car"): {_price = (call oev_impound_car);};
			case (_vehicle isKindOf "Ship"): {_price = (call oev_impound_boat);};
			case (_vehicle isKindOf "Air"): {_price = (call oev_impound_air);};
		};

		[player,_vehicle] remoteExec ["OES_fnc_copSeizeVeh",2];

		_vehicleDetails = ["allVehicles", (typeOf _vehicle)] call OEC_fnc_vehicleConfig;
		if(count _vehicleDetails > 0) then {
			_price = (_vehicleDetails select 6) * 0.3;
		};

		hint format["您已收缴%1",_vehName];
		if !(_gangID isEqualTo 0) then {
			// seized gang vehicle
			[0,format["%1已收缴%2的%3",name player,_gangName,_vehName]] remoteExec ["OEC_fnc_broadcast",-2];
			_preSeizeATM = oev_atmcash;
			[player,_price,1,150] call OEC_fnc_splitPay;
			[
				["event","Vehicle Seize"],
				["player",name player],
				["player_id",getPlayerUID player],
				["gang_name",_gangName],
				["gang_id",_gangID],

				["vehicle",_vehName],
				["location",getPosATL player]
			] call OEC_fnc_logIt;
		} else {
			// seized personal vehicle
			if (_vehSkin isEqualTo "APD Vandal" && (typeOf _vehicle) isEqualTo "C_Hatchback_01_sport_F") then {
				[0,format["%1已收回%2的%3（%4）！将刷一层新漆。",name player,_ownerName,_vehName,_vehSkin]] remoteExec ["OEC_fnc_broadcast",-2];
				[
					["event","Vehicle Seize"],
					["player",name player],
					["player_id",getPlayerUID player],
					["target_name",_ownerName],
					["target_id",(_vehicleData select 0) select 0],
					["vehicle",_vehName],
					["skin",_vehSkin],
					["location",getPosATL player]
				] call OEC_fnc_logIt;
			} else {
				[0,format["%1已收缴%2的%3",name player,(_vehicleData select 0) select 1,_vehName]] remoteExec ["OEC_fnc_broadcast",-2];
				_preSeizeATM = oev_atmcash;
				[player,_price,1,150] call OEC_fnc_splitPay;
				[
					["event","Vehicle Seize"],
					["player",name player],
					["player_id",getPlayerUID player],
					["target_name",_ownerName],
					["target_id",(_vehicleData select 0) select 0],
					["vehicle",_vehName],
					["location",getPosATL player]

				] call OEC_fnc_logIt;
			};
		};
	} else {
		hint "Seizing cancelled.";
	};
} else {
	[0,"黑水公司的车辆正被APD扣押。"] remoteExec ["OEC_fnc_broadcast",-2];
	oev_action_inUse = true;
	oev_interruptedTab = false;
	_upp = "Seizing Vehicle";
	//Setup our progress bar.
	disableSerialization;
	5 cutRsc ["life_progress","PLAIN DOWN"];
	_ui = uiNameSpace getVariable "life_progress";
	_progress = _ui displayCtrl 38201;
	_pgText = _ui displayCtrl 38202;
	_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
	_progress progressSetPosition 0.01;
	_cP = 0.01;
	while {true} do {
		uiSleep 0.09;
		_cP = _cP + 0.01;
		_progress progressSetPosition _cP;
		_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
		if(_cP >= 1) exitWith {};
		if(player distance _vehicle > 10) exitWith {};
		if(!alive player) exitWith {};
		if (oev_interruptedTab) exitWith {};
	};
	5 cutText ["","PLAIN DOWN"];

	if(player distance _vehicle > 10) exitWith {hint "扣押取消。"; oev_action_inUse = false;};
	if(!alive player) exitWith {oev_action_inUse = false;};
	if (oev_interruptedTab) exitWith {hint "你已经中断了车辆扣押。"; oev_interruptedTab = false; 5 cutText ["","PLAIN DOWN"]; oev_action_inUse = false;};

	if({alive _x} count (crew _vehicle) == 0) then {

		deleteVehicle _vehicle;

		_price = 4000000;

		if((typeof _vehicle) in ["B_T_LSV_01_armed_F"]) then {
			_price = 3000000;
		};

		hint format["您已经扣押了黑水公司的车辆并收取了%1元！",[_price] call OEC_fnc_numberText];
		[0,format["%1扣押了黑水公司的车辆",name player]] remoteExec ["OEC_fnc_broadcast",-2];
		_preSeizeATM = oev_atmcash;
		[player,_price,1,150] call OEC_fnc_splitPay;
		[
			["event","BW Vehicle Seize"],
			["player",name player],
			["player_id",getPlayerUID player],
			["vehicle",typeof _vehicle],
			["value",_price],
			["location",getPosATL player]
		] call OEC_fnc_logIt;
	} else {
		hint "扣押取消。";
	};
};
oev_action_inUse = false;
