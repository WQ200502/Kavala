//  File: fn_dopeMagRefill.sqf
//	Author: trimo
//	Description: Refills magazines at dope crate

private ["_crateOwner", "_val"];
(_this select 3) params [
	["_crate", objNull, [objNull]],
	["_val", 0, [0]]
];

_crateOwner = _crate getVariable ["owner", ""];

private _playerObject = objNull;
{
	if(isPlayer _x && getPlayerUID _x isEqualTo _crateOwner) exitWith {
		_playerObject = _x;
	};
} forEach playableUnits;

if (oev_cash < _val && oev_atmcash < _val) exitWith {hint "你付不起补充弹药的钱。";};

private _action = [
	format ["您确定花费%1元重新补充弹药吗?", [_val] call OEC_fnc_numberText],
	"确认",
	"是",
	"否"
] call BIS_fnc_guiMessage;

if (_action) then {
	if (oev_cash >= _val) then {
		oev_cash = oev_cash - _val;
		oev_cache_cash = oev_cache_cash - _val;
		[] call OEC_fnc_refillMags;
		[3,500,name player] remoteExec ["OEC_fnc_payPlayer", _playerObject];

	} else {
		oev_atmcash = oev_atmcash - _val;
		oev_cache_atmcash = oev_cache_atmcash - _val;
		[] call OEC_fnc_refillMags;
		[3,500,name player] remoteExec ["OEC_fnc_payPlayer", _playerObject];
	};
};