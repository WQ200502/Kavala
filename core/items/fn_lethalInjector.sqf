//file fn_lethalInjector.sqf
//Author  Mohsen98 steamid "76561198964849672"
//thanks to Bryan "Tonic" for progress bar

private ["_target","_title","_ui","_progress","_pgText","_cP","_perkTier","_cpRateChange"];
_target = cursorObject;
if !(_target isKindOf "man") exitWith {hint "You cannot do that"};
if (isNull _target) exitWith {};
if (life_inv_lethalinjector isEqualTo 0) exitWith {};
if (player distance _target > 4) exitWith {hint "You are to far away from target";};
if ((player getVariable["restrained",false]) || oev_action_inUse || !alive player || (alive _target) || oev_isDowned) exitWith {};

oev_action_inUse = true;
_perkTier = ["civ_lethal_injections"] call OEC_fnc_fetchStats;
_cpRateChange = switch (_perkTier) do {
	case 0: {0.01};
	case 1: {0.02};
	case 2: {0.03};
	case 3: {0.04};
	case 4: {0.08};
	default {0.01};
};

_title = "Injecting lethal injections into the target buttocks";
//Setup our progress bar.
disableSerialization;
"progressBar" cutRsc ["life_progress","PLAIN"];
_ui = uiNamespace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format ["%2 (1%1)...","%",_title];
_progress progressSetPosition 0.01;
_cP = 0.01;
[player,"UnconsciousReviveMedic_b"] remoteExec ["OEC_fnc_animSync",-2];
for "_i" from 0 to 1 step 0 do {
	uiSleep 0.27;
	_cP = _cP + _cpRateChange;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format ["%3 (%1%2)...",round(_cP * 100),"%",_title];
	if (_cP >= 1) exitWith {};
	if !(isNull objectParent player) exitWith {};
	if (oev_interrupted) exitWith {};
	if (player distance _target > 4) exitWith {
		hint "You are to far away from target";
	};
	if ((player getVariable["restrained",false]) || !alive player || (isNull _target) || oev_isDowned) exitWith {};
};
[player,"AmovPknlMstpSnonWnonDnon"] remoteExec ["OEC_fnc_animSync",-2];
oev_action_inUse = false;
"progressBar" cutText ["","PLAIN"];
if (!alive player || (isNull _target) || oev_isDowned || player getVariable["restrained",false] || !(isNull objectParent player) || oev_interrupted) exitWith {
	oev_interrupted = false;
	oev_action_inUse = false;
	titleText[localize "STR_NOTF_ActionCancel","PLAIN"]
};
_target setVariable ["infected",true,true];
[false,"lethalinjector",1] call OEC_fnc_handleInv;
["lethal_injections",1] call OEC_fnc_statArrUp;
titleText["Injection successful. Make sure to wash your hands well","PLAIN"];
