//	Author: Bryan "Tonic" Boardwine
// 	File: fn_defuseKit.sqf
//  Modified by Fusah for the FAKE bomb!
//	Defuses blasting charges for the cops?  DESCRIPTIONEND

private["_vault","_ui","_title","_progressBar","_cP","_titleText","_fakeBomb","_isFake"];
_vault = param [0,ObjNull,[ObjNull]];
if(isNull _vault) exitWith {};
if(!(typeOf _vault in ["CargoNet_01_box_F","Land_CargoBox_V1_F","Land_Mil_WallBig_4m_battered_F","Land_Dome_Big_F","B_Slingload_01_Cargo_F","Land_PowerGenerator_F"])) exitWith {};
_fakeBomb = nearestObject [[30111.8,76.9817,3.39661],"Land_CargoBox_V1_F"];
if (_vault == _fakeBomb) then {_isFake = true} else {_isFake = false};
if ((_vault getVariable["chargeplaced",false]) isEqualTo false && _isFake isEqualTo false) exitWith {hint localize "STR_ISTR_Defuse_Nothing"};

oev_action_inUse = true;
//Setup the progress bar
disableSerialization;
_title = localize "STR_ISTR_Defuse_Process";
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNamespace getVariable "life_progress";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;
["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;
while {true} do {
	uiSleep 0.1;
	if(isNull _ui) then {
		5 cutRsc ["life_progress","PLAIN DOWN"];
		_ui = uiNamespace getVariable "life_progress";
		_progressBar = _ui displayCtrl 38201;
		_titleText = _ui displayCtrl 38202;
	};
	if !(_isFake) then {
		private _perkTier = ["cop_defuses"] call OEC_fnc_fetchStats;
		private _cpRateChange = switch (_perkTier) do {
			case 1: {1.025};
			case 2: {1.05};
			case 3: {1.075};
			case 4: {1.10};
			case 5: {1.125};
			default {1};
		};
		_cP = _cP + (.0035 * _cpRateChange);
	} else {
		_cP = _cP + .01;
	};
	_progressBar progressSetPosition _cP;
	_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
	if (_cP >= 1 || !alive player) exitWith {};
	if (oev_interrupted) exitWith {};
	if ((_vault getVariable["chargeplaced",false]) isEqualTo false && _isFake isEqualTo false) exitWith {};
};

//Kill the UI display and check for various states
5 cutText ["","PLAIN DOWN"];
9 cutRsc ["bank_timer","PLAIN DOWN"];
9 cutText ["","PLAIN DOWN"];
[] spawn OEC_fnc_handleAnim;
if ((_vault getVariable["chargeplaced",false]) isEqualTo false && _isFake isEqualTo false) exitWith {oev_action_inUse = false; hint "The bomb has blown! There is nothing to defuse!";};
if !(alive player) exitWith {oev_action_inUse = false;};
if (oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false;};
oev_action_inUse = false;
if (_isFake) exitWith {hint "Congrats you just defused the fake bomb!"};
_vault setVariable["chargeplaced",false,true];
[[0,localize "STR_ISTR_Defuse_Success"],"OEC_fnc_broadcast",west,false] spawn OEC_fnc_MP;
if !(_isFake) then {["defuses",1] call OEC_fnc_statArrUp;};
