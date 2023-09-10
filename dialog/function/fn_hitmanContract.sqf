// 	File: fn_hitmanContract.sqf
// 	Author: TheCmdrRex
//	Description: Handles hitmanContract.hpp dialog

private ["_display","_units","_bounty","_sortedPlayers","_type","_bountyAmnt"];
disableSerialization;

_display = findDisplay 99220;
_units = _display displayCtrl 99222;
_bounty = _display displayCtrl 99221;
_contracts = _display displayCtrl 99227;

// Set up Select Target
_sortedPlayers = [];
{
	if (!(side _x isEqualTo independent) && {((_x getVariable ["hitmanBounty",0]) == 0)} && {!((group player) isEqualTo (group _x))}) then {
		if ((side _x isEqualTo civilian) && {((_x getVariable "gang_data") select 0 == (oev_gang_data select 0))}) exitWith {};
		_type = switch (side _x) do {
			case west: {"Cop"};
			case civilian: {"Civ"};
			default {"???"};
		};
		_sortedPlayers pushBack [format["%1 (%2)",_x getVariable["realname",name _x],_type],_x];
	};
} forEach playableUnits;

_sortedPlayers sort true;
lbClear _units;
{
	_units lbAdd (_x select 0);
	_units lbSetData [(lbSize _units)-1,str(_x select 1)];
}forEach _sortedPlayers;

// Set up Enter Bounty
for "_i" from 1 to 250 step 1 do {
	private _math = (_i * 200000);
	_bounty lbAdd format["%1元",[_math] call OEC_fnc_numberText];
	_bounty lbSetValue [(_i - 1),_math];
};
lbSetCurSel [99221,0];

// Set up Active Contracts
_sortedPlayers = [];
{
	_bountyAmnt = _x getVariable ["hitmanBounty",0];
	if (_bountyAmnt > 0) then {
		_type = switch (side _x) do {
			case west: {"Cop"};
			case civilian: {"Civ"};
			default {"???"};
		};
		_sortedPlayers pushBack [format["%1 (%2) - $%3",_x getVariable["realname",name _x],_type,[_bountyAmnt] call OEC_fnc_numberText],_x];
	};
} forEach playableUnits;

_sortedPlayers sort true;
lbClear _contracts;
{
	_contracts lbAdd (_x select 0);
	_contracts lbSetData [(lbSize _contracts)-1,str(_x select 1)];
}forEach _sortedPlayers;

uiSleep 0.2;
// Setup live changing reciept (Total Cost)
[] spawn{
	private ["_display","_bounty","_bountyText","_feeText","_bountyAmount","_totalFee","_subTotal","_totalText","_bountSel"];
	disableSerialization;
	_display = findDisplay 99220;
	_bounty = _display displayCtrl 99221;
	_bountyText = _display displayCtrl 99223;
	_feeText = _display displayCtrl 99224;
	_totalText = _display displayCtrl 99225;
	while {true} do {
		_bountSel = lbCurSel _bounty;
		_bountyAmount = _bounty lbValue _bountSel;
		if (_bountyAmount > 0 && _bountyAmount <= 50000000) then {
			_bountyText ctrlSetText format ["赏金: %1元",[_bountyAmount] call OEC_fnc_numberText];
			_totalFee = _bountyAmount * oev_hitmanTax;
			_feeText ctrlSetText format ["费用: %1元",[_totalFee] call OEC_fnc_numberText];
			_subTotal = _totalFee + _bountyAmount;
			_totalText ctrlSetText format ["总计: %1元",[_subTotal] call OEC_fnc_numberText];
		};
		uiSleep 0.2;
	};
};