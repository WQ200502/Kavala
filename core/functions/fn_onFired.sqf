//	Author: Bryan "Tonic" Boardwine
//	Description: Handles various different ammo types being fired.
private _unit = _this select 0;
private _weapon = _this select 1;
private _ammoType = _this select 4;
private _magazine = _this select 5;
private _projectile = _this select 6;

if (oev_isDowned) exitWith {deleteVehicle _projectile;};
if (player getVariable ["restrained",false]) exitWith {
	deleteVehicle _projectile;
	player removeWeapon _weapon;
	hint "You should be restrained right now but are bugged somehow. Please do not exploit while restrained! Attempting to restrain you properly now...";
	player setVariable ["restrained",false,true];
	player setVariable ["zipTied",false,true];
	player setVariable ["Escorting",false,true];
	player setVariable ["transporting",false,true];
	detach player;
	if (isNull ((player getVariable ["restrainedBy",[objNull,0]]) select 0)) then {
		[player] call OEC_fnc_restrain;
	} else {
		[((player getVariable ["restrainedBy",[objNull,0]]) select 0)] call OEC_fnc_restrain;
	};
};
if((typeOf _projectile) isEqualTo "M_Titan_AA")then{
	_target = missileTarget _projectile;
	if (!(isNull _target))then {
		[0,format["%1 fired a titan at you!",_unit getVariable["realname",name _unit]]] remoteExec ["OEC_fnc_broadcast",_target,false];
	};
};

if (_ammoType == "GrenadeHand_stone") then {
	_projectile spawn{
		private["_position"];
		while {!isNull _this} do {
			_position = getPosATL _this;
			uiSleep 0.1;
		};
		[[_position],"OEC_fnc_flashbang",-2,false] spawn OEC_fnc_MP;
	};
};

if (_ammoType isEqualTo "DemoCharge_Remote_Ammo") then {
	[] spawn{
		if (oev_spawnsRunning isEqualTo 1) exitWith {};
		oev_spawnsRunning = oev_spawnsRunning + 1;
		while {true} do {
				//If the player has no explosives currently then exit out of the loop
				if !(count (getAllOwnedMines player) > 0) exitWith {
					private _idx = player getVariable ["oev_explosiveDisarmHandler", -1];
					if (_idx >= 0) then {
						player removeAction _idx;
						player setVariable ["oev_explosiveDisarmHandler", -1];
					};
					oev_spawnsRunning = oev_spawnsRunning - 1;
				};
				private _explosiveFound = false;
				{
					if (((getPos player) distance2D _x) < 3) exitWith {
						oev_nearbyExplosive = _x;
						_explosiveFound = true;
					};
				} forEach (getAllOwnedMines player);
				if (_explosiveFound) then {
					private _obj_main = player;
					private _idx = player getVariable ["oev_explosiveDisarmHandler", -1];
					if (_idx isEqualTo -1) then {
						_idx = _obj_main addAction [
							"Deactivate mine",
							"player action [""deactivate"", player, oev_nearbyExplosive]; oev_nearbyExplosive = objNull;",
							nil,
							4,
							true,

							false,
							"",
							""
						];
						player setVariable ["oev_explosiveDisarmHandler", _idx];
					};
				} else {
					private _idx = player getVariable ["oev_explosiveDisarmHandler", -1];
					if (_idx >= 0) then {
						player removeAction _idx;
						player setVariable ["oev_explosiveDisarmHandler", -1];
					};
				};
			sleep 0.5;
		};
	};
};


[_projectile,_magazine] spawn{
	_initSpd = getNumber (configFile >> "CfgMagazines" >> (_this select 1) >> "initSpeed");
	_i = 0;
	while {alive (_this select 0) && _i < 0.5} do { // Loops for half a second checking for faster bullet velocity than what it should be.
		_vel = velocity (_this select 0);
		_pVel = velocity (vehicle player);
		// Compares bullet velocity to player velocity to get close to true speed
		_spd = sqrt(((_vel select 0)^2) + ((_vel select 1)^2) + ((_vel select 2)^2)) - sqrt(((_pVel select 0)^2) + ((_pVel select 1)^2) + ((_pVel select 2)^2));
		// Add some extra to defaults because some weapons change bullet velocity
		_max = if (typeOf (_this select 0) in ["M_Titan_AA","R_PG7_F","B_65x39_Caseless","B_65x39_Case_green"]) then [{_initSpd + 200},{_initSpd + 100}];

		if(_spd > _max && (player getVariable ["velLog", time]) <= time) exitWith {
			[11,player,[_spd,_max]] remoteExecCall ["OES_fnc_handleDisc",2];
			player setVariable ["velLog", time + 10];
		};
		sleep 0.1;
		_i = _i+0.1;
	};
};

//if ((_ammoType isEqualTo "G_40mm_SmokeOrange") || (_ammoType isEqualTo "SmokeShellOrange")) then {
//	[_projectile] spawn{
//		params ["_projectile"];
//		waitUntil {
//			uiSleep 1;
//			speed _projectile < 0.2
//		};
//		_near = playableUnits select {(_x distance _projectile) < 2000};
//		[[_projectile],"OEC_fnc_teargas",_near,false] spawn OEC_fnc_MP;
//	};
//};
