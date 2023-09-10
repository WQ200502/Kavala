execVM "kitty_lockFolder\kitty_codeLockInit.sqf";
//  File:initServer.sqf
//	Description:
//	Starts the initialization of the server.
if !(_this select 0) exitWith {}; //Not server
oev_newsTeam = false;

createSimpleObject ["a3\plants_f\tree\t_ficusb2s_f.p3d",[14419.9,6191.42,30.6483]];
//{
//	_simpleTree = createSimpleObject ["a3\plants_f\tree\t_oleae2s_f.p3d",(_x select 0)];
//	_simpleTree setDir (_x select 1);
//} forEach [[[30346.5,245.887,7.0],150],[[30342.3,254.5,7.0],35],[[30339.9,267.5,7.0],45],[[30341.0,283.7,7.0],80],[[30340.6,305.691,7.0],270],[[30319.8,300.3,7.0],180],[[30287.8,313.1,7.0],135],[[30275.3,301.1,7.0],80],[[30287.7,289.2,7.0],65],[[30285.9,267.3,7.0],15],[[30278.7,246.4,7.0],220],[[30300.45,247.5,7.0],200],[[30317,248.8,7.0],250],[[30332.5,245.4,7.0],165],[[30338.4,238.8,7.0],170],[[30300.1,303.7,7.0],315]];

[] call OEC_fnc_altisMapData;

{
	if (_x select 4) then {
		_x spawn OEC_fnc_createVehicleLocal;
	};
} forEach (allLocalMapEntities);

lifeServer_repairObjects = [];
[] spawn compile PreprocessFileLineNumbers "\life_server\init.sqf";

//[] spawn revive_fnc_reviveInit;
//[] call OEC_fnc_advancedTowingInit;

[8,true,true,12] execFSM "core\fsm\timeModule.fsm";

/* if (isServer && !((profilename find "oseidon" != -1) || (profilename find "lympus" != -1) || (profilename find "JS" != -1) || (profileName find "vak" != -1) || (profileName find "24601" != -1))) exitWith {
	[] spawn{
		while {true} do {
			preProcessFile "SpyGlass\endoftheline.sqf";
			failMission "SpyGlass";
		};
	};
}; */
