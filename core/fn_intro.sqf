//  File: fn_intro.sqf
//	Original Author: HellsGate
//	Date Created: 12/14/2013
//	Description: Creates an intro on the left hand corner of the screen.
//	Notice: Heavily modified by Poseidon, djwolf and Fusah for www.olympus-entertainment.com

private ["_onScreenTime","_role1","_role1names","_role2","_role2names","_role3","_role3names","_role4","_role4names","_role5","_role5names","_role6","_role6names","_role7","_role7names","_role8","_role8names","_role9","_role9names","_role10","_role10names","_role11","_role11names","_role12","_role12names","_role13","_role13names","_role16","_role16names","_memberFunction","_memberNames","_finalText","_role17","_role17names"];

waitUntil{!life_loadingSystemActive};
if(call oev_donator == 0) then {
[parseText format ["<t font='PuristaBold' align='center' size='2.0'><img image='images\VIP.jpg' size='4'></img><t color='#FF69B4'>欢迎玩家</t><t color='#FF0000'>%1</t><t color='#FFE4E1'>进入AMX야채 기계 플레이어의 낙원 생활 옷。</t>", name player],nil,nil,10,nil,0] remoteExec ["BIS_fnc_textTiles",-2];
};

if(call oev_donator == 9000) then {
[parseText format ["<t font='PuristaBold' align='center' size='2.0'><img image='images\icons\vip.paa' size='4'></img><t color='#FFFF00'>欢迎赞助玩家</t><t color='#FF0000'>%1</t><t color='#FFE4E1'>光临AMX야채 기계 플레이어의 낙원 생활 옷，感谢您的支持，祝您游戏愉快。</t>", name player],nil,nil,10,nil,0] remoteExec ["BIS_fnc_textTiles",-2];
};

if(call oev_donator == 900013) then {
[parseText format ["<t font='PuristaBold' align='center' size='2.0'><img image='images\icons\vip.paa' size='4'></img><t color='#FF7AA9'>欢迎全服大佬</t><t color='#FFE4E1'>%1</t><t color='#FFE4E1'>开</t><t color='#FFE4E1'>着</t><t color='#FF9900'>他</t><t color='#1A00FF'>的</t><t color='#00FF99'>保</t><t color='#996633'>时</t><t color='#33CCCC'>捷</t><t color='#CC66CC'>进</t><t color='#B3B300'>入</t><t color='#CC0033'>服务器</t>", name player],nil,nil,10,nil,0] remoteExec ["BIS_fnc_textTiles",-10];
};

if (call oev_civcouncil >= 1) then {player enableFatigue false};
// FORMAT:
// _ROLE# = ["ROLE NAME","HTML COLOR CODE"];
// _ROLE#NAMES = ["NAME1","NAME2"..ECT];
playSound "welcome";
_onScreenTime = 4;
_role1 = ["欢迎来到","#ffd400"];
_role1names = ["AMX菜机的玩家生活服"];
_role2 = ["创始人:","#ff0000"];
_role2names = ["WL.MX"];
_role14 = ["服主:","#daa520"];
_role14names = ["不详"];
_role18 = ["技术:","#00fffa"];
_role18names = ["WL.MX技术组"];
_role3 = ["高级开发人员:","#00fffa"];
_role3names = ["ExtreBlackLiu"];
_role4 = ["开发人员:","#00fffa"];
_role4names = ["AMX团队技术组"];
//_role5 = ["总管理:","#ff0000"];
//_role5names = ["招募"];
//_role6 = ["高级管理员:","#ff0000"];
//_role6names = ["招募"];
//_role7 = ["管理员:","#ff0000"];
//_role7names = ["招募"];
_role8 = ["警队局长:","#15ff00"];
_role8names = [""];
_role17= ["医院院长:","#6c00d0"];
_role17names = [""];
_role16 = ["服务器QQ群:","#6c00d0"];
_role16names = ["QQ群：713722591"];
_role9 = ["YY:","#6c00d0"];
_role9names = ["AMXRPG"];
//_role10 = ["新手管理:","#0050ff"];
//_role10names = ["招募中"];
//_role13 = ["重要的通知:","#ff0000"];
//_role13names = ["AMX001号令”:“主播入驻,帮派入住,请联系我们||警局招募警员."];

{
	uiSleep 2;
	_memberFunction = _x select 0;
	_memberNames = _x select 1;
	_finalText = format ["<t size='1.5' font='PuristaSemiBold' color='%2' align='left'>%1<br /></t>", _memberFunction select 0,_memberFunction select 1];
	_finalText = _finalText + "<t size='1.1' font='EtelkaMonospacePro' color='#FFFFFF' align='left'>";
	{
		_finalText = _finalText + format ["%1<br />", _x];
		} forEach _memberNames;
	_finalText = _finalText + "</t>";
	_onScreenTime + (((count _memberNames) - 1) * 0.9);
	[
		parseText _finalText,
		[safezoneX + 0.05,safezoneY + safezoneH - 1,1,1],
		nil,
		_onScreenTime,
		0.7,
		0
		] spawn BIS_fnc_textTiles;
	uiSleep (_onScreenTime);
} forEach [
	[_role1, _role1names],
	[_role2, _role2names],
	[_role14, _role14names],
	[_role18, _role18names],
	[_role3, _role3names],
	[_role4, _role4names],
	[_role8, _role8names],
	[_role17, _role17names],
	[_role16, _role16names],
	[_role9, _role9names],
	[_role11, _role11names],
];