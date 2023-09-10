#include "..\..\macro.h"
//  File: fn_vehicleShopBuy.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Does something with vehicle purchasing.
private["_mode","_spawnPoints","_className","_basePrice","_colorIndex","_spawnPoint","_vehicle","_ctrl","_goalDis"];

if (oev_garageCount isEqualTo -1) exitWith {hint "Please try this transaction again in a few seconds."};
if (oev_garageCount >= 15 && (call oev_restrictions)) exitWith {hint format["You have %1 out of 15 max vehicles due to your player restrictions. Contact an administrator if you feel this is an error.",oev_garageCount];};
if (oev_garageCount >= 75) exitWith {hint format["You have %1 out of 75 max vehicles.",oev_garageCount];};

if (isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if (isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};
if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",getPlayerUID player],["target","null"],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]] call OEC_fnc_logIt;
	[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

_mode = _this select 0;
_withMods = _this select 1; //modify enable

if ((lbCurSel 2302) isEqualTo -1) exitWith {hint localize "STR_Shop_Veh_DidntPick"};
_className = lbData[2302,(lbCurSel 2302)];
_vIndex = lbValue[2302,(lbCurSel 2302)];
_vehicleList = ["availableVehicles", life_veh_shop select 0] call OEC_fnc_vehicleConfig;
_goalDis = 1;
if (life_donation_active) then {_goalDis = .90;};
if (life_donation_vehicles) then {_goalDis = .80;};

if ((life_veh_shop select 0) == "reb_v") then {
	if (life_donation_rebVehicles) then {_goalDis = .90;};
	private _territory = "Arms";
	private _flagObj = call compile format["%1_flag",_territory];
	if(isNil "_flagObj" || isNull _flagObj) exitWith {};
	private _flagData = _flagObj getVariable ["capture_data",[]];
	if(count _flagData == 0) exitWith {};
	oev_armsCartel = [false,0,(_flagData select 0)];

	if(count oev_gang_data > 0) then {
		if(((_flagData select 0) == (oev_gang_data select 0)) && ((_flagData select 2) > 0) && !(oev_conquestData select 0)) then {
			_goalDis = _goalDis - 0.15;
			oev_armsCartel = [true,0,(_flagData select 0)];
		};
	};
};

if ((life_veh_shop select 0) != "war_v") then {
	_basePrice = ((((_vehicleList select _vIndex) select 6) * _goalDis) * __GETC__(life_medDis));
} else {
	_basePrice = ((_vehicleList select _vIndex) select 7);
};

if (_mode) then {_basePrice = round(_basePrice)};

disableSerialization;

_ctrl = getControl(2300,2304);
if ((lbSize _ctrl)-1 >= 0) then {
	_colorIndex = lbData[2304,(lbCurSel 2304)];
} else {
	_colorIndex = "";
};
//Close the dialog to prevent spamming buy
closeDialog 0;
//Series of checks (YAY!)
if (_basePrice < 0) exitWith {}; //Bad price entry
if (oev_atmcash < _basePrice && oev_cash < _basePrice) exitWith {hint format[localize "STR_Shop_Veh_NotEnough",[_basePrice - oev_atmcash] call OEC_fnc_numberText];};
if ((oev_warpts_count < _basePrice) && ((life_veh_shop select 0) == "war_v")) exitWith {hint format[localize "STR_Shop_WarVeh_NotEnough",[_basePrice - oev_warpts_count] call OEC_fnc_numberText];};

if (!([_className] call OEC_fnc_vehShopLicenses) && _className != "B_MRAP_01_hmg_F") exitWith {hint localize "STR_Shop_Veh_NoLicense"};

private _pDLC = getDlcs 1;
private _nDLC = false;

switch (getText (configFile >> "CfgVehicles" >> _className >> 'DLC')) do {
	case 'Expansion': {
		if !(395180 in _pDLC) then {_nDLC = true};
	};
	case 'Jets': {
		if !(601670 in _pDLC) then {_nDLC = true};
	};
	case 'Orange': {
		if !(571710 in _pDLC) then{_nDLC = true};
	};
	case 'Kart': {
		if !(288520 in _pDLC) then {_nDLC = true};
	};
	case 'Heli': {
		if !(304380 in _pDLC) then {_nDLC = true};
	};
	case 'Tank': {
		if !(395180 in _pDLC) then {_nDLC = true};
	};
};

if (_nDLC) then {
	private _action = [
		"您没有此车辆所需的数据链路连接器。我们添加了一个windows按键操作，当车辆解锁时，您可以使用它强制自己进入车辆，但是您将收到Bohemia提供的与内容相关的屏幕消息。您想继续购买吗？",
		"确认",
		"是",
		"否"
	] call BIS_fnc_guiMessage;

	if (_action) exitWith {_nDlc = false};
};

if (_nDLC) exitWith {};

_spawnPoints = life_veh_shop select 1;
_spawnPoint = "";

//Check if there is multiple spawn points and find a suitable spawnpoint.
if (_spawnPoints isEqualType []) then {
	//Find an available spawn point.
	{if (count(nearestObjects[(getMarkerPos _x),["Car","Ship"],5]) == 0 && count(nearestObjects[(getMarkerPos _x),["Air"],8]) isEqualTo 0) exitWith {_spawnPoint = _x};} foreach _spawnPoints;
} else {
	if (count(nearestObjects[(getMarkerPos _spawnPoints),["Car","Ship"],5]) == 0 && count(nearestObjects[(getMarkerPos _spawnPoints),["Air"],8]) isEqualTo 0) exitWith {_spawnPoint = _spawnPoints};
};

_boat = [allMapMarkers, _spawnPoint] call BIS_fnc_nearestPosition isEqualTo "reb_boat1_2";
_airCarrier = [allMapMarkers, _spawnPoint] call BIS_fnc_nearestPosition isEqualTo "civ_plane_16";
if(_boat || _airCarrier) then {
	_markerPos = getMarkerPos(_spawnPoint);
	_z = 0;
	if(_boat) then {
		_z = 8.5;
	};
	if(_airCarrier) then {
		_z = 23.5435;
	};
	if(count(nearestObjects[[_markerPos select 0, _markerPos select 1, _z],["Car","Ship","Air"],5]) > 0) then {
		_spawnPoint = "";
	};
};

if (_spawnPoint == "") exitWith {hint localize "STR_Shop_Veh_Block";};

private _type = switch (true) do {
	case (_className isKindOf "Car"): {"Car"};
	case (_className isKindOf "Helicopter"): {"Air"};
	case (_className isKindOf "Ship"): {"Ship"};
	case (_className isKindOf "Plane"): {"Plane"};
	default {""};
};
if (_className isEqualTo "O_T_VTOL_02_vehicle_F") then {_type = "Air";}; // Allow medic Y-32 Xians in Heli garage

private _side = switch (playerSide) do {
	case west:{"cop"};
	case civilian: {"civ"};
	case independent: {"med"};
	default {""};
};

if (_type isEqualTo "" || _side isEqualTo "") exitWith {hint "Unable to determine vehicle type or player faction... please try again.";};
// Gather Stats for kills
private _discount = 1.0;
if ((life_veh_shop select 0) == "reb_v") then {
	_perkTier = ["civ_kills"] call OEC_fnc_fetchStats;
	_discount = switch (_perkTier) do {
		case 1:{0.975};
		case 2:{0.95};
		case 3:{0.95};
		case 4:{0.95};
		case 5:{0.95};
		default {1};
	};
	_perkTier = ["civ_warKills"] call OEC_fnc_fetchStats;
	switch (_perkTier) do {
		case 1:{_discount = _discount - 0.02;};
		case 2:{_discount = _discount - 0.05;};
		case 3:{_discount = _discount - 0.10;};
		case 4:{_discount = _discount - 0.15;};
		case 5:{_discount = _discount - 0.15;};
		case 6:{_discount = _discount - 0.15;};
		default {_discount = _discount;};
	};
};

if (((life_veh_shop select 0) == "cop_car") || ((life_veh_shop select 0) == "cop_air")) then {
	_perkTier = ["cop_minutes"] call OEC_fnc_fetchStats;
	_discount = switch (_perkTier) do {
		case 1:{0.98};
		case 2:{0.96};
		case 3:{0.94};
		case 4:{0.92};
		case 5:{0.90};
		default {1};
	};
};

if (_discount < 0.80) then {_discount = 0.80;}; // Cap at 80%
_basePrice = _basePrice * _discount;

if ((life_veh_shop select 0) != "war_v") then {
	if (oev_cash >= _basePrice) then {
		oev_cash = oev_cash - _basePrice;
		oev_cache_cash = oev_cache_cash - _basePrice;
	} else {
		oev_atmcash = oev_atmcash - _basePrice;
		oev_cache_atmcash = oev_cache_atmcash - _basePrice;
	};
} else {
	[[1,_basePrice,player],"OES_fnc_warGetSetPts",false,false] spawn OEC_fnc_MP;
	oev_warpts_count = oev_warpts_count - _basePrice;
};

[1] call OEC_fnc_ClupdatePartial;
[
	["event","Vehicle Buy"],
	["player",name player],
	["player_id",getPlayerUID player],
	["vehicle",getText(configFile >> "CfgVehicles" >> _className >> "displayName")],
	["value",_basePrice]
] call OEC_fnc_logIt;

_defaultMods = [0,0,0,0,0,0,0,0];
if(count (_vehicleList select _vIndex) >= 12) then {
	_defaultMods = (_vehicleList select _vIndex) select 11;
};

//Spawn on the server

[_className,_type,(getMarkerPos _spawnPoint),(markerDir _spawnPoint),(getPlayerUID player),profileName,[_colorIndex,0],_side,_withMods,_defaultMods,player] remoteExec ["OES_fnc_createServVeh",2];

if ((life_veh_shop select 0) == "reb_v") then {
	if !(oev_armsCartel select 0 || oev_conquestData select 0) then {
		hint parseText format ["You bought a %1 for <t color='#8CFF9B'>$%2</t>. 10%3 of your purchase went to the owner of the Arms Cartel! <br/><br/> Sending purchase request to server...",getText(configFile >> "CfgVehicles" >> _className >> "displayName"),[_basePrice] call OEC_fnc_numberText,"%"];
		[[2,(oev_armsCartel select 2),player,round(_basePrice * 0.10),0,0,true],"OES_fnc_gangBank",false,false] spawn OEC_fnc_MP;
	} else {
		hint parseText format ["You bought a %1 for <t color='#8CFF9B'>$%2</t>. <br/><br/> Sending purchase request to server...",getText(configFile >> "CfgVehicles" >> _className >> "displayName"),[_basePrice] call OEC_fnc_numberText];
	};
} else {
	if ((life_veh_shop select 0) == "war_v") then {
		hint format [localize "STR_Shop_WarVeh_Bought",getText(configFile >> "CfgVehicles" >> _className >> "displayName"),[_basePrice] call OEC_fnc_numberText];
	} else {
		hint format [localize "STR_Shop_Veh_Bought",getText(configFile >> "CfgVehicles" >> _className >> "displayName"),[_basePrice] call OEC_fnc_numberText];
	};
};

true;
