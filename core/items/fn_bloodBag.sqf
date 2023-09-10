//	Description: Uses a bloodbag to replenish health slowly.
//  File: fn_bloodBag.sqf
private["_startTime"];
if (oev_action_inUse) exitWith {hint "You're already performing another action!";};
oev_bloodBagCooldown = (time + 120);
oev_action_inUse = true;
oev_interrupted = false;
_maxTime = (time + 60);
closeDialog 0;
if (isNull objectParent player) then {
	["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;
};

private _dam_obj = player;
while {true} do {
	if(animationState player != "AinvPknlMstpSnonWnonDnon_medic_1" && (isNull objectParent player)) then {
		player playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1";
	};

	uiSleep 0.26;

	_dam_obj setDamage ((damage player) - 0.005);

	if(time > _maxTime) exitWith {};
	if((damage player <= 0) || !alive player) exitWith {};
	if(oev_interrupted) exitWith {};
	if(!(isNull objectParent player) && ((driver vehicle player) isEqualTo player)) exitWith {};
};
if (player getVariable ["inAnim",false]) then {
	[] spawn OEC_fnc_handleAnim;
};
if(!(isNull objectParent player) && ((driver vehicle player) isEqualTo player)) exitWith {oev_action_inUse = false; titleText["You cannnot bloodbag while driving.","PLAIN DOWN"];};
if(time > _maxTime) exitWith {oev_action_inUse = false; titleText["You've emptied the blood bag.","PLAIN DOWN"];};
if(!alive player) exitWith {oev_action_inUse = false;};
if(player getVariable["restrained",false]) exitWith {oev_action_inUse = false;};
if(oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false; player switchMove "";};
oev_action_inUse = false;
["bloodbag",1] call OEC_fnc_statArrUp;