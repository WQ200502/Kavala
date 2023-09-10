//  File: fn_isUnitGunner.sqf
//	Author: SaMatra

//	Description: Since gunners are sometimes drivers this determines if they're actual gunners.

if(vehicle _this == _this) exitWith {false};

private ["_veh", "_cfg", "_trts", "_return", "_trt"];
_veh = (vehicle _this);
_cfg = configFile >> "CfgVehicles" >> typeOf(_veh);
_trts = _cfg >> "turrets";
_return = false;

for "_i" from 0 to (count _trts - 1) do {
	_trt = _trts select _i;

	if(getNumber(_trt >> "iscopilot") == 0 && (_veh turretUnit [_i]) == _this) exitWith {
		_return = true;
	};
};

_return;