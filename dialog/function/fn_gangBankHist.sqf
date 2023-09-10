#include "..\..\macro.h"
//	File: fn_gangBankHist.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Description: Populates the gang bank history for withdrawals/deposits.

["life_gang_bank_history"] call OEC_fnc_createDialog;

oev_gangBank_History = [];
oev_gangHistory_Ready = false;
[[(oev_gang_data select 0),player],"OES_fnc_gangBHistory",false,false] spawn OEC_fnc_MP;

disableSerialization;

[] spawn{
	waitUntil {oev_gangHistory_Ready || !(alive player)};
	if !(alive player) exitWith {};
	if (count oev_gangBank_History isEqualTo 0) exitWith {
		hint "Failed to fetch gang history.";
		oev_gangHistory_Ready = false;
	};
	uiSleep 0.5;
	disableSerialization;
	private ["_display","_list","_type"];
	_display = findDisplay 100300;
	_list = _display displayCtrl 100302;
	_list lnbAddColumn 0;
	_list lnbSetColumnsPos [0.002,0.5,0.75];

	{
		_type = switch (_x select 2) do {
			case 1: {"Deposited"};
			case 2: {"Withdrew"};
			case 3: {"Shed Purchase"};
			case 4: {"Shed Crates"};
			case 5: {"Shed Y-Inventory"};
			case 6: {"Shed Rent"};
			case 7: {"Oil Addon"};
			default {""};
		};

		_list lnbAddRow [format["%1 (%2)",_x select 0,_x select 1],_type,format["%1元",[_x select 3] call OEC_fnc_numberText]];
	} forEach oev_gangBank_History;

	oev_gangBank_History = [];
	oev_gangHistory_Ready = false;
};