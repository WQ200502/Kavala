#include "..\..\macro.h"
//  File: fn_bankSafeTake.sqf
//	Author: Bryan "Tonic" Boardwine
//	Modified by TheCmdrRex for use at the Altis Bank
//	Description: Gateway to fn_vehTakeItem.sqf but for safe(s).
private["_ctrl","_num","_safeInfo"];
disableSerialization;

if((lbCurSel 3552) == -1) exitWith {hint localize "STR_Civ_SelectItem";};
_ctrl = getSelData(3552);
_num = ctrlText 3555;
_safeInfo = life_bankSafe getVariable["safe",0];

//Error checks
if(!([_num] call OEC_fnc_isNumeric)) exitWith {hint localize "STR_MISC_WrongNumFormat";};
_num = parseNumber(_num);
if(_num < 1) exitWith {hint localize "STR_Cop_VaultUnder1";};
if(_ctrl != "moneybag") exitWith {hint "保险箱里除了金条你什么都不能拿。";};
if(_num > _safeInfo) exitWith {hint format["There isn't %1 moneybag(s) in the safe!",_num];};

//Secondary checks
_num = [_ctrl,_num,oev_carryWeight,oev_maxWeight] call OEC_fnc_calWeightDiff;
if(_num == 0) exitWith {hint localize "STR_NOTF_InvFull"};


//Take it
if(!([true,_ctrl,_num] call OEC_fnc_handleInv)) exitWith {hint localize "STR_NOTF_CouldntAdd";};
life_bankSafe setVariable["safe",_safeInfo - _num,TRUE];
[life_bankSafe] call OEC_fnc_bankSafeInventory;