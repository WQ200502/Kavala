// fn_monitorDisplay
// Author: Fraali
// Desc: Monitors all missionNamespace variables for code with createDisplay (Normally used to create hack menus)
//       Monitors all active displays checking if it does not have an IDD. (Normally only seen on hack menus)

//Just init monitors here
[] spawn{
	life_inSmoke = false;
	private ["_smokeShell","_shells"];
	_shells = ["G_40mm_SmokeOrange","SmokeShellOrange"];

	while{true} do {
		sleep 0.1;
		if(cameraView isEqualTo "GROUP") then {
			player switchCamera "EXTERNAL";
			hint "Aren't you glad this is fixed?! Regards, Jesse";
		};
		if (isNull objectParent player) then {
			_smokeShell = player nearObjects ["GrenadeHand", 15];
			{
				if !(typeOf _x in _shells) then {_smokeShell = _smokeShell - [_x];};
			} count _smokeShell;

			if (count _smokeShell > 0) then {uiSleep 1;};

			if (!(isNull (_smokeShell select 0)) && ((speed (_smokeShell select 0)) < 0.1)) then {
				life_inSmoke = true;
			} else {
				life_inSmoke = false;
			};
		} else {
			life_inSmoke = false;
		};
	};
};

[] spawn{
	private["_priority","_handle","_halfFace","_fullFace","_copMask","_closest","_gasDistance","_effect","_headGear","_goggles","_smokeShell","_shells"];
	_halfFace = ["G_Bandanna_aviator","H_Shemag_khk","H_Shemag_tan","H_Shemag_olive","H_ShemagOpen_khk","H_ShemagOpen_tan","H_Shemag_olive_hs","G_Bandanna_aviator","G_Bandanna_beast","G_Bandanna_blk","G_Bandanna_khk","G_Bandanna_oli","G_Bandanna_shades","G_Bandanna_sport","G_Bandanna_tan","G_Lowprofile","G_Combat"];
	_fullFace = ["H_CrewHelmetHeli_B","H_PilotHelmetFighter_O","H_PilotHelmetFighter_I"];
	_copMask = ["G_Balaclava_oli","G_Balaclava_combat","G_Balaclava_lowprofile","G_Respirator_blue_F","G_Balaclava_TI_blk_F","G_Balaclava_TI_G_blk_F","G_Balaclava_TI_tna_F","G_Balaclava_TI_G_tna_F","G_Balaclava_blk","G_AirPurifyingRespirator_02_black_F","G_AirPurifyingRespirator_02_olive_F","G_AirPurifyingRespirator_02_sand_F","G_AirPurifyingRespirator_01_F","G_RegulatorMask_F","G_Respirator_white_F"];
	_shells = ["G_40mm_SmokeOrange","SmokeShellOrange"];
	while {true} do {
		waitUntil {uiSleep .5; life_inSmoke};
		if !(headgear player in _copMask || goggles player in _copMask) then {
			enableCamShake true;
			addCamShake [3, 120, 6];
			[] spawn{
				private ["_sound","_sounds"];
				while {life_inSmoke} do {
					if !(life_inSmoke) exitWith {};
					_sounds = ["chokeOne","chokeTwo","chokeThree","chokeFour","chokeFive"];
					_sound = selectRandom _sounds;
					player say3D _sound;
					uiSleep 4;
				};
				if !(life_inSmoke) exitWith {};
			};
		};

		while {life_inSmoke} do {
			_priority = 400;
			while {
				_handle = ppEffectCreate ["DynamicBlur", _priority];
				_handle < 0
			} do {
				_priority = _priority + 1;
			};
			_handle ppEffectEnable true;

			_smokeShell = player nearObjects ["GrenadeHand", 15];
			{
				if !(typeOf _x in _shells) then {_smokeShell = _smokeShell - [_x];};
			} count _smokeShell;

			_closest = _smokeShell select 0;
			{
				if((_x distance player) < (_closest distance player)) then {
					_closest = _x;
				};
			} forEach _smokeShell;
			if ((count _smokeShell) isEqualTo 0) exitWith {};
			if !(life_inSmoke) exitWith {};

			_gasDistance = player distance _closest;
			_effect = 10*(1/(1.3^_gasDistance));
			_headGear = headgear player;
			_goggles = goggles player;
			if(_headGear in _halfFace || goggles player in _halfFace) then {_effect = _effect * .5;};
			if(_headGear in _fullFace || _goggles in _fullFace) then {_effect = _effect * .5;};
			if(_headGear in _copMask || _goggles in _copMask) then {_effect = 0;};
			_handle ppEffectAdjust [_effect];
			_handle ppEffectCommit 0;
			uiSleep .1;
		};

		life_inSmoke = false;
		_handle ppEffectEnable false;
		ppEffectDestroy _handle;
		resetCamShake;
	};
};

