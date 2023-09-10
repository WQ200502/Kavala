//  File: fn_pulloutAction.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Pulls players out of a vehicle
private["_crew","_curTarget","_progressBar","_cP","_title","_titleText","_ui","_tooFar","_pullUnconscious"];

_pullUnconscious = param [1,false,[false]];
_crew = crew cursorTarget;
_curTarget = cursorTarget;
private _isVTOL = if (typeOf _curTarget in ["B_T_VTOL_01_vehicle_F","B_T_VTOL_01_infantry_F"]) then {true} else {false};
if(oev_action_inUse) exitWith {};
if(isNull _curTarget) exitWith {};
if((player distance _curTarget > 5 && !(_isVTOL)) || (player distance _curTarget > 13 && _isVTOL)) exitWith {hint 'You are too far away to pull out players!'};
oev_interrupted = false;
oev_action_inUse = true;
_tooFar = false;
_title = format["Attempting to pull players out from %1",getText(configFile >> "CfgVehicles" >> (typeOf _curTarget) >> "displayName")];

disableSerialization;
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNamespace getVariable "life_progress";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;

["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;

while {true} do {
	uiSleep 0.05;
	_cP = _cP + 0.01;
	_progressBar progressSetPosition _cP;
	_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
	if(_cP >= 1 || !alive player) exitWith {};
	if(oev_interrupted) exitWith {};
	if((player getVariable["restrained",false])) exitWith {};
	if((player distance _curTarget > 5 && !(_isVTOL)) || (player distance _curTarget > 13 && _isVTOL)) exitWith {_tooFar = true;};
};

5 cutText ["","PLAIN DOWN"];
[] spawn OEC_fnc_handleAnim;
if(!alive player) exitWith {oev_action_inUse = false;};

if((player getVariable["restrained",false])) exitWith {oev_action_inUse = false;};
if(_tooFar) exitWith {titleText["You got too far away from the target.","PLAIN DOWN"]; oev_action_inUse = false;};
if(oev_interrupted) exitWith {oev_interrupted = false; titleText["Action cancelled","PLAIN DOWN"]; oev_action_inUse = false;};
oev_action_inUse = false;

{
	_x setVariable ["transporting",false,true]; _x setVariable ["Escorting",false,true];
	[[_x],"OEC_fnc_pullOutVeh",_x,false] spawn OEC_fnc_MP;
} foreach _crew;