//	File: fn_blindfold.sqf
//	Author: Serpico
//	Description: Applies a blindfold to the

params["_targetPlayer"];

if(oev_action_inUse) exitWith {};
if(isNull _targetPlayer) exitWith {}; //Bad type
if(!simulationEnabled _targetPlayer) exitWith {};
_distance = ((boundingBox _targetPlayer select 1) select 0) + 2;
if(player distance _targetPlayer > _distance) exitWith {}; //Too far
if(!isPlayer _targetPlayer) exitWith {};
if(!(_targetPlayer getVariable["restrained",false])) exitWith {};

if(!([false,"blindfold",1] call OEC_fnc_handleInv)) exitWith {hint "You do not have a blindfold."};

[[cursorTarget],"OEC_fnc_applyBlindfold",_targetPlayer,false] spawn OEC_fnc_MP;
