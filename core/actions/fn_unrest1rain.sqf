//  File: fn_unrest1rain.sqf
private["_unit"];
_unit = param [0,ObjNull,[ObjNull]];
if(isNull _unit || !(_unit getVariable["restrained",false])) exitWith {}; //Error check?

_unit setVariable["restrained",false,true];
_unit setVariable["zipTied",false,true];
_unit setVariable["Escorting",false,true];
_unit setVariable["transporting",false,true];
_unit setVariable["restrainedBy",[objNull,0],true];
_unit setVariable["beingRobbed",nil,true];
oev_inCasino = false;
detach _unit;

[[0,"STR_NOTF_Unrestrain",true,[_unit getVariable["realname",name _unit], profileName]],"OEC_fnc_broadcast",west,false] call OEC_fnc_MP;
