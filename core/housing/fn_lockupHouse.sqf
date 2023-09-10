//	Author: Bryan "Tonic" Boardwine
//  File: fn_lockupHouse.sqf
//  Modified by: Fusah
//	Description: Locks up the entire house and closes all doors. DESCRIPTIONEND

private["_house"];
_house = param [0,ObjNull,[ObjNull]];
if(isNull _house || !(_house isKindOf "House_F")) exitWith {};
_numberOfDoors = getNumber(configFile >> "CfgVehicles" >> (typeOf _house) >> "numberOfDoors");
if(_numberOfDoors == -1 || _numberOfDoors == 0) exitWith {}; //MEH
if (side player isEqualTo west || side player isEqualTo independent) exitWith {
	titleText [localize "STR_House_LockingUp","PLAIN DOWN"];
	uiSleep 3;
	for "_i" from 1 to _numberOfDoors do {
		_house animate[format["door_%1_rot",_i],0];
		_house setVariable[format["bis_disabled_Door_%1",_i],1,true];
		if ((_house getVariable [format["disabled_Door_%1",_i],0]) isEqualTo 1) then {
			_house setVariable[format["disabled_Door_%1",_i],0,true];
			};
	};
	_house setVariable["locked",true,true];
	titleText[localize "STR_House_LockedUp","PLAIN DOWN"];
};

if (side player isEqualTo civilian) exitWith {
	oev_action_inUse = true;
	disableSerialization;
	_title = "Repairing Doors";
	5 cutRsc ["life_progress","PLAIN DOWN"];
	_ui = uiNamespace getVariable "life_progress";
	_progressBar = _ui displayCtrl 38201;
	_titleText = _ui displayCtrl 38202;
	_titleText ctrlSetText format["%2 (1%1)...","%",_title];
	_progressBar progressSetPosition 0.01;
	_cP = 0.01;
	_cpRate = 0.0052; // eh suxks to suc if u dont see the civ repairing the door suuuuper slow unless cops lock it up

	["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;

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
		if(_cP >= 1 || !alive player) exitWith {};
		if(oev_interrupted) exitWith {};
	};

	5 cutText ["","PLAIN DOWN"];
	[] spawn OEC_fnc_handleAnim;
	if(!alive player) exitWith {oev_action_inUse = false;};

	if((player getVariable["restrained",false])) exitWith {oev_action_inUse = false;};
	if(oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false;};
	oev_action_inUse = false;
	for "_i" from 1 to _numberOfDoors do {
		if ((_house getVariable [format["disabled_Door_%1",_i],0]) isEqualTo 1) then {
			_house setVariable[format["disabled_Door_%1",_i],0,true];
		};
	};
	titleText["Repaired Doors!","PLAIN DOWN"];
};