#include "..\..\macro.h"
//  File: fn_onPlayerKilled.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: When the player dies collect various information about that player
//	and pull up the death dialog / camera functionality.
disableSerialization;

oev_inCasino = false;

params [
	["_unit",objNull,[objNull]],
	["_killer",objNull,[objNull]],
	["_instigator",objNull,[objNull]]
];
private _deathMsg = true;
private _warKill = false;
private _zoneKill = false;
private _conqKill = false;
private _myPos = getPos player;
private _killDist = 0;
private _instigatorPos = [];
private _isWz = _myPos inPolygon oev_warzonePoly;
private _log_event = "";
_instigatorPos = getPos _instigator;
_killDist = _instigatorPos distance _myPos;
//systemChat format["OPK U:%1 K:%2  I:%3 P:4%",  _unit, _killer, _instigator, player];
if(dialog) then {
	if(isNull (findDisplay 3100)) then {life_shop_cam cameraEffect ["TERMINATE","BACK"];camDestroy life_shop_cam;};
};
closeDialog 0;
if (_killer isEqualTo _unit && !(oev_respawned)) then {
	if !(oev_survival_damage) then {
		if !(oev_epipen_damage) then {
			[0, format ["%1 日了母猪后中毒了！", name player]] remoteExecCall ["OEC_fnc_broadcast", -2];
			_log_event = "Self Inflicted Death";
		} else {
			[0,format["%1 因花柳病救治无效而死亡。",name player]] remoteExec ["OEC_fnc_broadcast",-2];
			_log_event = "Dope Timer Death";
		};
	} else {
		[0,format["%1 SB 没吃饭，饿死了。",name player]] remoteExec ["OEC_fnc_broadcast",-2];
		_log_event = "Malnutrition Death";
	};
	_deathMsg = false;
	oev_survival_damage = false;
	oev_epipen_damage = false;
};

[
	["event",_log_event],
	["player",name player],
	["player_id",getPlayerUID player],
	["dropped_cash",oev_cash],
	["bounty",player getVariable ["statBounty", 0]],
	["position",_myPos]
] call OEC_fnc_logIt;

