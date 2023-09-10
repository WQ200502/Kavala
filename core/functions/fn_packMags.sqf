#include <zmacro.h>
if(scriptAvailable(15)) exitWith {hint "You cannot spam magazine packing...";};
// File: fn_packMags.sqf
// Author: Jesse "tkcjesse" Schultz
// Credits to Exilemod for the base of this to be used here in Altis Life

if !(alive player) exitWith {};
if (oev_action_inUse) exitWith {hint "您已经在执行另一个操作。";};

oev_action_inUse = true;
_upp = "Combining Magazines";
disableSerialization;
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNameSpace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
_cP = 0;

private _exit = false;

while {true} do {
	uiSleep 0.1;
	_cP = _cP + 0.01;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
	if (_cP >= 1) exitWith {};
	if!(alive player) exitWith {_exit = true;};
	if (oev_interrupted) exitWith {_exit = true; oev_interrupted = false;};
};

oev_action_inUse = false;
5 cutText ["","PLAIN DOWN"];
player playActionNow "stop";
if (_exit) exitWith {systemChat "子弹重新打包已停止。。。";};

private _fnc_repackMags = {
	private ["_ammoPerMagazine","_ammoToRefund","_equippedAmmo","_ammoToRefundThisRound"];
	_ammoPerMagazine = getNumber(configFile >> "CfgMagazines" >> (_this select 0) >> "count");
	_equippedAmmo = 0;
	if (_ammoPerMagazine > 1) then {
		{
			if ((_x select 0) isEqualTo (_this select 0)) then {
				_equippedAmmo = _equippedAmmo + (_x select 1);
			};
		} forEach magazinesAmmo player;

		player removeMagazines (_this select 0);
		_ammoToRefund = _equippedAmmo + 0;
		while {_ammoToRefund > 0} do {
			_ammoToRefundThisRound = _ammoToRefund min _ammoPerMagazine;
			player addMagazine [(_this select 0), _ammoToRefundThisRound];
			_ammoToRefund = _ammoToRefund - _ammoToRefundThisRound;
		};
	};
};

private _packedMags = [];
{
	if !(_x in _packedMags) then {
		[_x] call _fnc_repackMags;
		_packedMags pushBack _x;
	};
} forEach magazines player;

systemChat "All magazines have been repacked.";