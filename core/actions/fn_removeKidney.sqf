//	Filename: fn_removeKidney.sqf
//	Author: Serpico
//	Description: Remove a kidney from give player

private ["_upp","_progress","_pgText","_cP","_sleepVal","_victimName","_targetPlayer"];
_targetPlayer = cursorObject;
closeDialog 0;
oev_interrupted = false;
if (isNull _targetPlayer) exitWith {};
if (side _targetPlayer isEqualTo independent) exitWith {hint "你不能收割医生的肾！";};
_victimName = _targetPlayer getVariable["realname",name _targetPlayer];
if (_targetPlayer getVariable ["kidneyRemoved",false]) exitWith {hint format["%1 has already had their kidney removed",_victimName]};
if (!(isNil {_targetPlayer getVariable "lastHarvest"}) && (((_targetPlayer getVariable ["lastHarvest",0]) + 1800) > serverTime)) exitWith {hint format ["This person has already had their kidney removed within the last 30 minutes."];};
if ((group player) isEqualTo (group _targetPlayer)) exitWith {
};
if ((oev_carryWeight + 10) > oev_maxWeight) exitWith {hint "你不能带这个肾！";};
if (!(_targetPlayer getVariable ["zipTied",false])) exitWith {hint "Your victim must be ziptied";};
if (life_inv_scalpel < 1) exitWith {hint "你没有手术刀";};

oev_action_inUse = true;
_targetPlayer setVariable ["kidneyHarvester",player,true];

//Setup our progress bar.
_upp = format["正在从%1中摘取肾脏",_victimName];
disableSerialization;
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNameSpace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
_cP = 0;
_sleepVal = 0.27;

["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;

while {true} do {
	uiSleep _sleepVal;
	_cP = _cP + 0.01;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
	if (_cP >= 1) exitWith {};
	if (!alive player) exitWith {oev_interrupted = true;};
	if (!alive _targetPlayer) exitWith {oev_interrupted = true;};
	if (player != vehicle player) exitWith {};
	if (oev_interrupted) exitWith {};
	if (life_inv_scalpel isEqualTo 0) exitWith {};
	if (_targetPlayer getVariable ["kidneyHarvester",objNull] != player) exitWith {};
};

oev_action_inUse = false;
5 cutText ["","PLAIN DOWN"];
[] spawn OEC_fnc_handleAnim;
if (_targetPlayer getVariable ["kidneyHarvester",objNull] != player) exitWith {hint "已经有人在割肾了！";};
_targetPlayer setVariable ["kidneyHarvester",nil,true];
if (life_inv_scalpel isEqualTo 0) exitWith {hint "你不再有手术刀了";};
if (oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false;};
if (player != vehicle player) exitWith {titleText["您已通过进入车辆取消了操作","PLAIN DOWN"];};

[[_targetPlayer,"kick_balls"],"OEC_fnc_say3D",-2,false] spawn OEC_fnc_MP;
[[profileName],"OEC_fnc_setKidneyStatus",_targetPlayer,FALSE] spawn OEC_fnc_MP;
_targetPlayer setVariable ["lastHarvest",(serverTime + 1800),true];

[true,"kidney",1] call OEC_fnc_handleInv;
[[getPlayerUID player,name player,"61",player],"OES_fnc_wantedAdd",false,false] spawn OEC_fnc_MP;
[[0,"STR_NOTF_KidneyRemoved_1",true, [_victimName,name player]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
[
	["event","Kidney Harvest"],
	["player",name player],
	["player_id",getPlayerUID player],
	["target",name _targetPlayer],
	["target_id",getPlayerUID _targetPlayer],
	["location",getPosATL player]
] call OEC_fnc_logIt;

["kidney",1] call OEC_fnc_statArrUp;
