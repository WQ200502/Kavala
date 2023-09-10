//  File: fn_getDPMission.sqf
//	Author: Bryan "Tonic" Boardwine
//	Editor: TheCmdrRex
//	Description: Selects a random DP point for a delivery mission.

private["_dp","_target","_point"];

params [
	["_target",ObjNull,[ObjNull]]
];

_npc = _this select 3;
_dp = selectRandom oev_dp_points;

if(_dp isEqualTo _npc) then {
	_point = oev_dp_points;
	_point deleteAt (_point find _npc);
	_dp = selectRandom _point;
	_point = oev_dp_points;
};

life_dp_start = _target;

oev_delivery_in_progress = true;
oev_dp_point = call compile format["%1",_dp];

_dp = [_dp,"_"," "] call KRON_Replace;
life_cur_task = player createSimpleTask [format["Delivery_%1",oev_dp_point]];
life_cur_task setSimpleTaskDescription [format[localize "STR_NOTF_DPStart",toUpper _dp],"Delivery Job",""];
life_cur_task setTaskState "Assigned";
player setCurrentTask life_cur_task;
["DeliveryAssigned",[format[localize "STR_NOTF_DPTask",toUpper _dp]]] call bis_fnc_showNotification;
systemChat format ["Deliver the package to %1", _dp];

[] spawn{
	waitUntil {!oev_delivery_in_progress || !alive player};
	if(!alive player) then
	{
		life_cur_task setTaskState "Failed";
		player removeSimpleTask life_cur_task;
		["DeliveryFailed",[localize "STR_NOTF_DPFailed"]] call BIS_fnc_showNotification;
		oev_delivery_in_progress = false;
		oev_dp_point = nil;
	};
};