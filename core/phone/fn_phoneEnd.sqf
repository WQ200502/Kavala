/*
	File: fn_phoneEnd.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Phone call has been forcibly closed!
*/
if(life_phone_status ==3)then{hint "您已经挂断语音通话！";};
if(life_phone_status ==1)then{hint "您已经拒绝对方的呼叫请求！";};
life_phone_status = 0;
life_phone_channel = -1;
[player,objNull,true] remoteExecCall ["OES_fnc_managePhone",2];
ctrlEnable [34102,true];