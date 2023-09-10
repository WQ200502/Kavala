#include "..\..\macro.h"
//  File: fn_claimIllegal.sqf
//	Author: Jesse "tkcjesse" Schultz
//  Modified By: Kurt
//	Description: Used for claiming other peoples illegal vehicles.

params [
	["_vehicle",objNull,[objNull]],
	["_price",-1,[0]]
];
if (isNull _vehicle || _price isEqualTo -1) exitWith {hint "车辆不存在。";};
if !(playerSide isEqualTo civilian) exitWith {};
if (!(typeOf _vehicle in oev_illegal_vehicles) && !(_vehicle getVariable ["side",""] == "cop")) exitWith {hint "这辆车不能认领！";};
if (!(typeOf _vehicle in ["C_Hatchback_01_sport_F","I_G_Offroad_01_armed_F","B_T_LSV_01_armed_F"]) && _vehicle getVariable ["side",""] == "cop") exitWith {hint "这辆车不能认领！"};
if (_vehicle getVariable ["rekey",false]) exitWith {hint "这辆车已经被认领了！";};

_price = _price * 0.8;

//if they own arms cartel and apply discount
private _flagObj = call compile format["%1_flag","Arms"];
if(isNil "_flagObj" || isNull _flagObj) exitWith {};
_flagData = _flagObj getVariable ["capture_data",[]];
if(count _flagData == 0) exitWith {};
oev_armsCartel = [false,0,(_flagData select 0)];
if(count oev_gang_data > 0) then {
	if(((_flagData select 0) == (oev_gang_data select 0)) && ((_flagData select 2) > 0)) then {
		_price = _price * 0.9;
		oev_armsCartel = [true,0,(_flagData select 0)];
	};
};
if (_price > oev_atmcash) exitWith {hint localize "STR_NOTF_NotEnoughMoney"};

private _action = [
	format["您确定要以%1元索赔此车辆吗？在15-20秒的重新键入过程中，您不能进入、退出或移动车辆！",[_price] call OEC_fnc_numberText],
	"认领非法车辆",
	"索赔",
	localize "STR_Global_Cancel"
] call BIS_fnc_GUImessage;

if (_price > oev_atmcash) exitWith {hint localize "STR_NOTF_NotEnoughMoney"};
if (_action) then {
	if (_vehicle getVariable ["rekey",false]) exitWith {hint "这辆车已经被认领了！";};
	if (_price > oev_atmcash) exitWith {hint localize "STR_NOTF_NotEnoughMoney"};
	oev_action_inUse = true;
	life_claim_done = false;
	life_claim_success = false;
	hint "正在更换车辆锁。。。";

	oev_atmcash = oev_atmcash - _price;
	oev_cache_atmcash = oev_cache_atmcash - _price;

	//Prevent people from keeping donor textures if they aren't a donor
	private _donatorLevel = __GETC__(oev_donator);
	private _textures = ["access",(typeOf _vehicle)] call OEC_fnc_vehicleSkins;
	[[_vehicle,player,_textures,_donatorLevel],"OES_fnc_illegalClaim",false,false] spawn OEC_fnc_MP;

	waitUntil {life_claim_done};
	oev_action_inUse = false;
	if !(life_claim_success) exitWith {
		oev_atmcash = oev_atmcash + _price;
		oev_cache_atmcash = oev_cache_atmcash + _price;
		life_claim_done = false;
		life_claim_success = false;
		_vehicle setVariable ["rekey",false,true];
		hint "索赔失败。你的钱已退还到你的银行帐户。";
	};

	life_claim_success = false;
	life_claim_done = false;
	hint format ["%1已被认领，现在您可以随意处理了。",getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName")];
};
