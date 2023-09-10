if (oev_lockpick) exitWith {hint "You cannot spam lockpicks";};
//	File: fn_lockpick.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Main functionality for lock-picking.

private["_curTarget","_distance","_isVehicle","_title","_progressBar","_cP","_titleText","_dice","_badDistance","_inCar","_securitySystem","_pickDelay","_vehicleData","_vehicleLockpicked","_perkTier","_chance"];
_curTarget = cursorTarget;
oev_interrupted = false;
if (oev_action_inUse) exitWith {};
if (isNull _curTarget) exitWith {}; //Bad type
if (vehicle player != player) exitWith {}; // Can lockpick while in a car
if (typeOf _curTarget in ["O_Truck_03_repair_F","O_Truck_03_ammo_F","B_Truck_01_ammo_F","O_LSV_02_armed_F"]) exitWith {hint "You cannot lockpick this vehicle.";};

if (!simulationEnabled _curTarget) exitWith {};
_distance = ((boundingBox _curTarget select 1) select 0) + 2;
if (player distance _curTarget > _distance) exitWith {}; //Too far
_isVehicle = if ((_curTarget isKindOf "LandVehicle") || (_curTarget isKindOf "Ship") || (_curTarget isKindOf "Air")) then {true} else {false};
if (_isVehicle && _curTarget in oev_vehicles) exitWith {hint localize "STR_ISTR_Lock_AlreadyHave"};
_pickDelay = 0.26;
//More error checks
if (!_isVehicle && !isPlayer _curTarget) exitWith {};
if (!_isVehicle && !(_curTarget getVariable["restrained",false])) exitWith {};
if (_isVehicle && (_curTarget getVariable["eventVehicle",false]) && !(_curTarget getVariable["escortEventVehicle",false]) && call life_adminlevel < 1) exitWith {hint "This vehicle cannot be lockpicked!"};
if (_isVehicle && ((_curTarget getVariable["side",""]) == "med")) exitWith {hint "You cannot lockpick medic vehicles.";};


_title = format[localize "STR_ISTR_Lock_Process",if (!_isVehicle) then {"Handcuffs"} else {getText(configFile >> "CfgVehicles" >> (typeOf _curTarget) >> "displayName")}];

if (oev_action_inUse) exitWith {};
if (oev_lockpick) exitWith {hint "You cannot spam lockpicks";};
oev_action_inUse = true; //Lock out other actions
oev_lockpick = true;
_perkTier = ["civ_lockpicks"] call OEC_fnc_fetchStats;
if (_isVehicle) then {
	private _silentChance = switch (_perkTier) do {
		case 2: {75};
		default {101};
	};
	private _alarmDice = random(100);
	if (_alarmDice < _silentChance) then {
		_securitySystem = _curTarget getVariable["modifications",[0,0,0,0,0,0,0,0]];
		if ((_securitySystem select 2) > 0) then {
			[_curTarget,"carAlarm"] remoteExec ["OEC_fnc_say3D",-2];

			if ((_securitySystem select 2) > 1) then {
				_pickDelay = 0.52;
			};
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

if (life_inv_lockpick <= 0) exitWith {oev_action_inUse = false; oev_lockpick = false;};

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
	if (oev_interruptedTab) exitWith {_exit = true; oev_interruptedTab = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"];};
	if (player getVariable ["restrained",false]) exitWith {_exit = true;};
	if (player distance _curTarget > _distance) exitWith {_exit = true; titleText[localize "STR_ISTR_Lock_TooFar","PLAIN DOWN"];};
	if (vehicle player != player) exitWith {_exit = true; titleText[localize "STR_ISTR_Lock_InCar","PLAIN DOWN"];};
};

//Kill the UI display and check for various states
5 cutText ["","PLAIN DOWN"];
[] spawn OEC_fnc_handleAnim;
oev_action_inUse = false;
oev_lockpick = false;
if (_exit) exitWith {};
if !([false,"lockpick",1] call OEC_fnc_handleInv) exitWith {};

if (!_isVehicle) then {
	_curTarget setVariable["restrained",false,true];
	_curTarget setVariable["zipTied",false,true];
	_curTarget setVariable["Escorting",false,true];
	_curTarget setVariable["transporting",false,true];
} else {
	_chance = 30;
	switch (_perkTier) do {
		case 1: {_chance = 35;};
		case 2: {_chance = 40;};
	};
	_dice = random(100);
	if (_dice < _chance) then {
		private _puid = getPlayerUID player;
		_vehicleData = _curTarget getVariable["vehicle_info_owners",[]];
		_vehicleLockpicked = _curTarget getVariable["vehicle_info_lockpicked",[]];
		if (_vehicleData findIf { _x param [0, "", [""]] isEqualTo _puid } < 0) then {
			_curTarget setVariable ["oev_cop_stolen", true, true];
		};
		_vehicleData pushBack [getPlayerUID player,player getVariable["realname",name player]];
		_vehicleLockpicked append [_puid];
		_curTarget setVariable["vehicle_info_owners",_vehicleData,true];
		_curTarget setVariable["vehicle_info_lockpicked",_vehicleLockpicked,true];
		titleText[localize "STR_ISTR_Lock_Success","PLAIN DOWN"];
		oev_vehicles pushBack _curTarget;
		[getPlayerUID player,profileName,"11",player] remoteExec ["OES_fnc_wantedAdd",2];
		[
			["event","Lockpick"],
			["player", name player],
			["player_id", getPlayerUID player],
			["vehicle", getText(configFile >> "CfgVehicles" >> (typeOf _curTarget) >> "displayName")],
			["owners", _curTarget getVariable["vehicle_info_owners",[]]],
			["location", getPos player]
		] call OEC_fnc_logIt;
		["lockpicksuc",1] call OEC_fnc_statArrUp;
	} else {
		[getPlayerUID player,profileName,"6",player] remoteExecCall ["OES_fnc_wantedAdd",2];
		[0,"STR_ISTR_Lock_FailedNOTF",true,[profileName]] remoteExecCall ["OEC_fnc_broadcast",west];
		titleText[localize "STR_ISTR_Lock_Failed","PLAIN DOWN"];
		["lockpickfail",1] call OEC_fnc_statArrUp;
	};
};
