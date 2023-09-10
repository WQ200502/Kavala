//  File: fn_ticketAction.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Starts the ticketing process.
private["_unit"];
_unit = param [0,ObjNull,[ObjNull]];
disableSerialization;
["life_ticket_give"] call OEC_fnc_createDialog;

if(isNull _unit || !isPlayer _unit) exitwith {};
ctrlSetText[2651,format[localize "STR_Cop_Ticket",_unit getVariable["realname",name _unit]]];
life_ticket_unit = _unit;