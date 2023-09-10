#include <zmacro.h>
//  File: fn_keyMenu.sqf
//	Author: Bryan "Tonic" Boardwine
//  Description: Initializes the key menu

private["_display","_vehicles","_plist","_near_units","_pic","_name","_color","_index","_underglow"];
disableSerialization;

waitUntil {!isNull (findDisplay 33000)};
_display = findDisplay 33000;
_vehicles = _display displayCtrl 33001;
lbClear _vehicles;
_plist = _display displayCtrl 33004;
lbClear _plist;
_underglow = _display displayCtrl 33006;
lbClear _underglow;
_near_units = [];

_underglow ctrlShow false;
(_display displayCtrl 33007) ctrlShow false;
(_display displayCtrl 33008) ctrlShow false;

(_display displayCtrl 33005) ctrlEnable (playerSide isEqualTo civilian);

{ if(player distance _x < 20 && ((group player) isEqualTo (group _x))) then {_near_units pushBack _x};} foreach playableUnits;

for "_i" from 0 to (count oev_vehicles)-1 do{
	_veh = oev_vehicles select _i;
	if(!isNull _veh && alive _veh) then {

		_vehDist = round(player distance _veh);
		if(_vehDist > 3000) then {
			_vehDist = "> 3000";
		};

		_name = getText(configFile >> "CfgVehicles" >> (typeOf _veh) >> "displayName");
		_pic = getText(configFile >> "CfgVehicles" >> (typeOf _veh) >> "picture");
		_vehicles lbAdd format["%1 - [%2m]",_name,_vehDist];
		if (_veh getVariable ["oev_cop_reportedStolen", false]) then {
			_vehicles lbSetColor [(lbSize _vehicles) - 1, [1, 0, 0, 1]];
		};
		if(_veh getVariable["markedForAntiDespawn",false]) then {
			_vehicles lbSetColor [(lbSize _vehicles) - 1, [0, 1, 0, 1]];
		};
		if(_pic != "pictureStaticObject") then {
			_vehicles lbSetPicture [(lbSize _vehicles)-1,_pic];
		};
		_vehicles lbSetData [(lbSize _vehicles)-1,str(_i)];
	};
};

private _firstExtraIndex = count _near_units;
private _extraUnits = player getVariable ["life_extraInventoryTargets", []];
_near_units append (player getVariable ["life_extraInventoryTargets", []]);
player setVariable ["life_extraInventoryTargets", []];

{
	if(!isNull _x && alive _x && player distance _x < 20 && _x != player && isNil {_x getVariable "olympusinvis"}) then{
		_plist lbAdd format["%1 - %2",_x getVariable["realname",name _x], side _x];
		_plist lbSetData [(lbSize _plist)-1,str(_x)];
	};
} foreach _near_units;

if (count _extraUnits > 0) then {
	_plist lbSetCurSel _firstExtraIndex;
};

if(((lbSize _vehicles)-1) == -1) then{
	_vehicles lbAdd "您没有任何钥匙。";
	_vehicles lbSetData [(lbSize _vehicles)-1,str(ObjNull)];
};

//if ((__GETC__(oev_donator)) < 15) exitWith {(_display displayCtrl 33007) ctrlEnable false};
if (vehicle player isEqualTo player) exitWith {(_display displayCtrl 33007) ctrlEnable false};

{
	private _index = _underglow lbAdd (_x select 0);
	_underglow lbSetData [_index,_x select 1];
	} forEach [
	["Red",'[255,0,0]'],
	["Green",'[0,255,0]'],
	["Blue",'[0,0,255]'],
	["White",'[255,255,255]'],
	["Purple",'[50,0,128]'],
	["Hot Pink",'[128,0,128]'],
	["Yellow",'[255,255,0]'],
	["Light Blue",'[0,153,204]'],
	["Burnt Orange",'[255,163,7]'],
	["Turquoise",'[64,224,208]'],
	["Mint Green",'[0,204,102]'],
	["Dodger Blue",'[30,144,255]']
];

/*
switch (playerSide) do {
	case west: {
		{
			private _index = _underglow lbAdd (_x select 0);
			_underglow lbSetData [_index,_x select 1];
			} forEach [
			["Blue",'[0,0,255]'],
			["Light Blue",'[0,153,204]'],
			["Dodger Blue",'[30,144,255]'],
			["White",'[255,255,255]'],
			["Red",'[255,0,0]']
		];
	};
	case independent: {
		{
			private _index = _underglow lbAdd (_x select 0);
			_underglow lbSetData [_index,_x select 1];
			} forEach [
			["Green",'[0,255,0]'],
			["White",'[255,255,255]'],
			["Mint Green",'[0,204,102]'],
			["Turquoise",'[64,224,208]']
		];
	};
	case civilian: {
		{
			private _index = _underglow lbAdd (_x select 0);
			_underglow lbSetData [_index,_x select 1];
			} forEach [
			["Red",'[255,0,0]'],
			["Green",'[0,255,0]'],
			["Blue",'[0,0,255]'],
			["White",'[255,255,255]'],
			["Purple",'[128,0,128]'],
			["Hot Pink",'[255,105,180]'],
			["Yellow",'[255,255,0]'],
			["Light Blue",'[0,153,204]'],
			["Burnt Orange",'[181,73,7]'],
			["Turquoise",'[64,224,208]'],
			["Mint Green",'[0,204,102]'],
			["Steel Blue",'[70,130,180]']
		];
	};
}; */