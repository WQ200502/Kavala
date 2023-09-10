//  File: fn_spawnPointCfg.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Master configuration for available spawn points depending on the units side.

//	Return:
//	[Spawn Marker,Spawn Name,Image Path]
params [
	["_side",civilian,[civilian]]
];
private _return = [];
private _spawns = [];
private _numPlayers = 0;
private _marker = "";
private _dist = 0;

//Spawn Marker, Spawn Name, PathToImage, radius to search for players

switch (_side) do {
	case west: {
		_spawns = [
			["cop_spawn_1","卡瓦拉警局","images\icons\spawn_cop.paa",300],
			["cop_spawn_2","P城警局","images\icons\spawn_cop.paa",300],
			["cop_spawn_3","A城警局","images\icons\spawn_cop.paa",300],
			["cop_spawn_4","空军警局","images\icons\spawn_cop.paa",300],
			["cop_spawn_5","索菲亚警局","images\icons\spawn_cop.paa",300],
			["cop_spawn_6","赞助镇警局","images\icons\spawn_cop.paa",300],
			["cop_spawn_7","黑水前哨警察局","images\icons\spawn_cop.paa",300]
		];

		{
			_marker = _x select 0;
			_dist = _x select 3;
			_numPlayers = {(_x distance (getMarkerPos _marker)) < _dist} count playableUnits;
			_return pushBack [(_x select 0),format["%1 - %2",(_x select 1),_numPlayers],(_x select 2)];
		} forEach _spawns;
	};

	case civilian: {
		_spawns = [
			["civ_spawn_1","K城主城[安全区]","images\icons\spawn_city.paa",300],
			["civ_spawn_2","P城","images\icons\spawn_city.paa",300],
			["civ_spawn_3","A城","images\icons\spawn_city.paa",300],
			["civ_spawn_4","索菲亚","images\icons\spawn_city.paa",300],
			["civ_spawn_5","赞助镇","images\icons\spawn_city.paa",300],
			["civ_spawn_6","新人小镇","images\icons\spawn_city.paa",300]
		];

		if(oev_vigiarrests >= 200) then {
			_spawns pushBack ["jailtransport_5","Athira Vigi","images\icons\spawn_city.paa",300];
		};

		{
			_marker = _x select 0;
			_dist = _x select 3;
			_numPlayers = {(_x distance (getMarkerPos _marker)) < _dist} count playableUnits;
			_return pushBack [(_x select 0),format["%1 - %2",(_x select 1),_numPlayers],(_x select 2)];
		} forEach _spawns;

		if(count life_houses > 0) then {
			{
				_pos = call compile format["%1",_x select 0];
				_house = nearestBuilding _pos;
				if !(_pos inPolygon oev_warzonePoly) then {
					if((count (nearestObjects [_pos,["House_F"],10])) > 0) then {
						_house = ((nearestObjects [_pos,["House_F"],10]) select 0);
					};

					_numPlayers = {(_x distance (getPos _house)) < 300} count playableUnits;
					if !(_house getVariable ["restricted_house",false]) then {
						//_houseName = getText(configFile >> "CfgVehicles" >> (typeOf _house) >> "displayName");
						//_return pushBack [format["house_%1",_house getVariable "uid"],_houseName,"\a3\ui_f\data\map\MapControl\lighthouse_ca.paa"];
						_return pushBack [format["house_%1",_house getVariable "uid"],format["House - %1",_numPlayers],"images\icons\spawn_house.paa"];
					};
				};
			} forEach life_houses;
		};

		if !((count oev_gangShedPos) isEqualTo 0) then {
			private _shedPos = call compile format["%1",oev_gangShedPos select 0];
			if !(_shedPos inPolygon oev_warzonePoly) then {
				private _NearBldgs = nearestObjects [_shedPos,["House_F"],10];
				private "_building";

				if ((count _NearBldgs) > 0) then {
					{
						if ((typeOf _x) isEqualTo "Land_i_Shed_Ind_F") exitWith {_building = _x;};
					} forEach _NearBldgs;

					private _gangID = _building getVariable ["bldg_gangid",-1];
					private _gangOwner = _building getVariable ["bldg_owner",-2];
					if (_gangID isEqualTo -1 || _gangOwner isEqualTo -2) exitWith {};

					_numPlayers = {(_x distance (getPos _building)) < 300} count playableUnits;

					_return pushBack [format["house_%1%2",_gangID,_gangOwner],format["Gang Shed - %1",_numPlayers],"images\icons\spawn_shed.paa"];
				};
			};
		};

		if (oev_conquestData select 0) then {
			_spawns = switch (oev_conquestData select 1 select 0) do {
				case "Ghost Hotel": {[0]};
				case "Nifi": {[1]};
				case "Kavala": {[2]};
				case "Syrta": {[3]};
				case "Oreokastro": {[4]};
				case "Warzone": {["5_1","5_2"]};
				case "Panagia": {[6]};
				case "Sofia": {[7]};
				default {[0]};
			};

			{
				private _marker = format["conq_spawn_%1", _x];
				_numPlayers = {(_x distance (markerPos _marker)) < 200} count playableUnits;
				_return pushBack [_marker, format["Conq. Rebel - %1", _numPlayers], "images\icons\spawn_shed.paa"];
			} forEach _spawns;
		};
	};

	case independent: {
		_spawns = [
			["medic_spawn_1","卡瓦拉医院","images\icons\spawn_hospital.paa",300,"civ_spawn_1"],
			["medic_spawn_2","空军医院","images\icons\spawn_hospital.paa",300,"civ_spawn_3"],
			["medic_spawn_3","P城医院","images\icons\spawn_hospital.paa",300,"civ_spawn_2"],
			["medic_spawn_4","索菲亚医院","images\icons\spawn_hospital.paa",300,"civ_spawn_4"],
			["medic_spawn_5","赞助镇医院","images\icons\spawn_hospital.paa",300,"medic_spawn_5"]
		];

		{
			_marker = _x select 4;
			_dist = _x select 3;
			_numPlayers = {(_x distance (getMarkerPos _marker)) < _dist} count playableUnits;
			_return pushBack [(_x select 0),format["%1 - %2",(_x select 1),_numPlayers],(_x select 2)];
		} forEach _spawns;

		//if !(oev_newsTeam) then {
		//	_return = [
		//		["medic_spawn_1","K城","\a3\ui_f\data\map\MapControl\hospital_ca.paa"],
		//		["medic_spawn_2","Rescue and Recovery HQ","\a3\ui_f\data\map\MapControl\hospital_ca.paa"],
		//		["medic_spawn_3","P城","\a3\ui_f\data\map\MapControl\hospital_ca.paa"],
		//		["medic_spawn_4","S城","\a3\ui_f\data\map\MapControl\hospital_ca.paa"]
		//	];
		//} else {
		//	_return = [
		//		["news_station_1","Kavala","\a3\ui_f\data\map\MapControl\transmitter_ca.paa"],
		//		["news_station_2","Kalochori","\a3\ui_f\data\map\MapControl\transmitter_ca.paa"]
		//	];
		//};
	};
};

_return;
