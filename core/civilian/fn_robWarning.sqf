
private["_nearplayers","_logplayers"];
_nearplayers = player nearEntities ["Man", 300];
_logplayers = [];

if (playerSide == west) then
{
	[[player, "Rob_cop",300],"OEC_fnc_playSound",true,false] spawn BIS_fnc_MP;
	{
		if (isPlayer _x && _x != player) then
		{
			_logplayers pushBack ("." + name _x);
			[[0,2],format["警察 %1 在300米内向你发送了警告! 请双手抱头，不要反抗!",name player]] remoteExec ["OEC_fnc_broadcast",_x];
		};
	} forEach _nearplayers;

	[[0,2],"你向 300 米内所有玩家发送了警告"] call OEC_fnc_broadcast;

	["警察 %1 向 %2 发送了警告",name player, _logplayers] call OEC_fnc_logIt;
}
else
{
if (playerSide == independent) then
{
	[[player, "Rob_med",300],"OEC_fnc_playSound",true,false] spawn BIS_fnc_MP;
	{
		if (isPlayer _x && _x != player) then
		{
			_logplayers pushBack ("." + name _x);
			[[0,2],format["医生 %1 在300米内向你发送了医疗警告，请勿攻击医生！",name player]] remoteExec ["OEC_fnc_broadcast",_x];
		};
	} forEach _nearplayers;

	[[0,2],"你向 300 米内所有玩家发送了医疗警告"] call OEC_fnc_broadcast;

	["医生 %1 向 %2 发送了警告",name player, _logplayers] call OEC_fnc_logIt;
}
else
{
	[[player, "Rob_civ",300],"OEC_fnc_playSound",true,false] spawn BIS_fnc_MP;
	{
		if (isPlayer _x && _x != player) then
		{
			_logplayers pushBack ("." + name _x);
			[[0,2],format["%1 在300米内向你发送了打劫警告! 3 秒内按下 TAB 来表示投降!",name player]] remoteExec ["OEC_fnc_broadcast",_x];
		};
	} forEach _nearplayers;

	[[0,2],"你向 300 米内所有玩家发送了打劫警告,劫财不劫命,本次警告有效期为 1 分钟"] call OEC_fnc_broadcast;

	["%1 向 %2 发送了打劫警告",name player, _logplayers] call OEC_fnc_logIt;
};
};