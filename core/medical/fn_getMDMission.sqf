//  File: fn_getMDMission.sqf
//	Author: [OS] Odin
//	Editor: TheCmdrRex
//	Description: Selects a random Medic DP point for a delivery mission.

private["_md","_target","_point"];

params [
	["_target",ObjNull,[ObjNull]]
];

_npc = _this select 3;
_md = selectRandom oev_md_points;

if(_md isEqualTo _npc) then {
	_point = oev_md_points;
	_point deleteAt (_point find _npc);
	_md = selectRandom _point;
	_point = oev_md_points;
};

life_md_start = _target;

oev_delivery_in_progress = true;
oev_md_point = call compile format["%1",_md];

_md = [_md,"_"," "] call KRON_Replace;
life_cur_task = player createSimpleTask [format["Delivery_%1",oev_md_point]];
life_cur_task setSimpleTaskDescription [format[localize "STR_NOTF_DPStart",toUpper _md],"Delivery Job",""];
life_cur_task setTaskState "Assigned";
player setCurrentTask life_cur_task;
["MedDeliveryAssigned",[format[localize "STR_NOTF_DPTask",toUpper _md]]] call bis_fnc_showNotification;
systemChat format ["Deliver the package to %1", _md];

[] spawn{
	waitUntil {!oev_delivery_in_progress || !alive player};
	if(!alive player) then
	{
		life_cur_task setTaskState "Failed";
		player removeSimpleTask life_cur_task;
		["MedDeliveryFailed",[localize "STR_NOTF_DPFailed"]] call BIS_fnc_showNotification;
		oev_delivery_in_progress = false;
		oev_md_point = nil;
	};
};
