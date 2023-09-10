#include "..\..\macro.h"
//  File: fn_medicTicketPay.sqf
//	Author: [OS] Odin
//	Description: Pays tickets issued by R&R.

if(isnil {life_ticket_val} || isNil {life_ticket_cop}) exitWith {};
if(oev_cash < life_ticket_val) exitWith
{
	if(oev_atmcash < life_ticket_val) exitWith
	{
		hint localize "STR_Medic_Invoice_NotEnough";
		[[1,"STR_Medic_Invoice_NotEnoughNOTF",true,[profileName]],"OEC_fnc_broadcast",life_ticket_cop,false] spawn OEC_fnc_MP;
		closeDialog 0;
	};
	hint format[localize "STR_Medic_Invoice_Paid",[life_ticket_val] call OEC_fnc_numberText];
	oev_atmcash = oev_atmcash - life_ticket_val;
	oev_cache_atmcash = oev_cache_atmcash - life_ticket_val;
	life_ticket_paid = true;
	[1] call OEC_fnc_ClupdatePartial;
	[[0,"STR_Medic_Invoice_PaidNOTF",true,[profileName,[life_ticket_val] call OEC_fnc_numberText]],"OEC_fnc_broadcast",west,false] spawn OEC_fnc_MP;
	[[1,"STR_Medic_Invoice_PaidNOTF_2",true,[profileName]],"OEC_fnc_broadcast",life_ticket_cop,false] spawn OEC_fnc_MP;
	[[life_ticket_val,player,life_ticket_cop],"OEC_fnc_ticketPaid",life_ticket_cop,false] spawn OEC_fnc_MP;
	closeDialog 0;
};

oev_cash = oev_cash - life_ticket_val;
oev_cache_cash = oev_cache_cash - life_ticket_val;
life_ticket_paid = true;
[0] call OEC_fnc_ClupdatePartial;

[[0,"STR_Medic_Invoice_PaidNOTF",true,[profileName,[life_ticket_val] call OEC_fnc_numberText]],"OEC_fnc_broadcast",west,false] spawn OEC_fnc_MP;
closeDialog 0;
[[1,"STR_Medic_Invoice_PaidNOTF_2",true,[profileName]],"OEC_fnc_broadcast",life_ticket_cop,false] spawn OEC_fnc_MP;
[[life_ticket_val,player,life_ticket_cop],"OEC_fnc_ticketPaid",life_ticket_cop,false] spawn OEC_fnc_MP;