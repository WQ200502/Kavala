//  File: fn_handleVehDamage.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Handles damage for vehicles, mainly for armor upgrades
private["_unit","_damage","_source","_projectile","_hitBox","_mods","_wheelArmor","_hullArmor","_engineArmor","_fuelArmor","_dmgMod","_bulletproofGlass","_selections","_gethit","_selection","_olddamage","_scale","_isPlane"];
_unit = _this select 0;
_projectile = "";
if ((_this select 4) isEqualTo "<NULL-object>") then {
	_hitBox = _this select 2;
	_damage = _this select 3;
	_source = _this select 4;
} else {
	_hitBox = _this select 1;
	_damage = _this select 2;
	_source = _this select 3;
	_projectile = _this select 4;
};
_mods = _unit getVariable["modifications",[0,0,0,0,0,0,0,0]];
_wheelArmor = _mods select 2;
_hullArmor = _mods select 3;
_engineArmor = _mods select 4;
_fuelArmor = _mods select 5;
_bulletproofGlass = _mods select 6;

if(((typeof (vehicle _source)) in ["I_Heli_light_03_F","O_Heli_Light_02_v2_F","B_Heli_Light_01_armed_F","B_Plane_CAS_01_F","O_Plane_CAS_02_F","I_Plane_Fighter_03_CAS_F","O_Boat_Armed_01_hmg_F","O_Plane_Fighter_02_F","I_Plane_Fighter_04_F","B_Plane_Fighter_01_F"]) && (((player getVariable ["isInEvent",["no"]]) select 0) == "no")) exitWith {_damage = (getDammage _unit); _damage;};
if(_projectile == "Missile_AA_04_F") exitWith {_unit spawn{_this allowDamage false; sleep 2; _this allowDamage true;}; _damage = (getDammage _unit); _damage;};

if (_hitBox != "?") then {
	_oldDamage = if (_hitBox == "") then { damage _unit } else { _unit getHit _hitBox };

	if (!isNil "_oldDamage") then {
		_isPlane = _unit isKindOf "Plane";

		if (isNull _source && _projectile == "") exitWith {
			_scale = switch (true) do {
				case (_hitBox select [0,5] == "wheel"): { 0.15 };
				case (_isPlane):{ 0.5 };
				default { 0.35 };
			};

			_damage = ((_damage - _oldDamage) * _scale) + _oldDamage;
		};

		if((typeof (vehicle _unit) in ["B_Heli_Transport_01_F","B_Heli_Transport_01_camo_F","B_Heli_Transport_03_black_F","B_Heli_Transport_03_F","B_Heli_Transport_03_unarmed_green_F"]) && _projectile != "M_Titan_AA" && _projectile != "R_PG7_F") then {
			_scale = 0.5;

			switch(_hitBox) do {
				case "main_rotor_hit":{_scale = 0.25};
				default {_scale = 0.5};
			};

			_damage = ((_damage - _oldDamage) * _scale) + _oldDamage;
		} else {
			if (typeOf (vehicle _unit) isEqualTo "O_LSV_02_unarmed_viper_F" && _projectile != "") then {
				_scale = 0.5;
				switch(_hitBox) do {
					case "engine": {_scale = 0.1};
					case "light_1": {_scale = 0.1};
					case "light_2": {_scale = 0.1};
				};
				_damage = ((_damage - _oldDamage) * _scale) + _oldDamage;
			};
		};
	};
};

