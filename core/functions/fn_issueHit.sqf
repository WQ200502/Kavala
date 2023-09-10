#include "..\..\macro.h"
if (scriptAvailable(600)) exitWith {hint "You must wait 10 minutes before placing another hit";};
//	File: fn_issueHit.sqf
//	Author: TheCmdrRex
//	Description: Issues a hitman contract on an active player

private ["_unit","_bounty","_total"];

// Validate Selected Target
_unit = lbData[99222,lbCurSel (99222)];
_unit = call compile format["%1", _unit];
if ((lbCurSel 99222) == -1) exitWith {hint "You need to select someone to place a hit on";};
if (isNil "_unit" || {isNull _unit}) exitWith {hint "The player selected doesn't seem to exist?";};
if ((group player) isEqualTo (group _unit)) exitWith {hint "You cannot place a hit on a group member!";};
if ((_unit getVariable "gang_data") select 0 == (oev_gang_data select 0)) exitWith {hint "You cannot place a hit on a gang member!";};
if ((_unit getVariable ["hitmanBounty",0]) > 0) exitWith {hint "This player already has a bounty placed on them!";};

// Validate Bounty
_bounty = lbValue[99221,lbCurSel (99221)];
if (_bounty <= 0 || _bounty > 50000000) exitWith {hint "Please enter a valid bounty!";};
_total = _bounty + (_bounty * oev_hitmanTax);
if (oev_atmcash < _total) exitWith {hint "You do not have enough money to place this bounty!";};

// Confirm Hit Placement
private _action = [
	format ["Are you sure you want to place a hit of $%2 on %1? There will be a fee of $%3",name _unit, [_bounty] call OEC_fnc_numberText,[(_bounty * oev_hitmanTax)] call OEC_fnc_numberText],
	"Confirmation",
	"Yes",
	"No"
] call BIS_fnc_guiMessage;
if !(_action) exitWith {};
if (O_stats_playtime_civ <900) exitWith {hint "You must have 15 hours on the server to place a hit on them !";};

hint "Placing Hit...";
uiSleep (random(4));

// Re-Validate units bounty and your cash
if ((_unit getVariable ["hitmanBounty",0]) > 0) exitWith {hint "This player already has a bounty placed on them!";};
if (oev_atmcash < _total) exitWith {hint "You do not have enough money to place this bounty!";};

// Set hit on player
[[player,_bounty],"OEC_fnc_handleHit",_unit,false] spawn OEC_fnc_MP;

// Take money from account
if (oev_cash >= _total) then {
	oev_cash = oev_cash - _total;
	oev_cache_cash = oev_cache_cash - _total;
	[0] call OEC_fnc_ClupdatePartial;
} else {
	oev_atmcash = oev_atmcash - _total;
	oev_cache_atmcash = oev_cache_atmcash - _total;
	[1] call OEC_fnc_ClupdatePartial;
};

hint format["You have successfully placed a $%2 hit onto %1", name _unit, [_bounty] call OEC_fnc_numberText];
[
	["event", "Issued Hitman Contract"],
	["player", name player],
	["player_id", getPlayerUID player],
	["target",name _unit],
	["target_id", getPlayerUID _unit],
	["bounty", _bounty],
	["fee", (_bounty * oev_hitmanTax)],
	["location",getPosATL player]
] call OEC_fnc_logIt;

closeDialog 0;
