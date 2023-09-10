//  File: fn_vehicleShopMenu.sqf
//	Author: Bryan "Tonic" Boardwine

(_this select 3) params [
	["_shop","",[""]],
	["_sideCheck",sideUnknown,[civilian]],
	["_spawnPoints","",["",[]]],
	["_shopFlag","",[""]],
	["_shopTitle","",[""]],
	["_disableBuy",false,[true]]
];

disableSerialization;
//Long boring series of checks
if(dialog) exitWith {};
if(_shop isEqualTo "") exitWith {};
if(_sideCheck != sideUnknown && {playerSide != _sideCheck}) exitWith {hint localize "STR_Shop_Veh_NotAllowed"};

["Life_Vehicle_Shop_v2"] call OEC_fnc_createDialog;
oev_garageCount = -1;
[[getPlayerUID player, playerside, player],"OES_fnc_checkVehicleLimit",false,false] spawn OEC_fnc_MP;

life_veh_shop = [_shop,_spawnPoints,_shopFlag,_disableBuy]; //Store it so so other parts of the system can access it.

ctrlSetText [2301,_shopTitle];

if(_disableBuy) then {
	//Disable the buy button.
	ctrlEnable [2309,false];
};

//Fetch the shop config.
_vehicleList = ["availableVehicles", _shop] call OEC_fnc_vehicleConfig;

_control = ((findDisplay 2300) displayCtrl 2302);
lbClear _control; //Flush the list.
ctrlShow [2330,false];
ctrlShow [2304,false];

if ((life_veh_shop select 0) == "war_v") then {
		oev_warpts_count = -999;
		hint "Fetching war points...";
		[[0,0,player],"OES_fnc_warGetSetPts",false,false] spawn OEC_fnc_MP;
		waitUntil {!(oev_warpts_count isEqualTo -999)};
		uiSleep 0.5;
		hint format ["You have %1 war points to spend!",oev_warpts_count];
	};

//Loop through
if ((life_veh_shop select 0) != "war_v") then {
	_racingPlane = false;
	{
		_className = _x select 0;
		_basePrice = _x select 6;

		_vehicleInfo = [_className] call OEC_fnc_fetchVehInfo;

		if(_className isEqualTo "C_Plane_Civil_01_racing_F") then {
			_vehicleInfo = [_className,"",_x select 11] call OEC_fnc_fetchVehInfo;
		};

		_control lbAdd (_vehicleInfo select 3);
		_control lbSetPicture [(lbSize _control)-1,(_vehicleInfo select 2)];
		_control lbSetData [(lbSize _control)-1,_className];
		_control lbSetValue [(lbSize _control)-1,_ForEachIndex];
	} forEach _vehicleList;
} else {
	{
		_className = _x select 0;
		_basePrice = _x select 7;

		_vehicleInfo = [_className] call OEC_fnc_fetchVehInfo;

		if(_className isEqualTo "C_Plane_Civil_01_racing_F") then {
			_vehicleInfo = [_className,"",_x select 11] call OEC_fnc_fetchVehInfo;
		};

		_control lbAdd (_vehicleInfo select 3);
		_control lbSetPicture [(lbSize _control)-1,(_vehicleInfo select 2)];
		_control lbSetData [(lbSize _control)-1,_className];
		_control lbSetValue [(lbSize _control)-1,_ForEachIndex];
	} forEach _vehicleList;
};
