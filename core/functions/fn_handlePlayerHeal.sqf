#include "..\..\macro.h"
//	Filename: fn_handlePlayerHeal.sqf
//	Author: Serpico
//	Description: Handler for player use of the first aid kit. This was made to add action_in_use to prevent exploiting in other menus/actions

private _injured = _this select 0;
private _healer = _this select 1;
private _damage = damage _injured;

oev_action_inUse = true;
if (_damage isEqualTo 0.25) exitWith {oev_action_inUse = false;};
waitUntil {damage _injured != _damage};
oev_action_inUse = false;
if (damage _injured < _damage) then {
	private _dam_obj = _injured;
	if ((__GETC__(life_medicLevel)) > 0 && ("Medikit" in items _healer)) then {
		_dam_obj setDamage 0;
	} else {
		_dam_obj setDamage 0.25;
	};
};