if(_source isKindOf "Man") then {

//		if (_hitBox in ["wheel_1_1_steering","wheel_1_2_steering","wheel_1_3_steering","wheel_1_4_steering","wheel_2_1_steering","wheel_2_2_steering","wheel_2_3_steering","wheel_2_4_steering"]) then {
//			_damage = _damage * (1 - (_wheelArmor/10));
//			_damage = (_damage + (getDammage _unit));
//			[[0,format["%1 %2 %3 %4 %5",_unit,_hitBox,_damage,_source,_projectile]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
//		};
//		if (_hitBox in ["karoserie"]) then {
//			_damage = _damage * (1 - (_hullArmor/10));
//			_damage = (_damage + (getDammage _unit));
//			[[0,format["%1 %2 %3 %4 %5",_unit,_hitBox,_damage,_source,_projectile]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
//		};
//		if (_hitBox in ["engine","motor"]) then {
//			_damage = _damage * (1 - (_engineArmor/10));
//			_damage = (_damage + (getDammage _unit));
//			[[0,format["%1 %2 %3 %4 %5",_unit,_hitBox,_damage,_source,_projectile]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
//		};
//	if (_hitBox in ["palivo","fuel"]) then {
//			_damage = _damage * (1 - (_fuelArmor/10));
//			_damage = (_damage + (getDammage _unit));
//		[[0,format["%1 %2 %3 %4 %5",_unit,_hitBox,_damage,_source,_projectile]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
//	};
//	if (_hitBox in ["glass1","glass2","glass3","glass4","glass5","glass6","light_l","light_r"]) then {
//		_damage = 0;
//		_damage = (_damage + (getDammage _unit));
//		[[0,format["%1 %2 %3 %4 %5",_unit,_hitBox,_damage,_source,_projectile]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
//	};


	if(_projectile isEqualTo "M_Titan_AA" && _unit isKindOf "Air") then {
		if(time > oev_titanAnnouncement) then {
			oev_titanAnnouncement = (time + 3);
			[0,format["%2 was titaned by %1.",(_source getVariable["realname",name _source]),(_unit getVariable["realname",name _unit])]] remoteExec ["OEC_fnc_broadcast",-2];
			[
				["event","Fired a Titan"],
				["player",(_source getVariable["realname",name _source])],
				["player_id",(_source getVariable["steam64id",getPlayerUID _source])],
				["target",(_unit getVariable["realname",name _unit])],
				["target_id",(_unit getVariable["steam64id",getPlayerUID _unit])],
				["position",getPosATL player]
			] call OEC_fnc_logIt;
			["titan_hits",1] remoteExec ["OEC_fnc_statArrUp",_source,false];
			[getPlayerUID _source,_source getVariable ["realname", name _source], "75", _source] remoteExec ["OES_fnc_wantedAdd", 2];

			_unit setHit ["fuel_hit", 1];
			if ((fuel _unit) > 0.15) then {
			_unit setFuel ((fuel _unit) * 0.25);
			};
		};

		_dmgMod = switch(typeOf _unit) do {
			case "B_Heli_Light_01_F": {0.1};
			case "C_Heli_Light_01_civil_F": {0.1};
			case "B_Heli_Transport_01_F": {0.1};
			case "B_Heli_Transport_01_camo_F": {0.1};
			case "B_Heli_Transport_03_unarmed_F": {0.1};
			case "B_Heli_Transport_03_unarmed_green_F": {0.1};
			case "B_Heli_Transport_03_F": {0.1};
			case "O_Heli_Transport_04_bench_F": {0.2};
			case "O_Heli_Transport_04_covered_F": {0.2};
			case "O_Heli_Transport_04_F": {0.2};
			case "O_Heli_Transport_04_repair_F": {0.2};
			case "O_Heli_Transport_04_fuel_F": {0.2};
			case "B_T_VTOL_01_vehicle_F": {0.4};
			case "B_T_VTOL_01_infantry_F": {0.4};
			default {0.15};
		};

		_damage = (getDammage _unit) + ((_damage - (getDammage _unit)) * _dmgMod);
	};

	if (_projectile isEqualTo "R_PG7_F") then { //Make the RPG great again!
		_damage = (_damage * 2);
	};
};


if (typeOf(vehicle _unit) find "_Van_02_" >= 0 || typeOf(vehicle _unit) isEqualTo "C_SUV_01_F") then {
	if (_projectile isEqualTo "") then {_damage = (_damage / 2);};
};

//diag_log format["Unit: %1, HitBox: %2, Total Damage: %3, Source: %4,  Projectile Type: %5. Full Info: ** ( %6 ) **",_unit,_hitBox,_damage,_source,_projectile, _this];

_damage;
