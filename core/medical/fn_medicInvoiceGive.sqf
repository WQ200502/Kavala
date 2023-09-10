//  File: fn_medicTicketGive.sqf
//	Author: [OS] Odin

//	Description: Gives an invoice to the targeted player.

private["_val"];
if(isNil {life_ticket_unit}) exitWith {hint localize "STR_Medic_InvoiceNil"};
if(isNull life_ticket_unit) exitWith {hint localize "STR_Medic_InvoiceExist"};
if(life_ticket_unit getVariable ["restrictions", false]) exitWith {hint "This player is under player restrictions and cannot recieve money transfers.";};
if(call oev_restrictions) exitWith {hint "You are under player restrictions and cannot perform this action! Contact an administrator if you feel this is an error.";};
_val = ctrlText 2652;
if(!([_val] call OEC_fnc_isNumeric)) exitWith {hint localize "STR_Medic_InvoiceNum"};
if((parseNumber _val) > 5000000) exitWith {hint "You can only give invoices less than 5 million!"};
[[life_ticket_unit,"ticket"],"OEC_fnc_say3D",-2,false] spawn OEC_fnc_MP;
[[0,"STR_Medic_InvoiceGive",true,[profileName,[(parseNumber _val)] call OEC_fnc_numberText,life_ticket_unit getVariable["realname",name life_ticket_unit]]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
[[player,(parseNumber _val)],"OEC_fnc_medicInvoicePrompt",life_ticket_unit,false] call OEC_fnc_MP;
closeDialog 0;