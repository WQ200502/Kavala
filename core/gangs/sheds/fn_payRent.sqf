//  File: fn_payRent.sqf
//	Author: Jesse "tkcjesse" Schultz

//	Description: Pays the rent for a gang building

params [
	["_building",objNull,[objNull]],
	["_payStatus",-1,[0]],
	["_payAmount",-1,[0]]
];
closeDialog 0;
if (_payStatus isEqualTo -1 || _payAmount isEqualTo -1 || isNull _building) exitWith {};
if !((oev_gang_data select 2) >= 3) exitWith {hint "You are not the required rank to pay shed rent!";};
if (_payStatus isEqualTo 2) exitWith {hint "Your rent is already paid for the month, and next month!"};

oev_action_inUse = true;
oev_gangfund_ready = false;
oev_gang_funds = -1;
[[0,oev_gang_data select 0,player],"OES_fnc_gangBank",false,false] spawn OEC_fnc_MP;

waitUntil{oev_gangfund_ready};
uiSleep 0.5;

if (oev_gang_funds < _payAmount) exitWith {hint "You don't have enough money in your gang bank to pay rent!";};
[[player,_building,(typeOf _building),_payStatus,_payAmount,(oev_gang_data select 0),(oev_gang_data select 1)],"OES_fnc_rentPay",false,false] spawn OEC_fnc_MP;

uisleep 3;
oev_action_inUse = false;