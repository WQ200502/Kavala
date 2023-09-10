//  File: fn_medicInvoiceAction.sqf
//	Author: [OS] Odin
//	Description: Starts the medic invoicing process.

private["_unit"];
_unit = param [0,ObjNull,[ObjNull]];
disableSerialization;
["life_invoice_give"] call OEC_fnc_createDialog;

if(isNull _unit || !isPlayer _unit) exitwith {};
ctrlSetText[2651,format[localize "STR_Medic_Invoice",_unit getVariable["realname",name _unit]]];
life_ticket_unit = _unit;