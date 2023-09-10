#include "..\..\macro.h"
#include "\a3\editor_f\Data\Scripts\dikCodes.h"
//  File: fn_keyHandler.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Main key handler for event 'keyDown'
private ["_handled","_shift","_alt","_code","_ctrl","_alt","_ctrlKey","_veh","_locked","_interactionKey","_mapKey","_interruptionKeys","_house_id","_functionKeys"];

if(oev_inCasino) exitWith {};
if !(oev_session_completed) exitWith {};

_ctrl = _this select 0;
_code = _this select 1;
_shift = _this select 2;
_ctrlKey = _this select 3;
_alt = _this select 4;
_speed = speed cursorTarget;
_handled = false;
_inDist = [];

//Use for voice lines/Audio in certain area NON-FACTION 300m to make sure anyone moving into the area can hear it
_lcl_inArea = {
	{
		if (player distance _x <= 300) then {
			_inDist pushback owner _x;
		};
	} forEach (allPlayers);
	_inDist;
};

if(_shift && _code == 74) exitWith {
	hint "Shift + numpad minus input disabled on Olympus.";
	disableUserInput true;
	disableUserInput false;
	true
};

if(player getVariable["fly",false] && (_code in [200,208,203,205,57,29,44,74,78] || (_code in [17,31,16,18,30,32] && _shift && vehicle player != player)) && getPlayerUID player in ["76561198045288873","76561198064919358","76561198068537683","76561197988603739","76561198129408945","76561198069862784","76561198068833340","76561198071078342"]) exitWith {
	private _target = vehicle player;
	_velocity = velocityModelSpace _target;
	private _adj = oev_flyspeed;
	if (_shift) then {
		_adj = 4 * oev_flyspeed;
	};
	if (_code in [17,31,30,32,16,18] && _shift) then {
		_pitchbank = _target call BIS_fnc_getPitchBank;
		_dir = getDir _target;
		_p = _pitchbank select 0;
		_r = _pitchbank select 1;
		switch(_code) do {
			case 17: {
				_p = (_p - 3);
			};
			case 31: {
				_p = (_p + 3);
			};
			case 30: {
				_r = (_r - 4);
			};
			case 32: {
				_r = (_r + 4);
			};
			case 16: {
				_dir = (_dir - 4);
			};
			case 18: {
				_dir = (_dir + 4);
			};
		};
		(_target) setVectorDirAndUp [
			[sin _dir * cos _p,cos _dir * cos _p,sin _p],
			[[sin _r,-sin _p,cos _r * cos _p],-_dir] call BIS_fnc_rotateVector2D
		];
		_target setVelocityModelSpace _velocity;
	};
	switch(_code) do {
		case 57: {
			_target setVelocityModelSpace[_velocity select 0,_velocity select 1,(_velocity select 2) + _adj];
		};
		case 29: {
			_target setVelocityModelSpace[0,0,0];
		};
		case 44: {
			_target setVelocityModelSpace[_velocity select 0,_velocity select 1,(_velocity select 2) -_adj];
		};
		case 200: {
			_target setVelocityModelSpace[_velocity select 0,(_velocity select 1) + _adj,_velocity select 2];
		};
		case 208: {
			_target setVelocityModelSpace[_velocity select 0,(_velocity select 1) - _adj,_velocity select 2];
		};
		case 203: {
			_target setVelocityModelSpace[(_velocity select 0) - _adj,_velocity select 1,_velocity select 2];
		};
		case 205: {
			_target setVelocityModelSpace[(_velocity select 0) + _adj,_velocity select 1,_velocity select 2];
		};
		case 74: {
			if (_shift) then {
				oev_flyspeed = oev_flyspeed - 30;
			} else {
				oev_flyspeed = oev_flyspeed - 5;
			};
			if(oev_flyspeed < 0) then {
				oev_flyspeed = 0;
			};
			hint format["飞行速度: %1",oev_flyspeed];
		};
		case 78: {
			if (_shift) then {
				oev_flyspeed = oev_flyspeed + 30;
			} else {
				oev_flyspeed = oev_flyspeed + 5;
			};
			if(oev_flyspeed > 10000) then {
				oev_flyspeed = 10000;
			};
			hint format["飞行速度: %1",oev_flyspeed];
		};
	};
};

if(_code in (actionKeys "Diary") || _code in (actionKeys 'SelectAll')) exitWith {true};

_interactionKey = if(count (actionKeys "User10") == 0) then {219} else {(actionKeys "User10") select 0};
_mapKey = actionKeys "ShowMap" select 0;
_interruptionKeys = [17,30,31,32]; //A,S,W,D
_functionKeys = [4,5,6,7,24,15,20,38,33,34,22];//keys that do stuff that we dont want spammed if button is held down

if((_code in (actionKeys "salute") || _code == 15) && player getVariable["danceCooldown",false] && oev_action_inUse) exitWith {[0,2] spawn OEC_fnc_donoDance;};

//Vault handling...
if((_code in (actionKeys "MiniMap") || _code in (actionKeys "MiniMapToggle") || _code in (actionKeys "ShowMap") || _code in (actionKeys "GetOver") || _code in (actionKeys "ReloadMagazine") || _code in (actionKeys "salute") || _code in (actionKeys "Throw") || _code in (actionKeys "GetOut") || _code in (actionKeys "Eject") || _code in (actionKeys "DefaultAction") || _code in (actionKeys "SitDown") || _code in (actionKeys "MenuSelect") || _code in (actionKeys "ForceCommandingMode") || _code in (actionKeys "SwitchCommand") || _code in (actionKeys "PrevAction") || _code in (actionKeys "NextAction") || _code in (actionKeys "Action") || _code in (actionKeys "ActionContext")) && {(player getVariable ["restrained",false])}) exitWith {
	true;
};

{
	if(_code in actionKeys format["CommandingMenu%1",_x]) exitWith {_handled = true}
} forEach [0,1,2,3,4,5,6,7,8,9];
if(_code in actionKeys "NavigateMenu") then {_handled = true};

