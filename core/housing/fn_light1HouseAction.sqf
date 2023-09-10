//	Author: Bryan "Tonic" Boardwine
//	Description: Lights up the house.

private["_house"];
_house = param [0,ObjNull,[ObjNull]];
if(isNull _house) exitWith {};
if(!(_house isKindOf "House_F")) exitWith {};

if(isNull (_house getVariable ["lightSource",ObjNull])) then {
	[[_house,true],"OEC_fnc_lightHouse",true,false] spawn OEC_fnc_MP;
} else {
	[[_house,false],"OEC_fnc_lightHouse",true,false] spawn OEC_fnc_MP;
};