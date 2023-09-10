#include <zmacro.h>
//if(scriptAvailable(15)) exitWith {};

//	Original code by KillzoneKid, remade by Poseidon.
//	[player, "", 0, player, ""] spawn OEC_fnc_forceRagdoll;

private["_unit","_damage","_source","_projectile","_part","_curWep"];
_unit = _this select 0;
_part = _this select 1;
_damage = _this select 2;
_source = _this select 3;
_projectile = _this select 4;

if (vehicle _unit != _unit || isNull _source) exitWith {};

_launchDirection = getdir _source;
_unitPos = getPosASL _unit;
_force = 1000;
_velocity = 50;

_dir = getdir player;

_unit allowDamage false;

_o = "Steel_Plate_L_F" createVehicleLocal [0, 0, 0];
_o setObjectTexture [0, ""];

{
	if(_x != _unit) then {
		_o disableCollisionWith _x;
	};
}foreach ((position _unit) nearEntities [["Car","Air","Ship","Armored","Submarine","Man"], 25]);

_hitHeight = ((((boundingBox _unit) select 1) select 2) / 2);
if(_part in ["face_hub","neck","head","pelvis","spine1","spine2","spine3","body","arms","hands","legs"]) then {
	_hitHeight = (player selectionPosition _part) select 2;
};

_o setMass _force;
_o setDir _launchDirection;
_o setPosASL [(_unitPos select 0) + sin(_launchDirection + 180), (_unitPos select 1) + cos(_launchDirection + 180), (_unitPos select 2) + _hitHeight];
_o setVelocity [(sin(_launchDirection)) * _velocity, (cos(_launchDirection)) * _velocity, 1];

sleep 0.25;

deleteVehicle _o;

sleep 5;

_unit allowDamage true;