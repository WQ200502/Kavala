// File: fn_epiPen

private["_targetName","_ui","_progressBar","_titleText","_cP","_title","_badDistance","_sameGang"];
params [["_target",objNull,[objNull]]];
_badDistance = false;

if(isNull _target) exitWith {};
if(alive _target) exitWith {};
if(isNull _target) exitWith {};
if((_target getVariable["epiSide",sideUnknown]) != side player) exitWith {hint "You cannot use epi-pens on other factions."};
if(!(_target isKindOf "man")) exitWith {};
if (vehicle player != player) exitWith {hint "You cannot use epi-pens while inside of a vehicle!";};
if(player distance _target > 5) exitWith {hint "You're too far away."};
if(_target getVariable ["Reviving",ObjNull] == player) exitWith {hint localize "STR_Medic_AlreadyReviving";};
if(_target getVariable["epiFailed",false]) exitWith {hint "This player died from improper usage of epi-pens. They require proper medical attention.";};
_sameGang = false;
if ((_target getVariable "gang_data") select 0 == (oev_gang_data select 0)) then {
	_sameGang = true;
};
if (playerSide isEqualTo west && ((_target getVariable["epiSide",sideUnknown]) isEqualTo west)) then {_sameGang = true;};
// Player has to request revive
if (!(_target getVariable["allowEpi",false]) && !(_sameGang)) exitWith {hint "Player has not asked for an epipen.";};
if ((_target getVariable ["maxrevtime",serverTime]) <= serverTime) exitWith {hint "This player has been dead for over 15 minutes...";};

if((_target getVariable["jailed",false]) && (oev_actions_cooldown < time)) exitWith {};
if(_target getVariable["jailed",false]) exitWith {
	oev_actions_cooldown = (time + 35);
};
if(_target getVariable["Reviving",objNull] == player) exitWith {hint localize "STR_Medic_AlreadyReviving";([true,"epiPen",1] call OEC_fnc_handleInv)};
if(_target getVariable["epiActive",false]) exitWith {hint "This player just died from improper usage of epi-pens. They require medical attention.";([true,"epiPen",1] call OEC_fnc_handleInv)};

if(player distance _target > 4) exitWith {hint "You are too far away."}; //Not close enough.

//Fetch their name so we can shout it.
_targetName = _target getVariable["name","Unknown"];
_title = format[localize "STR_Medic_Progress",_targetName];
oev_action_inUse = true; //Lockout the controls.

_target setVariable["Reviving",player,true];
//Setup our progress bar
disableSerialization;
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNamespace getVariable ["life_progress",displayNull];
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;
["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;
while {true} do {
	uiSleep 0.15;
	_cP = _cP + 0.01;
	_progressBar progressSetPosition _cP;
	_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
	if(_cP >= 1 || !alive player) exitWith {};
	if (player getVariable ["downed", false]) exitWith {
		oev_interrupted = true;
	};
	if(oev_interrupted) exitWith {};
	if((player getVariable["restrained",false])) exitWith {};
	if(player distance _target > 4) exitWith {_badDistance = true;};
	if(_target getVariable["Reviving",objNull] != player) exitWith {};
	if (vehicle player != player) exitWith {oev_interrupted = true;};
};

//Kill the UI display and check for various states
5 cutText ["","PLAIN DOWN"];
[] spawn OEC_fnc_handleAnim;
if(_target getVariable ["Reviving",objNull] != player) exitWith {hint localize "STR_Medic_AlreadyReviving"; oev_action_inUse = false;};
_target setVariable["Reviving",nil,true];
if(!alive player) exitWith {oev_action_inUse = false;};
if((player getVariable["restrained",false])) exitWith {oev_action_inUse = false;};
if (_badDistance) exitWith {titleText[localize "STR_Medic_TooFar","PLAIN DOWN"]; oev_action_inUse = false;};
if(oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false;};

if ([false,"epiPen",1] call OEC_fnc_handleInv) then {
	[
		["event","Epi-pen"],
		["player",name player],
		["player_id",getPlayerUID player],
		["target",name _target],
		["target_id",getPlayerUID _target],
		["position",getPosATL player]
	] call OEC_fnc_logIt;

	_target setVariable["Revive",true,true];
	[profileName] remoteExec ["OEC_fnc_epiRevived",_target];

	uiSleep 0.6;
	player reveal _target;
	["epipen",1] call OEC_fnc_statArrUp;
};

oev_action_inUse = false;
