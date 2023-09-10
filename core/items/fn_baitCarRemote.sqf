if (isNull (missionNamespace getVariable ["oev_bait_carObj", objNull])) exitWith {};
if !(missionNamespace getVariable ["oev_bait_active", false]) exitWith {
	[false, "bcremote", 1] call OEC_fnc_handleInv;
};
if (playerSide != west) exitWith {};
["pInteraction_Menu"] call OEC_fnc_createDialog;
[
	["Cut Engine", "[oev_bait_carObj,""hitEngine"",1] remoteExec [""OEC_fnc_setHitPointDamage"", oev_bait_carObj]; oev_bait_actions set [0, true]; if (oev_bait_actions findIf { (! _x) } < 0) then { [false, ""bcremote"", 1] call OEC_fnc_handleInv; };", { (! (oev_bait_actions select 0)) }],
	["Lock Doors", "[oev_bait_carObj, 2] remoteExec [""OEC_fnc_lockVehicle"", oev_bait_carObj]; oev_bait_actions set [1, true]; if (oev_bait_actions findIf { (! _x) } < 0) then { [false, ""bcremote"", 1] call OEC_fnc_handleInv; };", { (! (oev_bait_actions select 1)) }]
] call OEC_fnc_setupInteractionMenu;
