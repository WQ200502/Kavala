// File: fn_clearBWCrate.sqf
// Author: Jesse "tkcjesse" Schultz
// Description: Clears out the BW crate of gear and stuffz for APD

params [["_crateObj",objNull,[objNull]]];

if !(typeOf _crateObj isEqualTo "B_Slingload_01_Cargo_F") exitWith {};
if (_crateObj getVariable ["locked",false]) exitWith {hint "This container has already been sealed shut!";};
if ((vehicle player) != player) exitWith {hint "This action cannot be performed from within a vehicle.";};

//Setup progress bar.
disableSerialization;
5 cutRsc ["life_progress","PLAIN DOWN"];
private _ui = uiNameSpace getVariable "life_progress";
private _progress = _ui displayCtrl 38201;
private _pgText = _ui displayCtrl 38202;
private _upp = "Sealing Blackwater Container";
_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
_progress progressSetPosition 0.01;
private _cP = 0.01;

oev_action_inUse = true;
[0,format["%1 has started sealing a Blackwater container.",name player]] remoteExecCall ["OEC_fnc_broadcast",-2];

while {true} do {
	uiSleep 0.52;
	_cP = _cP + 0.01;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
	if (_cP >= 1) exitWith {};
	if (player distance _crateObj > 6) exitWith {};
	if (vehicle player != player) exitWith {};
	if !(alive player) exitWith {};
	if (player getVariable ["restrained",false]) exitWith {};
	if (oev_interruptedTab) exitWith {};
};

if (player distance _crateObj > 6) exitWith {hint "You need to stay within 6m to seal the container."; 5 cutText ["","PLAIN DOWN"]; oev_action_inUse = false;};
if !(alive player) exitWith {5 cutText ["","PLAIN DOWN"]; oev_action_inUse = false;};
if (vehicle player != player) exitWith {5 cutText ["","PLAIN DOWN"]; oev_action_inUse = false;};
if (player getVariable ["restrained",false]) exitWith {5 cutText ["","PLAIN DOWN"]; oev_action_inUse = false;};
if (oev_interruptedTab) exitWith {hint "You have interrupted sealing of the container!"; oev_interruptedTab = false; 5 cutText ["","PLAIN DOWN"]; oev_action_inUse = false;};

clearBackpackCargoGlobal _crateObj;
clearWeaponCargoGlobal _crateObj;
clearMagazineCargoGlobal _crateObj;
clearItemCargoGlobal _crateObj;

_crateObj setVariable ["locked",true,true];

5 cutText ["","PLAIN DOWN"];
oev_action_inUse = false;
[0,format["%1 has sealed a Blackwater container.",name player]] remoteExecCall ["OEC_fnc_broadcast",-2];
[
	["event", "Sealed BW Container"],
	["player", name player],
	["player_id", getPlayerUID player],
	["position", getPos Player]
]	call OEC_fnc_logIt;
