#include "..\macro.h"
/*
	Master eventhandler file
*/
player addEventHandler ["Killed", {_this call OEC_fnc_onPlayerKilled}];
player addEventHandler ["handleDamage",{_this call OEC_fnc_handleDamage;}];
player addEventHandler ["Respawn", {_this call OEC_fnc_onPlayerRespawn}];
player addEventHandler ["Take",{_this call OEC_fnc_onTakeItem}]; //Prevent people from taking stuff they shouldn't...
player addEventHandler ["Put",{_this call OEC_fnc_onPutItem}]; //Prevent people from taking stuff they shouldn't...
player addEventHandler ["Fired",{_this call OEC_fnc_onFired}];
player addEventHandler ["InventoryClosed", {_this call OEC_fnc_inventoryClosed}];
player addEventHandler ["InventoryOpened", {_this call OEC_fnc_inventoryOpened}];
player addEventHandler ["FiredNear",{if (__GETC__(life_adminlevel) < 2) then {oev_inCombat = true; oev_inCombatTime = diag_tickTime;};}];
player addEventHandler ["FiredMan",{if (__GETC__(life_adminlevel) < 2) then {oev_inCombat = true; oev_inCombatTime = diag_tickTime;}; if (oev_conqGod) then {oev_conqGod = false;};}];
player addEventHandler ["HandleHeal", {oev_healingTime = diag_tickTime;}];
player addEventHandler ["HandleRating",{0}];

// View distance + gang vehicles
{
    player addEventHandler [_x, {
		_this call OEC_fnc_updateGangVehicleUsers;
		_this call OEC_fnc_updateViewDistance;
		_this call OEC_fnc_updateLastSeen;
	}];
} forEach ["GetInMan", "GetOutMan"];

// stolen vehicle detection
player addEventHandler ["GetInMan", {
	params [
		["_unit", objNull, [objNull]],
		["_role", "cargo", [""]],
		["_vehicle", objNull, [objNull]]
	];
  if(_vehicle getVariable["unused",false]) then {
  	_vehicle setVariable["unused",nil,true];
  };
	if (isNull _unit || isNull _vehicle) exitWith {};
	if !(_role isEqualTo "driver") exitWith {};
	private _uid = getPlayerUID _unit;
	if (_uid == "") exitWith {};
	if (_unit getVariable ["restrained", false]) exitWith {};
	if (side _unit != civilian) exitWith {};
	private _vehicleData = _vehicle getVariable ["vehicle_info_owners", []];
	if (_vehicleData findIf { _x param [0, "", [""]] isEqualTo _uid } < 0) then {
		_vehicle setVariable ["oev_cop_stolen", true, true];
	};
}];

if (playerSide isEqualTo independent) then {
	player addEventHandler ["GetInMan", {
		_this spawn OEC_fnc_checkMedVehicle;
	}];

	player addEventHandler ["SeatSwitchedMan", {
		_this spawn OEC_fnc_checkMedVehicle;
	}];
};

addMissionEventHandler ["Map",{_this call OEC_fnc_checkMap}];
//"OEC_fnc_MP_packet" addPublicVariableEventHandler {[_this select 0,_this select 1] call OEC_fnc_MPexec;};

"life_phone_channel" addPublicVariableEventHandler
{
	_message = if (life_phone_channel < 0) then { "你的语音通话已经结束." } else { "语音通话已经成功建立!" };
	[[0,2], _message] call life_fnc_broadcast;
	if (life_phone_channel > -1) then { life_phone_status = 3; setCurrentChannel life_phone_channel; };
};
