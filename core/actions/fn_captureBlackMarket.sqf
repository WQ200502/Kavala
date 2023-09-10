// File: fn_captureBlackMarket.sqf
// Author: Jesse "tkcjesse" Schultz
private _sign = param [0,objNull,[objNull]];
private _market = param [3,"",[""]];

if (isNull _sign || _market isEqualTo "") exitWith {};
if !((typeOf _sign) isEqualTo "Land_SignM_forRent_F") exitWith {};
if ((count oev_gang_data) isEqualTo 0) exitWith {hint "您必须在帮派中占领黑市！";};
if ((_sign getVariable ["owners",-1]) isEqualTo (oev_gang_data select 0)) exitWith {hint "您的团伙已经拥有黑市！";};
if (oev_action_inUse) exitWith {hint "您已经在执行其他操作！"};

oev_action_inUse = true;

private _name = switch (_market) do {
	case "bmOne": {"Cocaine"};
	case "bmTwo": {"Weed"};
	case "bmThree": {"Heroin"};
	case "bmFour": {"Mushroom"};
};

private _ownerID = _sign getVariable ["owners",-1];
if (!(_ownerID isEqualTo -1) && ((_sign getVariable ["notify",0]) <= serverTime)) then {
	private _onlineMembers = ([_ownerID] call OEC_fnc_getOnlineMembers);
	[[3,format["<t color='#ffa700'><t size='1.8'><t align='center'>帮派通知<br/><t color='#ffffff'><t align='center'><t size='1.1'>另一个帮派正在占领你的黑市，占领进度%1！",_name]],"OEC_fnc_broadcast",_onlineMembers,false] spawn OEC_fnc_MP;
	_sign setVariable ["notify",(serverTime + 300),true];
};

_market setMarkerType "mil_warning";
private _playerGangName = oev_gang_data select 1;

disableSerialization;
private _title = "Capturing Black Market";
5 cutRsc ["life_progress","PLAIN DOWN"];
private _ui = uiNamespace getVariable "life_progress";
private _progressBar = _ui displayCtrl 38201;
private _titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
private _cP = 0.01;
private _cpRate = 0.01;

hint "你需要保持在12米以内的才能占领。";

private _exit = false;
while {true} do {
	uiSleep 0.26;
	if(isNull _ui) then {
		5 cutRsc ["life_progress","PLAIN DOWN"];
		_ui = uiNamespace getVariable "life_progress";
		_progressBar = _ui displayCtrl 38201;
		_titleText = _ui displayCtrl 38202;
	};
	_cP = _cP + _cpRate;
	_progressBar progressSetPosition _cP;
	_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
	if (_cP >= 1) exitWith {_market setMarkerType "mil_marker";};
	if !(alive player) exitWith {_exit = true; _market setMarkerType "mil_marker";};
	if !(isNull objectParent player) exitWith {_exit = true; _market setMarkerType "mil_marker";};
	if (player distance _sign > 12) exitWith {_exit = true; hint "你必须呆在标志附近才能占领！"; _market setMarkerType "mil_marker";};
};

//Kill the UI display and check for various states
5 cutText ["","PLAIN DOWN"];
player playMoveNow "stop";
if (_exit) exitWith {oev_action_inUse = false;};

uiSleep round(random(5));
uiSleep round(random(5));

if !(_ownerID isEqualTo -1) then {
	private _onlineMembers = ([_ownerID] call OEC_fnc_getOnlineMembers);
	[[3,format["<t color='#ffa700'><t size='1.8'><t align='center'>紧急通知<br/><t color='#ffffff'><t align='center'><t size='1.1'>另一个帮派占领了你的黑市进度%1！",_name]],"OEC_fnc_broadcast",_onlineMembers,false] spawn OEC_fnc_MP;
};

_sign setVariable ["owners",(oev_gang_data select 0),true];
_sign setVariable ["notify",0,true];
oev_action_inUse = false;
titleText [format["你的帮派现在拥有这个黑市，可以用来加工%1。",_name],"PLAIN DOWN"];
_market setMarkerType "mil_marker";
_market setMarkerText format ["黑市 - %1 (%2)", _name, _playerGangName];
[[3,format["%1黑市已被%2占领！",_name,_playerGangName],false,[]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
