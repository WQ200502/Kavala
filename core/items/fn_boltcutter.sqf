// 	File: fn_boltcutter.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description:
//  Modified by: Fusah
//	Breaks the lock on a single door (Closet door to the player).

private["_door","_doors","_cpRate","_title","_progressBar","_titleText","_cp","_ui"];
params [
	["_building",objNull,[objNull]]
];

if (isNull _building) exitWith {};
if (player distance (getMarkerPos "bw_marker") < 100) exitWith {hint "You cannot use bolt cutters near the Blackwater Facility!";};
if (player distance (getMarkerPos "jail_marker") < 150) exitWith {hint "You cannot use bolt cutters near the Prison!";};
if (player distance [16033.3,16933,0] < 7) exitWith {hint "You cannot break into these doors! Try a large door instead!"};
if (_building isKindOf "Land_i_Shed_Ind_F") exitWith {hint "You cannot break into a gang shed."};
if !(_building isKindOf "House_F") exitWith {hint "You are not looking at a house door."};
if ((player distance _building) > 28) exitWith {hint "You are too far away to use bolt cutters!"};
if (isNil "life_boltcutter_uses") then {life_boltcutter_uses = 0;};

_dome = objNull;
_rsb = objNull;
_dome = nearestObject [[16019.5,16952.9,0],"Land_Dome_Big_F"];
_rsb = nearestObject [[16019.5,16952.9,0],"Land_Research_house_V1_F"];
_door = 0;
_door = [_building] call OEC_fnc_ClnearestDoor;

if(_door == 0) exitWith {hint localize "STR_Cop_NotaDoor"}; //Not near a door to be broken into.
private _exit = false;
if(_dome == _building || _rsb == _building) then {
	private _civCount = {side _x isEqualTo civilian && (getPos _x) inPolygon oev_federalReservePoly} count playableUnits;
	if !(_civCount >= 2) exitWith {_exit = true;};
};
if (_exit) exitWith {hint "There needs to be another civilian nearby to begin boltcutting!"};
if((_building getVariable[format["bis_disabled_Door_%1",_door],0]) == 0) exitWith {hint localize "STR_House_Raid_DoorUnlocked"};
oev_action_inUse = true;
private _copCount = [west,2] call OEC_fnc_playerCount;

if((_dome == _building || _rsb == _building) && _copCount < 5) exitWith {
	hint "There needs to be 5 or more cops online to start a fed!";
	oev_action_inUse = false;
};

if((_dome == _building || _rsb == _building) && oev_allFederalCooldown > time) exitWith {
	hint format ["Due to the recent robbery at the Blackwater Facility/Jail, the Federal Reserve is under extreme lockdown. You can not boltcut this door for %1 more seconds.", round(oev_allFederalCooldown - time)];
	oev_action_inUse = false;
};

if((_dome == _building || _rsb == _building)) then {
	[[[1,2],"STR_ISTR_Bolt_AlertFed",true,[]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
} else {
	[[0,"STR_ISTR_Bolt_AlertHouse",true,[profileName]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
};

//Setup the progress bar
disableSerialization;
_title = localize "STR_ISTR_Bolt_Process";
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNamespace getVariable "life_progress";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;

private _perkTier = 0;
_perkTier = ["civ_bombsPlanted"] call OEC_fnc_fetchStats;
private _cpRateChange = switch (_perkTier) do {
	case 1: {1.05};
	case 2: {1.10};
	case 3: {1.25};
	default {1};
};

switch (typeOf _building) do {
	case "Land_Dome_Big_F": {_cpRate = (0.003 * _cpRateChange);};
	case "Land_Research_house_V1_F": {_cpRate = (0.0015 * _cpRateChange);};
	case "Land_Cargo_House_V4_F": {_cpRate = (0.0015 * _cpRateChange);};
	default {_cpRate = 0.0173;}
};

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

//Kill the UI display and check for various states
5 cutText ["","PLAIN DOWN"];
[] spawn OEC_fnc_handleAnim;
if(!alive player) exitWith {oev_action_inUse = false;};

if((player getVariable["restrained",false])) exitWith {oev_action_inUse = false;};
if(oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false;};
life_boltcutter_uses = life_boltcutter_uses + 1;
oev_action_inUse = false;
if(life_boltcutter_uses >= 5) then {
	[false,"boltcutter",1] call OEC_fnc_handleInv;
	life_boltcutter_uses = 0;
};

if (side player isEqualTo west && {_dome != _building} && {_rsb != _building}) then {
	_building setVariable[format["disabled_Door_%1",_door],1,true]; //WHEN YOU HAVE A FUCKING WINDOWS KEY OPTION WHY SPEND THE EXTRA TIME TO USE A BOLT CUTTER HM???
};

_building setVariable[format["bis_disabled_Door_%1",_door],0,true]; //Unlock the door.
