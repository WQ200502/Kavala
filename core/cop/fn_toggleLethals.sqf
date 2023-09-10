//	Filename: fn_toggleLethals.sqf
//	Author: Serpico
//	Description: This script deals with toggling lethals on and off

if (playerSide != west) exitWith {}; // Only cops can do this
//private ["_ammo","_mag"];
disableSerialization;
// Set ammo to rubber and remove onscreen icon
if (((currentWeapon player) in oev_taserWeapons) && !(player getVariable ["nonLethals",false])) exitWith {

	// Reload weapon when change to lethal
	//if ((isNull objectParent player) && (player ammo (currentWeapon player) > 0)) then {
		//_ammo = player ammo (currentWeapon player);
		//_mag = currentMagazine player;
		//player setAmmo [currentWeapon player, 0];
		//reload player;
		//player addMagazine [_mag,_ammo];
	//};

	player setVariable ['nonLethals',true,true];
	11 cutText["","PLAIN DOWN"];
};

// Set ammo to lethals and add onscreen icon
if ((((player getVariable ["rank",0]) > 2) || ((getPos player inPolygon oev_warzonePoly || player getVariable ["lethalsPO", false]) && ((player getVariable ["rank",0]) == 2))) && ((currentWeapon player) in oev_taserWeapons) && (player getVariable ["nonLethals",false])) exitWith {

	// Reload weapon when change to lethal
	//if ((isNull objectParent player) && (player ammo (currentWeapon player) > 0)) then {
	//	_ammo = player ammo (currentWeapon player);
	//	_mag = currentMagazine player;
	//	player setAmmo [currentWeapon player, 0];
	//	reload player;
	//	player addMagazine [_mag,_ammo];
	//};

	player setVariable ['nonLethals',false,true];
	11 cutRsc ["life_lethal_flag","PLAIN DOWN"];
	_uiDisp = uiNamespace getVariable "life_lethal_flag";
	_timer = _uiDisp displayCtrl 38305;
	_timer ctrlSetText "致死人数";

	if (player getVariable ["rank", 0] isEqualTo 2 && !(player getVariable ["lethalsPO", false])) then {
		[] spawn{
			while {getPos player inPolygon oev_warzonePoly && alive player} do {
				uiSleep 1;
			};
			player setVariable ["nonLethals", true, true];
			11 cutText ["", "PLAIN DOWN"];
		};
	};
};