private _warZone = false;
if (playerSide isEqualTo civilian) then {
	if (oev_conquestData select 0 && _myPos inPolygon (oev_conquestData select 1 select 1)) then {
		_conqKill = true;
		oev_conqSpawnCD = time + 180;
	};
	if (_killer isEqualTo _unit) then {
		if !(_myPos inPolygon oev_warzonePoly || _conqKill) then {
			oev_deaths pushBack [getPos player, (time + 900),0];
			oev_death_count = oev_death_count + 1;

			{
				if(time > (_x select 1)) then {
					if(!isNil{_x select 3} && _x select 3) then {
						deleteMarkerLocal format["nlr_marker_%1", floor(_x select 1)];
						deleteMarkerLocal format["nlr_marker_text_%1", floor(_x select 1)];
					};
					oev_deaths deleteAt _forEachIndex;
				};
			} forEach oev_deaths;
		};
	};
	if (!isNull _instigator && _instigator != _unit && isPlayer _instigator) then {
		if !(_myPos inPolygon oev_warzonePoly) then {
			if (_conqKill) then {
				// conquest kill
			} else {
				private _rebel = false;
				private _cartel = false;

				if (side group _instigator isEqualTo west) then {
					{
						if (player distance2d (getMarkerPos _x) < 1000) exitWith {_rebel = true;};
					} forEach ["rebelOne","rebelTwo","rebelThree","rebelFour","rebelFive","rebelSix","rebelBoat"];
				};

				{
					if (player distance2d (getMarkerPos _x) < 900) exitWith {_cartel = true;};
				} forEach ["meth_cartel","moonshine_cartel","mushroom_cartel","arms_cartel"];

				if !(_rebel || _cartel) then {
					oev_deaths pushBack [getPos player, (time + 900),0];
					oev_death_count = oev_death_count + 1;

					{
						if(time > (_x select 1)) then {
							if(!isNil{_x select 3} && _x select 3) then {
								deleteMarkerLocal format["nlr_marker_%1", floor(_x select 1)];
								deleteMarkerLocal format["nlr_marker_text_%1", floor(_x select 1)];
							};
							oev_deaths deleteAt _forEachIndex;
						};
					} forEach oev_deaths;
				};
			};
		} else {
			if (side group _instigator isEqualTo civilian) then {
				_warZone = true;
				_zoneKill = true;
			};
		};
	};
	if (side group _instigator isEqualTo civilian) then {
		{
			if (player distance2D (getMarkerPos _x) < 900) exitWith {_zoneKill = true;};
		} forEach ["meth_cartel","moonshine_cartel","mushroom_cartel","arms_cartel"];
	};
	if (life_deathMessages) then {
		private _randomMsg = [
			"有人叫你不要推！","重要的不是你的打击有多重，而是你能被打击多少并且还能继续前进。","任务失败了，我们下次再来。","别按Alt-F4！","Tango down.","战争。 战争永不改变。","您已阅读有关此手册的内容吗？","这对我们来说是艰辛的生活！","DDoSing是一项联邦罪行。","我相信医生会很快。","我们不会举报或失败，我们会继续到最后。","1-800-273-8255","你死了","浪费了"
		];
		if((getPlayerUID player) isEqualTo "76561198074014053") then {
				_randomMsg = ["DDoSing is a federal offense."];
		};
		private _perkTier = ["civ_deaths"] call OEC_fnc_fetchStats;
		switch (_perkTier) do {
			case 1: {systemChat format["%1",selectRandom _randomMsg];};
		};
	};
} else {
	if(playerSide == independent) then {
		oev_deaths pushBack [getPos player, (time + 900),0];
		oev_death_count = oev_death_count + 1;

		{
			if(time > (_x select 1)) then {
				if(!isNil{_x select 3} && _x select 3) then {
					deleteMarkerLocal format["nlr_marker_%1", floor(_x select 1)];
					deleteMarkerLocal format["nlr_marker_text_%1", floor(_x select 1)];
				};
				oev_deaths deleteAt _forEachIndex;
			};
		} forEach oev_deaths;
	};
	oev_yInvItems = [];
	private _eFormatInv = [];
	private _eFormatWeight = 0;
	private ["_shrt","_amnt","_itemWeight"];
	{
	    _shrt = [_x,1] call OEC_fnc_varHandle;
	    _amnt = missionNameSpace getVariable _x;
	    _itemWeight = ([_shrt] call OEC_fnc_itemWeight) * _amnt;
	    if(_amnt > 0) then {
	        _eFormatInv pushBack [_shrt,_amnt];
	        _eFormatWeight = _eFormatWeight + _itemWeight;
	    };
	} forEach oev_inv_items;
	oev_yInvItems = [_eFormatInv,_eFormatWeight];
};

oev_loadout = getUnitLoadout player;
private _myPrimary = primaryWeapon _unit;
private _mySecondary = secondaryWeapon _unit;
private _myHandgun = handgunWeapon _unit;

if !(_myPrimary isEqualTo "") then {
	_unit removeWeapon _myPrimary;
};

if !(_mySecondary isEqualTo "") then {
	_unit removeWeapon _mySecondary;
};

if !(_myHandgun isEqualTo "") then {
	_unit removeWeapon _myHandgun;
};

if !(oev_currentDeliveryMarker isEqualTo """") then {
	deleteMarkerLocal oev_currentDeliveryMarker;
	oev_currentDeliveryMarker = """";
};

private ["_instigatorPrimary","_instigatorSecondary","_instigatorHandgun","_instigatorUniform","_instigatorVest","_instigatorHeadgear","_myUniform","_myVest","_myHeadgear","_instigatorGangID","_instigatorGangName"];
_myUniform = uniform _unit;
_myVest = vest _unit;
_myHeadgear = headgear _unit;
_instigatorGangID = -2;

if ((side group _instigator isEqualTo civilian)) then {
	_instigatorGangID = ((_instigator getVariable ["gang_data",[0,"",0]]) select 0);
	_instigatorPrimary = primaryWeapon _instigator;
	_instigatorSecondary = secondaryWeapon _instigator;
	_instigatorHandgun = handgunWeapon _instigator;
	_instigatorUniform = uniform _instigator;
	_instigatorVest = vest _instigator;
	_instigatorHeadgear = headgear _instigator;
	if(_instigator call OEC_fnc_isAtWar) then {
		_warKill = true;
	};
};

