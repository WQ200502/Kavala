/*
	File: fn_phoneCall.sqf
	Author: NGC TEAM ADD
	Description:
	Initiate or receive a phone call.
*/
private ["_init","_unit","_callStart"];
_init = [_this,0,true,[true]] call BIS_fnc_param;
_unit = [_this,1,objNull,[objNull]] call BIS_fnc_param;

if (isNull _unit) exitWith
{
	_to = objNull;
	_to = call compile format["%1",(lbData[34101,(lbCurSel 34101)])];
	if (isNull _to) exitWith {};
	[true,_to] spawn OEC_fnc_phoneCall;
};
if (life_phone_status != 0) exitWith {hint "您正处于一通语音通话当中，操作失败！"};

_callStart = time;

if (_init) then
{
	if (life_phone_channel > -1) exitWith {};
	life_phone_status = 2;
	[[0,2], format["正在呼叫 %1...", name _unit ]] call OEC_fnc_broadcast;
	[false,player] remoteExec ["OEC_fnc_phoneCall",_unit,false];
	while {life_phone_status == 2} do
	{
		if (life_phone_channel > -1) exitWith { life_phone_status = 3 };
		if (time - _callStart > 60) exitWith { life_phone_status = 0 };
		playSound "phonedial";
		sleep 4;
	};
	if (life_phone_status == 0) then { [[0,2], format["%1 电话暂时无人接听.", name _unit ]] call OEC_fnc_broadcast; };
	if (life_phone_status == 3 || life_phone_channel > -1) then { [[0,2], format["%1 电话已经接通.", name _unit ]] call OEC_fnc_broadcast; };
	ctrlEnable [34102,false];
}
else
{
	life_phone_status = 1;
	[[0,2], format["%1 正在给你打电话，你可以按9接听，按8拒绝！", name _unit ]] call OEC_fnc_broadcast;
	while {life_phone_status == 1} do
	{
		if (time - _callStart > 55) exitWith { life_phone_status = 0 };
		if (life_phone_status == 1) then { playSound "phonering"; };
		sleep 3;
	};
	if (life_phone_status == 3) then
	{
		[_unit,player] remoteExec ["OES_fnc_managePhone",2];
		
	};
	ctrlEnable [34102,false];
};