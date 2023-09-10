//	File: fn_checkRealtor.sqf
//	Author: TheCmdrRex
//	Description: Queries server for realtor_cash and rewards player with any cash
// This is terrible code pls don't use this for reference. addActions are the gayest pieces of shit when it comes to params.

private ["_foundCash","_mode"];

_foundCash = (_this select 3) select 0;
_mode = (_this select 3) select 1;
// Simple Check
if (isNull player) exitWith {};


if (_foundCash == -1) exitWith {
	if (_mode != 2) then {
		hint "向房地产经纪人查询出售房屋的款项。。。。";
	};
// Call server to find cash value
	[[player,_mode],"OES_fnc_realtorCash",false,false] call OEC_fnc_MP;
};
uiSleep 2; // Sleep cuz fuck you

if (_mode == 2) exitWith {
	if (_foundCash > 0) then {
		hint parseText "<t color='#ffff00' size='2' align='center'>房地产经纪人发来的短信</t><br/><br/>有空的时候请到房地产经纪人办公室来。我们有钱等着你从你的一个上市物业购买！";
	};
};
// More checks
if (_foundCash == -2) exitWith {hint "取回你的现金时出错！";};
if (_foundCash == 0) exitWith {hint "在房地产经纪人那里没有找到现金。你可以稍后再试！";};
// Hey we found cash time to pay you out
if (_foundCash > 0) then {
	hint format ["您已收到出售的挂牌房屋的%1元。",[_foundCash] call OEC_fnc_numberText];
	oev_atmcash = oev_atmcash + _foundCash;
	oev_cache_atmcash = oev_cache_atmcash + _foundCash;
	[1] call OEC_fnc_ClupdatePartial;
	[
		["event","Recieved Listed House Pay"],
		["player",name player],
		["player_id",getPlayerUID player],
		["value",_foundCash]
	] call OEC_fnc_logIt;
};
