//  File: fn_copInteractionMenu.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Replaces the mass for various cop actions towards another player.
#include <interaction.h>
private["_giveButton"];
_giveButton = [
	localize "STR_Global_Give",
	"[] spawn OEC_fnc_giveMenu; closeDialog 0;"
];
if(!dialog) then {
	["pInteraction_Menu"] call OEC_fnc_createDialog;
};
disableSerialization;
params [
	["_curTarget",objNull,[objNull]]
];
if(isNull _curTarget) exitWith {closeDialog 0;}; //Bad target

if(!isPlayer _curTarget && side _curTarget isEqualTo civilian) exitWith {closeDialog 0;}; //Bad side check?
life_pInact_curTarget = _curTarget;

if (life_pInact_curTarget getVariable ["restrained",false]) then {
	private _blindfoldButton = if (life_pInact_curTarget getVariable ["blindfolded", false]) then {
		["移除眼罩", "closeDialog 0; if (player distance life_pInact_curTarget > 4) exitWith {hint 'You are too far away.'};[life_pInact_curTarget] call OEC_fnc_removeBlindfold;"]
	} else {
		[
			"带上眼罩",
			"closeDialog 0; if (player distance life_pInact_curTarget > 4) exitWith {hint 'You are too far away.'};[life_pInact_curTarget] call OEC_fnc_blindfold;",
			{ life_pInact_curTarget getVariable ["restrained", false] }
		]
	};
	private _eligibleVehicles = nearestObjects[getPosATL player,["Car","Ship","Submarine","Air"],10,true];
	private _pardonPutInButton = if (count _eligibleVehicles > 0) then {
		[
			localize "STR_pInAct_PutInCar",
			"[life_pInact_curTarget] call OEC_fnc_putInCar;"
		]
	} else {
		[
			localize "STR_Wanted_Pardon",
			"[player, life_pInact_curTarget] spawn OEC_fnc_localPardon;"
		]
	};
	private _buttons = [
		[localize "STR_pInAct_Unrestrain", "[life_pInact_curTarget] call OEC_fnc_unrest1rain; closeDialog 0;"],
		["搜索功能", "[life_pInact_curTarget] call OEC_fnc_searchInteractionMenu;"],
		["扣押功能", "[life_pInact_curTarget] call OEC_fnc_seizeInteractionMenu;"],
		[localize "STR_pInAct_Escort", "[life_pInact_curTarget] spawn OEC_fnc_escortAction; closeDialog 0;"],
		[localize "STR_pInAct_TicketBtn", "[life_pInact_curTarget] call OEC_fnc_ticketAction;"],
		[localize "STR_pInAct_Arrest", "closeDialog 0; [life_pInact_curTarget] spawn OEC_fnc_arrestAction;", { ((player distance (getMarkerPos "police_hq_1") < 45) || (player distance (getMarkerPos "police_hq_2") < 45) || (player distance (getMarkerPos "cop_spawn_3") < 45) || (player distance (getMarkerPos "cop_spawn_4") < 45) || (player distance (getMarkerPos "jailtransport_2") < 25) || (player distance (getMarkerPos "jailtransport_1") < 25) || (player distance (getMarkerPos "cop_spawn_5") < 30) || (player distance (getMarkerPos "cop_spawn_6") < 90) || ((player distance (getMarkerPos "cop_spawn_7") < 40) && ((life_bwObj getVariable "robtime") <= time))) } ],
		_pardonPutInButton,
		_blindfoldButton,
		_giveButton
	];
	_buttons call OEC_fnc_setupInteractionMenu;
} else {
	private _buttons = [
	[localize "STR_pInAct_checkLicenses", "[player] remoteExec [""OEC_fnc_licenseCheck"", life_pInact_curTarget, FALSE];"],
	_giveButton
	]; _buttons call OEC_fnc_setupInteractionMenu;
};