[] spawn{
    for "_i" from 0 to 1 step 0 do {
        waitUntil{uiSleep 0.1;(!isNull (findDisplay 49)) && (!isNull (findDisplay 602))}; //Inventory & ESC dialogs
        (findDisplay 49) closeDisplay 2;
        (findDisplay 602) closeDisplay 2;
        uiSleep 0.5;
    };
};

[] spawn{
	private["_lastVehicle"];
	while{true} do {
		_lastVehicle = (vehicle player);
		waitUntil{uiSleep 0.1;(_lastVehicle != (vehicle player))};
		if((vehicle player) != player) then {
			(vehicle player) removeAllEventHandlers "handleDamage";
			(vehicle player) addEventHandler ["HandleDamage",{_this call OEC_fnc_handleVehDamage;}];

			if ((vehicle player) isKindOf "Air") then {
				private _sensors = listVehicleSensors (vehicle player);
				if ((count _sensors) isEqualTo 0) exitWith {};
				{
					(vehicle player) enableVehicleSensor [(_x select 0),false];
				} forEach _sensors;
			};

			if((((vehicle player) getVariable ["side",""]) == "civ") && (playerSide isEqualTo west) && !(player getVariable ["restrained",false])) then {
				if (typeOf(vehicle player) in oev_blackwater_vehicles_air) then {

					hint "You cannot enter this vehicle.";
					if ((locked(vehicle player) isEqualTo 2)) then {
						(vehicle player) lock 4;
						player action ["getOut", (vehicle player)];
						(vehicle player) lock 2;
					} else {
						player action ["getOut", (vehicle player)];
					};
				};
			};
		};
	};
};

[] spawn{
	waitUntil{!isNil "serverStartTime"};
	waitUntil{!isNil "serverCycleLength"};
	waitUntil{uiSleep 60;(serverCycleLength - (serverTime - serverStartTime)) <= 240};

	if(playerside isEqualTo civilian) then {
		hint "If you want a vehicle to persist through restart with its trunk data, you must remain online and within 150m of your vehicle.";
		if (player getVariable ["inGroup",false]) then {
			_group = profileNameSpace getVariable ["lastGroup",[grpNull,"","",0,0]]; // [group,group name,pass,# of members,serverTime]
			_actualGroup = (_group select 0);
			_name = (_group select 1);
			_password = (_group select 2);
			_members = (_group select 3);
			_lastRestart = serverTime;
			profileNameSpace setVariable ["lastGroup",[_actualGroup,_name,_password,_members,_lastRestart]];
		};
	};

	waitUntil{uiSleep 1;(serverCycleLength - (serverTime - serverStartTime)) <= 55};
	sleep random(25);

	[] call OEC_fnc_ClupdateRequest;
};

[] spawn {
// Betting cooldown
  oev_betCooldown = true;
  uiSleep 180;
  oev_betCooldown = false;
};

