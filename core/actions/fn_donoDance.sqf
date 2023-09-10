_runType = _this select 0;

switch(_runType) do {

	//client that called this script from keyHandler
	case 0: {
		if (!(alive player) || (isNull player)) exitWith {};
		if(time - (player getVariable ["peeCooldown",0]) < 25) exitWith {};
		_danceType = _this select 1;
		switch(_danceType) do {
			case 0: {
				player switchMove "Acts_Dance_02";
				oev_action_inUse = true;
				player setVariable["danceCooldown",true];
				[1,0, player] remoteExec ["OEC_fnc_donoDance", ((position player nearEntities ["Man", 50]) select {isPlayer _x}) + (([8486.22,25121.5,0] nearEntities ["Man", 800]) select {isPlayer _x})];
				uiSleep 20;
				player switchMove "";
				player setVariable["danceCooldown",false];
				oev_action_inUse = false;
			};
			case 1: {
				player switchMove "Acts_Dance_01";
				oev_action_inUse = true;
				player setVariable["danceCooldown",true];
				[1,1, player] remoteExec ["OEC_fnc_donoDance", ((position player nearEntities ["Man", 50]) select {isPlayer _x}) + (([8486.22,25121.5,0] nearEntities ["Man", 800]) select {isPlayer _x})];
				uiSleep 20;
				player switchMove "";
				player setVariable["danceCooldown",false];
				oev_action_inUse = false;
			};
			case 2: {
				player switchMove "";
				player setVariable["danceCooldown",false];
				[1,2, player] remoteExec ["OEC_fnc_donoDance", ((position player nearEntities ["Man", 50]) select {isPlayer _x}) + (([8486.22,25121.5,0] nearEntities ["Man", 800]) select {isPlayer _x})];
				uiSleep 2;
				oev_action_inUse = false;
			};
		};
	};

	//people within 50 meters of the client that called this script
	case 1: {
		_player = _this select 2;
		if (!(alive _player) || (isNull _player)) exitWith {};
		_danceType = _this select 1;
		switch(_danceType) do {
			case 0: {
				_player switchMove "Acts_Dance_02";
				uiSleep 20;
				_player switchMove "";
			};
			case 1: {
				_player switchMove "Acts_Dance_01";
				uiSleep 20;
				_player switchMove "";
			};
			case 2: {
				_player switchMove "";
			};
		};
	};
};