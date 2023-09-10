#include <zmacro.h>
if(scriptAvailable(2.25)) exitWith {};
//  File: fn_gather.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Main functionality for gathering.
if(oev_action_gathering < 0) then {oev_action_gathering = 0;};
if(oev_action_gathering > 0) exitWith {};
if(oev_newsTeam) exitWith {};
private["_checkFull","_totalGathered","_gather","_itemWeight","_diff","_itemName","_val","_resourceZones","_restrictedZones","_zone","_distance","_mineable","_cancelGather"];
_resourceZones = [];
//["apple_1","apple_2","apple_3","apple_4","peaches_1","peaches_2","peaches_3","peaches_4","heroin_1","cocaine_1","weed_1","lead_1","iron_1","salt_1","sand_1","diamond_1","oil_1","oil_2","rock_1","lithium_1","lithium_2","phosphorous_1","phosphorous_2","ephedra_1","sugar_1","sugar_2","corn_1","corn_2","yeast_1","yeast_2","frog_1","frog_2","frog_3","frog_4","frog_5","mushroom_1","platinum_1","silver_1","oil_drill"];

_restrictedZones = ["heroin_1","cocaine_1","weed_1","phosphorous_1","phosphorous_2","ephedra_2","sugar_1","sugar_2","corn_1","corn_2","frog_1","frog_2","frog_3","frog_4","frog_5"];
_mineable =  ["lead_1","iron_1","salt_1","sand_1","diamond_1","oil_1","oil_2","rock_1","platinum_1","silver_1","oil_drill","Topaz_1"];
_zone = "";
_totalGathered = 0;
_cancelGather = false;
_val = 10;
_checkFull = 0;
_cursorObject = cursorObject;
_cursorObjectModel = ((getModelInfo _cursorObject) select 0);

oev_action_gathering = oev_action_gathering + 1;
oev_action_inUse = true;

{
	for "_i" from 0 to ((count (_x select 1)) - 1) do {
		_resourceZones pushBackUnique ((_x select 1) select _i);
	};
} forEach oev_resourceConfig;

//Find out what zone we're near
{
	if(player distance2d (getMarkerPos _x) < 300) exitWith {_zone = _x;};
} forEach _resourceZones;

if(_zone == "") exitWith {
	oev_action_inUse = false;
	oev_action_gathering = 0;
};

//Check if minagle or if can harvest illegal.
if((_zone in _mineable) && ((missionNamespace getVariable "life_inv_pickaxe") < 1)) exitWith {hint "你需要一把鹤嘴锄来收集这些资源！"; oev_action_inUse = false; oev_action_gathering = 0;};
if((_zone in _restrictedZones) && (license_civ_wpl)) exitWith {
	hint "你的工人保护许可证禁止你收割。";
	oev_interrupted = false;
	oev_action_inUse = false;
	oev_action_gathering = 0;
};

_inZoneIndex = -1;

{
	if(_zone in (_x select 1)) exitWith {
		_inZoneIndex = _foreachindex;
	};
}foreach oev_resourceConfig;

if(_inZoneIndex == -1) exitWith {};
_selectedZone = (oev_resourceConfig select _inZoneIndex);

if(player distance2d (getMarkerPos _zone) > (_selectedZone select 3)) exitWith {
	hint "您离资源区域太远了.";
	oev_action_inUse = false;
	oev_action_gathering = 0;
};

if(vehicle player != player) exitWith {
	hint "在车里不能采集.";
	oev_action_inUse = false;
	oev_action_gathering = 0;
};

_gather = (_selectedZone select 0);

