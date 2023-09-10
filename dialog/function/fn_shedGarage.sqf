//  File: fn_shedGarage.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Description: Handles where vehicles spawn in sheds
params [
	["_spawnObject",objNull,[objNull]],
	["_type","",[""]]
];
private ["_gangShed","_gangID"];
_gangShed = false;
if((oev_gang_data select 2) >= 2) then {
	_gangShed = [
		format ["你想使用你的私人车库还是帮派车库？"],
		"生成载具",
		"帮派",
		"私人"
	] call BIS_fnc_guiMessage;
};

private _action = [
	"你想在棚子里还是外面生成？<br/>v生成目前被认为是工作中的过程，可能会产生不良的结果。。。",
	"生成地点",
	"外面",
	"里面"
] call BIS_fnc_guiMessage;

if (_action) then {
	oev_garage_sp = [(typeOf _spawnObject),_spawnObject];
} else {
	oev_garage_sp = [_spawnObject,(getDir _spawnObject)+270];
};

oev_garage_type = _type;
_gangID = _spawnObject getVariable ["bldg_gangid",-2];
[[getPlayerUID player,playerSide,_type,player,_gangShed,_gangID],"OES_fnc_getVehicles",false,false] spawn OEC_fnc_MP;
["Life_impound_menu"] call OEC_fnc_createDialog;
disableSerialization;
ctrlSetText[2802,(localize "STR_ANOTF_QueryGarage")];