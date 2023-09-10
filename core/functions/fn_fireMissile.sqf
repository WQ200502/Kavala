//	Author: Poseidon
//	Description:
//		Fires a missle at a target.
//		Missle starts at starting location, and aims at the target if it has line of sight.
//		If no line of sight it attempts to maneuver until line of sight is established, then chases target again. NO ESCAPE FROM DE MISSILES
//      [[14621.2,16772.7,5.00143814], "M_Titan_AA_static", 90, vehicle player, 600] spawn OEC_fnc_fireMissile;
// 	Modifications: Fusah

private["_startPos", "_missileType", "_target", "_missile", "_relDirVer"];
_startPos = param [0, [], [[]]];
_missileType = param [1, "", [""]];
_missileSpeed = param [2, 0, [0]];
_target = param [3, objNull, [objNull]];
_radius = param [4, 0, [0]];

if(_startPos isEqualTo [] || _missileType isEqualTo "" || _missileSpeed isEqualTo 0 || _radius isEqualTo 0 || isNull _target || oev_missileActive) exitWith {};

oev_missileActive = true;

for "_i" from 1 to 20 do {
	if(vehicle player != player) then {
		playSound "missileLocking";
	};

	if(_target distance2d _startPos > _radius) exitWith {};

	sleep 0.4;
};

if(_target distance2d _startPos > _radius) exitWith {
	sleep 2;
	oev_missileActive = false;
};

_missile = _missileType createVehicle _startPos;
_missile setPos _startPos;

_maxDuration = time + 17;
_playSound = 0;

// For the added smoke effect :)
[_missile,_maxDuration] spawn{
	private _missile = _this select 0;
	private _flare = objNull;
	while {alive _missile} do {
		if (time > _this select 1 || isNull _missile) exitWith {};
		_flare = "CMflare_Chaff_Ammo" createVehicle getPos (_missile);
		_flare attachTo [_missile,[0,0,0]];
		uiSleep 3;
		deleteVehicle _flare;
	};
};


while{alive _missile} do {
	_targetPosition = getPosASL _target;
	_missilePosition = getPosASL _missile;

	if(!(lineIntersects [_targetPosition , _missilePosition, _target, _missile]) && !(terrainIntersect [getPosATL _missile, getPosATL _target])) then {
		_targetPosition set[2, ((_targetPosition select 2) + 1)];
	}else{
		_targetPosition set[2, ((_targetPosition select 2) + 175)];
	};

	_targetDistance = _missilePosition distance _targetPosition;
	_travelTime = _targetDistance / _missileSpeed;

	_relDirHor = _missilePosition getDir _targetPosition;
	_missile setDir _relDirHor;

	_relDirVer = asin(((_missilePosition select 2) - (_targetPosition select 2)) / (_target distance _missile));
	_relDirVer = (_relDirVer * -1);
	[_missile, [direction _missile, _relDirVer, 0]] call BIS_fnc_setObjectRotation;
	_missileNewVelocity = [((_targetPosition select 0) - (_missilePosition select 0)) / _travelTime, ((_targetPosition select 1) - (_missilePosition select 1)) / _travelTime, ((_targetPosition select 2) - (_missilePosition select 2)) / _travelTime];

	_missile setVelocity _missileNewVelocity;

	if(time > _maxDuration) exitWith {};

	_playSound = _playSound + 1;
	if(_playSound == 2) then {
		if(vehicle player != player) then {
			playSound "missileLocked";
		};
	};

	if(_playSound >= 2) then {
		_playSound = 0;
	};

	if(_target distance2d _startPos > (_radius * 1.1)) exitWith {
		sleep 4;
	};

	sleep 0.07;
};

if(!isNull _missile) then {
	deleteVehicle _missile;
};

oev_missileActive = false;
