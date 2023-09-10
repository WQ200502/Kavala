//  File: fn_spawnConfirm.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Spawns the player where he selected.
private["_spCfg","_sp","_spawnPos","_spawnName"];

(findDisplay 38500) closeDisplay 0;
cutText ["","BLACK IN"];
oev_inSpawnMenu = false;

if(oev_medredeploy) then {
	_dam_obj = player;
	_dam_obj setdammage 0;
	oev_thirst = 100;
	oev_hunger = 100;
	oev_medredeploy = false;
};
if(oev_copredeploy) then {
	_dam_obj = player;
	_dam_obj setdammage 0;
	oev_thirst = 100;
	oev_hunger = 100;
	oev_copredeploy = false;
};
if (count life_spawn_point isEqualTo 0) then {
	private["_sp","_spCfg"];
	_spCfg = [playerSide] call OEC_fnc_spawnPointCfg;
	_sp = _spCfg select 0;
	_spawnName = _spCfg select 1;

	if(playerSide isEqualTo civilian) then {
		if(isNil {(call compile format["%1", _sp select 0])}) then {
			(_sp select 0) spawn{
				waitUntil{life_loadingSystemContinue};
				player setPos (getMarkerPos _this);
				[] call OEC_fnc_hudUpdate;
			};
		} else {
			_spawnPos = (call compile format["%1", _sp select 0]) call BIS_fnc_selectRandom;
			_spawnPos = _spawnPos buildingPos 0;
			(_spawnPos) spawn{
				waitUntil{life_loadingSystemContinue};
				player setPos (_this);
				[] call OEC_fnc_hudUpdate;
			};
		};
	} else {
		(_sp select 0) spawn{
			waitUntil{life_loadingSystemContinue};
			player setPos (getMarkerPos _this);
			[] call OEC_fnc_hudUpdate;
		};
	};
} else {
	if(playerSide isEqualTo civilian) then {
		if(isNil {(call compile format["%1",life_spawn_point select 0])}) then {
			private["_bPos","_house","_pos"];
			if(["house",life_spawn_point select 0] call BIS_fnc_inString) then {
				if !(["Gang Shed",(life_spawn_point select 1)] call BIS_fnc_inString) then {
					_house = nearestObjects [getMarkerPos (life_spawn_point select 0),["House_F"],10] select 0;
					_bPos = [_house] call OEC_fnc_getBuildingPositions;

					if(count _bPos isEqualTo 0) exitWith {
						(life_spawn_point select 0) spawn{
							waitUntil{life_loadingSystemContinue};
							player setPos (getMarkerPos _this);
							[] call OEC_fnc_hudUpdate;
						};
					};

					{_bPos = _bPos - [(_house buildingPos _x)];} foreach (_house getVariable ["slots",[]]);
					_pos = _bPos call BIS_fnc_selectRandom;
					(_pos) spawn{
						waitUntil{life_loadingSystemContinue};
						player setPosATL (_this);
						[] call OEC_fnc_hudUpdate;
					};
				} else {
					_house = nearestObjects [getMarkerPos (life_spawn_point select 0),["House_F"],10] select 0;
					player setPosATL (_house buildingPos (selectRandom [1,4,8,9]));
					[] call OEC_fnc_hudUpdate;
				};
			} else {
				(life_spawn_point select 0) spawn{
					waitUntil{life_loadingSystemContinue};
					player setPos (getMarkerPos _this);
					[] call OEC_fnc_hudUpdate;
				};
			};
		} else {
			_spawnPos = (call compile format["%1", life_spawn_point select 0]) call BIS_fnc_selectRandom;
			_spawnPos = _spawnPos buildingPos 0;

			(_spawnPos) spawn{
				waitUntil{life_loadingSystemContinue};
				player setPos (_this);
				[] call OEC_fnc_hudUpdate;
			};
		};
	} else {
		if (playerSide isEqualTo west) then {
			if (life_copSpawnVer) then {
				private _outdoorPts = [];
				private _bldgPts = [];

				switch (life_spawn_point select 0) do {
					//	Kavala
					case "cop_spawn_1": {
						_outdoorPts = [[3160.31,12914.6,0],[3174.18,12920.7,0],[3195.86,12925.2,0],[3206.93,12904.5,0],[3203.3,12891.9,0],[3207.03,12878.7,0],[3222.15,12949.1,0],[3207.32,12936.3,0],[3247.03,12975.8,0],[3242.4,12962.5,0]];
						_bldgPts = [[3274.8,12968.5,8.23095],[3273.52,12967.6,12.068],[3274.23,12971.6,12.06],[3263.57,12975.5,0.37],[3273.64,12966.5,0.34],[3286.82,12977.9,0.1],[3311.19,12972.9,0.31],[3306.17,12967.5,4.26624],[3315.33,12970.1,0.17601]];
					};
					// Pyrgos
					case "cop_spawn_2": {
						_outdoorPts = [[17416.6,13103.7,0],[17443,13087,0],[17471.1,13116.3,0],[17505.1,13102.4,0],[17480.6,13157.1,0],[17421.4,13113,0],[17357.6,13180.5,0],[17326.6,13202.7,0],[17374.8,13196.4,0],[17389.1,13140.3,0],[17429.3,13158.1,0],[17488,13202.1,0],[17457.4,13234.5,0],[17463.1,13198.1,0],[17519,13142,0]];
						_bldgPts = [[17415.8,13137.6,0.584135],[17416.9,13126.2,0.584134],[17416.9,13126.2,0.584134],[17437.9,13097.8,3.10275],[17440.5,13100.7,0.707022],[17480.4,13088,0.743872],[17496.4,13156.6,3.1013],[17489.8,13159.4,0.639351],[17461.1,13192.4,0.734475],[17440.9,13207.8,0.575518],[17461.8,13123.5,0.730218]];
					};
					//	Athira
					case "cop_spawn_3": {
						_outdoorPts = [[13845.8,18618.9,0],[13875.1,18612.9,0],[13852.6,18553.8,0],[13876.4,18587.3,0],[13866.5,18632.9,0]];
						_bldgPts = [[13869.6,18630,4],[13854.1,18571.2,.93],[13844.2,18623.5,0.00143814],[13876.4,18608.4,.93],[13871.7,18609.8,.47],[13823.3,18564.3,.90],[13841,18634.8,1.23]];
					};
					//	Air
					case "cop_spawn_4": {
						_outdoorPts = [[14177.8,16330.3,0],[14183.7,16323.1,0],[14198.5,16310.7,0],[14223.6,16280.8,0],[14152.6,16302.3,0],[14139.8,16283.6,0],[14131.9,16269.4,0],[14122.4,16243.7,0],[14137.8,16244.2,0],[14134.5,16238.3,0],[14146.7,16239.4,0],[14142.7,16255.7,0],[14161.3,16278.5,0],[14183.1,16220.2,0],[14189.2,16234.4,0],[14198.5,16250.1,0]];
						_bldgPts = [[14206.6,16261,4.34391],[14192.7,16313.5,3.11433],[14186.3,16313.5,0.615873],[14156.1,16304.3,4.13643],[14129,16260.7,0.581244],[14137.7,16249.6,0.552811],[14158.9,16239.4,0.450243],[14144.6,16246.2,0.579502],[14173.3,16239.9,0.529348],[14170.2,16249.1,0.758436],[14160,16253.3,0.770948],[14151.4,16243,0.687832]];
					};
					//	Sofia
					case "cop_spawn_5": {
						_outdoorPts = [[25220.2,21805.5,0],[25225.3,21851.4,0],[25337.1,21815.4,0],[25253.1,21856.7,0],[25332.7,21820.5,0],[25323,21783.3,0]];
						_bldgPts = [[25259.8,21860.3,1.3465],[25240.6,21811.2,1.90398],[25207,21810.5,4.45023],[25299.4,21779.7,4.31384],[25317.8,21811,0.56012],[25231.8,21807.3,4.65549],[25328,21782.9,4.48959]];
					};
					//	Neochori
					case "cop_spawn_6": {
						_outdoorPts = [[12409.5,14088.2,0],[12441.3,14118.6,0],[12441.2,14155.7,0],[12427.1,14144.7,0],[12405.9,14149.7,0],[12436.5,14093.3,0],[12396.3,14112.6,0]];
						_bldgPts = [[12410,14086.3,4.24317],[12427.6,14102.1,0.234748],[12441.5,14108.8,9.2953],[12445.4,14141.5,0.35378],[12442.4,14140.1,0.345426],[12445.1,14108.5,1.12592],[12444.9,14163.9,4.62063]];
					};
					//	Blackwater
					case "cop_spawn_7": {
						_outdoorPts = [[21790.8,18250,0],[21789.3,18236.3,0],[21793.6,18228.2,0],[21775.9,18249.2,0],[21757.7,18260.8,0],[21742.2,18246,0],[21728.3,18205.4,0],[21721.6,18223.2,0],[21761.8,18208.4,0]];
						_bldgPts = [[21765.7,18208.3,4.30199],[21744.9,18259.4,0.762167],[21744.3,18256.8,0.604183],[21738.7,18252.8,4.35963],[21716.5,18215,0],[21733.9,18206.6,0],[21749.1,18264.2,0.572313]];
					};
				};

				private _points = _outdoorPts;
				if (life_copSpawnBldgs) then {
					_points append _bldgPts;
				};

				private _finalPos = selectRandom _points;

				waitUntil {life_loadingSystemContinue};
				player setPos _finalPos;
				[] call OEC_fnc_hudUpdate;
			} else {
				private "_radius";
				_radius = switch (life_spawn_point select 0) do {
					case "cop_spawn_2": {150};
					case "cop_spawn_3": {150};
					case "cop_spawn_4": {150};
					case "cop_spawn_5": {55};
					case "cop_spawn_6": {55};
					default {55};
				};

				diag_log format ["RADIUS: %1",_radius];
				if ((life_spawn_point select 0) == "cop_spawn_1") then {
					private "_building";
					_building = nearestObject [(getMarkerPos "cop_spawn_1"),"Land_Offices_01_V1_F"];

					(selectRandom (_building buildingPos -1)) spawn{
						waitUntil{life_loadingSystemContinue};
						player setPosATL (_this);
						[] call OEC_fnc_hudUpdate;
					};

				} else {
					private ["_buildings","_mPos","_building"];
					_mPos = getMarkerPos (life_spawn_point select 0);
					diag_log format ["MPOS: %1",_mPos];
					_buildings = nearestObjects [_mPos,["Land_Cargo_House_V1_F","Land_Cargo_Patrol_V1_F","Land_MilOffices_V1_F"],_radius];

					if(_buildings isEqualTo []) then{
						((getMarkerPos (life_spawn_point select 0))) spawn{
							waitUntil{life_loadingSystemContinue};
							player setPos (_this);
							[] call OEC_fnc_hudUpdate;
						};

					} else {
						_building = selectRandom _buildings;
						if ((typeOf _building) == "Land_MilOffices_V1_F") then {

							(selectRandom (_building buildingPos -1)) spawn{
								waitUntil{life_loadingSystemContinue};
								player setPosATL (_this);
								[] call OEC_fnc_hudUpdate;
							};
						} else {
							(_building buildingPos 0) spawn{
								waitUntil{life_loadingSystemContinue};
								player setPosATL (_this);
								[] call OEC_fnc_hudUpdate;
							};
						};
					};
				};
			};
		} else {
			(getMarkerPos (life_spawn_point select 0)) spawn{
				waitUntil{life_loadingSystemContinue};
				player setPos (_this);
				[] call OEC_fnc_hudUpdate;
			};
		};
	};
};

