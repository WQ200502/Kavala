// File: fn_seizeEscort.sqf
// Author: Jesse "tkcjesse" Schultz
params [
	["_vehicle",objNull,[objNull]]
];

private _classname = (typeOf _vehicle);
if !(_classname in ["O_Truck_03_repair_F","O_Truck_03_ammo_F","B_Truck_01_ammo_F","O_LSV_02_armed_F"]) exitWith {};

[[0,"The Altis Pharmaceutical vehicle is being seized by the police."],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
oev_action_inUse = true;
oev_interruptedTab = false;
_upp = "Seizing Vehicle";
//Setup our progress bar.
disableSerialization;
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNameSpace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
_progress progressSetPosition 0.01;
_cP = 0.01;
while {true} do {
	uiSleep 0.09;
	_cP = _cP + 0.01;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
	if(_cP >= 1) exitWith {};
	if(player distance _vehicle > 10) exitWith {};
	if(!alive player) exitWith {};
	if (oev_interruptedTab) exitWith {};
};
5 cutText ["","PLAIN DOWN"];

if(player distance _vehicle > 10) exitWith {hint "Seizing cancelled."; oev_action_inUse = false;};
if(!alive player) exitWith {oev_action_inUse = false;};
if (oev_interruptedTab) exitWith {hint "You have interrupted the vehicle seizure."; oev_interruptedTab = false; 5 cutText ["","PLAIN DOWN"]; oev_action_inUse = false;};

if({alive _x} count (crew _vehicle) == 0) then {
	if(!((_vehicle isKindOf "Car") || (_vehicle isKindOf "Air") || (_vehicle isKindOf "Ship"))) exitWith {oev_action_inUse = false;};

	deleteVehicle _vehicle;

	private _base = switch (_classname) do {
		case "O_Truck_03_ammo_F": {1500000};
		case "B_Truck_01_ammo_F": {500000};
		case "O_Truck_03_repair_F": {1000000};
		case "O_LSV_02_armed_F": {500000};
	};

	private _time = ((escort_status select 1) - serverTime);
	private _cops = [];
	{
		if ((side _x isEqualTo west) && (_x distance2D _vehicle) <= 5000) then {_cops pushBack _x;};
	} forEach playableUnits;

	private _multi = switch (true) do {
		case (_time > 2100): {1.0};
		case (_time > 1800): {1.0};
		case (_time > 1500): {0.9};
		case (_time > 1200): {0.8};
		case (_time > 900): {0.7};
		case (_time > 600): {0.6};
		case (_time > 300): {0.5};
		default {.4};
	};

	private _payout = (_base * _multi);
	_payout = round(_payout / count _cops);


	[[0,format["%1 has seized the pharmaceutical vehicle",name player]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
	escort_status = [false,(servertime + 0)];

	{
			private _copLevel = _x getVariable ["rank",0];
			_deductionVal = switch (_copLevel) do {
				case 1: {0.4};
				case 2: {0.65};
				case 3: {0.85};
				default {1};
			};

			[[2,_payout*_deductionVal,name player],"OEC_fnc_payPlayer",_x,false] spawn OEC_fnc_MP;
	} forEach _cops;

	[
		["event","APD Escort Seize"],
		["player",name player],
		["player_id",getPlayerUID player],
		["value",_payout],
		["position",getPosATL player]
	] call OEC_fnc_logIt;
} else {
	hint "Seizing cancelled.";
};

oev_action_inUse = false;
