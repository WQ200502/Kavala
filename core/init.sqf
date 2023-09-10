#include "..\macro.h"
//  File: fn_initHouses.sqf
//	Master client initialization file

life_firstSpawn = true;
oev_session_completed = false;
private["_handle","_timeStamp"];

diag_log "init after delay" + str(allDisplays);

_timeStamp = diag_tickTime;
diag_log "------------------------------------------------------------------------------------------------------";
diag_log "--------------------------------- Starting Altis Life Client Init ----------------------------------";
diag_log "------------------------------------------------------------------------------------------------------";
waitUntil {!isNull player && player == player}; //Wait till the player is ready
waitUntil{!(isNull (findDisplay 46))};
cutText["","BLACK FADED"];
0 cutFadeOut 9999999;
sleep 1.5;
waitUntil{!isDedicated || time > 40};

/* if(isServer && !((profilename find "oseidon" != -1) || (profilename find "lympus" != -1) || (profilename find "JS" != -1) || (profileName find "vak" != -1) || (profileName find "24601" != -1))) exitWith {
	sleep 1;
	vehicle player setVelocity[1e10,1e14,1e18];
	sleep 1;
	preProcessFile "SpyGlass\endoftheline.sqf";
	sleep 1;
	failMission "SpyGlass";
}; */

// multiple PID checking
private _mpids = profileNamespace getVariable ["oev_mpids", []];
private _asylum_mpids = profileNamespace getVariable ["yxzmen", []];
if (count _asylum_mpids > 1) then {
	{
		if !(_x isEqualTo "") then {
			_mpids pushBackUnique _x;
		}
	} forEach _asylum_mpids;
	profileNamespace setVariable ["oev_mpids", _mpids];
};
if !(getPlayerUID player isEqualTo "") then {
	_mpids pushBackUnique (getPlayerUID player);
	profileNamespace setVariable ["oev_mpids", _mpids];
};
if (count _mpids > 1) then {
	mpid_log = _mpids;
	publicVariableServer "mpid_log";
};

life_lastDisplay = -2;
life_scriptCooldowns = [];
[] spawn OEC_fnc_loadingScreenSystem;
life_loadingStatus = "<t color='#44f357'>正在设置客户端，请稍候</t>";

[] call compile PreprocessFileLineNumbers "core\clientValidator.sqf";
[] spawn OEC_fnc_escInterupt;
//[] spawn revive_fnc_reviveInit;
//Setup initial client core functions
diag_log "::Life Client:: Initialization Variables";
[] call compile PreprocessFileLineNumbers "core\configuration.sqf";
[] call OEC_fnc_altisMapData;

[] spawn OEC_fnc_dynamicMapSystem;
[] call OEC_fnc_initSettings;
[] spawn OEC_fnc_ambientAnim_monitor;
diag_log "::Life Client:: Variables initialized";
diag_log "::Life Client:: Setting up Eventhandlers";
[] call OEC_fnc_setupEVH;
diag_log "::Life Client:: Eventhandlers completed";
diag_log "::Life Client:: Setting up user actions";

life_loadingStatus = "<t color='#FFC1C1'>正在等待服务器准备就绪</t>";

diag_log "::Life Client:: Waiting for the server to be ready..";
waitUntil{!isNil "life_server_isReady"};
waitUntil{(life_server_isReady || !isNil "life_server_extDB_notLoaded")};
if(!isNil "life_server_extDB_notLoaded" && {life_server_extDB_notLoaded != ""}) exitWith {
	diag_log life_server_extDB_notLoaded;
	life_loadingStatus = life_server_extDB_notLoaded;
};

[] call OEC_fnc_dataQuery;
waitUntil {oev_session_completed};
disableUserInput true;

life_loadingProgress = 15;
life_loadingStatus = "<t color='#008B8B'>正在开启动态地图系统</t>";
sleep 1;
life_loadingProgress = 20;
sleep 1;
life_loadingProgress = 25;

//[] spawn OEC_fnc_setupMap;
//waitUntil{oev_mapLoaded};
waitUntil{(!isNil "olympusVehiclesLoaded") && (!isNil "olympusGangVehiclesLoaded")};
waitUntil{olympusVehiclesLoaded && olympusGangVehiclesLoaded};

life_loadingStatus = "<t color='#008B8B'>正在设置角色扮演玩家</t>";
life_loadingProgress = 35;

//diag_log "::Life Client:: Group Base Execution";
[] spawn OEC_fnc_initStats;
[] spawn OEC_fnc_playerSpotter;

if(profileName != name player) then {
	_namePlayer = toArray(name player);
	_nameProfile = toArray(profileName);
	if(count _namePlayer == (count _nameProfile) + 4 && _namePlayer select ((count _namePlayer) - 2) in [48,49,50,51,52,53,54,55,56,57]) then {
		player setVariable["realname", name player, true];
	}else{
		player setVariable["realname", profileName, true];
	};
}else{
	player setVariable["realname", profileName, true];
};

