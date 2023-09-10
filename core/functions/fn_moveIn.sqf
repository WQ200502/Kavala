//	Description: Moves player into vehicle

private["_unit"];
_unit = param [0,ObjNull,[ObjNull]];
if(isNull _unit) exitWith {};

oev_disable_getIn = false;
player moveInCargo (_this select 0);
oev_disable_getOut = true;