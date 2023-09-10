//  File: fn_warRecieveInv.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Description: sent to opposing gang leader from warSendInv

params [
	["_mode",-1,[0]],
	["_sender",objNull,[objNull]],
	["_invGangID",0,[0]],
	["_invGangName","",[""]]
];
if (isNull _sender || _invGangName isEqualTo "" || _invGangID isEqualTo 0 || _mode isEqualTo -1 || oev_inCasino) exitWith {};
if (!(isNil "life_corpse") && { life_corpse getVariable ["revive", false] }) exitWith {
	[1, "STR_NOTF_NotAlive", true, []] remoteExecCall ["OEC_fnc_broadcast", _sender];
};
[1, "Gang war invitation sent."] remoteExecCall ["OEC_fnc_broadcast", _sender];
if (_invGangID in oev_declinedWars) exitWith {};
if (dialog) then {closeDialog 0;};
oev_declinedWars pushBackUnique _invGangID;

private _action = false;

if (_mode isEqualTo 0) then {
	_action = [
		format["帮派%1想和你的帮派开战。战争将持续到一方决定结束为止。RDM规则不适用于两个帮派之间的交战。你想去打仗吗？",_invGangName],
		"准备好开战了吗？",
		"同意开战",
		"拒绝开战"
	] call BIS_fnc_guiMessage;
};

if (_mode isEqualTo 1) then {
	life_warKey = true;
	hint parseText format ["帮派%1想和你的帮派开战。战争将持续到一方决定结束为止。RDM规则不适用于两个帮派之间的交战。你想去打仗吗？你有1分钟的时间接受或拒绝。<br/><br/>按F8接受<br/>按F9键拒绝",_invGangName];
	private _timer = time + 60;
	waitUntil {uiSleep 1; (!isNil "life_warResponse" || _timer <= time)};
	if (_timer <= time) then {life_warResponse = false;};
	_action = life_warResponse;
	life_warResponse = nil;
};

private _gangID = (oev_gang_data select 0);
private _gangName = (oev_gang_data select 1);


_log_event = "Accepted Gang War";
if (_action) then {
	[[_sender,_invGangID,_invGangName,_gangID,_gangName,player],"OES_fnc_warInsertGang",false,false] spawn OEC_fnc_MP;

	private _enemy = ([_invGangID] call OEC_fnc_getOnlineMembers);
	private _ally = ([_gangID] call OEC_fnc_getOnlineMembers);
	[[_invGangID,_invGangName,0],"OEC_fnc_warStart",_ally,false] spawn OEC_fnc_MP;
	[[_gangID,_gangName,1],"OEC_fnc_warStart",_enemy,false] spawn OEC_fnc_MP;

} else {
	hint "你拒绝了战争邀请。将自动通知另一方。";
	private _enemy = ([_invGangID] call OEC_fnc_getOnlineMembers);
	[[1,format["帮派：%1拒绝了你的战争邀请！",_gangName]],"OEC_fnc_broadcast",_enemy,false] spawn OEC_fnc_MP;
	if !(isNull _sender) then {[[_gangID],"OEC_fnc_warDeclined",_enemy,false] spawn OEC_fnc_MP;};

	_log_event = "Declined Gang War";
};

[
	["event",_log_event],
	["player",name player],
	["player_id",getPlayerUID player],
	["gang",_gangName],
	["gang_id",_gangID],
	["target_gang",_invGangName],
	["target_gang_id",_invGangID],
	["invite_sender",name _sender],
	["invite_sender_id",getPlayerUID _sender]
] call OEC_fnc_logIt;