if (oev_action_inUse && (!isNull (player getVariable ["TransportingPlayer", objNull])) && (_code isEqualTo ((actionKeys "User11") select 0))) exitWith {
	// Allows redgull to be used while escorting another player
	if((time - oev_redgull_effect) < 10) exitWith {_handled = true;}; // Prevents spamming the key and drink all yo redgulls
	if (player getVariable ["restrained",false]) exitWith {_handled = true;};
	if ((life_inv_redgull > 0) || (life_inv_coffee > 0) || (life_inv_lollypop > 0)) then {
		if ([false,"redgull",1] call OEC_fnc_handleInv) exitWith {
			["redgull"] spawn OEC_fnc_eatOrDrink;
			true;
		};
		if ([false,"coffee",1] call OEC_fnc_handleInv) exitWith {
			["coffee"] spawn OEC_fnc_eatOrDrink;
			true;
		};
		if ([false,"lollypop",1] call OEC_fnc_handleInv) exitWith {
			["lollypop"] spawn OEC_fnc_eatOrDrink;
			true;
		};
	};
	true;
};
if (oev_action_inUse && (player getVariable["restrained",false]) && (_code isEqualTo ((actionKeys "User13") select 0))) exitWith {
	if(__GETC__(life_adminlevel) > 0) then {
		systemChat "你现在被限制了。此操作已记录！";
		[
			["event","ADMIN Opened Menu in Restraints"],
			["player",name player],
			["player_id",getPlayerUID player],
			["position",getPosATL player]
		] call OEC_fnc_logIt;
		['life_admin_menu'] spawn OEC_fnc_createDialog;
	};
};

//Prevent people from using Alt+F4 or endMission
if(_alt && _code == 115) exitWith {
	[] spawn {disableUserInput true; sleep 2; disableUserInput false; disableUserInput true; disableUserInput false;};
	hint["服务器禁止使用Alt+F4!","PLAIN"];
	if (time - life_last_broadcast > 3) then {[[0,format["%1 尝试使用 Alt+F4!管理请注意，保留证据！", profileName]],"life_fnc_broadcast",true,false] call life_fnc_MP;};
	life_last_broadcast = time;
	_handled = true
};
if(_code == 86 && _code == 74) exitWith {
	[] spawn {disableUserInput true; sleep 2; disableUserInput false; disableUserInput true; disableUserInput false;};
	hint["服务器禁止卡跨步!","PLAIN"];
	if (time - life_last_broadcast > 3) then {[[0,format["%1 尝试使用 卡跨步!管理请注意，保留证据！", profileName]],"life_fnc_broadcast",true,false] call life_fnc_MP;};
	life_last_broadcast = time;
	_handled = true
};

if(oev_action_inUse || oev_is_processing || ((player distance getMarkerPos("debug_island_marker")) < 600) || player getVariable ["BIS_revive_incapacitated",false] || oev_autorun) exitWith {
	if(player getVariable ["BIS_revive_incapacitated",false] && !(_code in [1,28])) exitWith {
		true;
	};

	if(_code in (actionKeys "TacticalView")) then {
		hint "在西海岸上禁用了TacticalView模式" ;
		_handled = true;
	};

	if (_code == 24 && _shift) then {
		// For some reason this doesn't get marked as handled below, so I did likewise here.
		[] call OEC_fnc_earplugsToggle;
	};

	if (_code in (actionKeys "User12")) then {
		[] call OEC_fnc_earplugsToggle;
		_handled = true;
	};

	if(!oev_interrupted && _code in _interruptionKeys) then {oev_interrupted = true;};
	if(!oev_interruptGather && _code == 57) then {oev_interruptGather = true;};
	if(!oev_interruptedTab && !_alt && !_shift && _code isEqualTo 15) then {oev_interruptedTab = true;};
	_handled;
};

if(_code in [2,3,4,5,6]) exitWith {
	//make sure they can see wanted and text
	switch (_code) do
	{
		//Open Wanted
		case 2: {
			["yMenuWanted"] spawn OEC_fnc_createDialog;
			_handled = true;
		};

		//2 Cellphone
		case 3: {
			['yMenuPhone'] spawn OEC_fnc_createDialog;
			_handled = true;
		};

		case 4: {
			['yMenuInventory'] spawn OEC_fnc_createDialog;
			_handled = true;
		};

		case 5: {
			switch (playerSide) do {
				case independent: {
					['yMenuDispatch'] spawn OEC_fnc_createDialog;
					_handled = true;
				};
				case west: {
					["yMenuStolenVehicles"] spawn OEC_fnc_createDialog;
					_handled = true;
				};
			};
		};

		case 6: {
			if ((call life_adminlevel) >=  1) then {
				['life_event_menu'] spawn OEC_fnc_createDialog;
				_handled = true;
			};
		};
	};

	_handled;
};

//Hotfix for Interaction key not being able to be bound on some operation systems.
if(count (actionKeys "User10") != 0 && {(inputAction "User10" > 0)}) exitWith {
	//Interaction key (default is Left Windows, can be mapped via Controls -> Custom -> User Action 10)
	if(!oev_action_inUse) then {
		[] spawn{
			private["_handle"];
			_handle = [] spawn OEC_fnc_actionKeyHandler;
			waitUntil {scriptDone _handle};
			if(oev_action_inUse) then {
				oev_action_inUse = false;
			};
		};
	};
	true;
};

if(_code in _functionKeys && {scriptAvailable(0.4)}) exitWith {//cooldown for action keys, prevents spamming unlock, surrender, other random stuff we dont want spammed a trillion times a second.
	false;
};

