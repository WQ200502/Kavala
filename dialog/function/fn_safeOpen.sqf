//	File: fn_safeOpen.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Description: Opens the safe inventory menu.
//	Modifications by mohsen98 "76561198964849672"

if(dialog) exitWith {}; //A dialog is already open.
life_safeObj = param [0,ObjNull,[ObjNull]];
if(isNull life_safeObj) exitWith {};
if(playerSide != civilian) exitWith {};
if((life_safeObj getVariable["safe",-1]) < 1) exitWith {hint localize "STR_Civ_VaultEmpty";};
if(!(life_safeObj getVariable ["inUse","0"] isEqualTo (getPlayerUID player)) && !([life_safeObj getVariable ["inUse","0"]] call OEC_fnc_isUIDActive)) then {
	life_safeObj setVariable["inUse",(getPlayerUID player),true];
};
if(!(life_safeObj getVariable ["inUse","0"] isEqualTo (getPlayerUID player)) && ([life_safeObj getVariable ["inUse","0"]] call OEC_fnc_isUIDActive)) exitWith {
	hint localize "STR_Civ_VaultInUse"
};
//private _copCount = [west,2] call OEC_fnc_playerCount;
//if(_copCount < 5) exitWith {hint localize "STR_Civ_NotEnoughCops"};
["Federal_Safe"] call OEC_fnc_createDialog;
disableSerialization;
ctrlSetText[3501,(localize "STR_Civ_SafeInv")];
[life_safeObj] call OEC_fnc_safeInventory;
[life_safeObj] spawn{
	waitUntil {isNull (findDisplay 3500)};
	(_this select 0) setVariable["inUse",nil,true];
	//(_this select 0) setVariable["inUse","0",true];
};
