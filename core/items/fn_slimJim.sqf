if (oev_lockpick) exitWith {hint "You cannot spam Slim Jim's";};
//	File: fn_slimJim.sqf
//	Author: Bryan "Tonic" Boardwine
//	Modified by: Bow
//	Description: Main functionality for lock-picking, but re-purposed for APD Slim Jim's.

private["_curTarget","_distance","_isVehicle","_title","_progressBar","_cP","_titleText","_dice","_badDistance","_inCar","_securitySystem","_pickDelay", "_accountForSecurityUpgrade", "_playAlarm"];
_curTarget = cursorTarget;
oev_interrupted = false;
if (typeOf _curTarget in ["O_Truck_03_repair_F","O_Truck_03_ammo_F","B_Truck_01_ammo_F","O_LSV_02_armed_F","B_T_Truck_01_Repair_F","B_T_Truck_01_ammo_F"]) exitWith {hint "You cannot Slim Jim this vehicle."};
if (oev_action_inUse) exitWith {};
if (isNull _curTarget) exitWith {}; //Bad type
if (vehicle player != player) exitWith {}; // Can Slim Jim while in a car

_accountForSecurityUpgrade = false; // Should we slow the Slim Jim down if the player has a security upgrade?
_pickDelay = 0.083;					// If the above is true, define a delay here. Do not set to 0 however. (60 seconds * x) = seconds to unlock. 0.083 = 4.98 seconds
_playAlarm = false;					//Should we play the car alarm sound when the vehicle is being unlocked with a Slim Jim?

if (!simulationEnabled _curTarget) exitWith {};
_distance = ((boundingBox _curTarget select 1) select 0) + 2;
if (player distance _curTarget > _distance) exitWith {}; //Too far
_isVehicle = if ((_curTarget isKindOf "LandVehicle") || (_curTarget isKindOf "Ship") || (_curTarget isKindOf "Air")) then {true} else {false};
if (_isVehicle && _curTarget in oev_vehicles) exitWith {hint localize "STR_ISTR_SlimJim_AlreadyHave"};
//More error checks
if (!_isVehicle && !isPlayer _curTarget) exitWith {};
if (!_isVehicle && isPlayer _curTarget) exitWith {hint "Yeah uh... sliding Mr Slim Jim into this player may have unintended consequences. So we'll stop right there and refrain from any potential lawsuits ;)"};
if (_isVehicle && (_curTarget getVariable["eventVehicle",false]) && !(_curTarget getVariable["escortEventVehicle",false]) && call life_adminlevel < 1) exitWith {hint "This vehicle cannot be Slim Jim'd!"};
if (_isVehicle && ((_curTarget getVariable["side",""]) == "med")) exitWith {hint "You cannot Slim Jim medic vehicles."};

_title = format[localize "STR_ISTR_SlimJim_Process", getText(configFile >> "CfgVehicles" >> (typeOf _curTarget) >> "displayName")];

if (oev_action_inUse) exitWith {};
if (oev_lockpick) exitWith {hint "You cannot spam Slim Jim's";};
oev_action_inUse = true; //Lock out other actions
oev_lockpick = true;
if (_isVehicle) then {
	_securitySystem = _curTarget getVariable["modifications",[0,0,0,0,0,0,0,0]];
	if ((_securitySystem select 2) > 0) then {
		if(_playAlarm) then {[_curTarget,"carAlarm"] remoteExec ["OEC_fnc_say3D",-2]};

		if ((_securitySystem select 2) > 1 && _accountForSecurityUpgrade) then {
			_pickDelay = 0.52;
		};
	};
};
//Setup the progress bar
disableSerialization;
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNamespace getVariable "life_progress";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;

private _exit = false;
["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;
while {true} do {
	uiSleep _pickDelay;
	if (isNull _ui) then {
		5 cutRsc ["life_progress","PLAIN DOWN"];
		_ui = uiNamespace getVariable "life_progress";
		_progressBar = _ui displayCtrl 38201;
		_titleText = _ui displayCtrl 38202;
	};
	_cP = _cP + 0.01;
	_progressBar progressSetPosition _cP;
	_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
	if (_curTarget getVariable ["downed",false]) exitWith {_exit = true;};
	if (player getVariable ["downed",false]) exitWith {_exit = true;};
	if (_cP >= 1) exitWith {};
	if !(alive player) exitWith {_exit = true;};
	if (oev_interrupted) exitWith {_exit = true; oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"];};
	if (player getVariable ["restrained",false]) exitWith {_exit = true;};
	if (player distance _curTarget > _distance) exitWith {_exit = true; titleText[localize "STR_ISTR_SlimJim_TooFar","PLAIN DOWN"];};
	if (vehicle player != player) exitWith {_exit = true; titleText[localize "STR_ISTR_SlimJim_InCar","PLAIN DOWN"];};
};

//Kill the UI display and check for various states
5 cutText ["","PLAIN DOWN"];
[] spawn OEC_fnc_handleAnim;
oev_action_inUse = false;
oev_lockpick = false;
if (_exit) exitWith {};

_vehicleData = _curTarget getVariable["vehicle_info_owners",[]];
_vehicleData pushBack [getPlayerUID player,player getVariable["realname",name player]];
_curTarget setVariable["vehicle_info_owners",_vehicleData,true];
titleText[localize "STR_ISTR_SlimJim_Success","PLAIN DOWN"];
oev_vehicles pushBack _curTarget;
[
	["event", "APD Slim Jim"],
	["player", name player],
	["player_id", getPlayerUID player],
	["vehicle", getText(configFile >> "CfgVehicles" >> (typeOf _curTarget) >> "displayName")],
	["owners", _curTarget getVariable["vehicle_info_owners",[]]],
	["location", getPos player]
] call OEC_fnc_logIt;
