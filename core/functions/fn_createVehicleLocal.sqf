// File: fn_createVehicleLocal

private["_className","_position","_direction","_vehicle"];
_className = _this param [0,"",[""]];
_position = _this param [1,[],[[]]];
_direction = _this param [2,0,[0,[]]];
_code = _this param [3,"",[""]];

if(_className == "" || _position isEqualTo []) exitWith {};

if(isServer && isDedicated) then {//too lazy to add a param or whatever, makes sure anything made on server everyone can see.
	_vehicle = _className createVehicle [random(100),random(100),random(100)];
}else{
	_vehicle = _className createVehicleLocal [random(100),random(100),random(100)];
};

waitUntil{!isNull _vehicle};

if(isServer && isDedicated) then {
	_vehicle enableSimulation true;
}else{
	_vehicle enableSimulation false;
};

_vehicle allowDamage false;
_vehicle setPosWorld _position;

if(_direction isEqualType []) then {
	_vehicle setDir (_direction select 1);

	if(_vehicle isKindOf "Man") exitWith {};
	[_vehicle,[_direction select 1, _direction select 0, _direction select 2]] call {
		private ["_obj","_rotation","_pitch","_roll","_yaw","_vdir","_vup","_sign"];
		_obj = param [0,objnull,[objnull]];
		_rotation = param [1,[],[[]]];
		_yaw = [_rotation,0,0,[0]] call bis_fnc_paramin;
		_pitch = [_rotation,1,0,[0]] call bis_fnc_paramin;
		_roll = [_rotation,2,0,[0]] call bis_fnc_paramin;
		_yaw = 360 - _yaw;
		_sign = [1,-1] select (_pitch < 0);
		if(_pitch > 180) then {_pitch = -(360 - _pitch);};
		while {abs _pitch > 180} do {_pitch = _sign*(abs _pitch - 180)};
		if(abs _pitch == 90) then {_pitch = _sign*(89.9)};
		if(abs _pitch > 90) then{_roll = _roll + 180;};
		_vdir = [0, cos _pitch, sin _pitch];
		_vdir = [_vdir, _yaw] call BIS_fnc_rotateVector2D;
		_sign = [1,-1] select (_roll < 0);
		while {abs _roll > 360} do {_roll = _sign*(abs _roll - 360)};
		if(abs _roll > 180) then {_sign = -1*_sign; _roll = (360-_roll)*_sign};
		_vup  = [sin _roll, 0, cos _roll];
		_vup =  [_vup,  _yaw] call BIS_fnc_rotateVector2D;
		_obj setVectorDirAndUp [_vdir, _vup];
	};
}else{
	_vehicle setDir _direction;
};
_vehicle setPosWorld _position;

clearBackpackCargo _vehicle;
clearWeaponCargo _vehicle;
clearMagazineCargo _vehicle;
clearItemCargo _vehicle;

if(_code != "") then {
	_vehicle spawn (compile _code);
};

_vehicle;
