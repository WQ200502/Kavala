/* v1g Fast Rope by [STELS]Zealot */
if (isdedicated) exitwith {};
waituntil {player == player};

zlt_rope_ropes = [];
zlt_mutexAction = false;

zlt_rope_helis = ["O_Heli_Light_02_unarmed_F","O_Heli_Light_02_F","B_Heli_Transport_01_F","B_Heli_Transport_01_camo_F","O_Heli_Attack_02_F","O_Heli_Attack_02_black_F","I_Heli_Transport_02_F","B_Heli_Light_01_F"];
zlt_rope_helidata =
[
	[
		["O_Heli_Light_02_unarmed_F", "O_Heli_Light_02_F"],
		[1.35,1.35,-24.95],
		[-1.45,1.35,-24.95]
	],
	[
		["B_Heli_Transport_01_F", "B_Heli_Transport_01_camo_F"],
		[-1.11,2.5,-24.7],
		[1.11,2.5,-24.7]
	],
	[
		["O_Heli_Attack_02_F", "O_Heli_Attack_02_black_F"],
		[1.3,1.3,-25],
		[-1.3,1.3,-25]
	],
	[
		["I_Heli_Transport_02_F"],
		[0,-5,-26],
		[]
	],
	[
		["B_Heli_Light_01_F"],
		[0.6,0.5,-25.9],
		[-0.8,0.5,-25.9]
	]
];

RJRND_KRON_ArraySort ={
	private["_a","_d","_k","_s","_i","_vo","_v1","_v2","_j","_c","_x"];
	_a = +(_this select 0);
	_d = if ([_this,"DESC"] call KRON_findFlag) then {-1} else {1};
	_k = if ([_this,"CASE"] call KRON_findFlag) then {"CASE"} else {"nocase"};
	_s = -1;
	if (typeName (_a select 0)=="ARRAY") then {
		_s=0;
		if (((count _this)>1) && (typeName (_this select 1)=="SCALAR")) then {
			_s=_this select 1;
		};
	};
	for "_i" from 0 to (count _a)-1 do {
		_vo = _a select _i;
		_v1 = _vo;
		if (_s>-1) then {_v1=_v1 select _s};
		_j = 0;
		for [{_j=_i-1},{_j>=0},{_j=_j-1}] do {
			_v2 = _a select _j;
			if (_s>-1) then {_v2=_v2 select _s};
			_c=[_v2,_v1,_k] call KRON_Compare;
			if (_c!=_d) exitWith {};
			_a set [_j+1,_a select _j];
		};
		_a set [_j+1,_vo];

		systemChat format["%1",_i];
	};
	_a
};

RJRND_zlt_fnc_tossropes ={
	private ["_heli","_ropes","_oropes","_rope"];
	_heli = _this;
	_ropes = [];
	_oropes = _heli getvariable ["zlt_ropes",[]];
	if (count _oropes != 0 ) exitwith {};
	_i = 0;
	{
		if ((typeof _heli) in (_x select 0)) exitwith {
			_ropes pushBack (_x select 1);
			if (count (_x select 2) != 0) then {
				_ropes pushBack (_x select 2);
			};
		};
		_i = _i +1;
	} foreach zlt_rope_helidata;

	uiSleep random 0.3;
	if ( count (_heli getvariable ["zlt_ropes",[]]) != 0 ) exitwith { zlt_mutexAction = false; };
	_heli animateDoor ['door_R', 1];
	_heli animateDoor ['door_L', 1];
	{
		_rope = createVehicle ["land_rope_f", [0,0,0], [], 0, "CAN_COLLIDE"];
		_rope setdir (getdir _heli);
		_rope attachto [_heli, _x];
		_oropes pushBack _rope;
	} foreach _ropes;
	_heli setvariable ["zlt_ropes",_oropes,true];

	_heli spawn{
		private ["_heli","_ropes"];
		_heli = _this;
		while {alive _heli and count (_heli getvariable ["zlt_ropes", []]) != 0 and abs (speed _heli) < 30 } do {
			uiSleep 0.3;
		};
		_ropes = (_heli getvariable ["zlt_ropes", []]);
		{deletevehicle _x} foreach _ropes;
		_heli setvariable ["zlt_ropes", [], true];
	};

};

