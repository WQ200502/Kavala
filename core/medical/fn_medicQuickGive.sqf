params [
	["_target", objNull, [objNull]],
	["_itemShort", "", [""]],
	["_quantity", 1, [0]]
];
private ["_itemVar", "_itemName"];
if !(playerSide isEqualTo independent) exitWith {};
if (isNull _target) exitWith {};
if ([_target, player] findIf { _x getVariable ["restrained", false] } >= 0) exitWith {
	hint "You cannot transfer items while either player is restrained.";
};

_itemVar = [_itemShort, 0] call OEC_fnc_varHandle;
_itemName = [_itemVar] call OEC_fnc_varToStr;

if !([false, _itemShort, _quantity] call OEC_fnc_handleInv) exitWith {
	hint format ["You don't have enough %1 on you to give.", _itemName];
};

[_target, str(_quantity), _itemShort, player] remoteExec ["OEC_fnc_receiveItem", _target];
hint format ["You gave %1 %2 %3", _target getVariable ["realname", name _target], _quantity, _itemName];

[
	["event","Medic Quick Give"],
	["player",name player],
	["player_id",getPlayerUID player],
	["target",name _target],
	["target_id",getPlayerUID _target]
] call OEC_fnc_logIt;
[false] call OEC_fnc_saveGear;
if !(oev_newsTeam) then {
	[3] call OEC_fnc_ClupdatePartial;
};
