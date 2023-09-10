//  File: fn_dpFinish.sqf
//	Author: Bryan "Tonic" Boardwine
//	Editor: TheCmdrRex
//	Description: Finishes the  DP Mission and calculates the money earned based
//	on distance between points

private["_dp","_dis","_price"];

params [
	["_dp",ObjNull,[ObjNull]]
];

oev_delivery_in_progress = false;
oev_dp_point = nil;
_dis = round((getPos life_dp_start) distance (getPos _dp));
_price = round(2.4 * _dis);

["DeliverySucceeded",[format[(localize "STR_NOTF_Earned_1"),[_price] call OEC_fnc_numberText]]] call bis_fnc_showNotification;
[
	["event","Finished DP Mission"],
	["player",name player],
	["player_id",getPlayerUID player],
	["value",[_price] call OEC_fnc_numberText],
	["location",getPosATL player]
] call OEC_fnc_logIt;

life_cur_task setTaskState "成功";
player removeSimpleTask life_cur_task;
oev_atmcash = oev_atmcash + _price;
oev_cache_atmcash = oev_cache_atmcash + _price;
systemChat "包裹交付";
