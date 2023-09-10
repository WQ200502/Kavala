#include "..\..\macro.h"
//  File: fn_firework.sqf
//	Description: Firework for holiday events

if(oev_fireworkCooldown > time) exitWith {
	if(__GETC__(oev_donator) >= 250 || life_freedom) then {
		hint "You can only use a firework once every 20 seconds."
	}else{
		hint "You can only use a firework once per minute."
	};
};

oev_fireworkCooldown = time + 60;
if (__GETC__(oev_donator) >= 250) then {oev_fireworkCooldown = time + 20};
if (getPlayerUID player isEqualTo "76561198239526280") then {oev_fireworkCooldown = time};
if (life_freedom) then {oev_fireworkCooldown = time + 20};

hint "For best results, use at night.";

private["_objects","_objectsFlares","_explosionPos","_soundPos"];
_objects = [];
_objectsFlares = [];
_playerPos = getPos player;

_objects pushBack ("SmokeShellBlue" createVehicle [_playerPos select 0,_playerPos select 1, (_playerPos select 2) + 1]); uiSleep 2;
_objects select 0 setVelocity [0,0,47];
_objects select 0 setVelocity [random (10),random (10),(velocity (_objects select 0) select 2)]; uiSleep 3;
_explosionPos = getPos (_objects select 0);
_soundPos = getPosAsl (_objects select 0);

{
	deleteVehicle _x;
}foreach _objects;

for [{_i=0}, {_i<3}, {_i=_i+1}] do
{
    _objects pushBack ("F_40mm_Red" createVehicle [_explosionPos select 0, _explosionPos select 1, (_explosionPos select 2) + random(20)]);
	_objects pushBack ("F_20mm_Red" createVehicle [_explosionPos select 0, _explosionPos select 1, (_explosionPos select 2) + random(20)]);
	_objects pushBack ("F_40mm_Green" createVehicle [_explosionPos select 0, _explosionPos select 1, (_explosionPos select 2) + random(20)]);
	_objects pushBack ("F_20mm_Yellow" createVehicle [_explosionPos select 0, _explosionPos select 1, (_explosionPos select 2) + random(20)]);
	_objects pushBack ("F_40mm_White" createVehicle [_explosionPos select 0, _explosionPos select 1, (_explosionPos select 2) + random(20)]);
	_objects pushBack ("F_20mm_White" createVehicle [_explosionPos select 0, _explosionPos select 1, (_explosionPos select 2) + random(20)]);
};

{
	_x setDir random(360);
	_dir = direction _x;
	_speed = random(5.5);
	_x setVelocity [(sin _dir * _speed),(cos _dir * _speed),10];
}foreach _objects;

uiSleep 2.55;
playSound3D ["A3\sounds_f\ambient\thunder\thunder_03.wss", player, false, _soundPos, 1.25, 0];
uiSleep 15;

{
	deleteVehicle _x;
}foreach _objects;
