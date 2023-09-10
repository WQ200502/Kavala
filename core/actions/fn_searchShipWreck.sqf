#include <zmacro.h>
if(scriptAvailable(2.25)) exitWith {};
// Filename: fn_searchShipWreck.sqf

if !(playerSide isEqualTo civilian) exitWith {};
if ((player distance2d (getMarkerPos "wreck_1") > 50) && (player distance2d (getMarkerPos "wreck_2") > 50) && (player distance2d (getMarkerPos "wreck_3") > 50) && (player distance2d (getMarkerPos "wreck_4") > 50) && (player distance2d (getMarkerPos "wreck_5") > 50) && (player distance2d (getMarkerPos "wreck_6") > 50)) exitWith {hint "你需要在海上一个紫色的沉船标记附近进行挖掘。";};
if ((count(nearestTerrainObjects[player,["Shipwreck"],20,true,false])) isEqualTo 0) exitWith {titleText["你附近没有沉船。你必须在20米以内。","PLAIN DOWN"]};
if ((getPosASL player) select 2 > -12) exitWith {titleText["You need to be in deeper waters.","PLAIN DOWN"]};

if(oev_action_gathering < 0) then {oev_action_gathering = 0;};
if(oev_action_gathering > 0) exitWith {};

oev_action_gathering = 1;
oev_action_inUse = true;
private _cancelled = false;
private _full = false;

while {oev_carryWeight < oev_maxWeight} do {
	if ((count(nearestTerrainObjects[player,["Shipwreck"],20,true,false])) isEqualTo 0) exitWith {_cancelled = true;};
	if ((getPosASL player) select 2 > -12) exitWith {_cancelled = true;};
	if (oev_carryWeight >= oev_maxWeight) exitWith {_full = true;};
	if (vehicle player != player) exitWith {_cancelled = true;};
	if !(alive player) exitWith {_cancelled = true;};
	if !(oev_action_inUse) exitWith {_cancelled = true;};

	private _foundLoot = [["scrap","coin","wpearl","bpearl","emerald","amethyst","topazr","rum","lockpick","glass"],[.7,.13,.4,.4,.3,.3,.7,.13,.45,.3]] call BIS_fnc_selectRandomWeighted;

	if ([true,_foundLoot,1] call OEC_fnc_handleInv) then {
		_lootName = [([_foundLoot,0] call OEC_fnc_varHandle)] call OEC_fnc_varToStr;
		titleText[format["You recovered 1 %1.",_lootName],"PLAIN DOWN"];
	};
	uiSleep 4;
};

if (_cancelled) then {
	titleText["当前操作已取消。","PLAIN DOWN"];
} else {
	titleText["你的存货已经满了。","PLAIN DOWN"];
};

oev_action_inUse = false;
oev_action_gathering = 0;