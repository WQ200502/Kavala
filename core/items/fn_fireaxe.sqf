// 	File: fn_fireaxe.sqf
//	Author: Pledge
//	Description: Breaks the lock on a single door (Closet door to the player).

private["_door","_doors","_cpRate","_title","_progressBar","_titleText","_cp","_ui"];
params [
	["_building",objNull,[objNull]]
];

if (isNull _building) exitWith {};
if (player distance (getMarkerPos "bw_marker") < 100) exitWith {hint "You cannot use the fireaxe near the Blackwater Facility!";};
if (player distance (getMarkerPos "jail_marker") < 150) exitWith {hint "You cannot use the fireaxe near the Prison!";};
if (player distance [16033.3,16933,0] < 7) exitWith {hint "You cannot break into these doors! Try a large door instead!"};
if (_building isKindOf "Land_i_Shed_Ind_F") exitWith {hint "You cannot break into a gang shed."};
if !(_building isKindOf "House_F") exitWith {hint "You are not looking at a house door."};
if ((player distance _building) > 28) exitWith {hint "You are too far away to use the fireaxe!"};
if (isNil "life_fireaxe_uses") then {life_fireaxe_uses = 0;};

_dome = objNull;
_rsb = objNull;
_dome = nearestObject [[16019.5,16952.9,0],"Land_Dome_Big_F"];
_rsb = nearestObject [[16019.5,16952.9,0],"Land_Research_house_V1_F"];

if(_dome == _building || _rsb == _building) exitWith {hint "You cannot use the fireaxe on this door!"};
if ((typeOf _building == "Land_Dome_Big_F") || (typeOf _building == "Land_Research_house_V1_F") || (typeOf _building == "Land_Cargo_House_V4_F")) exitWith {hint "You cannot use the fireaxe on this door!"};
_door = 0;
_door = [_building] call OEC_fnc_ClnearestDoor;

if(_door == 0) exitWith {hint localize "STR_Cop_NotaDoor"}; //Not near a door to be broken into.
if((_building getVariable[format["bis_disabled_Door_%1",_door],0]) == 0) exitWith {hint localize "STR_House_Raid_DoorUnlocked"};
oev_action_inUse = true;
[[0,"STR_ISTR_FirAx_AlertHouse",true,[profileName]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
//Setup the progress bar
disableSerialization;
_title = localize "STR_ISTR_Axe_Process";
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNamespace getVariable "life_progress";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;
_cpRate = 0.0173;
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
if(oev_interruptedTab) exitWith {oev_interruptedTab = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false;};
life_fireaxe_uses = life_fireaxe_uses + 1;
oev_action_inUse = false;
if(life_fireaxe_uses >= 5) then {
	[false,"fireaxe",1] call OEC_fnc_handleInv;
	life_fireaxe_uses = 0;
};

_building setVariable[format["bis_disabled_Door_%1",_door],0,true];
[
	["event", "Fireaxe Opened Door"],
	["player", name player],
	["player_id",getPlayerUID player],
	["target_id",(_house getVariable "house_owner") select 0],
	["house_id",_house getVariable "house_id"],
	["playerside",side player],
	["location",getPosATL player]
] call OEC_fnc_logIt;
