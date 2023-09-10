#include "..\..\macro.h"
//  File: fn_impoundMenu.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Not actually a impound menu, may act as confusion to some but that is what I wanted.
//	The purpose of this menu is it is now called a 'Garage' where vehicles are stored (persistent ones).
private["_vehicles","_control"];
disableSerialization;
params [
	["_vehicles",[],[[]]],
	["_gangVehicle",[false],[false]]
];

ctrlShow[2803,false];
ctrlShow[2830,false];
waitUntil {!isNull (findDisplay 2800)};

if(count _vehicles == 0) exitWith
{
	ctrlSetText[2811,localize "STR_Garage_NoVehicles"];
	if (_gangVehicle) then {
		ctrlShow[2814,false];
		ctrlShow[2815,false];
	};
};

_control = ((findDisplay 2800) displayCtrl 2802);
lbClear _control;

private _exit = false;

{
	if (typeName (_x#4) isEqualTo "SCALAR" && {(oev_gang_data#0) != (_x#4)}) exitWith {_exit = true};
	if (typeName (_x#4) isEqualTo "STRING" && {(getPlayerUID player) != (_x#4)}) exitWith {_exit = true};
	_vehicleInfo = [_x select 2,_x select 11,_x select 10] call OEC_fnc_fetchVehInfo;
	_control lbAdd (_vehicleInfo select 3);
	//car type, [color,chrome], inventory, insured, modification array
	_tmp = [_x select 2,_x select 8, "", _x select 9, _x select 10, _x select 0];
	_tmp = str(_tmp);
	_control lbSetData [(lbSize _control)-1,_tmp];
	_control lbSetPicture [(lbSize _control)-1,_vehicleInfo select 2];
	//_control lbSetValue [(lbSize _control)-1,_x select 0];
} forEach _vehicles;

if (_exit) exitWith {hint "返回的车库数据不是您的！ 请再试一遍...";};

ctrlShow[2810,false];
ctrlShow[2811,false];
ctrlShow[2814,false];
if !(playerSide isEqualTo civilian) then {
	ctrlShow[2840,false];
	ctrlShow[2841,false];
};
if (_gangVehicle) then {
	ctrlShow[2812,false];
	ctrlShow[2813,true];
	ctrlShow[2814,false];
	ctrlShow[2840,false];
	ctrlShow[2841,false];
	ctrlShow[2815,false];
} else {
	ctrlShow[2812,true];
	ctrlShow[2813,false];
	ctrlShow[2814,true];
	if(call oev_donator >= 50) then {
		ctrlEnable[2815,true];
	} else {
		ctrlEnable[2815,false];
	};
};
