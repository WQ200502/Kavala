//  File: fn_claimVehicle.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Descripton: Used to claim blackwater vehicles

disableSerialization;
private _control = ((findDisplay 39400) displayCtrl 39402);
private _vehicleArrayIndex = _control lbData (lbCurSel _control);
private _price = _control lbValue (lbCurSel _control);
_vehicleArrayIndex = call compile format["%1", _vehicleArrayIndex];
private _nearVehicles = nearestObjects [getMarkerPos life_chopShop,["Car","Truck","Air"],25];
_vehicle = _nearVehicles select _vehicleArrayIndex;
if !(_vehicle getVariable ["chopListIndex", -1] isEqualTo _vehicleArrayIndex) exitWith {hint "找不到车辆"};
private _nearUnits = (nearestObjects[player,["Man"],10]) arrayIntersect playableUnits;
if (count _nearUnits > 1) exitWith {hint "玩家靠近时你不能认领车辆！"};
private _claimable = ["O_T_LSV_02_armed_F","B_T_LSV_01_armed_F","I_MRAP_03_F","B_MRAP_01_F","B_G_Offroad_01_armed_F","I_G_Offroad_01_armed_F","B_Heli_Transport_03_black_F","O_MRAP_02_F","B_Heli_Transport_01_camo_F","C_Plane_Civil_01_racing_F","I_C_Offroad_02_LMG_F","I_G_Offroad_01_AT_F","B_T_VTOL_01_vehicle_F","B_T_VTOL_01_infantry_F","C_Hatchback_01_sport_F"];
if !((typeOf _vehicle) in _claimable) exitWith {};
if ((typeOf _vehicle == "C_Hatchback_01_sport_F") && ((_vehicle getVariable ["side",""]) != "cop")) exitWith {};

closeDialog 0;
if (isNull _vehicle) exitWith {hint "车辆不存在。";};
if !(playerSide isEqualTo civilian) exitWith {};
if (((typeOf _vehicle) in _claimable) && !(_vehicle getVariable "isBlackwater")) exitWith {
	[_vehicle,_price] spawn OEC_fnc_claimIllegal;
};
if !(_vehicle getVariable "isBlackwater") exitWith {hint "你只能认领黑水公司的车辆！";};
if !(_vehicle getVariable "dbInfo" isEqualTo "1234" || _vehicle getVariable ["dbInfo",[""]] select 0 isEqualTo "1234") exitWith {hint "这辆车已经被认领了！";};

[_vehicle] spawn{
	_vehicle = _this select 0;
	private _nearUnits = (nearestObjects[player,["Man"],10]) arrayIntersect playableUnits;
	if(count _nearUnits > 1) exitWith {hint "玩家靠近时，你不能要求车辆！"};
	private _plate = round(random(1000000));
	private _className = typeOf _vehicle;

	private _side = switch(playerSide) do {
		case west:{"cop"};
		case civilian: {"civ"};
		case independent: {"med"};
		default {"Error"};
	};

	private _type = switch (true) do {
		case (_vehicle isKindOf "Car"): {"Car"};
		case (_vehicle isKindOf "Helicopter"): {"Air"};
		case (_vehicle isKindOf "Ship"): {"Ship"};
		case (_vehicle isKindOf "Plane"): {"Plane"};
	};

	if !((_className) in ["O_T_LSV_02_armed_F","B_T_LSV_01_armed_F","I_MRAP_03_F","B_MRAP_01_F","B_G_Offroad_01_armed_F","I_G_Offroad_01_armed_F","B_Heli_Transport_03_black_F","O_MRAP_02_F","B_Heli_Transport_01_camo_F","C_Plane_Civil_01_racing_F","I_C_Offroad_02_LMG_F","I_G_Offroad_01_AT_F","B_T_VTOL_01_vehicle_F","B_T_VTOL_01_infantry_F"]) exitWith {};
	if !(_vehicle getVariable "isBlackwater") exitWith {hint "该车辆已被索赔或不再存在。";};
	oev_action_inUse = true;
	hint "正在重新设置车辆钥匙。。。";
	uisleep 5;
	uisleep random(5);
	uisleep random(10);
	if (isNull _vehicle) exitWith {hint "车辆不存在。";};
	if !(_vehicle getVariable "isBlackwater") exitWith {hint "此车辆已被认领或已不存在。";};

	[
		["event","Claimed BW Vehicle"],
		["player",name player],
		["player_id",getPlayerUID player],
		["value",_className],
		["location",getPosATL player]
	] call OEC_fnc_logIt;

	_vehicle setVariable ["vehicle_info_owners",[],true];
	_vehicle setVariable ["isBlackwater",false,true];
	private _owners = _vehicle getVariable "vehicle_info_owners";
	private _index = [getPlayerUID player,_owners] call OEC_fnc_index;

	if (_index == -1) then {
		_owners pushBack [getPlayerUID player,player getVariable ["realname",name player]];
		_vehicle setVariable ["vehicle_info_owners",_owners,true];
	};

	_vehicle setVariable ["dbInfo",[getPlayerUID player,_plate],true];
	_color = -1;
	if !(_vehicle getVariable["oev_veh_color",[""]] select 0 isEqualTo "") then {_color = _vehicle getVariable "oev_veh_color" select 0;};
	[[(getPlayerUID player),_side,_type,_className,_color,_plate],"OES_fnc_insertVehicle",false,false] spawn OEC_fnc_MP;
	if (!(_vehicle in oev_vehicles)) then {oev_vehicles pushBack _vehicle;};
	[[getPlayerUID player,playerSide,_vehicle,1],"OES_fnc_keyManagement",false,false] spawn OEC_fnc_MP;

	uisleep 3;
	oev_action_inUse = false;
	hint "你现在拥有这辆车并拥有它的钥匙！";
};
