//	Filename: fn_repairClientObject.sqf
//	Author: Serpico
//	Description: Repairs the given object if it can be repaired
//	             For example, a destroyed house is a different object.
//	             Does not repair vehicles

private["_objects","_upp","_ui","_progress","_pgText","_cP","_displayName","_vehDamage","_sleepVal","_price","_dam_obj"];
// Array of object to be repaired
_objects = [];
_price = 100; //Amount 2 get per repair
{
	if (!(_x isKindOf "air" || _x isKindOf "car" || _x isKindOf "ship" || _x isKindOf "house" || _x isKindOf "Man") && (getDammage _x  > 0)) then {
		_objects pushBack _x;
	};
} forEach nearestObjects [player, [], 2];

// Check if any damaged objects are found
if (count _objects <= 0) exitWith {
	hint "你附近没有破碎的物体";
	oev_action_inUse = false;
};

if(count(nearestObjects[(getPos player),["Car","Ship","Air"],15]) > 0) exitWith {
	hint "开始维修前，确保该区域清洁";
	oev_action_inUse = false;
};

// Setup progress bar
_upp = "Repair in progress";
//Setup our progress bar.
disableSerialization;
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNameSpace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
_cP = 0;
_sleepVal = 0.05;

["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;

while {true} do {
	uiSleep _sleepVal;
	_cP = _cP + 0.01;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
	if(_cP >= 1) exitWith {};
	if(!alive player) exitWith {oev_interrupted = true;};
	if(player != vehicle player) exitWith {};
	if(oev_interrupted) exitWith {};
};

oev_action_inUse = false;
5 cutText ["","PLAIN DOWN"];
[] spawn OEC_fnc_handleAnim;

if(oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false;};
if(player != vehicle player) exitWith {titleText[localize "STR_NOTF_RepairingInVehicle","PLAIN DOWN"];};

{
	_dam_obj = _x;
	_dam_obj setDamage 0;
} forEach _objects;

hint format ["You have earned $%1 for keeping the streets neat!",_price];
oev_atmcash = oev_atmcash + _price;
oev_cache_atmcash = oev_cache_atmcash + _price;
