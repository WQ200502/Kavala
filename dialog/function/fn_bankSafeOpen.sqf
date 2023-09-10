//	File: fn_bankSafeOpen.sqf
//	Author: Bryan "Tonic" Boardwine
//	Modifications by TheCmdrRex for the Altis Bank
//	Modifications by mohsen98 - "76561198964849672" for fix Players cant access vault when person who was using vault Disconnect
//	Description: Opens the safe inventory menu.

if(dialog) exitWith {}; //A dialog is already open.
life_bankSafe = param [0,ObjNull,[ObjNull]];
if(isNull life_bankSafe) exitWith {};
if(playerSide != civilian) exitWith {};
if((life_bankSafe getVariable["safe",-1]) < 1) exitWith {hint localize "STR_Civ_VaultEmpty";};
if(!(life_bankSafe getVariable ["inUse","0"] isEqualTo (getPlayerUID player)) && !([life_bankSafe getVariable ["inUse","0"]] call OEC_fnc_isUIDActive)) then {
	life_bankSafe setVariable["inUse",(getPlayerUID player),true];
};
if(!(life_bankSafe getVariable ["inUse","0"] isEqualTo (getPlayerUID player)) && ([life_bankSafe getVariable ["inUse","0"]] call OEC_fnc_isUIDActive)) exitWith {
	hint localize "STR_Civ_VaultInUse"
};
//private _copCount = [west,2] call OEC_fnc_playerCount;
//if(_copCount < 5) exitWith {hint localize "STR_Civ_NotEnoughCops"};
["Bank_Safe"] call OEC_fnc_createDialog;
disableSerialization;
ctrlSetText[3551,(localize "STR_Civ_SafeInv")];
[life_bankSafe] call OEC_fnc_bankSafeInventory;
[life_bankSafe] spawn{
	waitUntil {isNull (findDisplay 3550)};
	(_this select 0) setVariable["inUse",nil,true];
	//(_this select 0) setVariable["inUse","0",true];
};
