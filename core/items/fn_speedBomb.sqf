//  File: fn_speedBomb.sqf
//	Author: Fuzz
//  Modifications: Fusah
//	Description: Attaches a speed bomb to a vehicle.

private _vehicle = cursorTarget;

if ((!(_vehicle isKindOf "LandVehicle")) && (!(_vehicle isKindOf "Air")) && (!(_vehicle getVariable ["restrained",false]))) exitWith {hint "You cannot add a speed bomb unit to this."};
if (player distance _vehicle > 7) exitWith {hint "You need to be within 7 feet!"};

closeDialog 0;

oev_action_inUse = true;

[[_vehicle,"carAlarm"],"OEC_fnc_say3D",-2,false] spawn OEC_fnc_MP;
player playMove "AinvPknlMstpSnonWnonDnon_medic_1";
uiSleep 10;
waitUntil {animationState player != "ainvpknlmstpsnonwnondnon_medic_1"};

oev_action_inUse = false;
if (player distance _vehicle > 7) exitWith {titleText["You are not in range to attach a car bomb!","PLAIN DOWN"]};
if(!alive player || oev_isDowned) exitWith {titleText ["You were not able to attach the car bomb!", "PLAIN DOWN"]};
if((player getVariable["restrained",false])) exitWith {titleText ["You were not able to attach the car bomb", "PLAIN DOWN"]};
if (oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]};
if !([false,"speedbomb",1] call OEC_fnc_handleInv) exitWith {};

titleText["You have attached an armed speed bomb to this vehicle.","PLAIN DOWN"];
["speedbomb",1] call OEC_fnc_statArrUp;

[_vehicle] spawn{
	_vehicle = _this select 0;
	waitUntil {(speed _vehicle) > 70};
	hint "A speed bomb you planted on a vehicle has just become active!";
	{[[2,"A speed bomb has been activated on this vehicle and will detonate when your speed drops below 50km/h!"],"OEC_fnc_broadcast",_x,false] spawn OEC_fnc_MP; } foreach (crew _vehicle);
	waitUntil {(speed _vehicle) < 50};

	_test = "Bo_Mk82" createVehicle [0,0,9999];
	_test setPos (getPos _vehicle);
	_test setVelocity [100,0,0];

	{
		_dam_obj = _x;
		_dam_obj setDamage 1;
	} forEach nearestObjects [_vehicle,["Car","Truck","Air","Ship"],12];

	hint "A speed bomb you planted on a vehicle has DETONATED!";
	[0,format["A speed bomb planted by %1 has DETONATED",name player]] remoteExec ["OEC_fnc_broadcast",-2];
};
