#include "..\..\macro.h"
//  File: fn_actionKeyHandler.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Master action key handler, handles requests for picking up various items and
//	interacting with other players (Cops = Cop Menu for unrestrain,escort,stop escort, arrest (if near cop hq), etc).

private["_curTarget","_isWater","_inUse"];
_curTarget = cursorObject;
if(oev_action_inUse) exitWith {}; //Action is in use, exit to prevent spamming.
if(oev_interrupted) exitWith {oev_interrupted = false;};
_isWater = surfaceIsWater (getPosASL player);
_dir = getDir player;
_pos = eyePos player;
_pos2 = _pos vectorAdd (getCameraViewDirection player vectorMultiply 5);
_intersect = lineIntersectsSurfaces [_pos,_pos2, player];
_typeOfInt = "";
if !(_intersect isEqualTo []) then {
	_typeOfInt = typeOf ((_intersect select 0) select 2);
};

if((["atm_",str(cursorObject)] call BIS_fnc_inString) && {!dialog}) exitWith {
	[] call OEC_fnc_atmMenu;
};

if(!isNull oev_medic_placeable) exitWith {
	["Place"] spawn OEC_fnc_medicPlaceables;
};

private ["_dome","_rsb","_blackwaterDome","_trainingDome", "_trainingDummy"];
_dome = nearestObject [[16019.5,16952.9,0],"Land_Dome_Big_F"];
_rsb = nearestObject [[16019.5,16952.9,0],"Land_Research_house_V1_F"];
_blackwaterDome = nearestObject [[20898.6,19221.7,0.00143909],"Land_Dome_Big_F"];
_trainingDome = nearestObject [[17402.2,13235.8,0.0014677],"Land_Dome_Small_F"];
_trainingDummy = nearestObject [[17409.5,13234.7,0.00142574],"C_Soldier_VR_F"];

if(isNull _curTarget) exitWith {
	if(_isWater && (player distance getMarkerPos("frog_tanoa_1") > 300)) then {
		private["_fish"];
		_fish = (nearestObjects[getPos player,["Fish_Base_F"],3]) select 0;
		if(!isNil "_fish") then {
			[_fish] call OEC_fnc_catchFish;
		};
	} else {
		if(playerSide isEqualTo civilian && (oev_action_gathering < 1)) then {
			[] spawn OEC_fnc_newGather;
		};
	};
};

if(!alive _curTarget && _curTarget isKindOf "Animal" && ((typeOf _curTarget) != "Turtle_F")) exitWith {
	[_curTarget] call OEC_fnc_gutAnimal;
};

private _miscItems = ["Land_Suitcase_F","Land_RotorCoversBag_01_F"];
_nearObjects = nearestObjects [player, _miscItems,3];

if (typeOf _curTarget isEqualTo "Land_Shed_Ind_ruins_F" && {playerSide == civilian} && {_typeOfInt isEqualTo "Land_Shed_Ind_ruins_F"} && {eyePos player distance (_intersect select 0 select 0) < 5} && {(count _nearObjects) isEqualTo 0}) exitWith {
	[] spawn OEC_fnc_repairShed;
};

if(typeOf _curTarget isEqualTo "Land_i_Shed_Ind_F" && {_typeOfInt isEqualTo "Land_i_Shed_Ind_F"} && {eyePos player distance (_intersect select 0 select 0) < 5} && {playerSide != independent} && {((count _nearObjects) isEqualTo 0)}) exitWith {
	if (playerSide isEqualTo west) then {
		[_curTarget] call OEC_fnc_copGangBldgMenu;
	} else {
		if ((count oev_gang_data) > 0) then {
			[_curTarget] call OEC_fnc_gangBldgMenu;
		} else {
			hint "You have to be in a gang to purchase a gang building!";
	 	};
	};
};

if(_curTarget isKindOf "House_F" || (_dome == _curTarget || _rsb == _curTarget || _blackwaterDome == _curTarget || _trainingDome == _curTarget)) exitWith {
	//if (!(_curTarget getVariable ["inAH",false])) then {
	//	[_curTarget] call OEC_fnc_houseMenu;
	//} else {
	//	hint "Property in auction. Unable to load interaction menu.";
	//};
	if (player distance _curTarget > 35) exitWith {};
	if (playerSide isEqualTo west || playerSide isEqualTo independent) then {
		[_curTarget] call OEC_fnc_houseMenu;
	} else {
		if (((typeOf _curTarget) in oev_buyableHomes) && {(!(_curTarget getVariable ["restricted_house",false]))} && player distance2D _curTarget < 10) then {
			if((!(_curTarget in oev_vehicles) && !(getPlayerUID player in (_curTarget getVariable["keyPlayers",[]]))) || isNil {_curTarget getVariable "house_owner"}) then {
				[_curTarget] call OEC_fnc_availableHouse;
			} else {
				if (dialog) exitWith {};
				//[_curTarget] call OEC_fnc_houseMenu;
				if (playerSide isEqualTo civilian) then {
					[_curTarget] call OEC_fnc_houseV3Menu;
				} else {
					[_curTarget] call OEC_fnc_houseMenu;
				};
			};
		};
	};
};

