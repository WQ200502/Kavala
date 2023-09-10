//  File: fn_storeVehicle.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Stores the vehicle in the garage.

private ["_esc","_vehicle","_nearVehicles","_isGangShed","_storeDistance"];
_storeDistance = param [3, 30, [0]];
_esc = false;
_finished = true;
if ((playerSide isEqualTo civilian || playerSide isEqualTo west) && {((diag_tickTime - oev_inCombatTime) <= 30)} && {((call life_adminlevel) < 2)}) exitWith {
	hint format ["You were recently in combat, please wait %1 seconds.",ceil(-(diag_tickTime - oev_inCombatTime) + 30)];
};


params ["_player","_type"];
if (vehicle player != player) then {
	_vehicle = vehicle player;
} else {
	_nearVehicles = nearestObjects[getPos (_player),["Car","Air","Ship"],_storeDistance]; //Fetch vehicles within 30m.
	if (count _nearVehicles > 0) then {
		if (playerSide isEqualTo civilian) then {
			private _eligibleVehicles = [];
			{
				//Is the user in a gang
				if ((count oev_gang_data) > 0) then {
	    			//Does the vehicle belong to the user's gang?
					if (((_x getVariable ["gangID",0]) isEqualTo (oev_gang_data select 0))) then {
						if (_x getVariable ["isBlackwater", false]) exitWith {_esc = true;};
						_eligibleVehicles pushBack _x;
					} else {
						//Does the vehicle belong to another gang?
						if!((_x getVariable ["gangID",0]) isEqualTo 0) exitWith {};
						if (_x getVariable ["isBlackwater", false]) exitWith {_esc = true;};
						_vehData = _x getVariable["vehicle_info_owners",[]];
						if(count _vehData  > 0) then {
							_vehOwner = (_vehData select 0) select 0;
							if((getPlayerUID player) == _vehOwner) exitWith	{
								_eligibleVehicles pushBack _x;
							};
						};
					};
	    		} else {
	    			//Does the vehicle belong to another gang?
					if!((_x getVariable ["gangID",0]) isEqualTo 0) exitWith {};
					_vehData = _x getVariable["vehicle_info_owners",[]];
					if(count _vehData  > 0) then {
						_vehOwner = (_vehData select 0) select 0;
						if((getPlayerUID player) == _vehOwner) exitWith	{
							_eligibleVehicles pushBack _x;
						};
					};
	    		};
			} foreach _nearVehicles;

			private _vehicleIdx = _eligibleVehicles findIf {
				private _ret = false;
				if ((_x getVariable ["gangID", 0]) isEqualTo (oev_gang_data select 0)) then {
					if (_x getVariable ["oev_hasUsed", false]) then {
						_ret = true;
					};
				} else {
					_ret = true;
				};
				_ret;
			};
			if (_vehicleIdx >= 0) then {
				_vehicle = _eligibleVehicles select _vehicleIdx;
			} else {
				if (count _eligibleVehicles > 0) then {
					_vehicle = _eligibleVehicles select 0;
				};
			};
		} else {
			{
				if(!isNil "_vehicle") exitWith {}; //Kill the loop.
				if (_x getVariable "isBlackwater") exitWith {_esc = true;};
				_vehData = _x getVariable["vehicle_info_owners",[]];
				if(count _vehData  > 0) then {
					_vehOwner = (_vehData select 0) select 0;
					if((getPlayerUID player) == _vehOwner) exitWith	{
						_vehicle = _x;
					};
				};
			} foreach _nearVehicles;
		};
	};
};

if (_esc) exitWith {hint "你得先到黑车店认领车辆！"};
if (isNil "_vehicle") exitWith {hint localize "STR_Garage_NoNPC"};
if (isNull _vehicle) exitWith {};
if !(alive _vehicle) exitWith {hint "这辆车太坏了，不能扣押！";};
if (_this select 0 in [meth_flag,mushroom_flag,moonshine_flag,arms_flag] && typeOf _vehicle in oev_illegal_vehicles) exitWith {hint "你不能在卡特尔储存非法车辆！";};
if (_vehicle getVariable ["dbInfo",["123"]] select 0 isEqualTo "123") exitWith {hint "你不能把袖珍卡丁车存放起来，试着把它打包。";};

if !(_vehicle getVariable ["zlt_ropes",[]] isEqualTo []) then {
	_ropes = (_vehicle getvariable ["zlt_ropes", []]);
	{deletevehicle _x} foreach _ropes;
	_vehicle setvariable ["zlt_ropes", [], true];
};

if ((_vehicle getVariable ["gangID",0]) isEqualTo (oev_gang_data select 0)) then {
	[
		["event","Gang Vehicle Store"],
		["player",name player],
		["player_id",getPlayerUID player],
		["vehicle",getText(configFile >> "CfgVehicles" >> (typeof _vehicle) >> "displayName")],
		["location",getPosATL player]
	] call OEC_fnc_logIt;
} else {
	[
		["event","Vehicle Store"],
		["player",name player],
		["player_id",getPlayerUID player],
		["vehicle",getText(configFile >> "CfgVehicles" >> (typeof _vehicle) >> "displayName")],
		["location",getPosATL player]
	] call OEC_fnc_logIt;
};

if ((count oev_gang_data) > 0) then {
	[[_vehicle,false,_type, (oev_gang_data select 0)],"OES_fnc_vehicleStore",false,false] spawn OEC_fnc_MP;
} else {
	[[_vehicle,false,_type,-1],"OES_fnc_vehicleStore",false,false] spawn OEC_fnc_MP;
};

hint localize "STR_Garage_Store_Server";
oev_garage_store = true;
