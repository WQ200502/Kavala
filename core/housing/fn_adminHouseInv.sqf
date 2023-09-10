#include "..\..\macro.h"
//  File: fn_adminHouseInv.sqf
//	Author: Kurt
//	Description: Physical items displayed on y-menu
private["_tInv","_pInv","_data","_icon","_storeBtn","_takeBtn","_details","_pEdit","_tEdit","_className","_str"];
params [
	["_veh",objNull,[objNull]],
	["_isVirtual",true,[true]]
];
if(isNull _veh || !alive _veh) exitWith {closeDialog 0;}; //If null / dead exit menu
if !(oev_adminForce) exitWith {closeDialog 0;};
if ((call life_adminlevel) < 3) exitWith {closeDialog 0;};
disableSerialization;

//Set up the buttons and inventory interfaces
_tInv = (findDisplay 4500) displayCtrl 4502;
_pInv = (findDisplay 4500) displayCtrl 4503;
_storeBtn = (findDisplay 4500) displayCtrl 4508;
_takeBtn = (findDisplay 4500) displayCtrl 4507;
_pEdit = (findDisplay 4500) displayCtrl 4506;
_tEdit = (findDisplay 4500) displayCtrl 4505;

//Initially clear all interfaces
lbClear _tInv;
lbClear _pInv;

/* Commenting out for now cause not sure what this portion is actually used for in game.
 --- It is used for comepnsation crates to prevent people not allowed to take/store items in them based on uid, see Jesse for further help
if (typeOf _veh isEqualTo "IG_supplyCrate_F") then {
	_storeBtn ctrlEnable false;
	if (((_veh getVariable ["owner",["",""]]) select 0) isEqualTo (getPlayerUID player)) then {
		_takeBtn ctrlEnable false;
	};
};*/

if (_isVirtual) then {
	_data = _veh getVariable ["Trunk",[]];
	private _curWeight = 0;
	if(count _data == 0) then {_veh setVariable["Trunk",[[],0],true]; _data = [];} else {_curWeight = _data select 1; _data = _data select 0;};
	private _vehdata = [0,0];
	private _mWeight = 0;
	if !(typeOf _veh isEqualTo "Land_i_Shed_Ind_F") then {
		ctrlSetText[4501,format["House Storage - %1",_veh getVariable ["house_id",-1]]];
		_vehdata = [(_veh getVariable["storageCapacity",100]),(_veh getVariable["Trunk",[[],0]]) select 1];
	} else {
		ctrlSetText[4501,format["Gang Storage - %1",_veh getVariable ["bldg_id",-1]]];
		_vehdata = [(_veh getVariable["storageCapacity",1000]),(_veh getVariable["Trunk",[[],0]]) select 1];
	};
	ctrlSetText[4504,format[(localize "STR_MISC_Weight")+ " %1/%2",_vehdata select 1,_vehdata select 0]];

	//All virtual items Items
	{
		_shrt = [_x,0] call OEC_fnc_varHandle;
		_str = [_shrt] call OEC_fnc_varToStr;
		_icon = [_shrt] call OEC_fnc_iconConfig;

		_pInv lbAdd format ["%1",_str];
		_pInv lbSetData [(lbSize _pInv)-1,_x];
		_pInv lbSetPicture [(lbSize _pInv)-1,_icon];
	} forEach ((["admin"] call OEC_fnc_virt_shops) select 1);

	//Trunk Inventory Items
	{
		if((_x select 0) != "money") then {
			_var = [_x select 0,0] call OEC_fnc_varHandle;
			_name = [_var] call OEC_fnc_varToStr;
			_icon = [_var] call OEC_fnc_iconConfig;
			_val = _x select 1;
			if(_val > 0) then {
				_tInv lbAdd format["[%1] - %2",_val,_name];
				_tInv lbSetData [(lbSize _tInv)-1,_x select 0];
				_tInv lbSetPicture [(lbSize _tInv)-1,_icon];
			};
		} else {
			_val = _x select 1;
			if(_val > 0) then {
				_tInv lbAdd format["$%1",[_val] call OEC_fnc_numberText];
				_tInv lbSetData [(lbSize _tInv)-1,"money"];
			};
		};
	} forEach _data;
} else {
	_data = _veh getVariable ["PhysicalTrunk",[]];
	private _curWeight = 0;
	if(count _data == 0) then {
		_veh setVariable["PhysicalTrunk",[[],0],true]; _data = [];
	} else {
		_data = _data select 0;
	};
	private _vehdata = [0,0];
	if !(typeOf _veh isEqualTo "Land_i_Shed_Ind_F") then {
		ctrlSetText[4501,format["House Storage - %1",_veh getVariable ["house_id",-1]]];
		_vehdata = [(_veh getVariable["physicalStorageCapacity",100]),(_veh getVariable["PhysicalTrunk",[[],0]]) select 1];
	} else {
		ctrlSetText[4501,format["Gang Storage - %1",_veh getVariable ["bldg_id",-1]]];
		_vehdata = [(_veh getVariable["physicalStorageCapacity",300]),(_veh getVariable["PhysicalTrunk",[[],0]]) select 1];
	};
	ctrlSetText[4504,format[(localize "STR_MISC_Weight")+ " %1/%2",_vehdata select 1,_vehdata select 0]];
	private _pCache = [];
	private _index = -1;
	private _tempItem = "";

	for "_i" from 0 to (count(missionConfigFile >> "CfgWeights")-1) do {
		_className = (configName ((missionConfigFile >> "CfgWeights") select _i));

		if (isClass (configFile >> "CfgWeapons" >> _className)) then {
			_str = getText(configFile >> "CfgWeapons" >> _className >> "DisplayName");
			_icon = getText(configFile >> "CfgWeapons" >> _className >> "picture");
		};

		if (isClass (configFile >> "CfgVehicles" >> _className)) then {
			_str = getText(configFile >> "CfgVehicles" >> _className >> "DisplayName");
			_icon = getText(configFile >> "CfgVehicles" >> _className >> "picture");
		};

		if (isClass (configFile >> "CfgMagazines" >> _className)) then {
			_str = getText(configFile >> "CfgMagazines" >> _className >> "DisplayName");
			_icon = getText(configFile >> "CfgMagazines" >> _className >> "picture");
		};

		if (isClass (configFile >> "CfgGlasses" >> _className)) then {
			_str = getText(configFile >> "CfgGlasses" >> _className >> "DisplayName");
			_icon = getText(configFile >> "CfgGlasses" >> _className >> "picture");
		};

		_pInv lbAdd format ["%1", _str];
		_pInv lbSetData [(lbSize _pInv)-1, _className];
		_pInv lbSetValue [(lbSize _pInv)-1, 200];
		_pInv lbSetPicture [(lbSize _pInv)-1, _icon];
	};

	//Trunk Inventory Items
	{
		_details = [_x select 0] call OEC_fnc_fetchCfgDetails;
    	_str = format["%1",(getText(configFile >> (_details select 6) >> _x select 0 >> "DisplayName"))];
		_shrt = _x select 0;
		_icon = getText(configFile >> (_details select 6) >> _x select 0 >> "picture");
		_tInv lbAdd format["[%1] - %2",_x select 1,_str];
		_tInv lbSetData [(lbSize _tInv)-1,_shrt];
		_tInv lbSetValue [(lbSize _tInv)-1,_x select 1];
		_tInv lbSetPicture [(lbSize _tInv)-1,_icon];
	} foreach _data;
};


