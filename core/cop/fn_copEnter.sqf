//  File: fn_copEnter.sqf
// 	Modifications: Fusah
//	Description: Allows cops to enter and exit locked vehicles

//if(!(playerSide in [west, independent])) exitWith {hint "You cannot enter locked vehicles.";};
private ["_seat","_vehicle"];
_seat = _this select 3;
_vehicle = cursortarget;

if(_seat isEqualTo "exit") then {
	_vehicle = vehicle player;
};

switch (_seat) do {
	case "driver": {
		if (_vehicle distance player > 5) exitWith {hint "You are too far away to enter that vehicle!"};
		_vehicle lock 4;
		player action ["getInDriver", cursorTarget];
		_vehicle lock 2;
	};
	case "passenger": {
		if (_vehicle distance player > 5) exitWith {hint "You are too far away to enter that vehicle!"};
		_vehicle lock 3;
		if ((typeOf cursorTarget) in ["O_LSV_02_unarmed_viper_F", "C_Boat_Transport_02_F"]) then {
				{
					private _open = cursorTarget turretUnit [_forEachIndex];
					if (isNull _open) exitWith {player action ["getInTurret", cursorTarget,_x]};
				} forEach allTurrets [cursorObject,true];
			} else {
				player action ["getInCargo", cursorTarget];
			};
		_vehicle lock 2;
	};
	case "commander": {
		if (_vehicle distance player > 5) exitWith {hint "You are too far away to enter that vehicle!"};
		_vehicle lock 3;
		player action ["GetInCommander", cursorTarget];
		_vehicle lock 2;
	};
	case "exit": {
		if (playerSide isEqualTo civilian) then {
			player action ["getOut", vehicle player];
		} else {
			_vehicle lock 4;
			player action ["getOut", vehicle player];
			_vehicle lock 2;
		};
	};
};

if (playerSide isEqualTo independent) then {[] spawn OEC_fnc_checkMedVehicle;};