if(_selectedZone select 6) then {//new gather system
	if(isNull _cursorObject) exitWith {hint "你一定是在寻找资源来收获它。"; oev_interrupted = false;oev_action_inUse = false;oev_action_gathering = 0;};//not looking at a supported object
	if(!(_cursorObjectModel in (_selectedZone select 2))) exitWith {oev_interrupted = false;oev_action_inUse = false;oev_action_gathering = 0;};//not looking at a supported object
	if(getdammage _cursorObject == 1 || isObjectHidden _cursorObject) exitWith {hint "这件物品已经全部收获了，请稍候再来."; oev_interrupted = false;oev_action_inUse = false;oev_action_gathering = 0;};//no resources left on this object
	if(player distance2d _cursorObject > 12 && _cursorObjectModel == "cliff_surfacemine_f.p3d") exitWith {oev_interrupted = false;oev_action_inUse = false;oev_action_gathering = 0;};
	if(player distance2d _cursorObject > 4 && _cursorObjectModel != "cliff_surfacemine_f.p3d") exitWith {oev_interrupted = false;oev_action_inUse = false;oev_action_gathering = 0;};

	_endTime = time + (_selectedZone select 5);

	while{time < _endTime} do {
		if(oev_action_gathering > 1) exitWith {};

		_checkFull = [_gather,100,oev_carryWeight,oev_maxWeight] call OEC_fnc_calWeightDiff;
		if(_checkFull < 1) exitWith {
			hint localize "STR_NOTF_InvFull";
			oev_interrupted = false;
			oev_action_inUse = false;
			oev_action_gathering = 0;
		};

		if(vehicle player != player) exitWith {
			titleText["取消采集，您不能在车内采集。","PLAIN DOWN"];
			oev_interrupted = false;
			oev_action_inUse = false;
			oev_action_gathering = 0;
		};

		if(oev_interrupted) exitWith {
			oev_interrupted = false;
			oev_action_inUse = false;
			oev_action_gathering = 0;
		};

		if(getDammage _cursorObject == 1 || isObjectHidden _cursorObject) exitWith {
			oev_interrupted = false;
			oev_action_inUse = false;
			oev_action_gathering = 0;
		};

		player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
		uiSleep 1.6;

		if(([true,_gather,1] call OEC_fnc_handleInv)) then{
			_itemName = [([_gather,0] call OEC_fnc_varHandle)] call OEC_fnc_varToStr;
		};
		_totalGathered = _totalGathered + 1;

		titleText[format[localize "STR_NOTF_Gather_Success",_itemName,1],"PLAIN DOWN"];
	};

	if((_totalGathered) >= round((_selectedZone select 5) / 5)) then {
		[[_cursorObject, (_selectedZone select 4)],"OES_fnc_repairObject",false,false] call OEC_fnc_MP;
	};

	sleep 1;
	titleText["","PLAIN DOWN"];
	oev_interrupted = false;
	oev_action_inUse = false;
	oev_action_gathering = 0;
} else {
	//old gather system
	private _canHold = [_gather,200,oev_carryWeight,oev_maxWeight] call OEC_fnc_calWeightDiff;
	private _gatherNum = 0;
	if(_canHold < 1) exitWith {
			hint localize "STR_NOTF_InvFull";
			oev_interrupted = false;
			oev_action_inUse = false;
			oev_action_gathering = 0;
	};

	_itemName = [([_gather,0] call OEC_fnc_varHandle)] call OEC_fnc_varToStr;
	titleText [format ["您将收集%1%2，直到已满。",_canHold,_itemName],"PLAIN DOWN"];

	while{true} do {
		if(oev_action_gathering > 1) exitWith {};
		player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
		uiSleep 2.5;
		_checkFull = [_gather,1,oev_carryWeight,oev_maxWeight] call OEC_fnc_calWeightDiff;
		if(_checkFull < 1) exitWith {
			hint localize "STR_NOTF_InvFull";
			oev_interrupted = false;
			oev_action_inUse = false;
			oev_action_gathering = 0;
		};

		if(player distance2d (getMarkerPos _zone) > (_selectedZone select 3)) exitWith {
			oev_action_inUse = false;
			oev_action_gathering = 0;
			oev_interrupted = false;
		};

		if !(alive player) exitWith {
			oev_action_inUse = false;
			oev_action_gathering = 0;
			oev_interrupted = false;
		};

		if ([true,_gather,1] call OEC_fnc_handleInv) then {
			_gatherNum = _gatherNum + 1;
			titleText [format ["你已经收集了 %1/%2 %3.",_gatherNum,_canHold,_itemName],"PLAIN DOWN"];
		};

		if(vehicle player != player) exitWith {titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"];
			oev_interrupted = false;
			oev_action_inUse = false;
			oev_action_gathering = 0;
		};

		if(oev_interrupted) exitWith {titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"];
			oev_interrupted = false;
			oev_action_inUse = false;
			oev_action_gathering = 0;
		};
	};
};