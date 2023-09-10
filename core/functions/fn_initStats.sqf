//  File: fn_initStats
//	Description: initializes player stats

private["_lastPos","_currentPos","_distanceStep","_startingDeaths","_startingTeleports"];
waitUntil {position player distance getMarkerPos("debug_island_marker") > 600};
[] spawn{
	while{true} do {
		uiSleep 300;
		[9] call OEC_fnc_ClupdatePartial;
	};
};

waitUntil{!isNil "O_stats_deaths"};
while{true} do {
	_startingDeaths =  O_stats_deaths;
	_startingTeleports = O_stats_teleports;
	_lastPos = [(getPos player select 0),(getPos player select 1)];
	uiSleep 60;
	_currentPos = [(getPos player select 0),(getPos player select 1)];
	_distanceStep = _lastPos distance _currentPos;
	if((_startingDeaths == O_stats_deaths) && (_startingTeleports == O_stats_teleports)) then {
		if(_distanceStep <= 6000) then {
			if(player != vehicle player) then {
				O_stats_distanceVehicle = O_stats_distanceVehicle + round(_distanceStep);
			} else {
				if(_distanceStep <= 500) then {
					O_stats_distanceFoot = O_stats_distanceFoot + round(_distanceStep);
				};
			};
		};
	};
	switch (playerSide) do
	{
		case west: {
			O_stats_playtime_cop = O_stats_playtime_cop + 1;
		};
		case civilian: {
			O_stats_playtime_civ = O_stats_playtime_civ + 1;
		};
		case independent: {
			if !(oev_newsTeam) then {
				O_stats_playtime_med = O_stats_playtime_med + 1;
			} else {
				O_stats_playtime_civ = O_stats_playtime_civ + 1;
			};
		};
	};
};
