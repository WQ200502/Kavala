//  File: fn_pulloutDeadAction.sqf
//	Author: Fusah
//	Description: Does client side stuffs & hands off actual pulling out to the server.

private ["_title","_progressBar","_titleText","_cp","_ui","_exit"];
private _veh = param [0,ObjNull,[ObjNull]];
//if (true) exitWith {hint "This feature is currently disabled."};
_exit = false;
//Some double checks
if (count crew _veh isEqualTo 0) exitWith {hint "这辆车里没有尸体！"};
if !(({alive _x} count crew _veh) isEqualTo 0) exitWith {hint "你不能对车上的活人执行此操作！"};

oev_action_inUse = true;
closeDialog 0;
disableSerialization;
_title = "Pulling out dead bodies";
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNamespace getVariable "life_progress";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;

["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;

while {true} do {
	uiSleep 0.05;
	if(isNull _ui) then {
		5 cutRsc ["life_progress","PLAIN DOWN"];
		_ui = uiNamespace getVariable "life_progress";
		_progressBar = _ui displayCtrl 38201;
		_titleText = _ui displayCtrl 38202;
	};
	_cP = _cP + 0.01;
	_progressBar progressSetPosition _cP;
	_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
	if(_cP >= 1 || !alive player) exitWith {};
	if(oev_interrupted) exitWith {};
	if(isNull _veh || !alive _veh) exitWith {_exit = true};
};

5 cutText ["","PLAIN DOWN"];
[] spawn OEC_fnc_handleAnim;
if (_exit) exitWith {};
if((player getVariable["restrained",false])) exitWith {oev_action_inUse = false};
if (oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false};
//Some triple checks
if (count crew _veh isEqualTo 0) exitWith {hint "这辆车里没有尸体！"; oev_action_inUse = false};
if !(({alive _x} count crew _veh) isEqualTo 0) exitWith {hint "你不能对车上的活人执行此操作！"; oev_action_inUse = false};
[_veh] remoteExec ["OES_fnc_pulloutDead",2,false];
oev_action_inUse = false;
if(_exit) exitWith {titleText["出事了！","PLAIN DOWN"]};
titleText["你把尸体拉出来了！","PLAIN DOWN"];