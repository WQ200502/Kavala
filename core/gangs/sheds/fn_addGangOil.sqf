//  File: fn_addGangOil.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Description: Gives the gang building the ability to have oil storage

params [
	["_building",objNull,[objNull]]
];
if (isNull _building) exitWith {};
if (!license_civ_home) exitWith {hint localize "STR_House_License"};
if !(typeOf _building isEqualTo "Land_i_Shed_Ind_F") exitWith {};
if ((oev_gang_data select 2) < 4) exitWith {};
if (oev_action_inUse) exitWith {};

if (_building getVariable ["oilstorage",false]) exitWith {hint "This gang building has the ability to store oil!";};

oev_action_inUse = true;
oev_gangfund_ready = false;
oev_gang_funds = -1;
[[0,oev_gang_data select 0,player],"OES_fnc_gangBank",false,false] spawn OEC_fnc_MP;

waitUntil{oev_gangfund_ready};
uiSleep 0.5;

if (oev_gang_funds < 500000) exitWith {hint "You don't have enough money in your gang bank to make this purchase!"; oev_action_inUse = false;};

private _action = [
	"Are you sure you would like to spend $500,000 to renovate the property to allow for oil storage?",
	"Purchase Oil Addon",
	localize "STR_Global_Buy",
	localize "STR_Global_Cancel"
] call BIS_fnc_GUImessage;

if (_action) then {
	[[_building,player],"OES_fnc_updateGangOil",false,false] spawn OEC_fnc_MP;
	hint "Renovating gang building...";
};