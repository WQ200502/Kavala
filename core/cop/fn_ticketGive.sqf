//  File: fn_ticketGive.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Gives a ticket to the targeted player.
private["_val"];
if(isNil {life_ticket_unit}) exitWith {hint localize "STR_Cop_TicketNil"};
if(isNull life_ticket_unit) exitWith {hint localize "STR_Cop_TicketExist"};
_val = ctrlText 2652;
if(!([_val] call OEC_fnc_isNumeric)) exitWith {hint localize "STR_Cop_TicketNum"};
if((parseNumber _val) > 5000000) exitWith {hint "You can only give tickets less than 5-mil!"};
[[life_ticket_unit,"ticket"],"OEC_fnc_say3D",-2,false] spawn OEC_fnc_MP;
[[0,"STR_Cop_TicketGive",true,[profileName,[(parseNumber _val)] call OEC_fnc_numberText,life_ticket_unit getVariable["realname",name life_ticket_unit]]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
[[player,(parseNumber _val)],"OEC_fnc_ticketPrompt",life_ticket_unit,false] spawn OEC_fnc_MP;
closeDialog 0;