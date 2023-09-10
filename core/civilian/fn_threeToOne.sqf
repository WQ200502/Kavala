//  File: fn_threeToOne.sqf
//	Author: Jesse "tkcjesse" Schultz
//  Modifications: Fusah
//	Description: Enforces 3 to 1 douchebagery

params [
	["_target",objNull,[objNull]]
];

if !(side _target isEqualTo west) exitWith {false};
if (license_civ_vigilante) exitWith {hint "You're not supposed to be capturing law enforcement members!"; false};

private _haveWeapons = 0;
private _exit = false;

{
	if (_haveWeapons >= 3) exitWith {};
	if (((_x distance _target) < 10) && {(side _x isEqualTo civilian)} && {!(_x getVariable ["restrained",false])} && {!(_x getVariable ["downed",false])}) then {
		if ([_x,"VIEW"] checkVisibility [eyePos player, eyePos _x] > 0) then {
			if (!(currentWeapon _x isEqualTo "") && {!(currentWeapon _x in oev_fake_weapons)}) then {
				_haveWeapons = _haveWeapons + 1;
			};
		};
	};
} forEach playableUnits;

if (_haveWeapons < 3) exitWith {hint "You don't meet the 3 to 1 requirements!"; false};
if !(life_pInact_curTarget getVariable ["downed",false]) exitWith {hint "The officer needs to be downed before you can restrain him!"; false};

if ((side player != west) && (side _target isEqualTo west)) then {
	private _nearPlayers = ((nearestObjects[_target,["Man"],25]) arrayIntersect playableUnits);
	{
		if (side _x isEqualTo west && (_x getVariable ["downed",false] isEqualTo false && _x getVariable ["restrained",false] isEqualTo false && !(currentWeapon _x isEqualTo ""))) exitWith {_exit = true};
	} forEach _nearPlayers;
};

if (_exit) exitWith {hint "All cops in a 25 meter radius must be tazed, restrained, or robbed for you to restrain this cop."; false};

true;