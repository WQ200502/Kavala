#include "..\..\macro.h"
//  File: fn_houseMoveItem.sqf
//	Author: Kurt

//	Description: Moves the item in the trunk for organization purposes

params [
	"_isVirtual",
	"_isUp"
];

disableSerialization;
if(!oev_didServerRespond) exitWith {hint "等待服务器响应，几秒后再试一次..."};

private _lbSelected = lbCurSel 4502;
//If nothing is selected
if(_lbSelected isEqualTo -1) exitWith {};

//Get the handles
_playerItemSelected = getSelData(4502); //Item Selected

//Safety exit if no classname associated with the selection
if(_playerItemSelected isEqualTo "") exitWith {};

//Distance check
private _vehPos = getPos oev_trunk_vehicle;
private _playerPos = getPos player;
if (_vehPos distance _playerPos > 10) exitWith {hint "你离得太远了!"; closeDialog 0;};

//Getting trunk inventory
private _trunkDetails = if (_isVirtual) then {
	(oev_trunk_vehicle getVariable ["Trunk",[[],0]]);
} else {
	(oev_trunk_vehicle getVariable ["PhysicalTrunk",[[],0]]);
};
private _trunkInv = _trunkDetails select 0;
private _trunkWeight = _trunkDetails select 1;

//Check if it is at the top or bottom of the list
private _trunkLength = count _trunkInv;
if (((_lbSelected isEqualTo 0) && _isUp) || ((_lbSelected isEqualTo (_trunkLength - 1)) && !(_isUp))) exitWith {};

//Assemble new array to set to the house
private _arrayItemSelected = _trunkInv select _lbSelected;
private _newTrunkInventory = [];

_newTrunkInventory = if (_isUp) then {
	//Accumulate the beginning of the array
	private _newInv = _trunkInv select [0,_lbSelected - 1];
	//Append the item that we wanted to swap
	_newInv append [(_trunkInv select _lbSelected)];
	//Append the item that got swapped
	_newInv append [(_trunkInv select (_lbSelected - 1))];
	//Append the rest of the array
	_newInv append (_trunkInv select [_lbSelected + 1,(_trunkLength - (_lbSelected + 1))]);
	_newInv;
} else {
	//Accumulate the beginning of the array
	private _newInv = _trunkInv select [0,_lbSelected];
	//Append the item that we wanted to swap
	_newInv append [(_trunkInv select _lbSelected + 1)];
	//Append the item that got swapped
	_newInv append [(_trunkInv select (_lbSelected))];
	//Append the rest of the array
	_newInv append (_trunkInv select [_lbSelected + 2,(_trunkLength - (_lbSelected + 1))]);
	_newInv;
};

//Safety check
if (count _newTrunkInventory isEqualTo 0) exitWith{};

//Save the new arrays to the house
if (_isVirtual) then {
	oev_trunk_vehicle setVariable["Trunk",[_newTrunkInventory,_trunkWeight]];
	[oev_trunk_vehicle, true] call OEC_fnc_houseInventory;
} else {
	oev_trunk_vehicle setVariable["PhysicalTrunk",[_newTrunkInventory,_trunkWeight]];
	[oev_trunk_vehicle, false] call OEC_fnc_houseInventory;
};

//Finally, set the selected cursor based on whether youy moved it up or down
if (_isUp) then {
	lbSetCurSel [4502, _lbSelected - 1];
} else {
	lbSetCurSel [4502, _lbSelected + 1];
};
oev_movedHouseItem = true;