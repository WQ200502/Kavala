params ["_unit", "_role", "_vehicle", "_turret"];
if (playerSide != civilian) exitWith {};
if (count oev_gang_data <= 0) exitWith {};
private _playerGangID = oev_gang_data select 0;
if ((_vehicle getVariable ["gangID", 0]) isEqualTo _playerGangID) then {
	_vehicle setVariable ["oev_hasUsed", true];
};
