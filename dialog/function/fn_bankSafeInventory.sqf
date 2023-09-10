//  File: fn_bankSafeInventory.sqf
//	Author: Bryan "Tonic" Boardwine
//	Modified by TheCmdrRex for the Altis Bank
//	Description: Fills up the safes inventory.

private["_safe","_tInv","_pInv","_safeInfo","_str","_shrt","_icon"];
_safe = param [0,ObjNull,[ObjNull]];
if(isNull _safe) exitWith {closeDialog 0;};
disableSerialization;

_tInv = (findDisplay 3550) displayCtrl 3552;
lbClear _tInv;

_safeInfo = _safe getVariable["safe",-1];
if(_safeInfo < 1) exitWith {closeDialog 0; hint localize "STR_Civ_VaultEmpty";};

_str = ["life_inv_moneybag"] call OEC_fnc_varToStr;
_shrt = ["life_inv_moneybag",1] call OEC_fnc_varHandle;
_icon = ["life_inv_moneybag"] call OEC_fnc_iconConfig;
_tInv lbAdd format["[%1] - %2",_safeInfo,_str];
_tInv lbSetData [(lbSize _tInv)-1,_shrt];
_tInv lbSetPicture [(lbSize _tInv)-1,_icon];