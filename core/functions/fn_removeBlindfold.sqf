//  File: fn_removeBlindfold.sqf
//	Author: Serpico
//	Description: Currently only changes the player blindfolded variable

params["_targetPlayer"];

if(oev_action_inUse) exitWith {};
if(isNull _targetPlayer) exitWith {}; //Bad type
if(!simulationEnabled _targetPlayer) exitWith {};
_distance = ((boundingBox _targetPlayer select 1) select 0) + 2;
if(player distance _targetPlayer > _distance) exitWith {}; //Too far
if(!isPlayer _targetPlayer) exitWith {};

_targetPlayer setVariable ["blindfolded",false,true];

if(!([true,"blindfold",1] call OEC_fnc_handleInv)) exitWith {hint "You did not have enough space for the blindfold. It was lost in the wind."};