if (_unit getVariable ["kidneyRemoved",false]) then {
	_unit setVariable ["kidneyRemoved",false,true];
};

if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[
		["event","Hacked Cash"],
		["player",name player],
		["player_id",getPlayerUID player],
		["hacked_cash",oev_cash - (oev_cache_cash - oev_random_cash_val)],
		["hacked_bank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)],
		["position",getPosATL player]
	] call OEC_fnc_logIt;
	[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]] remoteExec ["OEC_fnc_notifyAdmins",-2];
	[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]] remoteExec ["OES_fnc_handleDisc",2];
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

if(playerSide isEqualTo civilian) then {
	[11] call OEC_fnc_ClupdatePartial;
};

O_stats_deaths = O_stats_deaths + 1;
oev_drugDose = 0;
oev_inCombatTime = diag_tickTime - 90;
oev_inCombat = false;
oev_deathPosition = getPosATL _unit;

if !(isNull oev_vigiBuddyObj) then {
	["oev_vigiBuddyObj",objNull]remoteExec ["OEC_fnc_netSetVar",oev_vigiBuddyObj];
	["oev_vigiBuddyPID",""] remoteExec ["OEC_fnc_netSetVar",oev_vigiBuddyObj];
	[1,format["Your buddy has died. You will need to find a new friend."]] remoteExec ["OEC_fnc_broadcast",oev_vigiBuddyObj];
	oev_vigiBuddyObj = objNull;
	oev_vigiBuddyPID = "";
};

_unit setvariable ["revive",true,true];
_unit setvariable ["hasRequested",0,true];
_unit setvariable ["name",profileName,true];
_unit setvariable ["restrained",false,true];
_unit setvariable ["zipTied",false,true];
_unit setvariable ["blindfolded",false,true];
_unit setvariable ["statBounty",O_stats_crimes select 0,true];
player setvariable ["statBounty",O_stats_crimes select 0,true];
_unit setvariable ["Escorting",false,true];
_unit setVariable ["infected",false,true];
_unit setvariable ["transporting",false,true];
_unit setvariable ["steam64id",(getPlayerUID player),true];
_unit setvariable ["epiSide",playerside, true];
_unit setvariable ["dispatchStatus","",true];
_unit setvariable ["dispatchOwner","",true];
_unit setvariable ["responseType",3,true]; // 3 = no type
_unit setVariable ["kidneyHarvester",nil,true];
_unit setVariable ["deathPosition", oev_deathPosition, true];
_unit setVariable ["beingRobbed", nil, true];
if(("ItemGPS" in (assignedItems _unit))) then {
	_unit setVariable ["hasGPS", true, true];
} else{
	_unit setVariable ["hasGPS", false, true];
};
//systemChat format["DPOS: %1 HG: %2",(_unit getVariable["deathPosition",[]]), (_unit getVariable["hasGPS",false])];
//This thread will update a variable every 10 sec to see if the client is still here
[] spawn{
	while{!isNull life_corpse} do {
		life_corpse setvariable ["afkCheck",serverTime,true];
		uiSleep 10;
	};
};

// Epi revive stuff
if (player getvariable ["epiActive",false]) then {
	_unit setvariable ["epiFailed", true, true];
} else {
	_unit setvariable ["epiFailed", false, true];
};
if (player getVariable ["lastShot", 0] != 0) then {
	_unit setVariable ["lastShot", player getVariable ["lastShot", 0], true];
};
player setvariable ["epiActive", false, true];
player setvariable ["epiTime", 0];

life_corpse = _unit;
if(((player getVariable ["isInEvent",["no"]]) select 0) in ["derby","race","lastman","dogfight","roulette"]) then {
	_unit setVariable ["isInEvent", ["no"], true];
	[player, "leave"] remoteExec ["OES_fnc_eventPlayers", 2, false];
};

life_deathCamera = "CAMERA" camCreate (getPosATL _unit);
showCinemaBorder true;
life_deathCamera cameraEffect ["Internal","Back"];
//["DeathScreen"] call OEC_fnc_createDialog;

