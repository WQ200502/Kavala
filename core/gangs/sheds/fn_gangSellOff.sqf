//  File: fn_gangSellOff.sqf
//	Author: Jesse "tkcjesse" Schultz

//	Description: Sells off a gang building and awards money

params [
	["_building",objNull,[objNull]]
];
oev_houseTransaction = false;
oev_action_inUse = false;
if (isNull _building) exitWith {};

// Calculate Gangshed Mods Value
private _virtSize = ((_building getVariable["storageCapacity",-1]) - 1000) / 1000;
private _physSize = ((_building getVariable["physicalStorageCapacity",-1]) - 300) / 150;
private _modsValue = 0;
switch (_virtSize) do {
	case 1: {_modsValue = _modsValue + 1500000;};
	case 2: {_modsValue = _modsValue + (1500000 * 2);};
	case 3: {_modsValue = _modsValue + (1500000 * 3);};
	case 4: {_modsValue = _modsValue + (1500000 * 4);};
	case 5: {_modsValue = _modsValue + (1500000 * 5);};
	case 6: {_modsValue = _modsValue + (1500000 * 6);};
	case 7: {_modsValue = _modsValue + (1500000 * 7);};
	case 8: {_modsValue = _modsValue + (1500000 * 8);};
	case 9: {_modsValue = _modsValue + (1500000 * 9);};
};
switch (_physSize) do {
	case 1: {_modsValue = _modsValue + 1500000;};
	case 2: {_modsValue = _modsValue + (1500000 * 2);};
	case 3: {_modsValue = _modsValue + (1500000 * 3);};
	case 4: {_modsValue = _modsValue + (1500000 * 4);};
};
if (_building getVariable ["oilstorage",false]) then {_modsValue = _modsValue + 500000;};

_modsValue = _modsValue * 0.25;

// Set Variables and Add Money
_building setVariable ["locked",false,true];
_building setVariable ["inv_locked",false,true];
_building setVariable ["trunk",nil,true];
_building setVariable ["storageCapacity",0,true];
_building setVariable ["physicalStorageCapacity",0,true];

private _onlineMembers = ([(oev_gang_data select 0)] call OEC_fnc_getOnlineMembers);
if (count _onlineMembers > 0) then {
	[[_building,2],"OEC_fnc_gangBldgMembers",_onlineMembers,false] spawn OEC_fnc_MP;
};

private _preCash = oev_atmcash;
oev_atmcash = oev_atmcash + 15000000 + _modsValue;
oev_cache_atmcash = oev_cache_atmcash + 15000000 + _modsValue;

private _numOfDoors = getNumber(configFile >> "CfgVehicles" >> (typeOf _building) >> "numberOfDoors");
for "_i" from 1 to _numOfDoors do {
	_building setVariable[format["bis_disabled_Door_%1",_i],0,true];
};

[
	["event","Sold Gang Shed"],
	["player",name player],
	["player_id",getPlayerUID player],
	["value",15000000],
	["position",getPosATL player]
] call OEC_fnc_logIt;
