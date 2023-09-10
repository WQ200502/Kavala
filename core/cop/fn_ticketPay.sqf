//  File: fn_ticketPay.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Pays the ticket.
if(isnil {life_ticket_val} || isNil {life_ticket_cop}) exitWith {};

if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",name player],["player_id",getPlayerUID player],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)],["location",getPosATL player]] call OEC_fnc_logIt;
	[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

if(oev_cash < life_ticket_val) exitWith {
	if(oev_atmcash < life_ticket_val) exitWith	{
		hint localize "STR_Cop_Ticket_NotEnough";
		[[1,"STR_Cop_Ticket_NotEnoughNOTF",true,[profileName]],"OEC_fnc_broadcast",life_ticket_cop,false] spawn OEC_fnc_MP;
		closeDialog 0;
		[
			["event","Could Not Pay Ticket"],
			["player",name player],
			["player_id",getPlayerUID player],
			["officer",name life_ticket_cop],
			["officer_id",getPlayerUID life_ticket_cop],
			["amount",life_ticket_val],
			["position",getPosATL player]
		] call OEC_fnc_logIt;
	};
	hint format[localize "STR_Cop_Ticket_Paid",[life_ticket_val] call OEC_fnc_numberText];
	oev_atmcash = oev_atmcash - life_ticket_val;
	oev_cache_atmcash = oev_cache_atmcash - life_ticket_val;
	life_ticket_paid = true;
	["ticketpaid",1] call OEC_fnc_statArrUp;
	["ticketval",life_ticket_val] call OEC_fnc_statArrUp;
	[1] call OEC_fnc_ClupdatePartial;
	[[0,"STR_Cop_Ticket_PaidNOTF",true,[profileName,[life_ticket_val] call OEC_fnc_numberText]],"OEC_fnc_broadcast",west,false] spawn OEC_fnc_MP;
	[[1,"STR_Cop_Ticket_PaidNOTF_2",true,[profileName]],"OEC_fnc_broadcast",life_ticket_cop,false] spawn OEC_fnc_MP;
	[[life_ticket_val,player,life_ticket_cop],"OEC_fnc_ticketPaid",life_ticket_cop,false] spawn OEC_fnc_MP;
	[[getPlayerUID player],"OES_fnc_wantedRemove",false,false] spawn OEC_fnc_MP;
	[
		["event","Paid Ticket"],
		["player",name player],
		["player_id",getPlayerUID player],
		["officer",name life_ticket_cop],
		["officer_id",getPlayerUID life_ticket_cop],
		["amount",life_ticket_val],
		["position",getPosATL player]
	] call OEC_fnc_logIt;
	closeDialog 0;
};

oev_cash = oev_cash - life_ticket_val;
oev_cache_cash = oev_cache_cash - life_ticket_val;
life_ticket_paid = true;

[0] call OEC_fnc_ClupdatePartial;

["ticketpaid",1] call OEC_fnc_statArrUp;
["ticketval",life_ticket_val] call OEC_fnc_statArrUp;

[[getPlayerUID player],"OES_fnc_wantedRemove",false,false] spawn OEC_fnc_MP;
[[0,"STR_Cop_Ticket_PaidNOTF",true,[profileName,[life_ticket_val] call OEC_fnc_numberText]],"OEC_fnc_broadcast",west,false] spawn OEC_fnc_MP;
closeDialog 0;
[[1,"STR_Cop_Ticket_PaidNOTF_2",true,[profileName]],"OEC_fnc_broadcast",life_ticket_cop,false] spawn OEC_fnc_MP;
[[life_ticket_val,player,life_ticket_cop],"OEC_fnc_ticketPaid",life_ticket_cop,false] spawn OEC_fnc_MP;
[
	["event","Paid Ticket"],
	["player",name player],
	["player_id",getPlayerUID player],
	["officer",name life_ticket_cop],
	["officer_id",getPlayerUID life_ticket_cop],
	["amount",life_ticket_val],
	["position",getPos player]
] call OEC_fnc_logIt;