if((typeOf _curTarget) == "Land_HumanSkeleton_F" && (!isNil {_curTarget getVariable ["playerid",nil]}) && (!isNil {_curTarget getVariable ["playername",nil]})) exitWith {
	[[_curTarget,player],"OES_fnc_jailCombatLogger",false,false] call OEC_fnc_MP;
	systemChat format ["You've sent %2(%1) to jail for combat logging!", _curTarget getVariable ["playerid",nil], _curTarget getVariable ["playername",nil]];
	[
		["event", "Sent CL to Jail"],
		["player", name player],
		["player_id",getPlayerUID player],
		["target",_curTarget getVariable ["playername",nil]],
		["target_id",_curTarget getVariable ["playerid",nil]],
		["position",getPosATL player]
	] call OEC_fnc_logIt
};




if(dialog) exitWith {}; //Don't bother when a dialog is open.
if(vehicle player != player) exitWith {}; //He's in a vehicle, cancel!
oev_action_inUse = true;

//Temp fail safe.
[] spawn{
	uiSleep 60;
	oev_action_inUse = false;
};

//Check if it's a dead body.
if(_curTarget isKindOf "Man" && !((typeOf _curTarget) == "Turtle_F") && {!alive _curTarget}) exitWith {
	if (playerSide isEqualTo independent) then {
		[_curTarget] call OEC_fnc_revivePlayer;
	} else {
		if (life_inv_dopeShot > 0 && _curTarget getVariable ["epiFailed", false]) then {
			if (oev_conquestData select 0 && getPos player inPolygon (oev_conquestData select 1 select 1)) exitWith {hint "You cannot use dopamine shots in conquest!";};
			[_curTarget] spawn OEC_fnc_dopeShot;
		} else {
			if (life_inv_epiPen > 0) then {
				[_curTarget] spawn OEC_fnc_epiPen;
			};
		};
	};
};

//If its the apd dummy then let the deputies LEARN!!!
if (!dialog && _curTarget == _trainingDummy && playerSide isEqualTo west && (player distance _curTarget < 6)) exitWith {
	[_curTarget] call OEC_fnc_copTrainingMenu;
};

if (playerSide isEqualTo west && {typeOf _curTarget isEqualTo "B_Slingload_01_Cargo_F"} && {player distance _curTarget < 7}) exitWith {
	[_curTarget] spawn OEC_fnc_clearBWCrate;
};

//If target is a player then check if we can use the cop menu.
if(isPlayer _curTarget && _curTarget isKindOf "Man" && (vehicle _curTarget isEqualTo _curTarget)) then {
	if(!dialog && playerSide isEqualTo west && (player distance _curTarget < 6)) then {
		[_curTarget] call OEC_fnc_copInteractionMenu;
	};

	if((!dialog && playerSide isEqualTo civilian && (player distance _curTarget < 4) && !(player getVariable["restrained",false]))) then {
		[_curTarget] call OEC_fnc_civInteractionMenu;
	};

	if(!dialog && playerSide isEqualTo independent && !(oev_newsTeam) && (player distance _curTarget < 4)) then {
		[_curTarget] call OEC_fnc_medicInteractionMenu;
	};
} else {
	//OK, it wasn't a player so what is it?
	private _isVehicle = if((_curTarget isKindOf "landVehicle") || (_curTarget isKindOf "Ship") || (_curTarget isKindOf "Air") || (vehicle _curTarget != _curTarget)) then {_curTarget = vehicle _curTarget; true} else {false};
	_animalTypes = ["Salema_F","Ornate_random_F","Mackerel_F","Tuna_F","Mullet_F","CatShark_F","Turtle_F"];

	//It's a vehicle! open the vehicle interaction key!
	if(_isVehicle) then {
		if(!dialog) then {
			if(player distance _curTarget < ((boundingBox _curTarget select 1) select 0) + 2) then {
				[_curTarget] call OEC_fnc_vInteractionMenu;
			};
		};
	} else {
		//Is it a animal type?
		if((typeOf _curTarget) in _animalTypes) then {
			if((typeOf _curTarget) == "Turtle_F" && !alive _curTarget) then {
				private["_handle"];
				_handle = [_curTarget] spawn OEC_fnc_catchTurtle;
				waitUntil {scriptDone _handle};
			} else {
				private["_handle"];
				_handle = [_curTarget] spawn OEC_fnc_catchFish;
				waitUntil {scriptDone _handle};
			};
		} else {
			_medicObjects = ["RoadBarrier_small_F","RoadCone_F","PortableHelipadLight_01_yellow_F"];
			if (playerSide != civilian && (typeOf _curTarget) in _medicObjects && _curTarget getVariable ["medicPlaced",false]) then {
					["Pickup",_curTarget] spawn OEC_fnc_medicPlaceables;
			} else {
				if(!dialog && !(isNull cursorObject) && (typeOf cursorObject) in _miscItems && player distance cursorObject < 3) then {
					_inUse = cursorObject getVariable["inUse",ObjNull];
					if ((_inUse isEqualTo ObjNull)) then {
						cursorObject setVariable ["inUse",player,true];
						[cursorObject] call OEC_fnc_setupPickupMenu;
					} else {
						if (getPlayerUID (cursorObject getVariable["inUse",ObjNull]) == "") then {
							cursorObject setVariable ["inUse",player,true];
							[cursorObject] call OEC_fnc_setupPickupMenu;
						};
					};
				};
			};
		};
	};
};
