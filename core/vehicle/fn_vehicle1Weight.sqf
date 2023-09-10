//  File: fn_vehicle1Weight.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Starting to lose track on shit I wrote a year ago..
private["_vehicle","_weight","_used"];
_vehicle = param [0,ObjNull,[ObjNull]];
if(isNull _vehicle) exitWith {};

_weight = -1;
_used = (_vehicle getVariable "Trunk") select 1;
_weight = ["allVehicles", (typeOf _vehicle)] call OEC_fnc_vehicleConfig;
_weight = (_weight select 9);

if(isNil "_used") then {_used = 0};
[_weight,_used];