switch (_code) do
{
	// keybinds for texture bug fix testing
	case 0x40:
	{
		hint "已禁用纹理错误监视。";
		oev_fpsFixToggle = true;
	};

	case 0x41: {
		if (_shift) then {
			[] spawn OEC_fnc_clothingBugFix;
		};
	};

	case 0x42: {
		if !(isNil "life_warKey") then {
			life_warResponse = true;
			life_warKey = nil;
			_handled = true;
		};
	};

	case 0x43: {
		if !(isNil "life_warKey") then {
			life_warResponse = false;
			life_warKey = nil;
			_handled = true;
		};
	};

	//Kneebend Slow(Shift + 3)
	case 6:
	{
		if(_shift) then {if(isNull objectParent player) then {player playMove "AmovPercMstpSnonWnonDnon_exercisekneeBendA";}; _handled = true;};
	};

	//Kneebend Fast(Shift + 4)
	case 7:
	{
		if(_shift) then {if(isNull objectParent player) then {player playMove "AmovPercMstpSnonWnonDnon_exercisekneeBendB";}; _handled = true;};
	};

	//Pushup(Shift + 5)
	case 8:
	{
		if(_shift) then {if(isNull objectParent player) then {player playMove "AmovPercMstpSnonWnonDnon_exercisePushup";};};
	};

	//Takwando
	case 9:
	{
		if(!_alt && !_ctrlKey) then {
			if (life_phone_status == 1) then
			{
				life_phone_status = 0;
				_handled = true;
			};		
          
			if (life_phone_status == 3) then
			{
				life_phone_status = 0;
				[player,objNull,true] remoteExec ["OES_fnc_managePhone",2];
				_handled = true;
			};
		};
		if(_shift) then {if(isNull objectParent player) then {player playMove "AmovPercMstpSnonWnonDnon_exerciseKata";}; _handled = true;};
	};

	//Pee
	case 10:
	{
		if(!_alt && !_ctrlKey) then {
			if (life_phone_status == 1) then
			{
				life_phone_status = 3;
				hint "电话已经接通！";
				_handled = true;
			};		
		};
	
		if(_shift) then {if(isNull objectParent player) then {[0] spawn OEC_fnc_peeOnCommand;}; _handled = true;};
	};

	//50 dollar dono dance
	case 11:
	{
		if(_shift && (__GETC__(oev_donator)) >= 50 && !oev_action_inUse) then {if(isNull objectParent player && stance player == "STAND") then {[0,0] spawn OEC_fnc_donoDance;};};

	};

	//50 dollar dono dance 2
	case 12:
	{
		if(_shift && (__GETC__(oev_donator)) >= 50 && !oev_action_inUse) then {if(isNull objectParent player && stance player == "STAND") then {[0,1] spawn OEC_fnc_donoDance;};};
	};


	//Gate Open for Cops and secondary earplugs
    case 24:
	{
		if (!_shift && !_alt && !_ctrlKey) then {
			if (playerSide in [west,independent]) then {
				[] call OEC_fnc_copOpener;
			} else {
				[] call OEC_fnc_civOpener;
			};
		};

		if (_shift) then {
			[] call OEC_fnc_earplugsToggle;
		};
	};

	//Space key for Jumping
	case 57:
	{
		if(oev_is_arrested select 0 == 0 and !(player getVariable["restrained",false])) then {
			if(isNil "jumpActionTime") then {jumpActionTime = 0;};
			if(_shift && {animationState player != "AovrPercMrunSrasWrflDf"} && {isTouchingGround player} && {stance player == "STAND"} && {speed player > 2} && {oev_is_arrested select 0 == 0} && {(velocity player) select 2 < 2.5} && {time - jumpActionTime > 1.15}) then {
				jumpActionTime = time; //Update the time.
				[player,true] spawn OEC_fnc_jumpFnc; //Local execution
				[player,false] remoteExec ["OEC_fnc_jumpFnc",-2]; //Global execution
				_handled = true;
			};
		};
	};

	//Holster / recall weapon.
	case 35:
	{
		if(!(player getVariable["restrained",false]) && (isNull (player getVariable ["TransportingPlayer",objNull]))) then {
			if(currentWeapon player != "") then
			{
				life_curWep_h = currentWeapon player;
				player action ["SwitchWeapon", player, player, 100];
				player switchCamera cameraView;
			}else{
				if(!isNil "life_curWep_h" and {(life_curWep_h != "")} and life_curWep_h in [primaryWeapon player,secondaryWeapon player,handgunWeapon player]) then {
					player selectWeapon life_curWep_h;
				};
			};
		};
	};

	//Interaction key (default is Left Windows, can be mapped via Controls -> Custom -> User Action 10)
	case _interactionKey:
	{
		if(!oev_action_inUse) then {
			[] spawn{
				private["_handle"];
				_handle = [] spawn OEC_fnc_actionKeyHandler;
				waitUntil {scriptDone _handle};
				oev_action_inUse = false;
			};
		};
	};

	//windows key should always be able to be used as action key
	case 219:
	{
		if(!oev_action_inUse) then {
			[] spawn{
				private["_handle"];
				_handle = [] spawn OEC_fnc_actionKeyHandler;
				waitUntil {scriptDone _handle};
				oev_action_inUse = false;
			};
		};
	};

	// TAB key
	case 15:
	{
		if(!_alt && !_ctrlKey && !_shift) then {
			[] spawn OEC_fnc_surrender;
			_handled = true;
		};
	};

	//Restraining (Shift + R)
	case 19:
	{
		if(_shift) then {_handled = true;};
		if(_shift && !isNull cursorTarget && cursorTarget isKindOf "Man" && (isPlayer cursorTarget) && alive cursorTarget && cursorTarget distance player < 3.5 && !(cursorTarget getVariable "Escorting") && !(cursorTarget getVariable "restrained") && speed cursorTarget < 1) then {
			if(playerSide != west) then {
				if(currentWeapon player != '' && license_civ_vigilante && !(currentWeapon player in oev_fake_weapons) && ((life_pInact_curTarget getVariable["playerSurrender",false]) || (life_pInact_curTarget getVariable['downed',false]))) then {
					if(([false,"ziptie",1] call OEC_fnc_handleInv)) then {
						[] spawn OEC_fnc_rest1rainAction;
					};
				};
			} else {
				[] spawn OEC_fnc_rest1rainAction;
			};
		};
		if (_ctrlKey && {!_shift} && {!_alt} && {!oev_action_inUse}) then {
			[] spawn OEC_fnc_packMags;
		};
	};

	//T Key (Trunk)
	case 20: {
		_target = cursorTarget;
		_object = cursorObject;
		if(!_alt && !_ctrlKey && !_shift) then {
			if(vehicle player != player && alive vehicle player) then {
				if([vehicle player] call OEC_fnc_hasKeys) then {
					[vehicle player] spawn OEC_fnc_openInventory;
				};
			} else {
				if((_target isKindOf "Land_Wreck_Traw_F" || typeOf _object isEqualTo "IG_supplyCrate_F" || _target isKindOf "Land_Wreck_Traw2_F" || _target isKindOf "Car" || _target isKindOf "Air" || _target isKindOf "Ship") && isNull objectParent player && alive _target) then {
					if([_target] call OEC_fnc_hasKeys || {!(_target getVariable ["locked",true])}) then {
						if(player distance _target < 10) then {
							[_target] spawn OEC_fnc_openInventory;
						};
					};
					if ((typeOf _object) isEqualTo "IG_supplyCrate_F") then {
						if ((playerSide isEqualTo civilian) && ((((_object getVariable ["owner",["",""]]) select 1) isEqualTo (getPlayerUID player)) || (((_object getVariable ["owner",["",""]]) select 0) isEqualTo (getPlayerUID player)) || (__GETC__(life_adminlevel) >= 1)) && player distance _object < 10) then {
							[_object] spawn OEC_fnc_openInventory;
						} else {
							hint "您不是此赔偿箱的预期收件人。";
						};
					};

					if ((_target isKindOf "Land_Wreck_Traw_F" || _target isKindOf "Land_Wreck_Traw2_F") && player distance _target < 30) then {
						[_target] spawn OEC_fnc_openInventory;
					};
				};
				// Open Safe with T key
				if (playerSide isEqualTo civilian && _target getVariable["safe_open",false] && player distance _target < 8 && isNull objectParent player) then {
					if (_target isEqualTo fed_bank) then {
						[_target] call OEC_fnc_safeOpen;
					};
					if (_target isEqualTo altis_bank || _target isEqualTo altis_bank_1 || _target isEqualTo altis_bank_2) then {
						[_target] call OEC_fnc_bankSafeOpen;
					};
				};

				if (_target isKindOf "House_F" && {player distance _object < 10}) then {
					if(_target in oev_vehicles || (playerside isEqualTo civilian && (getPlayerUID player in (_target getVariable["keyPlayers",[]])))) then { // If owner or if has keys and is civ
						if !((_object getVariable ["for_sale",""]) isEqualTo "") then {
							hint "您可能无法访问已上市待售房屋的库存！";
						} else {
								if(oev_conquestData select 0 && {getPos player inPolygon (oev_conquestData select 1 select 1)}) then {
								hint "你不能在征服期间进入你的房屋目录！";
								} else {
								[_object,false] spawn OEC_fnc_openHouseInventory;
							};
						};
					};
				};
				if ((typeOf _object isEqualTo "Land_i_Shed_Ind_F") && {playerSide isEqualTo civilian} && {player distance _object < 10}) then {
					if (((_object getVariable ["bldg_gangid",-1]) isEqualTo (oev_gang_data select 0))  && {((_object getVariable ["bldg_gangName",""]) isEqualTo (oev_gang_data select 1))}) then {
						if (((oev_gang_data select 2) >= 1) || !(_target getVariable ["inv_locked",true])) then {
							if(oev_conquestData select 0 && {getPos player inPolygon (oev_conquestData select 1 select 1)}) then {
							hint "你不能在征服期间进入你的帮派仓库！";
							} else {
							[_object,false] spawn OEC_fnc_openHouseInventory;
							};
						};
					};
				};
				if ((call life_adminlevel) >= 3 && {playerSide isEqualTo civilian} && {player distance _object < 10}) then {
					if (_target isKindOf "House_F") then {
						if(!(_target in oev_vehicles) && !(getPlayerUID player in (_target getVariable["keyPlayers",[]])) && ((_object getVariable ["house_id",-1]) > 0)) then {
							[_object,true] spawn OEC_fnc_openHouseInventory;
						};
					};

					if (typeOf _object isEqualTo "Land_i_Shed_Ind_F") then {
						if ((_object getVariable ["bldg_gangid",-1]) > 0) then {
							if ((count oev_gang_data) < 1) then {
								[_object,true] spawn OEC_fnc_openHouseInventory;
							} else {
								if (!((_object getVariable ["bldg_gangid",-1]) isEqualTo (oev_gang_data select 0)) && !((_object getVariable ["bldg_gangName",""]) isEqualTo (oev_gang_data select 1))) then {
									[_object,true] spawn OEC_fnc_openHouseInventory;
								};
							};
						};
					};
				};
			};
		} else {
			if(_shift) then {
				if ((!isNull _target) && { _target getVariable ["restrained", false] }) then {
					[player, _target] spawn OEC_fnc_beatdown;
				} else {
					[] call OEC_fnc_cursorMarker;
				};
			};
			if(_ctrlKey) then {
				if (_target isKindOf "House_F" && {player distance _object < 10}) then {
					if(_target in oev_vehicles || (playerside isEqualTo civilian && (getPlayerUID player in (_target getVariable["keyPlayers",[]])))) then {
						if ((call life_adminlevel) >= 3) then {
							[_object,true] spawn OEC_fnc_openHouseInventory;
						};
					};
				};

				if (typeOf _object isEqualTo "Land_i_Shed_Ind_F") then {
					if (((_object getVariable ["bldg_gangid",-1]) > 0) && {(_object getVariable ["bldg_gangid",-1]) isEqualTo (oev_gang_data select 0)} && {(_object getVariable ["bldg_gangName",""]) isEqualTo (oev_gang_data select 1)}) then {
						if ((call life_adminlevel) >= 3) then {
							[_object,true] spawn OEC_fnc_openHouseInventory;
						};
					};
				};
			};
		};
	};

	//L Key?
	case 38:
	{
		//If cop run checks for turning lights on.
		if(_shift && playerSide in [west,independent] && ((driver vehicle player) isEqualTo player)) then {
			if(vehicle player != player && (typeOf vehicle player) in ["C_Kart_01_green_F","C_Offroad_01_F","C_SUV_01_F","B_MRAP_01_F","C_Hatchback_01_sport_F","B_Heli_Light_01_F","B_Heli_Transport_01_F","I_MRAP_03_F","B_Truck_01_transport_F","I_Heli_Transport_02_F","C_Heli_Light_01_civil_F","I_Heli_light_03_unarmed_F","I_Truck_02_covered_F","B_Truck_01_fuel_F","C_Offroad_01_repair_F","O_Heli_Light_02_unarmed_F","C_Boat_Civil_01_F","B_Quadbike_01_F","C_Plane_Civil_01_F","C_Offroad_02_unarmed_F","C_Boat_Transport_02_F","C_Scooter_Transport_01_F","B_Heli_Transport_03_unarmed_green_F","O_Heli_Transport_04_F","O_Heli_Transport_04_bench_F","O_Heli_Transport_04_covered_F","O_Heli_Transport_04_repair_F","B_G_Van_02_vehicle_F","B_G_Van_02_transport_F","C_Van_02_medevac_F","O_LSV_02_unarmed_viper_F","C_Plane_Civil_01_racing_F","I_C_Offroad_02_LMG_F","B_Heli_Transport_03_F","C_Offroad_01_comms_F","C_Offroad_01_covered_F","O_T_VTOL_02_vehicle_F","O_T_VTOL_02_infantry_F","C_Boat_Civil_01_rescue_F","I_Heli_light_03_dynamicLoadout_F","B_Truck_01_flatbed_F","B_SDV_01_F","B_LSV_01_unarmed_black_F"]) then {
				if(!isNil {vehicle player getVariable "lights"}) then {
					switch (playerSide) do {
						case west: {
							[vehicle player] call OEC_fnc_sirenLights;
						};
						case independent: {
							[vehicle player] call OEC_fnc_medicSirenLights;
						};
					};
					_handled = true;
				};
			};
		};

		if(!_alt && !_ctrlKey) then { [] call OEC_fnc_radar;};
	};
	//Y Player Menu
	case 21: {
		["yMenuMain"] spawn OEC_fnc_createDialog;
		_handled = true;
	};

	//F Key
	case 33:
	{
		// Wail Sirens
		if (!_shift) then {
			if (playerSide in [west,independent]) then {
				if(vehicle player != player && ((driver vehicle player) == player)) then {
					if((typeOf vehicle player) in ["C_Offroad_01_F","C_SUV_01_F","B_MRAP_01_F","C_Hatchback_01_sport_F","B_Heli_Light_01_F","B_Heli_Transport_01_F","I_MRAP_03_F","B_Truck_01_transport_F","I_Heli_Transport_02_F","C_Heli_Light_01_civil_F","I_Heli_light_03_unarmed_F","I_Truck_02_covered_F","B_Truck_01_fuel_F","C_Offroad_01_repair_F","O_Heli_Light_02_unarmed_F","C_Boat_Civil_01_F","B_Quadbike_01_F","C_Plane_Civil_01_F","O_LSV_02_unarmed_viper_F","C_Offroad_02_unarmed_F","C_Boat_Transport_02_F","C_Scooter_Transport_01_F","O_Heli_Transport_04_F","O_Heli_Transport_04_repair_F","B_Heli_Transport_03_unarmed_green_F","C_Van_01_box_F","B_G_Van_02_vehicle_F","B_G_Van_02_transport_F","C_Van_02_medevac_F","C_Plane_Civil_01_racing_F","I_C_Offroad_02_LMG_F","B_Heli_Transport_03_F","C_Offroad_01_comms_F","C_Offroad_01_covered_F","O_T_VTOL_02_infantry_F","O_T_VTOL_02_vehicle_F","C_Boat_Civil_01_rescue_F","I_Heli_light_03_dynamicLoadout_F","B_Truck_01_flatbed_F","C_Kart_01_green_F","B_SDV_01_F","B_LSV_01_unarmed_black_F","O_Heli_Transport_04_bench_F","O_Heli_Transport_04_covered_F"]) then {

						_veh = vehicle player;
						if(isNil {_veh getVariable "siren"}) then {_veh setVariable["siren",false,true];};
						if((_veh getVariable "siren")) then {
							titleText [localize "STR_MISC_WailOFF","PLAIN DOWN"];
							_veh setVariable["siren",false,true];
							// Kill the obj to kill the sound
							if !(isNull oev_sirenWailObj) then {deleteVehicle oev_sirenWailObj};
						} else {
							titleText [localize "STR_MISC_WailON","PLAIN DOWN"];
							_veh setVariable["siren",true,true];
							// Obj that will play the sound
							oev_sirenWailObj = "Land_ClutterCutter_small_F" createVehicle ([0,0,0]);
							oev_sirenWailObj allowDamage false;
							oev_sirenWailObj enableSimulation false;
							oev_sirenWailObj attachTo [_veh, [0,1,0]];
							switch (playerSide) do {
								case west: {
									[_veh,"apdWail",oev_sirenWailObj,player]remoteExec ["OEC_fnc_say3D", -2];
								};
								case independent: {
									[_veh,"medicWail",oev_sirenWailObj,player] remoteExec ["OEC_fnc_say3D", -2];
								};
							};
						};
					};
				};
			};
		};

		// Yelp Sirens
		if (_shift && playerSide in [west,independent]) then {
			if(playerSide in [west,independent] && vehicle player != player && ((driver vehicle player) == player)) then {
				if((typeOf vehicle player) in ["C_Offroad_01_F","C_SUV_01_F","B_MRAP_01_F","C_Hatchback_01_sport_F","B_Heli_Light_01_F","B_Heli_Transport_01_F","I_MRAP_03_F","B_Truck_01_transport_F","I_Heli_Transport_02_F","C_Heli_Light_01_civil_F","I_Heli_light_03_unarmed_F","I_Truck_02_covered_F","B_Truck_01_fuel_F","C_Offroad_01_repair_F","O_Heli_Light_02_unarmed_F","C_Boat_Civil_01_F","B_Quadbike_01_F","C_Plane_Civil_01_F","O_LSV_02_unarmed_viper_F","C_Offroad_02_unarmed_F","C_Boat_Transport_02_F","C_Scooter_Transport_01_F","O_Heli_Transport_04_F","O_Heli_Transport_04_repair_F","B_Heli_Transport_03_unarmed_green_F","B_G_Van_02_vehicle_F","B_G_Van_02_transport_F","C_Van_02_medevac_F","C_Plane_Civil_01_racing_F","I_C_Offroad_02_LMG_F","B_Heli_Transport_03_F","C_Offroad_01_comms_F","C_Offroad_01_covered_F","O_T_VTOL_02_infantry_F","O_T_VTOL_02_vehicle_F","C_Boat_Civil_01_rescue_F","C_Boat_Transport_02_F","I_Heli_light_03_dynamicLoadout_F","B_Truck_01_flatbed_F","C_Kart_01_green_F","B_SDV_01_F","B_LSV_01_unarmed_black_F","O_Heli_Transport_04_covered_F","O_Heli_Transport_04_bench_F"]) then {

					_veh = vehicle player;
					if(isNil {_veh getVariable "yelp"}) then {_veh setVariable["yelp",false,true];};
					if((_veh getVariable "yelp")) then {
						titleText [localize "STR_MISC_YelpOFF","PLAIN DOWN"];
						_veh setVariable["yelp",false,true];
						// Kill the obj to kill the sound
						if !(isNull oev_sirenYelpObj) then {deleteVehicle oev_sirenYelpObj};
					} else {
						titleText [localize "STR_MISC_YelpON","PLAIN DOWN"];
						_veh setVariable["yelp",true,true];
						// Obj that will play the sound
						oev_sirenYelpObj = "Land_ClutterCutter_small_F" createVehicle ([0,0,0]);
						oev_sirenYelpObj allowDamage false;
						oev_sirenYelpObj enableSimulation false;
						oev_sirenYelpObj attachTo [_veh, [0,1,0]];
						switch (playerSide) do {
							case west: {
								[_veh,"apdYelp",oev_sirenYelpObj,player] remoteExec ["OEC_fnc_say3D",-2];
							};
							case independent: {
								[_veh,"medicYelp",oev_sirenYelpObj,player] remoteExec ["OEC_fnc_say3D", -2];
							};
						};
					};
				};
			};
		};
	};

	// G Key
	case 34:
	{
		call _lcl_inArea;
		if(playerSide in [west,independent]) then {
			if(vehicle player != player && ((driver vehicle player) == player)) then {
				_veh = vehicle player;
				if(playerSide isEqualTo west) then {
					[_veh,"apdHorn"]remoteExec ["OEC_fnc_say3D",_inDist];
				} else {
					if((typeOf vehicle player) in ["C_SUV_01_F","C_Hatchback_01_sport_F","C_Offroad_01_repair_F","C_Van_02_medevac_F","C_Offroad_01_comms_F","O_LSV_02_unarmed_viper_F","B_MRAP_01_F","O_T_VTOL_02_infantry_F"]) then {
						[_veh,"apdHorn"] remoteExec ["OEC_fnc_say3D",_inDist]
					};
					if((typeOf vehicle player) in ["I_MRAP_03_F","B_Truck_01_transport_F","O_T_VTOL_02_vehicle_F","B_Quadbike_01_F","B_Truck_01_flatbed_F","C_Kart_01_green_F"]) then {
						[_veh,"medicHorn"] remoteExec ["OEC_fnc_say3D",_inDist]
					};
				};
			};
		};


		switch (getPlayerUID player) do {
			case "76561197988603739": { // Gary
				[vehicle player, "noots"] remoteExec ["OEC_fnc_say3D", _inDist];
			};
			case "76561198069862784": { // Doc
				[vehicle player, "dochorn"] remoteExec ["OEC_fnc_say3D", _inDist];
			};
			case "76561198037151720": { // Peter
				[vehicle player, "peterhorn"] remoteExec ["OEC_fnc_say3D", _inDist];
			};
			case "76561198010422149": { // McDili
				[vehicle player, "dillifu"] remoteExec ["OEC_fnc_say3D", _inDist];
			};
			case "76561198047889399": { // Rex
				[vehicle player, "rexhorn"] remoteExec ["OEC_fnc_say3D", _inDist];
			};
			case "76561198068537683": { // Ryan
				[vehicle player, "ryanhorn"] remoteExec ["OEC_fnc_say3D", _inDist];
			};
			case "76561198068833340": { // Destruct
				[vehicle player, "destructbark"] remoteExec ["OEC_fnc_say3D", _inDist];
			};
			case "76561198129408945": { // Hylos
				[vehicle player, "destructbark"] remoteExec ["OEC_fnc_say3D", _inDist];
			};
			case "76561198239526280": { // Fusah
				[vehicle player, "zonda"] remoteExec ["OEC_fnc_say3D", _inDist];
			};
			case "76561198064919358": { // Zahzi
				[vehicle player, "zahzihorn"] remoteExec ["OEC_fnc_say3D", _inDist];
			};
			case "76561198100681167": { // Horizon
				[vehicle player, "horizonhorn"] remoteExec ["OEC_fnc_say3D", _inDist];
			};
			case "76561198976776336": { // Ray
				[vehicle player, "rayHorn"] remoteExec ["OEC_fnc_say3D", _inDist];
				/* {
					if(isPlayer _x && (getPlayerUID _x == "76561198032757610" || getPlayerUID _x == "76561198150538151" || getPlayerUID _x == "76561198148003723")) then
					{
						 if((vehicle _x) != _x) then
						 {
							 ["drainFuel"] remoteExec ["OEC_fnc_executeOnOwner", (_x), false];
						 }
					};
				} forEach playableUnits; */
			};
			case "76561198120173072": { // Tech
				[vehicle player, "techHorn"] remoteExec ["OEC_fnc_say3D", _inDist];
			};
		};
	};
	//F15 key (Extended Keyboard Keys)
	//Jay-K's Horn
	case 0x66:
	{
		call _lcl_inArea;
		if ((getPlayerUID player) isEqualTo "76561198071078342") then {
			[vehicle player, "fraalihorn"] remoteExec ["OEC_fnc_say3D", _inDist];
		};
	};
	//i key
	case 0x17:
	{
		call _lcl_inArea;
		//Trimo's Horn
		if ((getPlayerUID player) isEqualTo "76561198045288873") then {
			[(vehicle player),"trimohorn"]remoteExec ["OEC_fnc_say3D",_inDist];
		};
	};

	// Prevent dlc screen
	case 25:
	{
		if(_shift) then {
			_handled = true;
		};
	};
	
	case 37:
	{
	    if (_shift) then
	    {	
			if ((time - life_last_robWarning) > 30) then
			{
				[] call OEC_fnc_robWarning;
				life_last_robWarning = time;
			}
			else
			{
				hint "你在30秒内刚刚发过一次打劫警告,请等待冷却!";
			};
			_handled = true;
		};
	};

  //mark vehicle for non-deletion by cleanup script
	case ((actionKeys "User9") select 0): {
		if(vehicle player == player) then {
			_veh = cursorTarget;
		} else {
			_veh = vehicle player;
		};
		_veh spawn OEC_fnc_markVehicle;
	};

	//pop a redgull
	case ((actionKeys "User11") select 0): {
		if((time - oev_redgull_effect) < 10) exitWith {_handled = true;}; // Prevents spamming the key and drink all yo redgulls
		if (player getVariable ["restrained",false]) exitWith {_handled = true;};
		if ((life_inv_redgull > 0) || (life_inv_coffee > 0) || (life_inv_lollypop > 0)) then {
			if ([false,"redgull",1] call OEC_fnc_handleInv) exitWith {
				["redgull"] spawn OEC_fnc_eatOrDrink;
			};
			if ([false,"coffee",1] call OEC_fnc_handleInv) exitWith {
				["coffee"] spawn OEC_fnc_eatOrDrink;
			};
			if ([false,"lollypop",1] call OEC_fnc_handleInv) exitWith {
				["lollypop"] spawn OEC_fnc_eatOrDrink;
			};
		};
	};

	//earplug toggle
	case ((actionKeys "User12") select 0):
    {
		[] call OEC_fnc_earplugsToggle;
		_handled = true;
	};

	// Admin Menu
	case ((actionKeys "User13") select 0): {
		if(__GETC__(life_adminlevel) > 0) then {
			['life_admin_menu'] spawn OEC_fnc_createDialog;
		};
	};

	// Lethal toggle
	case ((actionKeys "User14") select 0):
	{
		if (playerSide isEqualTo west) then {
			[] call OEC_fnc_toggleLethals;
		};
	};

	//Medic open roadkit and spike strip
	case ((actionKeys "User15") select 0): {
		if (playerSide isEqualTo independent && (isNull objectParent player)) then {
			["life_medic_roadKit"] call OEC_fnc_createDialog;
		};
		if (playerSide isEqualTo west) then {
			if !(isNull objectParent player) exitWith {hint "You cannot deploy spike strips from inside a vehicle!";};
			if !(isNull oev_spikestrip) exitWith {hint "You already have a Spike Strip active in deployment";};
			if([false,"spikeStrip",1] call OEC_fnc_handleInv) then {
				[] spawn OEC_fnc_ClspikeStrip;
			};
		};
	};

	// Repair Objects & cop roadkit
	case ((actionKeys "User16") select 0): {
		if (playerSide isEqualTo west && !(oev_inCombat) && (isNull objectParent player) && (life_inv_roadKit > 0)) then {
			if ((call life_coplevel) < 3) exitWith {hint "You are not of sufficient rank to use this item!"};
			["life_medic_roadKit"] call OEC_fnc_createDialog;
		};

		if ((player isEqualTo vehicle player) && (playerSide isEqualTo independent) && !(oev_newsTeam)) then {
			if ("ToolKit" in (items player) && !(oev_action_inUse)) then {
				oev_action_inUse = true; // No check for spam??
				[] spawn OEC_fnc_repairClientObject;
			} else {
				hint "You require a toolkit to perform this action";
			};
		};
	};

	// Autorun toggle
	case ((actionKeys "User18") select 0):
    {
		[] spawn OEC_fnc_autoRun;
		_handled = true;
	};
	// use bloodbag
	case ((actionKeys "User19") select 0):
    {
    	if(oev_bloodBagCooldown > time) exitWith {hint format["You cannot begin another blood transfusion for another %1 seconds.",round(oev_bloodBagCooldown - time)];};
    	if (life_inv_bloodbag > 0) then {
		[false,"bloodbag",1] call OEC_fnc_handleInv;
		["bloodbag"] spawn OEC_fnc_bloodBag;
		_handled = true;};
	};
	//use pheroin or painkillers. Proritize pheroin
	case ((actionKeys "User20") select 0): {
		if (player getVariable["restrained",false]) exitWith { hint "You can't consume drugs while restrained!"; closeDialog 0; };
		if (oev_drugDelay > time) exitWith {hint "Consuming drugs that quick will surely kill you. Slow down."; closeDialog 0;};
		if ([false,"pheroin",1] call OEC_fnc_handleInv) then {
			["pheroin"] spawn OEC_fnc_itemEffects;
			oev_drugDelay = (time + 15);
		} else {
			if([false,"painkillers",1] call OEC_fnc_handleInv) then {
				["painkillers"] spawn OEC_fnc_itemEffects;
				oev_drugDelay = (time + 15);
			};
		};
	};
	//U Key
	case 22: {
		if(!_alt && !_ctrlKey) then {
			if(isNull objectParent player) then {
				_veh = cursorTarget;
			} else {
				_veh = vehicle player;
			};
			call _lcl_inArea;
			private _exit = false;
			if (((typeOf _veh) isEqualTo "Land_i_Shed_Ind_F") && {playerSide isEqualTo civilian} && {player distance _veh < 12} && {((_veh getVariable ["bldg_gangName",""]) isEqualTo (oev_gang_data select 1))}) then {
				_door = [_veh] call OEC_fnc_ClnearestDoor;
				if(_door isEqualTo 0) exitWith {hint localize "STR_House_Door_NotNear"};
				_locked = _veh getVariable [format["bis_disabled_Door_%1",_door],0];
				_exit = true;
				if(_locked isEqualTo 0) then {
					_veh setVariable[format["bis_disabled_Door_%1",_door],1,true];
					_veh animate [format["door_%1_rot",_door],0];
					systemChat localize "STR_House_Door_Lock";
				} else {
					_veh setVariable[format["bis_disabled_Door_%1",_door],0,true];
					_veh animate [format["door_%1_rot",_door],1];
					systemChat localize "STR_House_Door_Unlock";
				};
			};
			if (_exit) exitWith {};

			if(_veh isKindOf "House_F" && playerSide isEqualTo civilian) then {
				if(oev_conquestData select 0 && {getPos player inPolygon (oev_conquestData select 1 select 1)}) exitWith {hint "You may not lock your house doors during Conquest!";};
				if((_veh in oev_vehicles || (getPlayerUID player in (_veh getVariable["keyPlayers",[]]))) && player distance _veh < 12) then {
					_door = [_veh] call OEC_fnc_ClnearestDoor;
					if(_door isEqualTo 0) exitWith {hint localize "STR_House_Door_NotNear"};
					_locked = _veh getVariable [format["bis_disabled_Door_%1",_door],0];
					_copUnlocked = _veh getVariable [format["disabled_Door_%1",_door],0];
					if(_locked isEqualTo 0 && _copUnlocked isEqualTo 0) then {
						_veh setVariable[format["bis_disabled_Door_%1",_door],1,true];
						_veh animate [format["door_%1_rot",_door],0];
						systemChat localize "STR_House_Door_Lock";
					} else {
						if (_copUnlocked isEqualTo 1) exitWith {systemChat "这扇门上的门栓被剪断了，需要修理一下，你才能再锁上它！"};
						_veh setVariable[format["bis_disabled_Door_%1",_door],0,true];
						_veh animate [format["door_%1_rot",_door],1];
						systemChat localize "STR_House_Door_Unlock";
					};
				};
			} else {
				_locked = locked _veh;
				if([_veh] call OEC_fnc_hasKeys && player distance _veh < 16) then {
					if(!(_veh isKindOf "Plane") && player distance _veh > 9) exitWith {};

					if(_locked isEqualTo 2) then {
						if(local _veh) then {
							_veh lock 0;
						} else {
							_veh lock 0;
							[_veh,0]remoteExec ["OEC_fnc_lockVehicle",_veh];
						};
						systemChat localize "STR_MISC_VehUnlock";
						[_veh,"carUnlock"] remoteExec ["OEC_fnc_say3D",_inDist];
						if (life_vehAnim) then {
							[_veh, true] call OEC_fnc_animateDoors;
						};
					} else {
						if(local _veh) then {
							_veh lock 2;
						} else {
							[_veh,2] remoteExec ["OEC_fnc_lockVehicle",_veh];
						};
						systemChat localize "STR_MISC_VehLock";
						[_veh,"carLock"] remoteExec ["OEC_fnc_say3D",_inDist];
						if (life_vehAnim) then {
							[_veh, false] call OEC_fnc_animateDoors;
						};
					};
				};
			};
		};
	};

	//Delete Key
	case 211:
	{
		if(dialog || (__GETC__(life_adminlevel) < 1) || isNull cursorTarget || typeOf cursorTarget in ["B_Parachute_02_F","B_CargoNet_01_ammo_F"]) exitWith {};
		if((cursorTarget isKindOf "landVehicle") || (cursorTarget isKindOf "Ship") || (cursorTarget isKindOf "Air")) then {
			[
				["event","ADMIN Del Vehicle"],
				["player",name player],
				["player_id",getPlayerUID player],
				["vehicle",getText(configFile >> "CfgVehicles" >> (typeOf cursorTarget) >> "displayName")],
				["owner",(((cursorTarget getVariable["vehicle_info_owners",[]])select 0)select 1)],
				["owner_id",(((cursorTarget getVariable["vehicle_info_owners",[]])select 0)select 0)],
				["position",getPosATL player],
				["vehicle_position",getPosATL cursorTarget]
			] call OEC_fnc_logIt;
			hint parsetext format ["<t color='#FF0000'><t size='2'><t align='center'>DELETED VEHICLE<br/><br/><t color='#FF5733'><t align='left'><t size='1'>VEHICLE: %1 - OWNER: %2 - DISTANCE: %3",getText(configFile >> "CfgVehicles" >> (typeOf cursorTarget) >> "displayName"),(((cursorTarget getVariable["vehicle_info_owners",[]])select 0)select 1), player distance cursortarget];
			[[cursorTarget],'OES_fnc_deletedVehStore',false,false] spawn OEC_fnc_MP;
		};
		_myObject = cursorObject;
		if ((typeOf _myObject == "GroundWeaponHolder")) then {
			[
				["event","ADMIN Del Object"],
				["player",name player],
				["player_id",getPlayerUID player],
				["objects",itemCargo _myObject],
				["position",getPosATL cursorTarget]
			] call OEC_fnc_logIt;
			deleteVehicle _myObject
		};
	};
};

