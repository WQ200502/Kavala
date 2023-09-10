#include "..\..\macro.h"
//  File: fn_unimpound.sqf
//	Author: Bryan "Tonic" Boardwine
//  Description: Yeah... Gets the vehicle from the garage.

private["_vehicle","_vid","_pid","_unit","_price","_spawnPoint","_override"];
params [
	["_mode",0,[0]]
];
disableSerialization;
if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",getPlayerUID player],["target","null"],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]] call OEC_fnc_logIt;
	[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

if(lbCurSel 2802 == -1) exitWith {hint localize "STR_Global_NoSelection"};
_vehicle = lbData[2802,(lbCurSel 2802)];
_vid = (call compile format["%1",_vehicle]) select 5;
_vehicle = (call compile format["%1",_vehicle]) select 0;
//_vid = lbValue[2802,(lbCurSel 2802)];
_pid = getPlayerUID player;
_unit = player;
_spawnPoint = "";

if(isNil "_vehicle") exitWith {hint localize "STR_Garage_Selection_Error"};

_vehicleDetails = ["allVehicles", _vehicle] call OEC_fnc_vehicleConfig;
if(count _vehicleDetails > 0) then {
	_price = _vehicleDetails select 8;
} else {
	_price = 1000;
};

_price = [_vehicle,__GETC__(life_garage_prices)] call OEC_fnc_index;
if(_price == -1) then {_price = 1000;} else {_price = (__GETC__(life_garage_prices) select _price) select 1;};
if(cursortarget isKindOF "House_f" && !isNil {cursortarget getVariable "house_owner"}) then {
	_price = 0;
};
if(oev_atmcash < _price && oev_cash < _price) exitWith {hint format[(localize "STR_Garage_CashError"),[_price] call OEC_fnc_numberText];};

private _exit = false;
private _shed = false;
if(typeName oev_garage_sp isEqualTo typeName []) then {
	if (((oev_garage_sp select 0) isEqualTo "Land_i_Shed_Ind_F") && {(typeName (oev_garage_sp select 1) isEqualTo "OBJECT")}) then {
		private _shedPos = getPos (oev_garage_sp select 1);
		private _shedDir = getDir (oev_garage_sp select 1);
		private _emptyPos = _shedPos findEmptyPosition [5,45,_vehicle];
		if (count _emptyPos isEqualTo 0) exitWith {_exit = true; hint "没有找到该尺寸车辆的生成。 请与开发人员联系，以提供您尝试产生的车辆类型和位置信息。 谢谢你。";};
		_shed = true;
		private _azimuth = getPos player getDir _emptyPos;
		player setDir _azimuth;
		_override = true; //Disables server side count vehicle check
		//Check if pulling a gang vehicle
		if (_mode isEqualTo 1) then {
			[[_vid,_pid,_emptyPos,_unit,_price,getDir (oev_garage_sp select 1),(oev_gang_data select 0),(oev_gang_data select 1),_override],"OES_fnc_spaw1nVehicle",false,false] spawn OEC_fnc_MP;
		} else {
			[[_vid,_pid,_emptyPos,_unit,_price,getDir (oev_garage_sp select 1),0,"",_override],"OES_fnc_spaw1nVehicle",false,false] spawn OEC_fnc_MP;
		};
	} else {
		if ((typeName (oev_garage_sp select 0) isEqualTo "OBJECT") && {(typeOf (oev_garage_sp select 0) isEqualTo "Land_i_Shed_Ind_F")} && {(typeName (oev_garage_sp select 1) isEqualTo "SCALAR")}) then {
			private _spawnPos = ((oev_garage_sp select 0) modelToWorld [6,6.3,-1.5]);
			if (_vehicle in ["B_Truck_01_box_F","O_Truck_03_device_F"]) exitWith {_exit = true; hint "您真的觉得这样可以安全地在棚内生成而不炸毁吗？ 尝试在外面生成...";};
			_override = true; //Disables refunding
			//Check if its a gang vehicle
			if (_mode isEqualTo 1) then {
				[[_vid,_pid,_spawnPos,_unit,_price,oev_garage_sp select 1,(oev_gang_data select 0),(oev_gang_data select 1),_override],"OES_fnc_spaw1nVehicle",false,false] spawn OEC_fnc_MP;
			} else {
				[[_vid,_pid,_spawnPos,_unit,_price,oev_garage_sp select 1,0,"",_override],"OES_fnc_spaw1nVehicle",false,false] spawn OEC_fnc_MP;
			};
		} else {
			if (typeName (oev_garage_sp select 0) isEqualTo typeName []) then {
				[[_vid,_pid,oev_garage_sp select 0,_unit,_price,oev_garage_sp select 1],"OES_fnc_spaw1nVehicle",false,false] spawn OEC_fnc_MP;
			} else {
				{
					if(count(nearestObjects[(getMarkerPos _x),["Car","Ship"],5]) isEqualTo 0 && count(nearestObjects[(getMarkerPos _x),["Air"],8]) isEqualTo 0)  exitWith {
						_spawnPoint = _x;
						if (_mode isEqualTo 1) then {
							[[_vid,_pid,(getMarkerPos _x),_unit,_price,markerDir _x,(oev_gang_data select 0),(oev_gang_data select 1)],"OES_fnc_spaw1nVehicle",false,false] spawn OEC_fnc_MP;
						} else {
							[[_vid,_pid,(getMarkerPos _x),_unit,_price,markerDir _x],"OES_fnc_spaw1nVehicle",false,false] spawn OEC_fnc_MP;
						};
					};
				} foreach oev_garage_sp;
			};
		};
	};
} else {
	if(oev_garage_sp in ["medic_spawn_1","medic_spawn_2","medic_spawn_3"]) then {
		[[_vid,_pid,oev_garage_sp,_unit,_price],"OES_fnc_spaw1nVehicle",false,false] spawn OEC_fnc_MP;
	} else {
		[[_vid,_pid,(getMarkerPos oev_garage_sp),_unit,_price,markerDir oev_garage_sp],"OES_fnc_spaw1nVehicle",false,false] spawn OEC_fnc_MP;
	};
};

if(_exit) exitWith {};
if !(_override) then {
	if(_spawnPoint == "") exitWith {hint localize "STR_Shop_Veh_Block";closeDialog 0;};
};

if (_shed) then {
	hint "您的车辆朝着您所面对的方向生成。";
} else {
	hint localize "STR_Garage_SpawningVeh";
};

closeDialog 0;
if(oev_cash >= _price) then {
	oev_cash = oev_cash - _price;
	oev_cache_cash = oev_cache_cash - _price;
} else {
	oev_atmcash = oev_atmcash - _price;
	oev_cache_atmcash = oev_cache_atmcash - _price;
};
