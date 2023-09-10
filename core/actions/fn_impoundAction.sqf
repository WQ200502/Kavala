//  File: fn_impoundAction.sqf
//	Author: Bryan "Tonic" Boardwine
//  Modifications: Fusah
//	Description: Impounds the vehicle

private["_vehicle","_type","_time","_price","_vehicleData","_upp","_ui","_progress","_pgText","_cP","_vehicleName","_gangID"];

_vehicle = cursorTarget;
_exit = false;
if(player distance _vehicle > 10) exitWith {};
if !(alive _vehicle) exitWith {hint "这辆车坏了，不能扣押！";};
if(!((_vehicle isKindOf "Car") || (_vehicle isKindOf "Air") || (_vehicle isKindOf "Ship"))) exitWith {};
if(_vehicle getVariable "isBlackwater") exitWith {hint "你只能扣押黑水公司的车辆！";};
_gangID = _vehicle getVariable ["gangID",0];
_vehicleData = _vehicle getVariable["vehicle_info_owners",[]];

if((count _vehicleData == 0) && (_gangID isEqualTo 0)) then {
	// If no owner is found, check dbInfo
	_vehOwner = (_vehicle getVariable["dbInfo",["",-1]])select 0;
	if (_vehOwner isEqualTo "") exitWith {_exit = true};
	// If dbInfo has info, get player and name associated with it
	_obj = objNull;
	{
		if(isPlayer _x && getPlayerUID _x isEqualTo _vehOwner) exitWith {
			_obj = _x;
		};
	}foreach playableUnits;
	_vehicleData pushBack [_vehOwner,_obj getVariable ["realName", name _obj]];
}; //Bad vehicle.
if(_exit) exitWith {deleteVehicle _vehicle};

_gangName = _vehicle getVariable ["gangName",""];
_vehicleName = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
_customName = _vehicle getVariable["customName",""];
_vehicleSide = _vehicle getVariable ["side",""];
_vehicleType = typeof _vehicle;
//private _trunkContent = ((_vehicle getVariable ["Trunk",[[-199],0]]) select 0);


//Form the impound systemChat
_prefix = "";
_body = "";
_suffix = "";
if !(_gangID isEqualTo 0) then {
	_prefix = format["%1 你的帮派",_gangName];
} else {
	_prefix = format["%1 你 ",(_vehicleData select 0) select 1];
};
if !(_customName isEqualTo "") then {
	_body = format['"%1" (%2)正在被扣押 ',_customName,_vehicleName];
} else {
	_body = format["%1 正在被扣押 ",_vehicleName];
};
_suffix = switch (playerSide) do {
    case west: {"扣押者：警察.";};
		case independent: {"扣押者：医生.";};
		case civilian: {"离开生成点";};
};

[0,format["%1%2%3",_prefix,_body,_suffix]] remoteExec ["OEC_fnc_broadcast",-2];
oev_action_inUse = true;
oev_interruptedTab = false;

_upp = localize "STR_NOTF_Impounding";
//Setup our progress bar.
disableSerialization;
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNameSpace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
_progress progressSetPosition 0.01;
_cP = 0.01;