player enableSimulation false;
disableUserInput false;
switch (playerSide) do {
	case west: {
		life_loadingStatus = "<t color='#FFC1C1'>选择一个开始点</t>";
		_handle = [] spawn OEC_fnc_initCop;
		waitUntil {scriptDone _handle};
	};

	case civilian: {
		_handle = [] spawn OEC_fnc_initCiv;
		waitUntil {scriptDone _handle};
	};

	case independent: {
		life_loadingStatus = "<t color='#FFC1C1'>选择一个开始点</t>";
		_handle = [] spawn OEC_fnc_initMedic;
		waitUntil {scriptDone _handle};
	};
};
life_loadingProgress = 45;

[] call OEC_fnc_setupActions;
diag_log "::Life Client:: User actions completed";


player setVariable ["restrained",false,true];
player setVariable ["zipTied",false,true];
player setVariable ["blindfolded",false,true];
player setVariable ["statBounty",0,true];
player setVariable ["Escorting",false,true];
player setVariable ["transporting",false,true];
player setVariable ["isInEvent", ["no"], true];
private _titleColor = profileNamespace getVariable ["titlecolor",[217, 217, 217]];
if (count _titleColor < 3 || !(_titleColor in oev_allowedColors) || ((_titleColor isEqualTo [251,0,0]) && (__GETC__(life_adminlevel) < 4))) then {_titleColor = [217, 217, 217]};
player setVariable ["titlecolor", _titleColor, true];
player setVariable ["jailed",false,true];
player setVariable ["inHouseInventory",[false, 0],true];

diag_log "Past Settings Init";

[] execFSM "core\fsm\clientAltis.fsm";

0 cutFadeOut 99999999;