life_deathCamera camSetTarget _unit;
life_deathCamera camSetRelPos [0,3.5,4.5];
life_deathCamera camSetFOV .5;
life_deathCamera camSetFocus [50,0];
life_deathCamera camCommit 0;

//(findDisplay 7300) displaySetEventHandler ["KeyDown","if((_this select 1) == 1) then {true}"];
//Rewrite of death screen. Pain in the arse tbh
[_unit, _killer, _instigator, _deathMsg, _warKill, _killDist, _isWz] spawn{
	params[
	["_unit", objNull, [objNull]],
	["_killer", objNull, [objNull]],
	["_instigator", objNull, [objNull]],
	["_deathMsg", true, []],
	["_warKill", false, []],
	["_killDist", 0, []],
	["_isWz", false, []]
	];
	_looped = false;
	player setVariable ["maxrevtime",(serverTime + 900),true];
	_maxTime = time + 31;
	while {true} do {
		uiSleep 0.5;
		//Checks for if the player is still dead/in spawn menu
		if (!isNull (findDisplay 7300)) exitWith {}; //Death menu already open
		if (!isNull (findDisplay 38500)) exitWith {}; //Spawn menu open
		["DeathScreen"] call OEC_fnc_createDialog;
		[] spawn OEC_fnc_deathScreen;
		_timer = ((findDisplay 7300) displayCtrl 7301);
		_DeathInfo = ((findDisplay 7300) displayCtrl 7309);
		_adminSelfRevive = ((findDisplay 7300) displayCtrl 7322);
		_instigatorGangName = if (side group _instigator isEqualTo west) then {""} else {
			((_instigator getVariable ["gang_data",[0,"",0]]) select 1);
		};
		(findDisplay 7300) displaySetEventHandler ["KeyDown","if((_this select 1) == 1) then {true}"];
		((findDisplay 7300) displayCtrl 7302) ctrlEnable false;
		if(call life_adminlevel < 1) then {
			_adminSelfRevive ctrlShow false;
		};
		if(side group _instigator isEqualTo west && playerSide != west) then {
			if(!isNull _instigator && {_instigator != _unit}) then {
				if(((_instigator getvariable ["isInEvent",["no"]]) select 0) == "no") then {
					if !(_looped) then {
						if (playerSide isEqualTo civilian) then {
							["cop_lethals",1] remoteExec ["OEC_fnc_statArrUp",_instigator];
							[player,_instigator]remoteExec ["OES_fnc_lethalPay",2]; // Pay cops for the kill
						};
						[0,format["%1被警官%2杀死。",name player,name _instigator]] remoteExec ["OEC_fnc_broadcast",-2];
						[
							["event","APD Lethal Kill"],
							["player",name _instigator],
							["player_id",getPlayerUID _instigator],
							["position",getPosATL _instigator],
							["target",name player],
							["target_id",getPlayerUID player],
							["target_position",getPosATL player],
							["dropped_cash",oev_cash],
							["distance",_killDist],
							["is_wz",_isWz]
						] call OEC_fnc_logIt;
					};
					_DeathInfo ctrlSetStructuredText parseText format["<t align='center'>你被%1杀死（APD）</t>",name _instigator];
					_deathMsg = false;
					// When the player is dead, updateWanted is not getting run. Pulled the required code to solve
					// wanted remove and sync.. if its not a medic
					if (playerSide != civilian || _looped) exitWith {};
					O_stats_crimes = [];
					for [{_x=0},{_x<=oev_totalCrimes},{_x=_x+1}] do {
						O_stats_crimes pushBack 0;
					};
					[10] call OEC_fnc_ClupdatePartial;
				};
			};
			if(!oev_use_atm && {oev_cash > 0} && !(_looped)) then {
				format[localize "STR_Cop_RobberDead",[oev_cash] call OEC_fnc_numberText]remoteExec ["OEC_fnc_broadcast",-2];
				oev_cash = 0;
				oev_cache_cash = oev_random_cash_val;
			};
		} else {
			if !(_looped) then {
				if (_deathMsg && !(oev_respawned)) then {
					if ((name _killer == "Error: No vehicle") || (name _killer == "Error: No unit")) then {
						[0,format["%1 has died.",name player]] remoteExec ["OEC_fnc_broadcast",-2];
					} else {
						if !(_warKill) then {
							[0,format["%1被%2击杀！",name player,name _instigator]] remoteExec ["OEC_fnc_broadcast",-2];
						} else {
							[0,format["%1被敌方帮派成员%2杀死!",name player,name _instigator]]remoteExec ["OEC_fnc_broadcast",-2];
						};
						if (_instigatorGangName != "") then {
							_DeathInfo ctrlSetStructuredText parseText format["<t align='center'>你被%1（%2）杀死</t>",name _instigator, _instigatorGangName];
						}else{
							_DeathInfo ctrlSetStructuredText parseText format["<t align='center'>你被%1杀死（没有帮派关系）</t>",name _instigator];
						};
					};
				[
					["event","Player Kill"],
					["player",name _instigator],
					["player_id",getPlayerUID _instigator],
					["position",getPosATL _instigator],
					["target",name player],
					["target_id",getPlayerUID player],
					["dropped_cash",[oev_cash] call OEC_fnc_numberText],
					["target_position",getPosATL player],
					["distance",_killDist],
					["is_wz",_isWz]
				] call OEC_fnc_logIt;
				};
			} else {
				if !((name _killer == "Error: No vehicle") || (name _killer == "Error: No unit")) then {
					if (_instigatorGangName != "") then {
						_DeathInfo ctrlSetStructuredText parseText format["<t align='center'>你被%1（%2）杀死</t>",name _instigator, _instigatorGangName];
					}else{
						_DeathInfo ctrlSetStructuredText parseText format["<t align='center'>你被%1杀死（没有帮派关系）</t>",name _instigator];
					};
				};
			};
		};
		if (round(_maxTime - time) > 1) then {
			waitUntil{
				if (oev_request_timer) then {
					_maxTime = oev_respawn_timer;
				};
				_timer ctrlSetStructuredText parseText format["<t align='center'>改头换面倒计时: %1</t>",[round((_maxTime - Time)- 1),"MM:SS"] call BIS_fnc_secondsToString];
				uiSleep 0.5;
				oev_request_timer || round(_maxTime - time) <= 1 || isNull(findDisplay 7300) || isNull life_corpse;
			};
		} else {
			((findDisplay 7300) displayCtrl 7302) ctrlEnable true;
			_timer ctrlSetStructuredText parseText "<t align='center'>你现在可以新的生活！</t>";
		};
		if (!oev_request_timer) then {
			((findDisplay 7300) displayCtrl 7302) ctrlEnable true;
			_timer ctrlSetStructuredText parseText "<t align='center'>你现在可以新的生活!</t>";
		};
		waitUntil {sleep 1; isNull (findDisplay 7300)};
		//Act as a loop if the dialog gets closed somehow
		_looped = true;
		if (isNull life_deathCamera) exitWith {false};
	};
};