while{true} do {
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

if(player distance _vehicle > 10) exitWith {hint localize "STR_NOTF_ImpoundingCancelled"; oev_action_inUse = false;};
if(!alive player) exitWith {oev_action_inUse = false;};
if (oev_interruptedTab) exitWith {hint "你打断了扣押过程！"; oev_interruptedTab = false; 5 cutText ["","PLAIN DOWN"]; oev_action_inUse = false;};
//_time = _vehicle getVariable "time";
//if(isNil {_time}) exitWith {deleteVehicle _vehicle; hint "This vehicle was hacked in"};
//if((time - _time)  < 120) exitWith {hint "This is a freshly spawned vehicle, you have no right impounding it."};
if({alive _x} count (crew _vehicle) == 0) then {
	switch (true) do {
		case (_vehicle isKindOf "Car"): {_price = (call oev_impound_car);};
		case (_vehicle isKindOf "Ship"): {_price = (call oev_impound_boat);};
		case (_vehicle isKindOf "Air"): {_price = (call oev_impound_air);};
	};

	oev_impound_inuse = true;
	private _stolenReward = 0;
	if ((missionNamespace getVariable ["oev_cop_stolenVehicles", []]) findIf { (_x select 0) isEqualTo _vehicle } >= 0) then {
		_stolenReward = round (0.1 * ((["allVehicles", _vehicleType] call OEC_fnc_vehicleConfig) select 6));
	};
	[[_vehicle,true,player],"OES_fnc_vehicleStore",false,false] spawn OEC_fnc_MP;
	waitUntil {!oev_impound_inuse};
	private _messageTemplate = if (_stolenReward > 0) then {
		"STR_NOTF_HasRecovered"
	} else {
		"STR_NOTF_HasImpounded"
	};
	if !(_gangID isEqualTo 0) then {
		[0,_messageTemplate,true,[profileName,_gangName,_vehicleName]] remoteExecCall ["OEC_fnc_broadcast", -2];
		[
			["event","Gang Vehicle Impounded"],
			["player",name player],
			["player_id",getPlayerUID player],
			["gang_name",_gangName],
			["gang_id",_gangID],
			["vehicle",_vehicleName],
			["position",getPosATL player]
		] call OEC_fnc_logIt;
	} else {
		[0,_messageTemplate,true,[profileName,(_vehicleData select 0) select 1,_vehicleName]] remoteExecCall ["OEC_fnc_broadcast", -2];
		[
			["event","Vehicle Impounded"],
			["player",name player],
			["player_id",getPlayerUID player],
			["target",((_vehicleData select 0) select 1)],
			["target_id",((_vehicleData select 0) select 0)],
			["vehicle",_vehicleName],
			["position",getPosATL player]
		] call OEC_fnc_logIt;
	};
	if (playerSide isEqualTo west) then {
		if !(_vehicleSide isEqualTo "cop") then {
			private _playerPos = getPos player;
			if (_playerPos inPolygon oev_kavalaPoly || _playerPos inPolygon oev_athiraPoly || _playerPos inPolygon oev_sofiaPoly || _playerPos inPolygon oev_pyrgosPoly) then {
				oev_atmcash = oev_atmcash + (6 * _price);
				oev_cache_atmcash = oev_cache_atmcash + (6 * _price);
				hint parseText format["您已扣押%1<br/><br/>您因打扫街道而获得%2元，因在城市而获得%3元奖金！",_vehicleName,_price,(5 * _price)];
			} else {
				oev_atmcash = oev_atmcash + _price;
				oev_cache_atmcash = oev_cache_atmcash + _price;
				hint parseText format["您已扣押%1<br/><br/>你因清理街道而获得%2元！",_vehicleName,_price];
			};
			if (_stolenReward > 0) then {
				[player, _stolenReward, 1, 50, false] call OEC_fnc_splitPay;
			};
		} else {
			hint parseText format["您已扣押%1<br/><br/>你没有收到扣押执法车辆的款项。",_vehicleName];
		};
	} else {
		if (playerSide isEqualTo independent) then {
			if (_vehicleSide isEqualTo "med") then {
				hint parseText format["您已扣押%1<br/><br/>你没有收到扣押医用载具的钱！",_vehicleName];
			} else {
				private _impoundIncrease = switch (["med_impounds"] call OEC_fnc_fetchStats) do {
					case 1: {1.02};
					case 2: {1.04};
					case 3: {1.06};
					case 4: {1.08};
					case 5: {1.10};
					default {1};
				};
				_vehicleDetails = ["allVehicles", _vehicleType] call OEC_fnc_vehicleConfig;
				// 0.05 of vehicle price, max of 15k after bonus
				if(count _vehicleDetails == 0) then {
					_price = 0;
				} else {
					_price = (((_vehicleDetails select 6) * 0.05) * _impoundIncrease) min 15000;
				};
				if((player getVariable["rank",0] isEqualTo 3)) then {
						_price = round (_price / 2);
				};
				oev_atmcash = oev_atmcash + _price;
				oev_cache_atmcash = oev_cache_atmcash + _price;
				hint parseText format["您已扣押%1<br/><br/>你因清理街道而获得%2元！",_vehicleName,_price];
			};
		} else {
			hint parseText format["你已经从刷新点上移除了一个%1",_vehicleName];
		};
	};
} else {
	hint localize "STR_NOTF_ImpoundingCancelled";
};
oev_action_inUse = false;
