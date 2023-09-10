//  File: fn_revivePlayer.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Starts the revive process on the player.
#include "..\..\macro.h"
private["_target","_revivable","_targetName","_ui","_progressBar","_titleText","_cP","_title","_shouldExit"];
params [
	["_target", objNull, [objNull]],
	["_isAdminRevive", false, [false]],
	["_isMassRevive", false, [false]]
];
if(isNull _target) exitWith {};
if(oev_newsTeam) exitWith {};
if (_isAdminRevive && { __GETC__(life_adminlevel) < 1 }) exitWith {
	hint "管理权限不足。";
};
if (_isMassRevive && { __GETC__(life_adminlevel) < 1 }) exitWith {
	hint "管理权限不足。";
};
if (_isAdminRevive && alive _target) exitWith {
	hint "你不能复活一个已经活着的玩家。";
};
_shouldExit = false;
if !(_isAdminRevive) then {
	if ((((player distance (getMarkerPos "fed_reserve_1") < 700) && fed_bank getVariable ["chargeplaced",false]) || ((player distance (getMarkerPos "bw_marker") < 700) && life_bwObj getVariable ["chargeplaced",false]) || ((player distance (getMarkerPos "jail_marker") < 700) && jailwall getVariable ["chargeplaced",false])) && ((_target getVariable["epiSide",sideUnknown]) isEqualTo independent)) exitWith {
		hint "你不能在联邦活动中救活其他医生！";
		_shouldExit = true;
	};
};
if(_isAdminRevive && _isMassRevive) then {
	_target setVariable["Revive",false];
};

_revivable = _target getVariable["Revive",false];
if (_revivable) then {
	if (_isAdminRevive && !(_isMassRevive)) then {
		_shouldExit = [
			"此玩家尚未请求肾上腺素或EMS恢复。你确定要复活他们吗？",
			"确认复活",
			"是",
			"否",
			findDisplay 2900
		] call BIS_fnc_guiMessage;
		_shouldExit = !(_shouldExit);
		if !(_shouldExit) then {
			_target setVariable ["Revive", false];
		};
	} else {
		if !(_isMassRevive) then {
			_shouldExit = true;
		};
	};
};
if (_shouldExit) exitWith {};
if ((playerSide isEqualTo independent) && (_target getVariable["hasRequested",0] isEqualTo 0) && !_isAdminRevive) exitWith {hint "此玩家未请求医疗服务！";};
if ((_target getVariable ["maxrevtime",serverTime]) <= serverTime) exitWith {hint "这个玩家已经死了15分钟了。。。";};
if((_target getVariable["jailed",false]) && (oev_actions_cooldown < time)) exitWith {};
if(_target getVariable["jailed",false]) exitWith {
	oev_actions_cooldown = (time + 35);
};

if(_target getVariable ["Reviving",objNull] == player) exitWith {hint localize "STR_Medic_AlreadyReviving";};
if(player distance _target > 3 && !_isAdminRevive) exitWith {}; //Not close enough.

oev_interruptedTab = false; //Tab cancel
_targetName = _target getVariable["name","Unknown"];