[_unit] spawn{
	_unit = _this select 0;
	_vars = allVariables _unit;
	_pos = getPosATL _unit;
	while {true} do {
		uiSleep 1;
		if (player distance [8400,25250,0] > 500 || isNull (objectParent _unit)) exitWith {};

		waitUntil {uiSleep 1; _pos = getPosATL _unit; uiSleep 1; (_pos distance getPosATL _unit) < 10 || player distance [8400,25250,0] > 500 || isNull _unit};
		if !(isNull _unit) then {
			_vars = allVariables _unit;
			_pos = getPosATL _unit;
		};
		if (((!(isNull (objectParent _unit)) && getDammage (objectParent _unit) >= 1) || isNull _unit) && player distance [8400,25250,0] < 500) exitWith {
			[_unit,_vars,_pos] call OEC_fnc_fixDead;
		};
	};
};

if(!isNull _instigator && _instigator != _unit && isPlayer _instigator) then {
	["stat_kills"] remoteExec ["OEC_fnc_updateStat",_instigator];
	if (!(vehicle _instigator isEqualTo _instigator) && (typeOf (vehicle _instigator) isEqualTo "C_Plane_Civil_01_racing_F") && ((getPosATL _instigator select 2) > 10)) then {
		["plane_kills",1] remoteExec ["OEC_fnc_statArrUp",_instigator];
	};
};
oev_copDeathPay = false;
if(!isNull _instigator && {_instigator != _unit} && {side group _instigator != west} && {alive _instigator}) then {
	if(((_instigator getvariable ["isInEvent",["no"]]) select 0) == "no") then {
		if (playerside isEqualTo west) then {
			[getPlayerUID _instigator,_instigator getvariable ["realname",name _instigator],"53",_instigator] remoteExec ["OES_fnc_wantedAdd",2];
			["cop_kills",1]remoteExec["OEC_fnc_statArrUp",_instigator];

			if ((getPos _instigator) inPolygon oev_warzonePoly) then {
				[_instigator,_unit,1] remoteExec ["OES_fnc_copZoneKillPts",2];
				_instigator setVariable ["killStreak",(_instigator getVariable ["killStreak",0]) + 1, true];
			};
			if (_myPos inPolygon oev_warzonePoly && (__GETC__(life_coplevel) > 1)) then {
				oev_copDeathPay = true;
			};

			//if ((getPos _instigator) inPolygon oev_federalReservePoly) then {
			//	[[_instigator,_unit,2],"OES_fnc_copZoneKillPts",false,false] spawn OEC_fnc_MP;
			//};

			//if ((getPos _instigator) inPolygon oev_blackwaterPoly) then {
			//	[[_instigator,_unit,3],"OES_fnc_copZoneKillPts",false,false] spawn OEC_fnc_MP;
			//};
		} else {
			if (playerSide isEqualTo civilian) then {
				["civ_kills",1] remoteExec ["OEC_fnc_statArrUp",_instigator];
				if(_killDist >= 1000 && isNull objectParent _instigator && !(currentWeapon _instigator in ["launch_Titan_F","launch_RPG32_F","launch_I_Titan_F","launch_RPG7_F"])) then {
					["kills_1km",1] remoteExec ["OEC_fnc_statArrUp",_instigator];
				};
				if (_conqKill) then {
					// add to pot
					oev_conqDeath = ["cost"] call OEC_fnc_conquestClient;
					["deathPrice", true, oev_conqDeath] remoteExec ["OES_fnc_conquestServer", 2];
					//add to array of conquest kills/deaths (for payout at end)
					if (!(_unit getVariable["conquestDeath",false]) && !(isNull _unit)) then {
						oev_conquest_add_homie = [getPlayerUID _unit,(_unit getVariable["gang_data",[]]) select 0,_unit];
						publicVariableServer "oev_conquest_add_homie";
						_unit setVariable["conquestDeath",true,true];
					};
					if (!(_instigator getVariable["conquestDeath",false]) && !(isNull _instigator)) then {
						oev_conquest_add_homie = [getPlayerUID _instigator,(_instigator getVariable["gang_data",[]]) select 0,_unit];
						publicVariableServer "oev_conquest_add_homie";
						_instigator setVariable["conquestDeath",true,true];
					};
					["conq_kills",1] remoteExec ["OEC_fnc_statArrUp",_instigator];
					["conq_deaths",1] call OEC_fnc_statArrUp;
				};
			};
			player setVariable ["killStreak", 0, true];
			if (_conqKill) then {
				[getPlayerUID _instigator, _instigator getVariable ["realname", name _instigator], "63", _instigator] remoteExec ["OES_fnc_wantedAdd", 2];
				if (_warKill) then {
					_instigator setVariable ["killStreak",(_instigator getVariable ["killStreak",0]) + 1, true];
					[getPlayerUID _instigator,_instigatorGangID,getPlayerUID _unit,(oev_gang_data select 0),0,0,3,_instigator,_unit,3] remoteExec ["OES_fnc_warAwardPts", 2];
					[1] remoteExec ["OEC_fnc_clientWarkillIncrement", _instigator];
				} else {
          [getPlayerUID _instigator,_instigatorGangID,getPlayerUID _unit,(oev_gang_data select 0),0,0,2,_instigator,_unit,3] remoteExec ["OES_fnc_warAwardPts", 2];
				};
			} else {
				if (_warKill) then {
					[getPlayerUID _instigator, _instigator getVariable ["realname", name _instigator], "63", _instigator] remoteExec ["OES_fnc_wantedAdd", 2];
					private _myGS = [_myPrimary,_mySecondary,_myHandgun,_myUniform,_myVest,_myHeadgear] call OEC_fnc_calcGearScore;
					private _instigatorGS = [_instigatorPrimary,_instigatorSecondary,_instigatorHandgun,_instigatorUniform,_instigatorVest,_instigatorHeadgear] call OEC_fnc_calcGearScore;
					_instigator setVariable ["killStreak",(_instigator getVariable ["killStreak",0]) + 1, true];
					[getPlayerUID _instigator,_instigatorGangID,getPlayerUID _unit,(oev_gang_data select 0),_killDist,_instigatorGS,_myGS,_instigator,_unit,[1,0] select (_instigatorGangID in oev_gang_warAccptIDs)] remoteExec ["OES_fnc_warAwardPts", 2];
					[1] remoteExec ["OEC_fnc_clientWarkillIncrement", _instigator];
				} else {
					if (vehicle _instigator isKindOf "LandVehicle" || vehicle _instigator isKindOf "Air") then {
						[getPlayerUID _instigator, _instigator getVariable ["realname", name _instigator], "1", _instigator] remoteExec ["OES_fnc_wantedAdd", 2];
					} else {
						[getPlayerUID _instigator, _instigator getVariable ["realname", name _instigator], "2", _instigator] remoteExec ["OES_fnc_wantedAdd", 2];
					};
					if (_zoneKill) then {
						private _myGS = [_myPrimary,_mySecondary,_myHandgun,_myUniform,_myVest,_myHeadgear] call OEC_fnc_calcGearScore;
						private _instigatorGS = [_instigatorPrimary,_instigatorSecondary,_instigatorHandgun,_instigatorUniform,_instigatorVest,_instigatorHeadgear] call OEC_fnc_calcGearScore;
						_instigator setVariable ["killStreak",(_instigator getVariable ["killStreak",0]) + 1, true];
						[getPlayerUID _instigator,_instigatorGangID,getPlayerUID _unit,(oev_gang_data select 0),_killDist,_instigatorGS,_myGS,_instigator,_unit,2] remoteExec ["OES_fnc_warAwardPts", 2];
					};
				};
			};
		};
	};
};
// Hitman Contract checks
if(!isNull _instigator && ((player getVariable ["hitmanBounty",0]) > 0)) then {
	if (_instigator isEqualTo _unit) exitWith {};
	if (_instigator getVariable ["restrictions",false]) exitWith {};
	if (side group _instigator isEqualTo west) exitWith {};
	if ((group _instigator) isEqualTo (group player)) exitWith {};
	if ((_instigator getVariable "gang_data") select 0 == (oev_gang_data select 0)) exitWith {};
	// Passed checks, give the man a bounty
	[0,format["%1已在%3上领取$2的赏金。",name _instigator,[(player getVariable ["hitmanBounty",0])] call OEC_fnc_numberText, name player]] remoteExec ["OEC_fnc_broadcast",-2];
	[3,player] remoteExec ["OES_fnc_setGetHit",2];
	[7,(player getVariable ["hitmanBounty",0]),name player] remoteExec ["OEC_fnc_payPlayer",_instigator];
	[
		["event","Completed Hitman Contract"],
		["player",name _instigator],
		["player_id",getPlayerUID _instigator],
		["position",getPosATL _instigator],
		["target",name player],
		["target_id",getPlayerUID player],
		["target_position",getPosATL player],
		["dropped_cash",oev_cash],
		["distance",_killDist],
		["is_wz",_isWz],
		["hitman_bounty", [(player getVariable ["hitmanBounty",0])] call OEC_fnc_numberText]
	] call OEC_fnc_logIt;
};

