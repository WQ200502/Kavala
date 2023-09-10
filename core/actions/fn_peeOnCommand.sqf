//ripped from https://bitbucket.org/mikehudak/a3_leaking_liquid/src/master/pee.sqf

params [
	["_mode", 0, [0]],
	["_obj", objNull, [objNull]]
];

switch (_mode) do {
	case 0: {
		//["Acts_AidlPercMstpSlowWrflDnon_pissing", 1.5] spawn OEC_fnc_handleAnim;
		if(time - (player getVariable ["peeCooldown",0]) < 25) exitWith {hint "请把你的膀胱再憋一会儿！";};
		player playMove "Acts_AidlPercMstpSlowWrflDnon_pissing";
		player setVariable["peeCooldown",time];
		[1, player] remoteExec ["OEC_fnc_peeOnCommand", ((position player nearEntities ["Man", 50]) select {isPlayer _x}) + (([8486.22,25121.5,0] nearEntities ["Man", 800]) select {isPlayer _x})];
	};
	case 1: {
		if (isNull _obj) exitWith {};
		uiSleep 4;
		private _piss = "#particlesource" createVehicleLocal [0,0,0];
		_piss setParticleRandom [0,[0.004,0.004,0.004],[0.01,0.01,0.01],30,0.01,[0,0,0,0],1,0.02,360];
		_piss setDropInterval 0.001;
		_piss attachTo [_obj,[0.1,0.15,-0.10],"Pelvis"];

		private _particle = [["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,3,[0,0,0],[0,0,0],0,1.5,1,0.1,[0.02,0.02,0.1],[[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0]],[1],1,0,"","",_piss,0,true,0.1,[[0.8,0.7,0.2,0]]];
		for "_i" from 0 to 1 step 0.01 do {
			_particle set [6, [sin(getDir _obj) * _i, cos(getDir _obj) * _i, 0]];
			_piss setParticleParams _particle;
			uiSleep 0.02;
		};
		uiSleep 4;

		for "_i" from 1 to 0.4 step -0.01 do {
			_particle set [6, [sin(getDir _obj) * _i, cos(getDir _obj) * _i, 0]];
			_piss setParticleParams _particle;
			uiSleep 0.02;
		};

		for "_i" from 0.4 to 0.8 step 0.02 do {
			_particle set [6, [sin(getDir _obj) * _i, cos(getDir _obj) * _i, 0]];
			_piss setParticleParams _particle;
			uiSleep 0.02;
		};

		for "_i" from 0.8 to 0.2 step -0.01 do {
			_particle set [6, [sin(getDir _obj) * _i, cos(getDir _obj) * _i, 0]];
			_piss setParticleParams _particle;
			uiSleep 0.02;
		};

		for "_i" from 0.2 to 0.3 step 0.02 do {
			_particle set [6, [sin(getDir _obj) * _i, cos(getDir _obj) * _i, 0]];
			_piss setParticleParams _particle;
			uiSleep 0.02;
		};

		for "_i" from 0.3 to 0.1 step -0.01 do {
			_particle set [6, [sin(getDir _obj) * _i, cos(getDir _obj) * _i, 0]];
			_piss setParticleParams _particle;
			uiSleep 0.02;
		};

		for "_i" from 0.1 to 0 step -0.01 do {
			_particle set [6, [sin(getDir _obj) * _i, cos(getDir _obj) * _i, 0]];
			_particle set [12, [[0.8,0.7,0.2,_i],[0.8,0.7,0.2,_i],[0.8,0.7,0.2,0]]];
			_piss setParticleParams _particle;
			uiSleep 0.02;
		};

		deleteVehicle _piss;
	};
};