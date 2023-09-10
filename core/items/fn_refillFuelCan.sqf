//file : fn_refillFuelCan.sqf
//Author : mohsen98
//thanks to : Bryan "Tonic" for progress

private ["_target","_upp","_ui","_progress","_pgText","_cP"];
_target = cursorObject;
if !(typeof cursorObject in ["Land_fs_feed_F","B_Slingload_01_Fuel_F","Land_FuelStation_01_pump_F"]) exitWith {hint "You need to use this item on a gas tank.";};
if (isNull _target) exitWith {};
if (life_inv_fuelE < 1) exitWith {};
if (player distance _target > 10) exitWith { hint "You are too far away to refuel"; };
_diff = ["fuelF",1,oev_carryWeight,oev_maxWeight] call OEC_fnc_calWeightDiff;
if(_diff <= 0) exitWith {hint "You do not have enough inventory space to hold the gas!";};
oev_action_inUse = true;

_upp = "Refueling";
//Setup our progress bar.
disableSerialization;
"progressBar" cutRsc ["life_progress","PLAIN"];
_ui = uiNamespace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format ["%2 (1%1)...","%",_upp];
_progress progressSetPosition 0.01;
_cP = 0.01;
["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;
for "_i" from 0 to 1 step 0 do {
	uiSleep 0.13;
	_cP = _cP + 0.01;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format ["%3 (%1%2)...",round(_cP * 100),"%",_upp];
	if (_cP >= 1) exitWith {};
	if (!alive player || oev_isDowned) exitWith {};
	if !(isNull objectParent player) exitWith {};
	if (oev_interrupted) exitWith {};
	if (player distance _target > 4) exitWith {
		hint "You are too far away from target";
		oev_action_inUse = false;
	};
	if (player getVariable ["restrained",false]) exitWith {
		oev_action_inUse = false;
	};
};

[] spawn OEC_fnc_handleAnim;
oev_action_inUse = false;
"progressBar" cutText ["","PLAIN"];
player playActionNow "stop";

if !(isNull objectParent player) exitWith {
	oev_interrupted = false;
	oev_action_inUse = false;
	titleText[localize "STR_NOTF_ActionCancel","PLAIN"]
};

if (!alive player || oev_isDowned) exitWith {
	oev_action_inUse = false;
};

if (player getVariable["restrained",false]) exitWith {
	oev_action_inUse = false;
};

if (oev_interrupted) exitWith {
	oev_interrupted = false;
	oev_action_inUse = false;
	titleText[localize "STR_NOTF_ActionCancel","PLAIN"]
};

if (life_inv_fuelE > 0) then {
	[false,"fuelE",1] call OEC_fnc_handleInv;
	[true,"fuelF",1] call OEC_fnc_handleInv;
};
titleText["You successfully refueled your fuel can!","PLAIN"];
