//  File: fn_jerryRefuel.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Refuels the vehicle if the player has a fuel can.
private["_vehicle","_displayName","_upp","_ui","_progress","_pgText","_cP","_previousState"];
_vehicle = cursorTarget;
oev_interrupted = false;
if(isNull _vehicle) exitWith {hint localize "STR_ISTR_Jerry_NotLooking"};
if(!(_vehicle isKindOF "LandVehicle") && !(_vehicle isKindOf "Air") && !(_vehicle isKindOf "Ship")) exitWith {};
if(player distance _vehicle > 7.5) exitWith {hint localize "STR_ISTR_Jerry_NotNear"};

if(!([false,"fuelF",1] call OEC_fnc_handleInv)) exitWith {};
oev_action_inUse = true;
_displayName = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");

_upp = format[localize "STR_ISTR_Jerry_Process",_displayName];
//Setup our progress bar.
disableSerialization;
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNameSpace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
_progress progressSetPosition 0.01;
_cP = 0.01;

["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;

while{true} do {
	uiSleep 0.2;
	if(isNull _ui) then {
		5 cutRsc ["life_progress","PLAIN DOWN"];
		_ui = uiNamespace getVariable "life_progress";
		_progressBar = _ui displayCtrl 38201;
		_titleText = _ui displayCtrl 38202;
	};
	_cP = _cP + 0.01;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
	if(_cP >= 1) exitWith {};
	if(!alive player) exitWith {};
	if(oev_interrupted) exitWith {};
};

oev_action_inUse = false;
5 cutText ["","PLAIN DOWN"];
[] spawn OEC_fnc_handleAnim;
if(!alive player) exitWith {};
if(oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"];};


switch (true) do {
	case (_vehicle isKindOF "LandVehicle"): {
		if(!local _vehicle) then {
			[[_vehicle,(Fuel _vehicle) + 0.5],"OEC_fnc_setFuel",_vehicle,false] spawn OEC_fnc_MP;
		} else {
			_vehicle setFuel ((Fuel _vehicle) + 0.5);
		};
	};

	case (_vehicle isKindOf "Air"): {
		if(!local _vehicle) then {
			[[_vehicle,(Fuel _vehicle) + 0.2],"OEC_fnc_setFuel",_vehicle,false] spawn OEC_fnc_MP;
		} else {
			_vehicle setFuel ((Fuel _vehicle) + 0.2);
		};
	};

	case (_vehicle isKindOf "Ship"): {
		if(!local _vehicle) then {
			[[_vehicle,(Fuel _vehicle) + 0.35],"OEC_fnc_setFuel",_vehicle,false] spawn OEC_fnc_MP;
		} else {
			_vehicle setFuel ((Fuel _vehicle) + 0.35);
		};
	};
};

titleText[format[localize "STR_ISTR_Jerry_Success",_displayName],"PLAIN DOWN"];
[true,"fuelE",1] call OEC_fnc_handleInv;