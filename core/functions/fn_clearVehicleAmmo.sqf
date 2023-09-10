//  File: fn_clearVehicleAmmo.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Clears the vehicle of ammo types that we don't want.

params [
	["_vehicle",objNull,[objNull]],
	["_side","none",[""]],
	["_adminSpawned",false,[false]]
];

if(isNull _vehicle) exitWith {};

switch (typeOf _vehicle) do {
	case "I_Plane_Fighter_03_CAS_F": {
		_vehicle removeWeaponTurret ["Twin_Cannon_20mm",[-1]];
		_vehicle removeWeaponTurret ["missiles_SCALPEL",[-1]];
		_vehicle removeWeaponTurret ["missiles_ASRAAM",[-1]];
		_vehicle removeWeaponTurret ["GBU12BombLauncher_Plane_Fighter_03_F",[-1]];
	};

	case "C_Plane_Civil_01_racing_F": {
		if (_side != "med" && (((_vehicle getVariable ["modifications", [0,0,0,0,0,0,0,0]]) select 3) isEqualTo 1 || _adminSpawned)) then {
			_vehicle addMagazineTurret ["100Rnd_127x99_mag_Tracer_Red",[-1]];
			_vehicle addWeaponTurret ["HMG_M2",[-1]];
			_vehicle addMagazineTurret ["100Rnd_127x99_mag_Tracer_Red",[-1]];
			_vehicle addMagazineTurret ["100Rnd_127x99_mag_Tracer_Red",[-1]];
			_vehicle addWeaponTurret ["CMFlareLauncher",[-1]];
			_vehicle addMagazineTurret ["60Rnd_CMFlare_Chaff_Magazine",[-1]];
			_vehicle addEventHandler ["IncomingMissile", {
				params ["_target", "_ammo", "_vehicle", "_instigator"];
				[_target] spawn{
					_target = param [0,ObjNull,[ObjNull]];
					[3,"<t color='#ff0000'><t size='2'><t align='center'>警报<br/><t color='#eeeeff'><t align='center'><t size='1.2'>来袭导弹"] remoteExec ["OEC_fnc_broadcast",(driver _target),false];
					sleep 2;
					[3,"<t color='#ffff00'><t size='2'><t align='center'>雷达<br/><t color='#eeeeff'><t align='center'><t size='1.2'>扫描更多的导弹！"] remoteExec ["OEC_fnc_broadcast",(driver _target),false];
				};
				}];
		};
		if (_side == "cop") then {
			_vehicle setVariable ["teargasCans", 6, true];
		};
	};

	case "O_Plane_CAS_02_F": {
		_vehicle removeWeaponTurret ["Cannon_30mm_Plane_CAS_02_F",[-1]];
		_vehicle removeWeaponTurret ["Missile_AA_03_Plane_CAS_02_F",[-1]];
		_vehicle removeWeaponTurret ["Missile_AGM_01_Plane_CAS_02_F",[-1]];
		_vehicle removeWeaponTurret ["Bomb_03_Plane_CAS_02_F",[-1]];
		_vehicle removeWeaponTurret ["Rocket_03_HE_Plane_CAS_02_F",[-1]];
		_vehicle removeWeaponTurret ["Rocket_03_AP_Plane_CAS_02_F",[-1]];
	};

	case "B_Plane_CAS_01_F": {
		_vehicle removeWeaponTurret ["Gatling_30mm_Plane_CAS_01_F",[-1]];
		_vehicle removeWeaponTurret ["Missile_AA_04_Plane_CAS_01_F",[-1]];
		_vehicle removeWeaponTurret ["Missile_AGM_02_Plane_CAS_01_F",[-1]];
		_vehicle removeWeaponTurret ["Bomb_04_Plane_CAS_01_F",[-1]];
		_vehicle removeWeaponTurret ["Rocket_04_HE_Plane_CAS_01_F",[-1]];
		_vehicle removeWeaponTurret ["Rocket_04_AP_Plane_CAS_01_F",[-1]];
	};

	case "I_Plane_Fighter_04_F": {
		_vehicle removeWeaponTurret ["weapon_Fighter_Gun20mm_AA",[-1]];
		_vehicle removeWeaponTurret ["Laserdesignator_pilotCamera",[-1]];
		_vehicle removeWeaponTurret ["weapon_BIM9xLauncher",[-1]];
		_vehicle removeWeaponTurret ["weapon_AGM_65Launcher",[-1]];
		_vehicle removeWeaponTurret ["weapon_AMRAAMLauncher",[-1]];
	};

	case "B_Plane_Fighter_01_F": {
		_vehicle removeWeaponTurret ["weapon_Fighter_Gun20mm_AA",[-1]];
		_vehicle removeWeaponTurret ["Laserdesignator_pilotCamera",[-1]];
		_vehicle removeWeaponTurret ["weapon_BIM9xLauncher",[-1]];
		_vehicle removeWeaponTurret ["weapon_GBU12Launcher",[-1]];
		_vehicle removeWeaponTurret ["weapon_AMRAAMLauncher",[-1]];
		_vehicle removeWeaponTurret ["weapon_AGM_65Launcher",[-1]];
	};

	case "O_Plane_Fighter_02_F": {
		_vehicle removeWeaponTurret ["weapon_Fighter_Gun_30mm",[-1]];
		_vehicle removeWeaponTurret ["Laserdesignator_pilotCamera",[-1]];
		_vehicle removeWeaponTurret ["weapon_R73Launcher",[-1]];
		_vehicle removeWeaponTurret ["weapon_R77Launcher",[-1]];
		_vehicle removeWeaponTurret ["weapon_KAB250Launcher",[-1]];
	};

	case "B_Boat_Armed_01_minigun_F": {
		_vehicle removeMagazinesTurret ["200Rnd_40mm_G_belt",[0]];
	};

	case "B_APC_Wheeled_01_cannon_F": {
		_vehicle removeMagazinesTurret ["60Rnd_40mm_GPR_Tracer_Red_shells",[0]];
		_vehicle removeMagazinesTurret ["40Rnd_40mm_APFSDS_Tracer_Red_shells",[0]];
	};

	case "O_Heli_Attack_02_black_F": {
		_vehicle removeMagazinesTurret ["250Rnd_30mm_APDS_shells",[0]];
		_vehicle removeMagazinesTurret ["8Rnd_LG_scalpel",[0]];
		_vehicle removeMagazinesTurret ["38Rnd_80mm_rockets",[0]];
	};

	case "B_Heli_Transport_01_F": {
		if (_side == "med") then {
			_vehicle removeMagazinesTurret ["2000Rnd_65x39_Belt_Tracer_Red",[1]];
			_vehicle removeMagazinesTurret ["2000Rnd_65x39_Belt_Tracer_Red",[2]];
		};
	};
	case "O_T_VTOL_02_infantry_F": {
	    _vehicle removeMagazinesTurret ["250Rnd_30mm_HE_shells_Tracer_Green",[0]];
        _vehicle removeMagazinesTurret ["250Rnd_30mm_APDS_shells_Tracer_Green",[0]];
        _vehicle removeMagazinesTurret ["8Rnd_LG_scalpel",[0]];
	    _vehicle removeMagazinesTurret ["38Rnd_80mm_rockets",[0]];
   };
   case "O_T_VTOL_02_vehicle_F": {
		_vehicle removeMagazinesTurret ["250Rnd_30mm_HE_shells_Tracer_Green",[0]];
        _vehicle removeMagazinesTurret ["250Rnd_30mm_APDS_shells_Tracer_Green",[0]];
        _vehicle removeMagazinesTurret ["8Rnd_LG_scalpel",[0]];
	    _vehicle removeMagazinesTurret ["38Rnd_80mm_rockets",[0]];
   };
   case "I_Heli_light_03_dynamicLoadout_F": {
   	_vehicle removeWeaponTurret ["missiles_DAR",[-1]];
   	_vehicle removeWeaponTurret ["M134_minigun",[-1]];
	_vehicle removeWeapon "missiles_DAGR";
	_vehicle setPylonLoadout [1, "",true];
	_vehicle removeWeapon "missiles_DAGR";
	_vehicle setPylonLoadout [2, "",true];
   	_vehicle removeMagazinesTurret ["5000Rnd_762x51_Yellow_Belt",[-1]];
   	_vehicle removeMagazinesTurret ["24Rnd_missiles",[-1]];
   };
};

clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;

_vehicle disableTIEquipment true;
