#include <zmacro.h>
if(scriptAvailable(180)) exitWith {hint "请稍候2分钟，然后再换车";};
//  File: fn_vehicleTransfer.sqf
//	Author: TheCmdrRex
//	Description: Transfers vehicles between players in game. Civilian only at the moment.
private ["_vehicle","_vid","_unit","_unitID","_vehName","_fee"];

disableSerialization;
if (lbCurSel 2802 isEqualTo -1) exitWith {hint localize "STR_Global_NoSelection";};
_vehicle = lbData[2802,(lbCurSel 2802)];
_vid = (call compile format["%1",_vehicle]) select 5;
_vehicle = (call compile format["%1",_vehicle]) select 0;
//_vid = lbValue[2802,(lbCurSel 2802)];
_unit = lbData[2841,lbCurSel (2841)];
_unit = call compile format["%1", _unit];
_unitID = getPlayerUID _unit;
_fee = 0;

if (isNil "_vehicle") exitWith {hint localize "STR_Garage_Selection_Error";};
if (isNil "_unit") exitWith {hint "所选玩家不存在";};
if (__GETC__(oev_restrictions)) exitWith {hint "你受到限制";};
if (_unit getVariable ["restrictions", false]) exitWith {hint "所选玩家受限制";};
_vehName = getText(configFile >> "CfgVehicles" >> _vehicle >> "displayName");

if(_vehicle in oev_illegal_vehicles) then {
	if(!(_vehicle in oev_blackwater_vehicles_ground) && !(_vehicle in oev_blackwater_vehicles_air)) then {
		_fee = round (0.1 * ((["allVehicles", _vehicle] call OEC_fnc_vehicleConfig) select 6));
	} else {
		if(_vehicle in oev_blackwater_vehicles_ground) then {
				_fee = 400000;
			} else {
				_fee = 800000;
			};
	};
};

if(_fee == 0) then {
	// Confirm they want to transfer
	private _action = [
		format ["确实要将%2转移到%1吗？",name _unit, _vehName],
		"确认",
		"是",
		"否"
	] call BIS_fnc_GUImessage;
	waitUntil {!isNil "_action"};
	if (_action) then {
		[[_vid, player, _unit, getPlayerUID player, _unitID, _vehName],"OES_fnc_updateVehOwnership",false,false] spawn OEC_fnc_MP;
		hint format["%2已转移到%1",name _unit,_vehName];
		[
			["event","Vehicle Transfer"],
			["player",name player],
			["player_id",getPlayerUID player],
			["target",name _unit],
			["target_id",_unitID],
			["vehicle",_vehName]
		] call OEC_fnc_logIt;
	};
} else {
	private _action = [
		format ["您确定要用%3元将%2传输到%1吗？",name _unit, _vehName, _fee],
		"确认",
		"是",
		"否"
	] call BIS_fnc_GUImessage;
	waitUntil {!isNil "_action"};
	if (_action) then {
		if (oev_cash < (_fee) && oev_atmcash < (_fee)) exitWith {hint "你没有足够的钱！"};
		if !(oev_cash < _fee) then {
			oev_cash = oev_cash - _fee;
			oev_cache_cash = oev_cache_cash - _fee;
			[0] call OEC_fnc_ClupdatePartial;
		} else {
			oev_atmcash = oev_atmcash - _fee;
			oev_cache_atmcash = oev_cache_atmcash - _fee;
			[1] call OEC_fnc_ClupdatePartial;
		};
		[[_vid, player, _unit, getPlayerUID player, _unitID, _vehName],"OES_fnc_updateVehOwnership",false,false] spawn OEC_fnc_MP;
		hint format["%2已以%3元的价格转移到%1",name _unit,_vehName, _fee];
		[
			["event","Illegal Vehicle Transfer"],
			["player",name player],
			["player_id",getPlayerUID player],
			["target",name _unit],
			["target_id",_unitID],
			["vehicle",_vehName],
			["cost",_fee]
		] call OEC_fnc_logIt;
	};
};
closeDialog 0;
