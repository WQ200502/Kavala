//  File: fn_unlockInv.sqf
//	Author: Jesse "tkcjesse" Schultz

//	Description: Unlock Inventory of a building

params [
	["_building",objNull,[objNull]],
	["_mode",-2,[0]]
];
if (isNull _building || _mode isEqualTo -2) exitWith {};

if (_mode isEqualTo 0) then {
	_building setVariable ["inv_locked",false,true];
	systemChat "建筑库存现已解锁！";
} else {
	_building setVariable ["inv_locked",true,true];
	systemChat "建筑库存现已上锁!";
};