if (side group _instigator isEqualTo west && {playerSide isEqualTo civilian} && {!isNull _instigator} && {!(_instigator isEqualTo _unit)}) then {
	oev_lastkiller = 1;
} else {
	if (side group _instigator isEqualTo civilian && {playerSide isEqualTo west} && {!isNull _instigator} && {!(_instigator isEqualTo _unit)}) then {
		oev_lastkiller = 1;
	} else {
		oev_lastkiller = 0;
	};
};

//Add to bank variables for moneybag spawn
[_unit] spawn{
	params [
		["_unit", objNull, [objNull]]
	];
	//Check if player is cop, within distance of bank and has not died near the bank while it was active
	if (playerSide isEqualTo west && _unit distance (getMarkerPos "bank_marker_1") < 900 && !oev_bankDeath) then {
		//If bank is active, track that he has died atleast once there and send it to server
		if((((altis_bank getVariable ["bankCooldown", 0]) >= serverTime) || ((altis_bank_1 getVariable ["bankCooldown", 0]) >= serverTime) || ((altis_bank_2 getVariable ["bankCooldown", 0]) >= serverTime) || ((altis_bank getVariable ["chargeplaced",false]) || (altis_bank_1 getVariable ["chargeplaced",false]) || (altis_bank_2 getVariable ["chargeplaced",false])))) then{
			oev_bankDeath = true;
			[] remoteExec ["OES_fnc_bankDeaths", 2];
			//Wait until bank is inactive and there is no cooldown left
			waitUntil {
	      uiSleep 5;
	      (((altis_bank getVariable ["bankCooldown", 0]) <= serverTime) && ((altis_bank_1 getVariable ["bankCooldown", 0]) <= serverTime) && ((altis_bank_2 getVariable ["bankCooldown", 0]) <= serverTime) &&
	      !((altis_bank getVariable ["chargeplaced",false]) || (altis_bank_1 getVariable ["chargeplaced",false]) || (altis_bank_2 getVariable ["chargeplaced",false])));
	    };
			oev_bankDeath = false;
		};
	};
};

