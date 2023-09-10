//  File: fn_gangSellBldg.sqf
//	Author: Jesse "tkcjesse" Schultz

//	Description: Sells off a gang building

params [
	["_building",objNull,[objNull]]
];
if (isNull _building) exitWith {};
if !(typeOf _building isEqualTo "Land_i_Shed_Ind_F") exitWith {};
if (oev_action_inUse) exitWith {};
if !((oev_gang_data select 0) isEqualTo (_building getVariable "bldg_gangid")) exitWith {};
if ((oev_gang_data select 2) < 5) exitWith {hint "You are not of rank to sell the gang building.";};
if (oev_houseTransaction) exitWith {hint "You currently have an active transaction, please wait.";};

closeDialog 0;

private _action = [
	"Are you sure you want to sell your gang building? It will sell for $15,000,000 plus a percentage of upgrades",
	"Sell Gang Building",
	"Sell",
	localize "STR_Global_Cancel"
] call BIS_fnc_GUImessage;

if (_action) then {
	if (oev_houseTransaction) exitWith {hint "You currently have an active transaction, please wait.";};
	oev_houseTransaction = true;
	oev_action_inUse = true;
	_building setVariable["house_sold",true,true];
	[[_building,player],"OES_fnc_sellGangBldg",false,false] spawn OEC_fnc_MP;
	hint "Sending sell request to realtor...";
};