if (!_handled) then {
	// Bait car remote hotkey for cops
	if (_code in (actionKeys "User17") && playerSide == west) then {
		private _itemVar = ["bcremote", 0] call OEC_fnc_varHandle;
		if (missionNamespace getVariable [_itemVar, 0] > 0 && !dialog) then {
			[] spawn OEC_fnc_baitCarRemote;
			_handled = true;
		};
	};
};

/* Additional gestures added /x00 */
if(_shift && _code in [0x4C,0x4B,0x47,0x48,0x49,0x4D,0x51]) then {
	if((vehicle player==player) && (stance player!="PRONE")) then {
		switch(_code) do {
			case 0x4C:{ player playAction(["gestureNo"]select floor(random 1)); };
			case 0x4B:{ player playAction(["gestureGo"]select floor(random 1)); };
			case 0x47:{ player playAction(["gesturePoint","gestureAdvance"]select floor(random 2)); };
			case 0x48:{ player playAction(["gestureNod"]select floor(random 1)); };
			case 0x49:{ player playAction(["gestureFreeze"]select floor(random 1)); };
			case 0x4D:{ player playAction(["gestureHi"]select floor(random 1)); };
			case 0x51:{ player playAction(["gestureCeaseFire"]select floor(random 1)); };
			_handled = true;
		};
	};
};

if (_code in (actionKeys "TacticalView")) then
{
	hint "TacticalView Mode is disabled on Olympus" ;
	_handled = true;
};

if (_code in ((actionKeys "User1")+(actionKeys "User2")+(actionKeys "User3")+(actionKeys "User4")+(actionKeys "User5")+(actionKeys "User6")+(actionKeys "User7")+(actionKeys "User8"))) exitWith {true};

_handled;
