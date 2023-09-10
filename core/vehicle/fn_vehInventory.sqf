//  File: fn_vehInventory.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Used a refresher for the vehicle inventory / trunk menu items.
private["_veh","_tInv","_pInv","_veh_data","_mods","_trunkUpgrade","_icon","_storeBtn","_takeBtn"];
_veh = param [0,ObjNull,[ObjNull]];
if(isNull _veh || !alive _veh) exitWith {closeDialog 0;}; //If null / dead exit menu
disableSerialization;

_tInv = (findDisplay 3500) displayCtrl 3502;
_pInv = (findDisplay 3500) displayCtrl 3503;
_storeBtn = (findDisplay 3500) displayCtrl 3508;
_takeBtn = (findDisplay 3500) displayCtrl 3507;

lbClear _tInv;
lbClear _pInv;

if (typeOf _veh isEqualTo "IG_supplyCrate_F") then {
	_storeBtn ctrlEnable false;
};

_trunkUpgrade = 0;
if(_veh isKindOf "House_F") then {
	private["_mWeight"];
	_mWeight = _veh getVariable ["storageCapacity",100];
	_veh_data = [_mWeight,(_veh getVariable["Trunk",[[],0]]) select 1];
} else {
	_veh_data = [_veh] call OEC_fnc_vehicle1Weight;
	_mods = _veh getVariable["modifications",[0,0,0,0,0,0,0,0]];
	_trunkUpgrade = round((_mods select 1) * ((_veh_data select 0) * 0.05));

};

if(_veh_data select 0 == -1) exitWith {closeDialog 0};

_veh_data set[0,((_veh_data select 0) + _trunkUpgrade)];

ctrlSetText[3504,format["Weight: %1/%2",_veh_data select 1,_veh_data select 0]];
_data = _veh getVariable ["Trunk",[]];
if(count _data == 0) then {_veh setVariable["Trunk",[[],0],true]; _data = [];} else {_data = _data select 0;};
//Player Inventory Items
{
	//Money Handle
	if(_x != "oev_cash") then
	{
		_str = [_x] call OEC_fnc_varToStr;
		_shrt = [_x,1] call OEC_fnc_varHandle;
		_icon = [_x] call OEC_fnc_iconConfig;
		_val = missionNameSpace getVariable _x;
		if(_val > 0) then
		{
			_pInv lbAdd format["[%1] - %2",_val,_str];
			_pInv lbSetData [(lbSize _pInv)-1,_shrt];
			_pInv lbSetPicture [(lbSize _pInv)-1,_icon];
		};
	}
		else
	{
		if(oev_cash > 0) then
		{
			_pInv lbAdd format["$%1",[oev_cash] call OEC_fnc_numberText];
			_pInv lbSetData [(lbSize _pInv)-1,"money"];
		};
	};
} foreach oev_inv_items;

//Trunk Inventory Items
{
	if((_x select 0) != "money") then
	{
		_var = [_x select 0,0] call OEC_fnc_varHandle;
		_name = [_var] call OEC_fnc_varToStr;
		_icon = [_var] call OEC_fnc_iconConfig;
		_val = _x select 1;
		if(_val > 0) then
		{
			_tInv lbAdd format["[%1] - %2",_val,_name];
			_tInv lbSetData [(lbSize _tInv)-1,_x select 0];
			_tInv lbSetPicture [(lbSize _tInv)-1,_icon];
		};
	}
		else
	{
		_val = _x select 1;
		if(_val > 0) then
		{
			_tInv lbAdd format["$%1",[_val] call OEC_fnc_numberText];
			_tInv lbSetData [(lbSize _pInv)-1,"money"];
		};
	};
} foreach _data;
