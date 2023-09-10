//  File: fn_catchTurtle.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Catches a dead turtle?
private _obj = cursorTarget;
if(isNull _obj) exitWith {}; //Not valid
if(alive _obj) exitWith {}; //It's alive, don't take it charlie!
if ((player distance2d (getMarkerPos "turtle_one") > 230) && (player distance2d (getMarkerPos "turtle_two") > 230)) exitWith {hint "你需要在一个海龟偷猎区收集海龟！";};

if([true,"turtle",1] call OEC_fnc_handleInv) then {
	deleteVehicle _obj;
	titleText[localize "STR_NOTF_CaughtTurtle","PLAIN DOWN"];
};