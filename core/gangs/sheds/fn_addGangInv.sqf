//  File: fn_addGangInv.sqf
//	Author: Jesse "tkcjesse" Schultz
//  Modifications: Fusah
//	Description: Upgrades the gang buildings virtual storage limit

params [
	["_building",objNull,[objNull]],
	["_isVirtual",true,[true]]
];
if (isNull _building) exitWith {};
if (!license_civ_home) exitWith {hint localize "STR_House_License"};
if !(typeOf _building isEqualTo "Land_i_Shed_Ind_F") exitWith {};
if ((oev_gang_data select 2) < 4) exitWith {};
if (oev_action_inUse) exitWith {};

private _currentInv = _building getVariable ["storageCapacity",10000];
if (_currentInv >= 10000) exitWith {hint "This gang building has the maximum amount of item storage!";};

oev_action_inUse = true;
oev_gangfund_ready = false;
oev_gang_funds = -1;
[[0,oev_gang_data select 0,player],"OES_fnc_gangBank",false,false] spawn OEC_fnc_MP;

waitUntil{oev_gangfund_ready};
uiSleep 0.5;
if (life_donation_house) then{
	if (oev_gang_funds < 1275000) exitWith {hint "You don't have enough money in your gang bank to make this purchase!"; oev_action_inUse = false;};
	private _action = false;
	if (_isVirtual) then {
		_action = [
			"This building supports up to 10,000 storage space. Would you like to add an additional 1,000 inventory space for $1,275,000?",
			"Purchase Storage Space",
			localize "STR_Global_Buy",
			localize "STR_Global_Cancel"
		] call BIS_fnc_GUImessage;
	} else {
		_action = [
			"This building supports up to 900 physical storage space. Would you like to add an additional 150 inventory space for $1,275,000?",
			"Purchase Storage Space",
			localize "STR_Global_Buy",
			localize "STR_Global_Cancel"
		] call BIS_fnc_GUImessage;
	};
	if (_action) then {
		[[_building,player,_isVirtual],"OES_fnc_updateGangBldg",false,false] spawn OEC_fnc_MP;
		hint "Renovating gang building...";
	};
	} else {
	if (oev_gang_funds < 1500000) exitWith {hint "You don't have enough money in your gang bank to make this purchase!"; oev_action_inUse = false;};

	private _action = false;
	if (_isVirtual) then {
		_action = [
			"This building supports up to 10,000 storage space. Would you like to add an additional 1,000 inventory space for $1,500,000?",
			"Purchase Storage Space",
			localize "STR_Global_Buy",
			localize "STR_Global_Cancel"
		] call BIS_fnc_GUImessage;
	} else {
		_action = [
			"This building supports up to 900 physical storage space. Would you like to add an additional 150 inventory space for $1,500,000?",
			"Purchase Storage Space",
			localize "STR_Global_Buy",
			localize "STR_Global_Cancel"
		] call BIS_fnc_GUImessage;
	};

	if (_action) then {
		[[_building,player,_isVirtual],"OES_fnc_updateGangBldg",false,false] spawn OEC_fnc_MP;
		hint "Renovating gang building...";
	};
};