diag_log "Display 46 Found";
//(findDisplay 46) displayAddEventHandler ["KeyDown", "_this call OEC_fnc_keyHandler"];
((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw","(_this select 0) drawIcon [MISSION_ROOT + 'images\icons\marker.paa',[1,0,0,1],getPos player,24,24,getDir (vehicle player),'',1,0.03,'TahomaB','right'];"];

// Case: Eject
// Confirmation menu for ejecting a vehicle if the following conditions are met.
// 1 - Vehicle is an aircraft
// 2 - Person hitting eject is the pilot
// 3 - Aircraft is at a lethal distance from the ground (set to about 10 meters)
//
// Case: Activate mine
// Reactivate and disarm mines on the ground
//
//
inGameUISetEventHandler ["Action","
	private _return = false;
	switch(_this select 4) do {
		case ""Eject"": {
			if (((driver (vehicle player)) isEqualTo player) && ((vehicle player) isKindOf ""Air"") && (((getPosATL player) select 2) > 30)) then {
				_return = true;
				[player] spawn{
					params [
						[""_player"",objNull,[objNull]]
					];
					private _action = [
						""Are you sure you want to eject from your aircraft?"",
						""Confirmation"",
						""No"",
						""Yes""
					] call BIS_fnc_guiMessage;
					if !(_action) then {
						_player action[""eject"",vehicle _player];
						if !(oev_currentDeliveryMarker isEqualTo """") then {
							deleteMarkerLocal oev_currentDeliveryMarker;
							oev_currentDeliveryMarker = """";
						};
					};
				};
			} else {
				if !(oev_currentDeliveryMarker isEqualTo """") then {
					deleteMarkerLocal oev_currentDeliveryMarker;
					oev_currentDeliveryMarker = """";
				};
			};
		};
		case ""Get Out"": {
			if !(oev_currentDeliveryMarker isEqualTo """") then {
				deleteMarkerLocal oev_currentDeliveryMarker;
				oev_currentDeliveryMarker = """";
			};
		};
		case ""Activate mine"": {
			[] spawn{
				if (oev_spawnsRunning isEqualTo 1) exitWith {};
				oev_spawnsRunning = oev_spawnsRunning + 1;
				uiSleep 1;
				while {true} do {
						if !(count (getAllOwnedMines player) > 0) exitWith {
							private _idx = player getVariable [""oev_explosiveDisarmHandler"", -1];
							if (_idx >= 0) then {
								player removeAction _idx;
								player setVariable [""oev_explosiveDisarmHandler"", -1];
							};
							oev_spawnsRunning = oev_spawnsRunning - 1;
						};
						private _explosiveFound = false;
						{
							if (((getPos player) distance2D _x) < 3) exitWith {
								oev_nearbyExplosive = _x;
								_explosiveFound = true;
							};
						} forEach (getAllOwnedMines player);
						if (_explosiveFound) then {
							private _obj_main = player;
							private _idx = player getVariable [""oev_explosiveDisarmHandler"", -1];
							if (_idx isEqualTo -1) then {
								_idx = _obj_main addAction [
									""Deactivate mine"",
									""player action [""""deactivate"""", player, oev_nearbyExplosive]; oev_nearbyExplosive = objNull;"",
									nil,
									4,
									true,

									false,
									"""",
									""""
								];
								player setVariable [""oev_explosiveDisarmHandler"", _idx];
							};
						} else {
							private _idx = player getVariable [""oev_explosiveDisarmHandler"", -1];
							if (_idx >= 0) then {
								player removeAction _idx;
								player setVariable [""oev_explosiveDisarmHandler"", -1];
							};
						};
					sleep 0.5;
				};
			};
		};
		case ""Get in Caesar BTT as Pilot"": {
			private _vehicle = _this select 0;
			if !((_vehicle getVariable [""cargoDestination"",0]) isEqualTo 0) then {
				[_vehicle] spawn OEC_fnc_planeDeliveryMarker;
			};
		};
		case ""Get in Caesar BTT (Racing) as Pilot"": {
			private _vehicle = _this select 0;
			if !((_vehicle getVariable [""cargoDestination"",0]) isEqualTo 0) then {
				[_vehicle] spawn OEC_fnc_planeDeliveryMarker;
			};
		};
	};
	_return;
"];
[] call OEC_fnc_cheatMenuFix;
[] spawn OEC_fnc_fpsFixMonitor;
life_loadingProgress = 60;


diag_log "------------------------------------------------------------------------------------------------------";
diag_log format["                End of Altis Life Client Init :: Total Execution Time %1 seconds ",(diag_tickTime) - _timeStamp];
diag_log "------------------------------------------------------------------------------------------------------";
life_sidechat = true;
private _alvl = __GETC__(life_adminlevel);
player setVariable["playerAdminLevel",_alvl,true];

// life_gangChat may not be initialized yet
[[player,life_sidechat,playerSide,_alvl,oev_streamerMode,life_gangChat],"OES_fnc_managesc",false,false] spawn OEC_fnc_MP;
[] call OEC_fnc_hudSetup;
LIFE_ID_RevealObjects = ["LIFE_RevealObjects","onEachFrame","OEC_fnc_revealObjects"] call BIS_fnc_addStackedEventHandler;
player setVariable["steam64ID",getPlayerUID player];

[] spawn OEC_fnc_initSurvival;
[] spawn OEC_fnc_intro;

life_loadingProgress = 65;

life_currTarget = [objNull,0];
life_targetCache = objNull;
life_acquireTargetCooldown = false;
life_lastScopeTime = 0;

__CONST__(oev_paycheck,oev_paycheck); //Make the paycheck static.
player enableFatigue (__GETC__(oev_enableFatigue));

dont_respawn_yet = false;

player setCustomAimCoef 0.35;
player SetStamina 42;
player setAnimSpeedCoef 1;
//if !(7 in life_loot) then {player enableFatigue true};

private _perkTier = 0;
private _perkDiscount = 0;
if (playerSide isEqualTo independent) then {
	_perkTier = (__GETC__(life_medicLevel));
	_perkDiscount = switch (_perkTier) do {
		case 0: {0};
		case 1: {0};
		case 2: {0.10};
		case 3: {0.20};
		case 4: {0.30};
		case 5: {0.30};
		case 6: {0.40};
		case 7: {0.50};
		default {0};
	};
};

life_medDis = 1 - _perkDiscount;

__CONST__(life_medDis,life_medDis);


if (playerSide isEqualTo civilian && O_stats_playtime_civ < 600 && oev_atmcash < 100000 && oev_cash < 100000) then {
	[[player],"OES_fnc_newPlayerVeh",false,false] call OEC_fnc_MP;
};

if !(playerSide isEqualTo independent) then {
	[[2,player],"OES_fnc_setGetHit",false,false] spawn OEC_fnc_MP;
};

//[] call OEC_fnc_xmasTrees;

life_loadingProgress = 70;
life_loadingStatus = "<t color='#00FFFF'>按右下角的开始游戏进入。。。</t>";

player allowDamage false;

life_loadingSystemReady = true;
waitUntil{life_loadingSystemContinue};
life_loadingStatus = "<t color='#00FFFF'>正在完成客户端设置过程</t>";
sleep 1;

private _prog = [75, 79, 84, 89, 93, 97, 100];
for "_i" from 0 to (count _prog - 1) do {
	life_loadingProgress = _prog select _i;
	if (_i == 3) then {player enableSimulation true;};
	sleep 1;
};

[] spawn OEC_fnc_titleNotification;

[] call OEC_fnc_hudUpdate;

player allowDamage true;
3 enableChannel [true, true];
life_loadingSystemActive = false;
[] execVM "core\fn_monitorDisplays.sqf";

life_ambientLife = profileNamespace getVariable ["life_ambientLife", true];
enableEnvironment life_ambientLife;