[] spawn{
  // Fuck trying to count event handlers, have to add one and the return gives how many are active
  if (call(life_adminlevel) < 2) then {
    while {true} do {
      _event = "";
      _keyHandle = (findDisplay 46) displayAddEventHandler ["KeyDown","false"];
      (findDisplay 46) displayRemoveAllEventHandlers "KeyDown";
      if (oev_isDowned) then {
        (findDisplay 46) displayAddEventHandler ["KeyDown",{if !([(_this select 1)] in [(actionKeys "voiceOverNet"),(actionKeys "pushToTalk")]) then {true}else{false}}];
      } else {
        (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call OEC_fnc_keyHandler"];
      };

      _keyHandleUp = (findDisplay 46) displayAddEventHandler ["KeyUp","false"];
      (findDisplay 46) displayRemoveAllEventHandlers "KeyUp";

      uiSleep 0.1;

      _fired = player addEventHandler ["Fired","false"];
      player removeAllEventHandlers "Fired";
      player addEventHandler ["Fired",{_this call OEC_fnc_onFired}];

      {
        uiSleep 0.1;
        _ret2 = addMissionEventHandler [_x select 0,"false"];
        removeAllMissionEventHandlers (_x select 0);
        if ((_x select 0) isEqualTo "Map") then {
          addMissionEventHandler ["Map",{_this call OEC_fnc_checkMap}];
        };
        if (_ret2 > _x select 1) then {_event = _event + format ["<t color='#FFFF00'>Event: <t color='#FFFFFF'>%1, <t color='#FFFF00'>Count:<t color='#FFFFFF'> %2 <t color='#FFFF00'>(Max: %3)<br/><t color='#FFFFFF'>",_x select 0, _ret2, _x select 1]};
      } forEach [["Draw3D",0], ["Map",1], ["MapSingleClick",0]];

      if (_keyHandle > 1) then {_event = _event +   format ["<t color='#FFFF00'>Event: <t color='#FFFFFF'>KeyDown, <t color='#FFFF00'>Count: <t color='#FFFFFF'>%1 <t color='#FFFF00'>(Max: 1)<br/><t color='#FFFFFF'>", _keyHandle]};
      if (_keyHandleUp > 0) then {_event = _event + format ["<t color='#FFFF00'>Event: <t color='#FFFFFF'>KeyUp, <t color='#FFFF00'>Count: <t color='#FFFFFF'>%1 <t color='#FFFF00'>(Max: 0)<br/><t color='#FFFFFF'>", _keyHandleUp]};
      if (_fired > 1) then {_event = _event +       format ["<t color='#FFFF00'>Event: <t color='#FFFFFF'>Fired, <t color='#FFFF00'>Count: <t color='#FFFFFF'>%1 <t color='#FFFF00'>(Max: 0)", _fired]};

      if !(_event isEqualTo "") then {
        [9, player, [_event]] remoteExec ["OES_fnc_handleDisc",2];
        [profileName,format ["<br/><t color='#FFFF00'>Event Handler Flags:<br/><t color='#FFFFFF'> %1",_event]] remoteExec ["OEC_fnc_notifyAdmins", -2];
      };
      uiSleep (random [30,45,60]);
    };
  } else {
    (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call OEC_fnc_keyHandler"];
  };
};

waitUntil{uiSleep 1; oev_session_completed};
[] spawn{
  _scripts = ["OEC_fnc_createDialog","OEC_fnc_casinoBlackjack","OEC_fnc_loadingScreenIcon","OEC_fnc_ctrlCreate_meta","test_loadWeapons","OEC_fnc_ctrlCreate","OEC_fnc_nlrInfo","OEC_fnc_weaponShopMenu","OEC_fnc_casinoSlotsCreate","OEC_fnc_loadingScreenSystem","OEC_fnc_initTimedMarkers","OEC_fnc_escInterupt","OEC_fnc_casinoSlots","OES_fnc_payload","OEC_fnc_loadingScreenContent","OEC_fnc_modShopMenu","OEC_fnc_monitorDisplays"];
  _scripts = _scripts apply {toLowerAnsi _x}; //Keep this for Obfuscation purposes
	while {true} do {
			_count = 0;
			{
        uiSleep 0.1;
        _var = (missionNamespace getVariable _x);
				if (!isNil {_var} && {_var isEqualType {}}) then {
          if ("bis_fnc_" in _x) exitWith {_count = _count + 1};
          _var = toLowerAnsi str _var;
          if (("createdisplay" in _var || "ctrlcreate" in _var) && {!(_x in _scripts)}) then {
            [8, player, [_x]] remoteExec ["OES_fnc_handleDisc",2];
            [profileName,format ["<br/><t color='#FFFF00'>Bad Variable:<t color='#FFFFFF'> %1", _x]] remoteExec ["OEC_fnc_notifyAdmins", -2];
  				};
        };
			}forEach allVariables missionNamespace;
		if (_count > 1674) then {
      [7, player, [format ["%1 (Max: 1674)",_count]]] remoteExec ["OES_fnc_handleDisc",2];
      [profileName,format ["<br/><t color='#FFFF00'>Bad BIS Variables:<t color='#FFFFFF'> %1 <t color='#FFFF00'>(Max 1674)", _count]] remoteExec ["OEC_fnc_notifyAdmins", -2];
    };
  uiSleep 10;
	};
};
//[] spawn{
//  uiSleep 2;
//  if ((call oev_developerlevel) < 3) then {
//    while{true} do {
//      {
//        if ((_x select 1) isEqualTo "") then {
//          //[profileName,getPlayerUID player,format["----Flagged Script!----%1%2%1----Flagged Script!----",toString[10],_x]] remoteExec ["OEC_fnc_cookieJar",2];
//          //[10, player, [_x]] remoteExec ["OES_fnc_handleDisc",2];
//          systemChat format ["1%1", _x];
//          //[profileName,format ["<br/><t color='#FFFF00'>Bad Script:<t color='#FFFFFF'> %1", _x]] remoteExec ["OEC_fnc_notifyAdmins", -2];
//        };
//      }forEach diag_activeSQFScripts;
//    };
//  };
//};

[] spawn{
  // _1 = Display Blacklist - Add 129 back when Zahzi lets us get rid of the diary
  // _2 = Display Whitelist - Compare controls to _3 to check if any have been added
  _1 = [-1,2,3,19,22,25,26,27,28,29,30,31,32,33,34,37,40,41,43,44,45,47,48,50,51,52,53,56,57,58,62,64,65,66,69,71,72,74,101,102,103,104,105,106,121,122,123,125,126,128,132,133,136,144,146,147,149,153,156,157,158,160,162,163,164,165,166,167,170,171,172,173,174,175,176,177,178,179,180,187,188,262,264,304,311,312,313,314,315,316,317,318,319,320,351,505,506,632,666,1320,1321,2035,2121,2727,2928,2929,3030,8001,50500,50502,60490,100002,316000];
  _2 = [4, 5,  6, 8, 12, 17,18,24,46,49, 54,55,63,70,129,131,148,150,151,154,159,169,602,999,50000,60492,999999];
  _3 = [37,116,27,68,117,39,15,2 ,96,106,12,2, 5, 48,54, 20, 18, 19 ,142,34, 11, 7,  87, 9,  36,   99,   13];
  while {true} do {
    {
      uiSleep 0.25;
      _idd = ctrlIDD _x;
      if (_idd in _1) then {
				uiSleep 0.1;
				if (!(_x isEqualTo displayNull)) then {
          _ctrls = count allControls _x;
          _class = _x getVariable ["BIS_fnc_initDisplay_configClass", "unknown"];
          [6, player, [_class, _ctrls]] remoteExec ["OES_fnc_handleDisc",2];
          [profileName,format ["<br/><t color='#FFFF00'>Bad Display:<t color='#FFFFFF'> %1<br/><t color='#FFFF00'> Controls:<t color='#FFFFFF'> %2<br/><t color='#FFFF00'> Display:<t color='#FFFFFF'> %3", _class,_ctrls, _idd]] remoteExec ["OEC_fnc_notifyAdmins", -2];
					uiSleep 10;
				};
      } else {
        _ind = _2 find _idd;
        _ctrls = count allControls _x;
        if (_ind != -1 && {_ctrls > (_3 select _ind)}) then {
          _class = _x getVariable ["BIS_fnc_initDisplay_configClass", "unknown"];
          [6, player, [_class, format ["%1 (Max: %2)",_ctrls, _3 select _ind]]] remoteExec ["OES_fnc_handleDisc",2];
          [profileName,format ["<br/><t color='#FFFF00'>Bad Control Count:<t color='#FFFFFF'> %1 <t color='#FFFF00'>(Max: %4)<br/>Class:<t color='#FFFFFF'> %2<br/><t color='#FFFF00'> Display:<t color='#FFFFFF'> %3",_ctrls,_class, _idd, _3 select _ind]] remoteExec ["OEC_fnc_notifyAdmins", -2];
          uiSleep 10;
        };
      };
    }forEach allDisplays;
  };
};

//Admin menu checks
[] spawn{
  private _alvl = call life_adminlevel;
  private _dlvl = call oev_developerlevel;
  while {true} do {
    uiSleep 1;
    if ((!(isDamageAllowed player) || oev_godmode) && _alvl < 1) then {
      [10, player, ["Non-Staff God Mode!",_alvl]] remoteExec ["OES_fnc_handleDisc",2];
      [profileName,"<br/><t color='#FFFF00'>Non-Staff God Mode!"] remoteExec ["OEC_fnc_notifyAdmins", -2];
    };
    uiSleep 1;
    if (((player getVariable ["invis", false])|| isObjectHidden player || player getVariable["olympusinvis",false]) && _alvl < 2) then {
      [10, player, ["Non-Staff Invis!",_alvl]] remoteExec ["OES_fnc_handleDisc",2];
      [profileName,"<br/><t color='#FFFF00'>Non-Staff Invis!"] remoteExec ["OEC_fnc_notifyAdmins", -2];
    };
    uiSleep 1;
    if ((oev_eventESP || player getVariable ["adminesp",false]) && _alvl < 1) then {
      [10, player, ["Non-Staff ESP!",_alvl]] remoteExec ["OES_fnc_handleDisc",2];
      [profileName,"<br/><t color='#FFFF00'>Non-Staff ESP!"] remoteExec ["OEC_fnc_notifyAdmins", -2];
    };
    uiSleep 1;
    if (player getVariable ["superHeal", false] && _alvl < 3) then {
      [10, player, ["Non-Admin Super Heal!",_alvl]] remoteExec ["OES_fnc_handleDisc",2];
      [profileName,"<br/><t color='#FFFF00'>Non-Admin Super Heal!"] remoteExec ["OEC_fnc_notifyAdmins", -2];
    };
    uiSleep 1;
    if (player getVariable ["superTaze", false] && (_alvl < 3 || _dlvl < 1)) then {
      [10, player, ["Non-Admin Spangle-Gun!",format ["Adminlevel: %1, Devlevel: %2",_alvl,_dlvl]]] remoteExec ["OES_fnc_handleDisc",2];
      [profileName,"<br/><t color='#FFFF00'>Non-Admin Spangle-Gun!"] remoteExec ["OEC_fnc_notifyAdmins", -2];
    };
    uiSleep 1;
    if (player getVariable["fly",false] && !(getPlayerUID player in ["76561198045288873","76561198064919358","76561198068537683","76561197988603739","76561198129408945","76561198069862784","76561198068833340","76561198071078342"])) then {
      [10, player, ["Non-Whitelisted Fly Mode!",_alvl]] remoteExec ["OES_fnc_handleDisc",2];
      [profileName,"<br/><t color='#FFFF00'>Non-Whitelisted Fly Mode!"] remoteExec ["OEC_fnc_notifyAdmins", -2];
    };
    uiSleep 1;
    if (!isNull (findDisplay 2900) && _alvl < 1) then {
      [10, player, ["Non-Staff Admin Menu!",_alvl]] remoteExec ["OES_fnc_handleDisc",2];
      [profileName,"<br/><t color='#FFFF00'>Non-Staff Admin Menu!"] remoteExec ["OEC_fnc_notifyAdmins", -2];
    };
    uiSleep 1;
    if (!isNull (findDisplay 50000) && _alvl < 1) then {
      [10, player, ["Non-Staff Event Menu!",_alvl]] remoteExec ["OES_fnc_handleDisc",2];
      [profileName,"<br/><t color='#FFFF00'>Non-Staff Event Menu!"] remoteExec ["OEC_fnc_notifyAdmins", -2];
    };
  };
};

//addMissionEventHandler ["HandleChatMessage", {
//  _whitelist = ["message from","dispatch from","request from","staff message","event notification","button activated","response from"];
//  _blacklist = ["menu","building","exploaded","rainbow","[+]","[-]","[error]","explode","launch","esp","impulse","god","visuals","infinite","noclip","superman"];
//  _text = (toLowerAnsi(_this select 3));
//  if ((_this select 0) isEqualTo 16) then {
//    {
//      if (_x in _text) then {
//        {
//          if !(_x in _text) then {
//            [11, player, [_this select 3,getPlayerUID player]] remoteExec ["OES_fnc_handleDisc",2];
//            [profileName,format ["<br/><t color='#FFFF00'>Bad systemChat message:<br/>%1",_this select 3]] remoteExec ["OEC_fnc_notifyAdmins", -2];
//          };
//        } forEach _whitelist;
//      };
//    }forEach _blacklist;
//  };
//  false
//}];
