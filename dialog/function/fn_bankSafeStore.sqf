#include "..\..\macro.h"
//  File: fn_bankSafeStore.sqf
//	Author: Bryan "Tonic" Boardwine
//	Modified by TheCmdrRex for the Altis Bank
//	Description: Gateway copy of fn_vehStoreItem but designed for the safe.
private["_ctrl","_num"];
disableSerialization;
_ctrl = getSelData(3503);
_num = ctrlText 3506;

//Error checks
if(!([_num] call OEC_fnc_isNumeric)) exitWith {hint localize "STR_MISC_WrongNumFormat";};
_num = parseNumber(_num);
if(_num < 1) exitWith {hint localize "STR_Cop_VaultUnder1";};
if(_ctrl != "moneybag") exitWith {hint "除了金条，你什么都不能放在保险箱里。";};
if(_num > life_bankSafe) exitWith {hint format["You don't have %1 moneybag(s)",_num];};

//Store it.
if(!([false,_ctrl,_num] call OEC_fnc_handleInv)) exitWith {hint localize "STR_Cop_CantRemove";};
_safeInfo = life_bankSafe getVariable["safe",0];
life_bankSafe setVariable["safe",_safeInfo + _num,true];

[life_bankSafe] call OEC_fnc_bankSafeInventory;