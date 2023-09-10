if(isServer && isDedicated) exitWith {};

[] spawn{
	private _Survival_fnc_food = {
		if(oev_hunger < 2) then {
			while{oev_hunger < 2 && damage player < 1} do {
				if(player getVariable ["restrained",false]) exitWith {};
				oev_survival_damage = false;
				if (((getDammage player) + 0.05) >= 1) then {oev_survival_damage = true;};
				_dam_obj = player;
				_dam_obj setDamage (damage player + 0.05);
				player setFatigue 1;
				hint localize "STR_NOTF_EatMSG_Death";
				uiSleep 30;
			};
		} else {
			// If player is restrained, do not -10 tax that arse - /x00
			if(!(player getVariable ["restrained",false]) && !(oev_godmode)) then {
				oev_hunger = oev_hunger - 10;
				[] call OEC_fnc_hudUpdate;
			};

			switch(oev_hunger) do {
				case 30: {hint localize "STR_NOTF_EatMSG_1";};
				case 20: {hint localize "STR_NOTF_EatMSG_2";};
				case 10: {hint localize "STR_NOTF_EatMSG_3";player setFatigue 1;};
				default {};
			};
		};
	};

	private _Survival_fnc_water = {
		if(oev_thirst < 2) then {
			while{oev_thirst < 2 && damage player < 1} do {
				if(player getVariable ["restrained",false]) exitWith {};
				oev_survival_damage = false;
				if (((getDammage player) + 0.05) >= 1) then {oev_survival_damage = true;};
				_dam_obj = player;
				_dam_obj setDamage (damage player + 0.05);
				player setFatigue 1;
				hint localize "STR_NOTF_DrinkMSG_Death";
				uiSleep 30;
			};
		} else {
			// If player is restrained, do not -10 tax that arse - /x00
			if(!(player getVariable ["restrained",false]) && !(oev_godmode)) then {
				oev_thirst = oev_thirst - 10;
				[] call OEC_fnc_hudUpdate;
			};

			switch(oev_thirst) do {
				case 30: {hint localize "STR_NOTF_DrinkMSG_1";};
				case 20: {hint localize "STR_NOTF_DrinkMSG_2"; player setFatigue 1;};
				case 10: {hint localize "STR_NOTF_DrinkMSG_3"; player setFatigue 1;};
				default {};
			};
		};
	};

	private _Survival_fnc_regen = {
		//	while loop prevents depletion of thirst and hunger while active so script is repeated
		// Is checked again due to uiSleep for consistency in damage
		if (oev_thirst >= 75 && oev_hunger >= 75 && damage player > 0 && damage player < 0.5 && player getHit "legs" < 0.5 && !(oev_isDowned)) then {
			_dam_obj = player;
			_dam_obj setDamage (damage player - 0.01);
		};
	};

	if(oev_thirst < 2) then {
		uiSleep 5;
		[] call _Survival_fnc_water;
		uiSleep 20;
	};

	if(oev_hunger < 2) then {
		uiSleep 5;
		[] call _Survival_fnc_food;
		uiSleep 20;
	};

	while {true} do {
		//if on debug island will make sure you dont die of thirst or hunger, waits until you leave debug island
		waitUntil{
			if((([position player select 0,position player select 1,0] distance getMarkerPos("debug_island_marker")) < 600) || ((oev_is_arrested select 0) == 1)) then {
				oev_thirst = 100;
				oev_hunger = 100;
				_dam_obj = player;
				_dam_obj setDamage 0;
				[] call OEC_fnc_hudUpdate;
			};
			uiSleep 1;
			(([position player select 0,position player select 1,0] distance getMarkerPos("debug_island_marker")) > 600)
		};

		//drinks water every 5 and a half minutes
		if(round(time % 430) <= 2) then {
			if (player getVariable "restrained") exitWith {};
			[] call _Survival_fnc_water;
			uiSleep 3;
		};

		//eats food every 7 and a half minutes
		if(round(time % 540) <= 2) then {
			if (player getVariable "restrained") exitWith {};
			[] call _Survival_fnc_food;
			uiSleep 3;
		};

		// regenerates health if food and water are at or above 75 and you aren't limping/severly hurt
		if(round(time % 10) <= 2) then {
			if (oev_thirst >= 75 && oev_hunger >= 75 && damage player > 0 && damage player < 0.5 && player getHit "legs" < 0.5 && !(oev_isDowned)) then {
				[] call _Survival_fnc_regen;
				uiSleep 3;
			};
		};
	};
};

[] spawn{
	private["_bp","_load","_cfg"];
	while{true} do {
		waitUntil {backpack player != ""};
		_bp = backpack player;
		_cfg = getNumber(configFile >> "CfgVehicles" >> (backpack player) >> "maximumload");
		_load = round(_cfg / 8);
		oev_maxWeight = oev_maxWeightT + _load;
		[] call OEC_fnc_hudUpdate;
		waitUntil {backpack player != _bp};
		if(backpack player == "") then {
			oev_maxWeight = oev_maxWeightT;
		};
		[] call OEC_fnc_hudUpdate;
	};
};

[] spawn{
	while {true} do {
		uiSleep 1.5;
		if (call oev_civcouncil >= 1) then {player enableFatigue false};
		if (oev_inCombat) then {
			if (diag_tickTime - oev_inCombatTime >= 30) then {
				oev_inCombat = false;
			};
		};
		if(oev_carryWeight > oev_maxWeight && !isForcedWalk player) then {
			player forceWalk true;
			player setFatigue 1;
			hint localize "STR_NOTF_MaxWeight";
		} else {
			if(isForcedWalk player && !((oev_is_arrested select 0) isEqualTo 1)) then {
				player forceWalk false;
			};
		};
	};
};

[] spawn{
	private _walkDis = 0;
	private _myLastPos = (getPos player select 0) + (getPos player select 1);
	private _MaxWalk = 1200;
	while {true} do {
		uiSleep 0.5;
		if(!alive player) then {
			_walkDis = 0;
		} else {
			_CurPos = (getPos player select 0) + (getPos player select 1);
			if(_CurPos != _myLastPos && isNull objectParent player) then {
				_walkDis = _walkDis + 1;
				if(_walkDis == _MaxWalk) then {
					_walkDis = 0;
					oev_thirst = oev_thirst - 5;
					oev_hunger = oev_hunger - 5;
					[] call OEC_fnc_hudUpdate;
				};
			};
			_myLastPos = (getPos player select 0) + (getPos player select 1);
		};
	};
};
