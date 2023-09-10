//  File: fn_pickupMoney.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Picks up money
if((count (player nearEntities ["Man", 10])) > 1) then {
	uiSleep (random(4));
};
if((time - oev_action_delay) < 1.5) exitWith {
	hint "你不能快速使用动作键！";
	if(getPlayerUID (_obj getVariable["inUse", ObjNull]) != (getPlayerUID player)) exitWith{closeDialog 0;};
};

if(call oev_restrictions) exitWith {hint "您受到玩家限制，无法执行此操作！如果您认为这是一个错误，请与管理员联系。";};
[[player],"OES_fnc_internetCheck",false,false] spawn OEC_fnc_MP;
oev_didServerRespond = false;
private _maxDelayTime = time + 5;
waitUntil{time > _maxDelayTime || oev_didServerRespond};
if(time > _maxDelayTime) exitWith {hint "拾取失败，再试一次.";};

params [
	["_obj",ObjNull,[ObjNull]],
    ["_var","",[""]],
    ["_val",0,[0]]
];
if(isNil {_val}) exitWith {};
if(isNull _obj || player distance _obj > 3) exitWith {};

if(!isNil {_val}) then {
	deleteVehicle _obj;
	//waitUntil {isNull _obj};

	player playmove "AinvPknlMstpSlayWrflDnon";
	titleText[format[localize "STR_NOTF_PickedMoney",[_val] call OEC_fnc_numberText],"PLAIN DOWN"];
	[
		["event","Picked up Cash"],
		["player",name player],
		["player_id",getPlayerUID player],
		["value",[_val] call OEC_fnc_numberText],
		["location",getPosATL player]
	] call OEC_fnc_logIt;
	oev_cash = oev_cash + _val;
	oev_cache_cash = oev_cache_cash + _val;
	oev_action_delay = time;
};
