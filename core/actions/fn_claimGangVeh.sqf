//  File: fn_claimGangVeh.sqf
//	Author: Jesse "tkcjesse" Schultz
// 	Modified by: Kurt
//	Description: Used for adding vehicles to the gang's garage.

params [
	["_building",objNull,[objNull]]
];
private ["_esc","_vehName","_vehicle","_nearVehicles","_vehData","_vehOwner"];

_esc = false;
if (isNull _building) exitWith {};
if !(playerSide isEqualTo civilian) exitWith {};
if (vehicle player != player) exitWith {};

_vehicle = objNull;
oev_garageCount = -1;
[player] remoteExec ["OES_fnc_checkGangVehicleLimit",2];
waitUntil {!(oev_garageCount isEqualTo -1)};

_nearVehicles = nearestObjects[getPos (_this select 0),["Car","Truck","Armored"],30]; //Fetch vehicles within 30m.
if (count _nearVehicles > 0) then {
	{
		//Does the vehicle belong to a gang?
		if ((_x getVariable ["gangID",0]) isEqualTo 0) then {
			//Is the vehicle an unclaimed BW vehicle?
			if (_x getVariable "isBlackwater") exitWith {_esc = true;};
			//Is the vehicle an escort vehicle?
			if (_x getVariable ["isEscort",false]) exitWith {_esc = true;};
			//Does the person own the vehicle?
			_vehData = _x getVariable["vehicle_info_owners",[]];
			if(count _vehData  > 0) then {
				_vehOwner = (_vehData select 0) select 0;
				if((getPlayerUID player) == _vehOwner) exitWith	{
					_vehicle = _x;
				};
			};
		};
	} forEach _nearVehicles;
};
if(oev_garageCount >= 25) exitWith {hint "你的帮派车库已经满了，不能再容纳任何车辆了！";};
if (_esc) exitWith {hint "这是一辆无人驾驶的车！";};
if (isNull _vehicle) exitWith {hint "你附近没有车！"};
_vehName = getText(configFile >> "CfgVehicles" >> (typeof _vehicle) >> "displayName");
if (_vehicle getVariable ["rekey",false]) exitWith {hint "这辆车已经被添加到你的帮派车库了！";};
//Confirmation
private _action = [
	format["是否确实要将%1添加到帮派车库？", _vehName],
	"添加到帮派车库",
	"是",
	"否"
] call BIS_fnc_GUImessage;

if (_action) then {
	if (_vehicle getVariable ["rekey",false]) exitWith {hint "这辆车已经被添加到你的帮派车库了！";};
	oev_action_inUse = true;
	life_claim_done = false;
	life_claim_success = false;
	hint "正在更换车辆锁。。。";

	[_vehicle,player,(oev_gang_data select 0)] remoteExec ["OES_fnc_gangClaim",2];

	waitUntil {life_claim_done};

	oev_action_inUse = false;
	if !(life_claim_success) exitWith {
		life_claim_done = false;
		life_claim_success = false;
		hint "此时车辆无法转移到帮派车库。";
	};

	life_claim_success = false;
	life_claim_done = false;
	hint format ["您的%1已添加到您的帮派车库！",_vehName];
};