if(life_firstSpawn) then {
	life_firstSpawn = false;
};


if ((life_spawn_point select 0) find "conq_spawn_" > -1) then {
	oev_conqSpawnCD = time;
	player allowDamage false;
	oev_conqGod = true;
	player setVariable ["conqSafezone", true, true];
	hint "您已在安全区域中生成。 在离开该区域，射击或经过5分钟之前，您是无敌的。";
	private _markerPos = markerPos (life_spawn_point select 0);
	private _count = 0;
	[] spawn{
		disableSerialization;
		"oev_conq_timer" cutRsc ["oev_conq_timer","PLAIN"];
		_uiDisp = uiNameSpace getVariable "oev_conq_timer";
		_conqGod = _uiDisp displayCtrl 38503;
		for "_time" from 300 to 0 step -1 do {
			if (isNull _uiDisp) then {
				"oev_conq_timer" cutRsc ["oev_conq_timer","PLAIN"];
				_uiDisp = uiNameSpace getVariable "oev_conq_timer";
				_conqGod = _uiDisp displayCtrl 38503;
			};
			_conqGod ctrlSetStructuredText parseText format["<t size='1' align='center'>%1</t>",(([_time,"MM:SS"] call BIS_fnc_secondsToString) select [1])];
			if !(player getVariable ["conqSafezone",false]) exitWith {};
			uiSleep 1;
		};
		"oev_conq_timer" cutText ["","PLAIN"];
	};
	waitUntil {
		uiSleep 0.5;
		_count = _count + 1;
		player distance _markerPos > 200 || !alive player || !oev_conqGod || _count > 600
	};
	player allowDamage true;
	player setVariable ["conqSafezone", nil, true];
	oev_conqGod = false;
	hint "您已经失去了安全区保护，现在很容易受到攻击。";
};

[] call OEC_fnc_hudSetup;

if (playerSide isEqualTo west) then {
	[
		["event","APD SPAWN"],
		["player_id",getPlayerUID player],
		["position",getPosATL player]
	] call OEC_fnc_logIt;
};
