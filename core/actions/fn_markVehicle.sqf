// File: fn_markVehicle.sqf
// Author: Trimo
// Description: mark vehicle for anti despawn

if((_this) getVariable["markedForAntiDespawn",false]) exitWith {hint "这辆车已经被标记!";};
if((_this) getVariable["baited",false]) exitWith {hint "你不能坚持标记诱饵车辆!";};
if(oev_markCD > time) exitWith {hint "请稍候再使用标记功能!";};

private _keys = false;
{
	if((getPlayerUID player) isEqualTo (_x select 0)) then {
		_keys = true;
	};
} forEach ((_this) getVariable["vehicle_info_owners",[]]);

oev_markCD = time + 60;

if !(isNull (player getVariable["currMarked",objNull])) then {
	(player getVariable["currMarked",objNull]) setVariable["markedForAntiDespawn",nil,true];
};

player setVariable["currMarked",(_this)];
(_this) setVariable["markedForAntiDespawn",true,true];

if (!(isNull (findDisplay 33000)) && _keys) then {
	[] spawn OEC_fnc_updateKeyChainTab;
};

systemChat format["You have persistence marked this %1. It will not be eligible for despawn until you mark another vehicle or disconnect.",getText(configFile >> "CfgVehicles" >> (typeOf (_this)) >> "displayName")];