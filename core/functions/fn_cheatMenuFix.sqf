//	Description: Disables the Aram 3 cheat menu.

life_monitoredDisplays = [];

[] spawn{
	private["_targetDisplay","_ignoreDisplays"];
	disableSerialization;

	while{true} do {
		sleep 0.2;
		_ignoreDisplays = [(findDisplay 70),(findDisplay 46),(findDisplay 49),(findDisplay 12)];

		for "_i" from 1 to 3 do {
			_targetDisplay = (allDisplays select ((count allDisplays) - _i));

			if(!(_targetDisplay in _ignoreDisplays)) then {
				if(!(_targetDisplay in life_monitoredDisplays)) then {
					life_monitoredDisplays pushBack _targetDisplay;

					_targetDisplay displayAddEventHandler ["KeyDown", "_this call {
						disableSerialization;
						_code = _this select 1;
						_shift = _this select 2;
						_ctrl = _this select 3;
						_alt = _this select 4;

						if(_alt && _code == 62) exitWith {true};
						if(isDedicated && _code in (actionKeys 'GetOver')) exitWith {true};
						if(_code in (actionKeys 'Diary') || _code in (actionKeys 'SelectAll') || (!_ctrl && _code in (actionKeys 'GetOver')) || _code in (actionKeys 'TacticalView')) exitWith {true};

						if(_shift && _code == 74) exitWith {
							disableUserInput true;
							disableUserInput false;
							true
						};
					}"];

					[_targetDisplay] spawn{
						private["_targetDisplay"];
						disableSerialization;

						_targetDisplay = _this select 0;

						waitUntil{sleep 0.25; (isNull _targetDisplay)};
						life_monitoredDisplays = life_monitoredDisplays - [_targetDisplay];
					};
				};
			};
		};
	};
};

[] spawn{
	disableSerialization;
	private["_targetDisplay"];

	while{true} do {
		waitUntil{sleep 0.25; !(isNull (findDisplay 49))};
		(findDisplay 49) displayAddEventHandler ["KeyDown", "_this call {
			_code = _this select 1;
			_shift = _this select 2;
			_alt = _this select 4;

			if(_alt && _code == 62) exitWith {true};
			if(isDedicated && _code in (actionKeys 'GetOver')) exitWith {true};
			if(_code in (actionKeys 'Diary') || _code in (actionKeys 'TacticalView')) exitWith {true};

			if(_shift && _code == 74) exitWith {
				disableUserInput true;
				disableUserInput false;
				true
			};
		}"];
	};
};


[] spawn{
	disableSerialization;
	waitUntil{sleep 0.1; !(isNull (findDisplay 12))};

	(findDisplay 12) displayAddEventHandler ["KeyDown", "_this call {
		_code = _this select 1;
		_shift = _this select 2;
		_alt = _this select 4;

		if(_alt && _code == 62) exitWith {true};
		if(_code in (actionKeys 'Diary') || _code in (actionKeys 'SelectAll')|| _code in (actionKeys 'TacticalView')) exitWith {true};

		if(_shift && _code == 74) exitWith {
			disableUserInput true;
			disableUserInput false;
			true
		};
	}"];
};
