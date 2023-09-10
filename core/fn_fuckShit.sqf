//fuckin group chat aids voice
0 enableChannel [false, false];
1 enableChannel [false, false];
2 enableChannel [false, false];

if (hasInterface) then {
	if (!isNumber (missionConfigFile >> "briefing")) exitWith {};
	if (getNumber (missionConfigFile >> "briefing") == 1) exitWith {};

	[] spawn{
		private["_display"];
		if (isDedicated) then {_display=53} else {_display=52};
		waitUntil {
			if (!isNull findDisplay _display && !isNull((findDisplay _display) displayCtrl 1)) exitWith {
				ctrlActivate (findDisplay _display displayCtrl 1);
				findDisplay _display closeDisplay 1;
				true
			};
			false
		};
	};
};

if !(isDedicated) then {
	[] spawn{
		waitUntil{!isNull player};
		player setPos [getPos player select 0, getpos player select 1, 0];//no spawning in the sky, duh fuck arma
	};

	[] spawn{
		private ["_display", "_mapCtrl"];

		disableSerialization;
		waitUntil {_display = findDisplay 12; !isNull _display};
		_mapCtrl = _display displayCtrl 51;

		_mapCtrl ctrlAddEventHandler ["KeyDown", "_this call {
			if((_this select 3) && !(currentChannel == 3)) then {
				openMap false;
				hint '您无法在地图上绘制，糟糕，糟糕！';
				true;
			};

			false
		}"];
	};
};