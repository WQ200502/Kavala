//  File: fn_requestDenial.sqf
//	Author: Pledge
//	Description: Notifies the medics that someone has requested to be denied

private["_caller","_callerName"];
_caller = param [0,ObjNull,[ObjNull]];
_callerName = param [1,"Unknown Player",[""]];
if(isNull _caller) exitWith {};
if(oev_newsTeam) exitWith {}; //Mirroring this from the other file in case we bring them back

["MedicalRequestEmerg",[format[localize "STR_Denial_Request",_callerName]]] call BIS_fnc_showNotification;