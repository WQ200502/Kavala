// File: fn_checkStartEscort.sqf

params [
	["_type",-1,[0]]
];

if !(_type in [1, 2, 3]) exitWith {};
if (currentWeapon player == "" || currentMagazine player in ["30Rnd_9x21_Mag", "16Rnd_9x21_Mag", "11Rnd_45ACP_Mag", "30Rnd_9x21_Mag_SMG_02", "6Rnd_45ACP_Cylinder", "9Rnd_45ACP_Mag"] || currentMagazine player == "") exitWith {hint "你需要一把5.56口径或更高口径的枪来抢劫制药厂！";};

[player, _type] remoteExec ["OES_fnc_startEscort", 2];