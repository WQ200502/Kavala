//  File: fn_mdFinish.sqf
//	Author: [OS] Odin
//	Editor: TheCmdrRex
//	Description: Finishes the Medic DP Mission and calculates the money earned based
//	on distance between points

private["_dp","_dis","_price"];

params [
	["_dp",ObjNull,[ObjNull]]
];

oev_delivery_in_progress = false;
oev_md_point = nil;
_dis = round((getPos life_md_start) distance (getPos _dp));
_price = round(1.85 * _dis);

["MedDeliverySucceeded",[format[(localize "STR_NOTF_Earned_1"),[_price] call OEC_fnc_numberText]]] call bis_fnc_showNotification;
[
	["event", "Medic DP Finish"],
	["player", name player],
	["player_id", getPlayerUID player],
	["value", _price],
	["location", getPos player]
] call OEC_fnc_logIt;

life_cur_task setTaskState "Succeeded";
player removeSimpleTask life_cur_task;
oev_atmcash = oev_atmcash + _price;
oev_cache_atmcash = oev_cache_atmcash + _price;
systemChat "包裹交付";
