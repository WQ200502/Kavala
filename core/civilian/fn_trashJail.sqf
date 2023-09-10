// File: fn_jailTrash.sqf
// Author: Jesse "tkcjesse" Schultz
params ["_target"];

if !(typeOf _target isEqualTo "Land_GarbageBags_F") exitWith {};
if (_target getVariable ["deactivated",false]) exitWith {titleText ["You recently searched this trash pile!","PLAIN DOWN"];};
if (oev_action_gathering > 1) exitWith {};
if ((oev_is_arrested select 0) isEqualTo 0) exitWith {};
if ((oev_is_arrested select 1) <= 900) exitWith {titleText ["You can only search for contraband if you have over 15 minutes left on your sentence!","PLAIN DOWN"];};
if (player distance _target > 4) exitWith {titleText ["You need to be closer to the trash pile!","PLAIN DOWN"];};

oev_action_gathering = oev_action_gathering + 1;
if (oev_action_gathering > 1) exitWith {oev_action_gathering = oev_action_gathering - 1;};
oev_action_inUse = true;
private _upp = "Searching for Contraband";
disableSerialization;
5 cutRsc ["life_progress","PLAIN DOWN"];
private _ui = uiNameSpace getVariable "life_progress";
private _progress = _ui displayCtrl 38201;
private _pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
private _cP = 0;
_exit = false;

while {true} do {
	if(animationState player != "AinvPknlMstpSnonWnonDr_medic2") then {
		player playMoveNow "AinvPknlMstpSnonWnonDr_medic2";
	};
	uiSleep 0.32;
	_cP = _cP + 0.0045;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
	if (_cP >= 1) exitWith {};
	if (oev_action_gathering > 1) exitWith {_exit = true;};
	if !(alive player) exitWith {_exit = true;};
	if (player != vehicle player) exitWith {_exit = true;};
	if (oev_interrupted) exitWith {_exit = true;oev_interrupted = false;};
	if ((player distance oev_jailPos2) > 27) exitWith {_exit = true; titleText ["You don't appear to be in jail anymore","PLAIN DOWN"];};
	if (player distance _target > 4) exitWith {_exit = true; titleText ["You need to be close the the vehicle!","PLAIN DOWN"];};
};

player playMoveNow "stop";
player playActionNow "stop";

5 cutText ["","PLAIN DOWN"];
oev_action_inUse = false;
if (_exit) exitWith {oev_action_gathering = oev_action_gathering - 1;};
_target setVariable ["deactivated",true];

private _contraband = 0;
_contraband = round(random(3)) + 1;

titleText [format ["You have found %1 pieces of contraband.",_contraband],"PLAIN DOWN"];
private _allContraband = profileNamespace getVariable ["contraband",0];
_allContraband = _allContraband + _contraband;
profileNamespace setVariable ["contraband",_allContraband];
oev_action_gathering = 0;

[_target] spawn{
	uiSleep (70 + round(random(50)));
	(_this select 0) setVariable ["deactivated",false];
};