if !(_isAdminRevive) then {
	//Fetch their name so we can shout it.
	_title = format[localize "STR_Medic_Progress",_targetName];
	oev_action_inUse = true; //Lockout the controls

	_target setVariable["Reviving",player,true];
	//Setup our progress bar
	disableSerialization;
	5 cutRsc ["life_progress","PLAIN DOWN"];
	_ui = uiNamespace getVariable ["life_progress",displayNull];
	_progressBar = _ui displayCtrl 38201;
	_titleText = _ui displayCtrl 38202;
	_titleText ctrlSetText format["%2 (1%1)...","%",_title];
	_progressBar progressSetPosition 0.01;
	_cP = 0.01;

	["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;

	// Passive Revive Perks
	private _perkTier = ["med_revives"] call OEC_fnc_fetchStats;
	private _cpRateChange = switch (_perkTier) do {
		case 1: {1.02};
		case 2: {1.02};
		case 3: {1.05};
		case 4: {1.05};
		case 5: {1.10};
		case 6: {1.10};
		case 7: {1.15};
		case 8: {1.15};
		case 9: {1.20};
		default {1};
	};
	private _cpRate = 0.01 * _cpRateChange;
	//Lets reuse the same thing!
	while {true} do {
		if ((time - oev_redgull_effect) < (3.5 * 60)) then {
			uiSleep 0.12;
		} else {
			uiSleep 0.15;
		};

		_cP = _cP + _cpRate;
		_progressBar progressSetPosition _cP;
		_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
		if(_cP >= 1 || !alive player) exitWith {};
		if (player getVariable ["downed", false]) exitWith {
			oev_interrupted = true;
		};
		if(oev_interrupted) exitWith {};
		if(player getVariable["restrained",false]) exitWith {};
		if (vehicle player != player) exitWith {oev_interrupted = true;};
		if(player distance _target > 4) exitWith {_badDistance = true;};
		if(_target getVariable["Revive",false]) exitWith {};
		if(_target getVariable["Reviving",objNull] != player) exitWith {};
		if (oev_interruptedTab) exitWith {};
	};

	//Kill the UI display and check for various states
	5 cutText ["","PLAIN DOWN"];
	[] spawn OEC_fnc_handleAnim;
};

if(_target getVariable ["Reviving",objNull] != player && !(_isAdminRevive)) exitWith {hint localize "STR_Medic_AlreadyReviving"};
if (! isNull (_target getVariable ["Reviving", objNull]) && _isAdminRevive && !(_isMassRevive)) then {
	private _confirmed = [
		"已经有人在复活这个人了。你确定要复活他们吗？",
		"确认复活",
		"是",
		"否",
		findDisplay 2900
	] call BIS_fnc_guiMessage;
	_shouldExit = !(_confirmed);
};
if (_shouldExit) exitWith {};
_target setVariable["Reviving",nil,true];
if !(alive player) exitWith {oev_action_inUse = false;};
if(_target getVariable["Revive",false]) exitWith {hint localize "STR_Medic_RevivedRespawned"};
if(player getVariable["restrained",false]) exitWith {oev_action_inUse = false;};
if(!isNil "_badDistance") exitWith {titleText[localize "STR_Medic_TooFar","PLAIN DOWN"]; oev_action_inUse = false;};
if(oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false;};
if (oev_interruptedTab) exitWith {hint "你打断了恢复！"; oev_interruptedTab = false; 5 cutText ["","PLAIN DOWN"]; oev_action_inUse = false;};

if !(_isMassRevive) then {
	[
		["event","Revived Player"],
		["player",name player],
		["player_id",getPlayerUID player],
		["target",_target getVariable ["realname", name _target]],
		["target_id", _target getVariable ["steam64id",""]],
		["player_location", getPos player],
		["target_location", getPos _target]
	] call OEC_fnc_logIt;
};

private _payout = (call oev_revive_fee);
{
	if(player distance (getMarkerPos _x) < 350)exitWith{_payout = _payout + 2500};
} forEach ["rebelOne","rebelTwo","rebelThree","rebelFour"];

if((position player) inPolygon oev_warzonePoly) then {_payout = _payout + 2500};

if !(_isAdminRevive) then {
	if !((((player distance (getMarkerPos "fed_reserve_1") < 700) && fed_bank getVariable ["chargeplaced",false]) || ((player distance (getMarkerPos "bw_marker") < 700) && life_bwObj getVariable ["chargeplaced",false]) || ((player distance (getMarkerPos "jail_marker") < 700) && jailwall getVariable ["chargeplaced",false]))) then {
		if (isNull life_buddyObj) then {
			oev_atmcash = oev_atmcash + _payout;
			oev_cache_atmcash = oev_cache_atmcash + _payout;
		} else {
			if (!([life_buddyPID] call OEC_fnc_isUIDActive) || ((life_buddyObj distance player) > 2000)) exitWith {
				life_buddyObj = objNull;
				life_buddyPID = "";
				hint "好友已不在服务器上或离您太远。正在删除数据。。。你将得到这个复活的单独报酬！";
				oev_atmcash = oev_atmcash + _payout;
				oev_cache_atmcash = oev_cache_atmcash + _payout;
			};
			_payout = round(_payout * 0.5);
			oev_atmcash = oev_atmcash + _payout;
			oev_cache_atmcash = oev_cache_atmcash + _payout;
			[[4,_payout, name player],"OEC_fnc_payPlayer",life_buddyObj,false] spawn OEC_fnc_MP;
		};
	};
};
oev_action_inUse = false;
_target setVariable["Revive",true,true];
_target setVariable["allowEpi",false,true];
[[profileName, _isAdminRevive],"OEC_fnc_revived",_target,false] spawn OEC_fnc_MP;

if !(_isAdminRevive) then {
	if !((((player distance (getMarkerPos "fed_reserve_1") < 700) && fed_bank getVariable ["chargeplaced",false]) || ((player distance (getMarkerPos "bw_marker") < 700) && life_bwObj getVariable ["chargeplaced",false]) || ((player distance (getMarkerPos "jail_marker") < 700) && jailwall getVariable ["chargeplaced",false]))) then {
		["revive",1] call OEC_fnc_statArrUp;
		titleText[format[localize "STR_Medic_RevivePayReceive",_targetName,[_payout] call OEC_fnc_numberText],"PLAIN DOWN"];
		O_stats_revives = O_stats_revives + 1;
	} else {
		["revive",1] call OEC_fnc_statArrUp;
		_payout = _payout * 0.5;
		titleText[format["您已恢复%1，但收到$%2，因为该地区有一个活动的联邦事件。", _targetName,[_payout] call OEC_fnc_numberText],"PLAIN DOWN"];
		O_stats_revives = O_stats_revives + 1;
		oev_atmcash = oev_atmcash + _payout;
		oev_cache_atmcash = oev_cache_atmcash + _payout;
	};
} else {
	[0, format ["%1 被管理员复活。", _targetName]] remoteExecCall ["OEC_fnc_broadcast", independent];
	hint format ["你复活了 %1.", _targetName];
};

[] spawn OEC_fnc_titleNotification;

uiSleep 0.6;
player reveal _target;