RJRND_zlt_fnc_ropes_cond ={
	_veh = vehicle player;
	_flag = (_veh != player) and {(not zlt_mutexAction)} and {count (_veh getvariable ["zlt_ropes", []]) == 0} and { (typeof _veh) in zlt_rope_helis } and {alive player and alive _veh and (abs (speed _veh) < 30 ) } and {driver vehicle player == player};
	_flag;
};

RJRND_zlt_fnc_fastrope ={
	diag_log ["fastrope", _this];
	zlt_mutexAction = true;
	uiSleep random 0.3;
	player call RJRND_zlt_fnc_fastropeUnit;
	zlt_mutexAction = false;
};

RJRND_zlt_fnc_fastropeUnit ={
	private ["_unit","_heli","_ropes","_rope","_zmax","_zdelta","_zc"];
	_unit = _this;
	_heli = vehicle _unit;
	if (_unit == _heli) exitWith {};

	_ropes = (_heli getvariable ["zlt_ropes", []]);
	if (count _ropes == 0) exitwith {};

	_rope = _ropes call BIS_fnc_selectRandom;
	_zmax = 22;
	_zdelta = 7 / 10  ;

	_zc = _zmax;
	_unit action ["eject", _heli];
	_unit switchmove "gunner_standup01";

	_unit setpos [(getpos _unit select 0), (getpos _unit select 1), 0 max ((getpos _unit select 2) - 3)];
	while {alive _unit and (getpos _unit select 2) > 1 and (abs (speed _heli)) < 10  and _zc > -24} do {
		_unit attachTo [_rope, [0,0,_zc]];
		_zc = _zc - _zdelta;
		uiSleep 0.1;
	};
	_unit switchmove "";
	detach _unit;

};


RJRND_zlt_fnc_cutropes ={
	_veh = _this;
	_ropes = (_veh getvariable ["zlt_ropes", []]);
	{deletevehicle _x} foreach _ropes;
	_veh setvariable ["zlt_ropes", [], true];
	_veh animateDoor ['door_R', 0];
	_veh animateDoor ['door_L', 0];

};

RJRND_zlt_fnc_removeropes ={
	(vehicle player) call RJRND_zlt_fnc_cutropes;
};

RJRND_zlt_fnc_createropes ={
	zlt_mutexAction = true;
	(vehicle player) call RJRND_zlt_fnc_tossropes;
	zlt_mutexAction = false;
};


private["_obj_main"];
player createDiarySubject [STR_SCRIPTS_NAME,STR_SCRIPTS_NAME];
player createDiaryRecord [STR_SCRIPTS_NAME,[STR_SCRIPT_NAME, STR_HELP]];
_obj_main = player;
_obj_main addAction["<t color='#ffff00'>"+"Toss Ropes"+"</t>", RJRND_zlt_fnc_createropes, [], -1, false, false, '','[] call RJRND_zlt_fnc_ropes_cond'];
_obj_main addAction["<t color='#ff0000'>"+"Cut Ropes"+"</t>", RJRND_zlt_fnc_removeropes, [], -1, false, false, '','not zlt_mutexAction and count ((vehicle player) getvariable ["zlt_ropes", []]) != 0'];
_obj_main addAction["<t color='#00ff00'>"+"Fast Rope"+"</t>", RJRND_zlt_fnc_fastrope, [], 15, false, false, '','not zlt_mutexAction and count ((vehicle player) getvariable ["zlt_ropes", []]) != 0 and player != driver vehicle player'];

player addEventHandler ["Respawn", {
	_obj_main addAction["<t color='#ffff00'>"+"Toss Ropes"+"</t>", RJRND_zlt_fnc_createropes, [], -1, false, false, '','[] call RJRND_zlt_fnc_ropes_cond'];
	_obj_main addAction["<t color='#ff0000'>"+"Cut Ropes"+"</t>", RJRND_zlt_fnc_removeropes, [], -1, false, false, '','not zlt_mutexAction and count ((vehicle player) getvariable ["zlt_ropes", []]) != 0'];
	_obj_main addAction["<t color='#00ff00'>"+"Fast Rope"+"</t>", RJRND_zlt_fnc_fastrope, [], 15, false, false, '','not zlt_mutexAction and count ((vehicle player) getvariable ["zlt_ropes", []]) != 0 and player != driver vehicle player'];
}];
