#include "..\..\macro.h"
if(scriptAvailable(10)) exitWith {hint "你不能垃圾邮件抢劫。不错的尝试。。。";};
//  File: fn_robShops.sqf
//	Author: MrKraken
//	Made from MrKrakens bare-bones shop robbing tutorial on www.altisliferpg.com forums
//	Description: Executes the rob shob action!
//	Idea developed by PEpwnzya v2.0

private["_robber","_shop","_payout","_ui","_progress","_pgText","_cP","_rip","_shopPos","_markerName"];
_shop = param [0,ObjNull,[ObjNull]]; //The object that has the action attached to
_robber = param [1,ObjNull,[ObjNull]]; //Player robbing store
_action = param [2]; // addAction index

// Initialize variables
_rip = _shop getVariable "status";
if (isNil "_rip") then {
	_rip = false;
	_shop setVariable["status", _rip, true];
};
_shopPos = getPos _shop;
_markerName = format["storeRobery_%1",_shopPos];
_serverCheckDelay = 300; // 50 seconds more than the time it takes to rob a store

// Check if the shop has been robbed recently
_lastRobbed = _shop getVariable ["lastRobbed",(serverTime - 900)];
if ((serverTime - _lastRobbed) < 900) exitWith {
	hint "这家商店最近被抢了，没钱了。";
};

//  Check if robbery can be done
if(vehicle player != _robber) exitWith { hint "你得下车！"; };
if (_robber getVariable ["restrained",true]) exitWith {};
if !(alive _robber) exitWith { hint "死了不能抢劫加油站。"; };
if (currentWeapon _robber == "" || currentWeapon _robber in oev_fake_weapons) exitWith { hint "SB赶紧滚！有了枪在和我说话！"; };
if (playerSide isEqualTo west) exitWith { hint "你穷疯了吧！警察还来抢劫加油站！"; };
if(_rip) exitWith {
	hint "一个抢劫案正在发生！";
};

hint "Intimidating clerk...";
//prevent people from robbing at same time.
uiSleep round(random 4);

// Set store state as being robbed
_rip = true;
_shop setVariable["status",_rip,true];
_shop setVariable["lastRobbed",serverTime,true];

// Start server side function to cleanup in the event a player disconnected.
[[_shop,_markerName,_serverCheckDelay],"OEC_fnc_robShopReset",false,false] spawn OEC_fnc_MP;


// getting cops online
_copsCount = {side _x isEqualTo west} count playableUnits;

_payout = if (_copsCount > 5) then [{85000}, {35000 + (_copsCount * 10000)}];

// Create a unique marker to indicate this shop is being robbed
_marker = createMarker [_markerName, _shopPos];
_markerName setMarkerColor "ColorOrange";
_markerName setMarkerText "!危险！抢劫正在进行！危险！";
_markerName setMarkerType "mil_warning";

// Time to notify the cops about the robbery. In the dispatch, the name of the nearest city is included
_nearestCity = nearestLocation [ _shopPos, "nameCity"];
[[1,format["%1正在抢劫%2城市附近的加油站！", name player,text _nearestCity]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
hint parseText "请记住，加油站抢劫不是一个KOS地区！<br/>你必须坚持到底！";
//Setup our progress bar.
disableSerialization;
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNameSpace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["抢劫正在进行中, 你必须呆在 (10m)之内 (1%1)...","%"];
_progress progressSetPosition 0.01;
_cP = 0.01;
private _precash = oev_cash;
private _prebank = oev_atmcash;

if(_rip) then {
	while{true} do {
		//_shop removeAction _action;
		uiSleep  2.50;
		_cP = _cP + 0.01;
		_progress progressSetPosition _cP;
		_pgText ctrlSetText format["抢劫正在进行，你必须呆在 (10m) 之内(%1%2)...",round(_cP * 100),"%"];
		if(_cP >= 1) exitWith {};
		if(_robber distance _shop > 10) exitWith {};
		if!(alive _robber) exitWith {};
		if (_robber getVariable ["restrained",true]) exitWith {5 cutText ["","PLAIN DOWN"];};
		playSound3D ["A3\Sounds_F\sfx\alarm_independent.wss", player];
	};

	deleteMarker _markerName;
	if!(alive _robber) exitWith {};
	if (_robber getVariable ["restrained",true]) exitWith {};
	if(_robber distance _shop > 10) exitWith { hint "你得呆在10米以内才能抢钱箱！-现在钱箱锁上了。"; 5 cutText ["","PLAIN DOWN"]; _rip = false; };
	5 cutText ["","PLAIN DOWN"];
	titleText[format["你抢劫了%1元，在警察到来之前迅速离开此地！",[_payout] call OEC_fnc_numberText],"PLAIN DOWN"];
	oev_cash = oev_cash + _payout;
	oev_cache_cash = oev_cache_cash + _payout;

	[
		["event","Robbed Gas Station"],
		["player",name player],
		["player_id",getPlayerUID player],
		["value",[_payout] call OEC_fnc_numberText],
		["location",getPosATL player]
	] call OEC_fnc_logIt;

	[[getPlayerUID player,profileName,"60",player],"OES_fnc_wantedAdd",false,false] spawn OEC_fnc_MP;
};

oev_use_atm = false;
uiSleep 180;
hint "您现在可以再次使用自动取款机。";
oev_use_atm = true;
