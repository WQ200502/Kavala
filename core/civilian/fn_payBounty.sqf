//      File: fn_payBounty.sqf
//	Author: Fusah
//	Description: Allows a civilian to pay off their bounty.

private ["_cpRate","_title","_progressBar","_titleText","_cp","_ui"];
if (oev_action_inUse) exitWith {titleText ["You are already performing another action!", "PLAIN DOWN"]}; //prevent spamming of this SHEET
private _isGood = true;
_nearPlayers = (nearestObjects[player,["Man"],10]) arrayIntersect playableUnits;
{
	if (side _x isEqualTo west) exitWith {_isGood = false};
} forEach _nearPlayers;

if !(_isGood) exitWith {hint "You are not able to pay off your bounty near cops!"};
private _bounty = player getVariable ["statBounty",1000500];
//refer to fn_crimeName2Number if you want to add something to the no no list ^____^
private _badCrimes = [3,8,42,44,59,45,67,53,39,64,65,66];
if (_bounty isEqualTo 0) exitWith {};
if (player getVariable ["restrained",false]) exitWith {};
if (_bounty > 1000000) exitWith {hint "You can only pay off a bounty less than $1000,000."};
if (oev_cash < _bounty && oev_atmcash < _bounty) exitWith {hint "You don't have enough money to pay off your bounty!"};
{
	private _crimeAmount = O_stats_crimes select _x;
	if (_crimeAmount != 0) exitWith {_isGood = false};
} forEach _badCrimes;

if !(_isGood) exitWith {titleText ["Your charges are too serious to pay off your bounty!", "PLAIN DOWN"]};

_areYouSure = [
	format ["Are you sure you would like to pay off your bounty of $%1",_bounty],
	"Confirm Pay Bounty",
	"Yes",
	"No"
] call BIS_fnc_guiMessage;

if !(_areYouSure) exitWith {};

oev_action_inUse = true;

//make it a BIT faster to pay it off if you have below half of max bounty amount
if (_bounty > 62500) then {
	_cpRate = 0.008;
} else {
	_cpRate = 0.009;
};

//Setup the progress bar
disableSerialization;
_title = "Paying off Bounty";
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNamespace getVariable "life_progress";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;

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
	if(oev_isDowned) exitWith {};
	if(oev_interrupted) exitWith {};
};

5 cutText ["","PLAIN DOWN"];
if(!alive player || oev_isDowned) exitWith {titleText ["You were not able to pay off your bounty!", "PLAIN DOWN"]; oev_action_inUse = false;};
if((player getVariable["restrained",false])) exitWith {titleText ["You were not able to pay off your bounty!", "PLAIN DOWN"]; oev_action_inUse = false;};
if (oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false;};

if !(oev_cash < _bounty) then {
	oev_cash = oev_cash - _bounty;
	oev_cache_cash = oev_cache_cash - _bounty;
	[0] call OEC_fnc_ClupdatePartial;
} else {
	oev_atmcash = oev_atmcash - _bounty;
	oev_cache_atmcash = oev_cache_atmcash - _bounty;
	[1] call OEC_fnc_ClupdatePartial;
};

[[getPlayerUID player],"OES_fnc_wantedRemove",false,false] spawn OEC_fnc_MP;
player setVariable ["statBounty",0,true];
titleText ["You have paid off your bounty!", "PLAIN DOWN"];
oev_action_inUse = false;

[
	["event", "Paid off Bounty"],
	["player", name player],
	["player_id", getPlayerUID player],
	["bounty", _bounty],
	["position", getPos player]
]	call OEC_fnc_logIt;