[_unit] spawn{
	params [
		["_unit", objNull, [objNull]]
	];
	if !(playerSide isEqualTo independent) then {
		_handle = [_unit] spawn OEC_fnc_dropItems;
		waitUntil {scriptDone _handle};
	};

	oev_hunger = 100;
	oev_thirst = 100;
	oev_carryWeight = 0;
	oev_cash = 0;
	oev_cache_cash = oev_random_cash_val;

	[] call OEC_fnc_hudUpdate;
	private _alvl = __GETC__(life_adminlevel);
	[player,false,playerSide,_alvl,oev_streamerMode,life_gangChat] remoteExec ["OES_fnc_managesc",2];

	if(playerSide isEqualTo civilian) then {
		life_gear = ["U_C_Poloshirt_stripped","","","","",["ItemMap","ItemCompass","ItemWatch"],"","",[],[],[],[],[],[],[],[],[]];
		if(_unit getVariable["hasGPS", false]) then {
			life_gear = ["U_C_Poloshirt_stripped","","","","",["ItemMap","ItemCompass","ItemWatch","ItemGPS"],"","",[],[],[],[],[],[],[],[],[]];
		};
		oev_lastSynced_gear = format["%1",life_gear];
		life_ses_last_pos = [];
	} else {
		if(_unit getVariable["hasGPS", false]) then {
			_unit linkItem "ItemGPS";
		};
		private["_item","_value","_var"];
		{
			_item = _x;
			_value = missionNamespace getVariable _item;

			if(_value > 0) then {
				_var = [_item,1] call OEC_fnc_varHandle;
				missionNamespace setvariable [_x,0];
			};
		} foreach (oev_inv_items + ["oev_cash"]);
		oev_inventoryMonitor = oev_inventoryRandomVar;

		[0] call OEC_fnc_ClupdatePartial;
	};
};

[_unit] spawn{
	params [["_unit", objNull, [objNull]]];
	uiSleep 10;
	waitUntil {_unit getVariable ["infected",false] || (alive _unit && _unit distance2D [8479.78,25079.7,0] > 3000)};
	if (_unit getVariable ["infected",false]) exitWith {
		closeDialog 0;
		oev_respawned = true;
		if !(oev_inSpawnMenu) then {
			[] spawn OEC_fnc_spawnMenu;
		};
		hint "有人刺穿了您的臀部，并注入了致命的注射剂";
	};
};
[] spawn OEC_fnc_titleNotification;
