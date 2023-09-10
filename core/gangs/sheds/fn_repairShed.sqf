// File: fn_repairShed.sqf

private ["_shed","_action"];

_shed = nearestBuilding player;
if (typeOf _shed != "Land_i_Shed_Ind_F") exitWith {hint "You can only repair gang sheds.";};
if (count oev_gang_data == 0) exitWith {hint "You must be in a gang to repair a shed.";};
if (_shed getVariable ["bldg_gangid", -1] != (oev_gang_data select 0)) exitWith {hint "You cannot repair another gang's shed.";};
if (getDammage _shed != 1) exitWith {hint "This gang shed does not require repairs.";};
if (oev_atmcash < 1000000 && oev_cash < 1000000) exitWith {hint "You don't have enough money to repair this shed!";};
if (oev_action_inUse) exitWith {hint "You're already performing another action!";};
oev_interrupted = false;
oev_interruptedTab = false;
oev_action_inUse = true;

_action = [
	"Are you sure you want to repair this gang shed for $1,000,000?",
	"Confirmation",
	"Yes",
	"No"
] call BIS_fnc_guiMessage;

if (_action) then {
	disableSerialization;
	private _title = "Repairing Gang Shed";
	5 cutRsc ["life_progress","PLAIN DOWN"];
	private _ui = uiNamespace getVariable "life_progress";
	private _progressBar = _ui displayCtrl 38201;
	private _titleText = _ui displayCtrl 38202;
	_titleText ctrlSetText format["%2 (1%1)...","%",_title];
	_progressBar progressSetPosition 0.01;
	private _cP = 0.01;
	private _cpRate = 0.01;

	["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;

	private _exit = false;
	while {true} do {
		uiSleep 0.26;
		if(isNull _ui) then {
			5 cutRsc ["life_progress","PLAIN DOWN"];
			_ui = uiNamespace getVariable "life_progress";
			_progressBar = _ui displayCtrl 38201;
			_titleText = _ui displayCtrl 38202;
		};
		_cP = _cP + _cpRate;
		_progressBar progressSetPosition _cP;
		_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
		if (_cP >= 1) exitWith {};
		if !(alive player) exitWith {_exit = true;};
		if !(isNull objectParent player) exitWith {_exit = true;};
		if (player distance2D _shed > 15) exitWith {_exit = true; hint "You must stay near the shed to repair!";};
		if (oev_interrupted) exitWith {_exit = true; oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"];};
		if (oev_interruptedTab) exitWith {_exit = true; oev_interruptedTab = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"];};
	};

	oev_action_inUse = false;
	5 cutText ["","PLAIN DOWN"];
	[] spawn OEC_fnc_handleAnim;
	if (_exit) exitWith {oev_action_inUse = false;};
	if (oev_atmcash < 1000000 && oev_cash < 1000000) exitWith {hint "You don't have enough money to repair this shed!";};
	if (oev_cash >= 1000000) then {
		oev_cash = oev_cash - 1000000;
		oev_cache_cash = oev_cache_cash - 1000000;
	} else {
		oev_atmcash = oev_atmcash - 1000000;
		oev_cache_atmcash = oev_cache_atmcash - 1000000;
	};

	private _dam_obj = _shed;
	_dam_obj setDamage 0;
} else {
	hint localize "STR_NOTF_ActionCancel";
	closeDialog 0;
	oev_action_inUse = false;
};
