//  File: fn_searchAction.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Starts the searching process.
private["_unit"];
_unit = param [0,ObjNull,[ObjNull]];
if(isNull _unit) exitWith {};
hint localize "STR_NOTF_Searching";
uiSleep 2;
if(player distance _unit > 5 || !alive player || !alive _unit) exitWith {hint localize "STR_NOTF_CannotSearchPerson"};
[[player],"OEC_fnc_searchClient",_unit,false] spawn OEC_fnc_MP;
oev_action_inUse = true;
