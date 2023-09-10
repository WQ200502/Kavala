#include "..\..\macro.h"
//  File: fn_medicPlaceables.sqf
//	Author: Ozadu
//	Description: Medic placables.

params[["_mode","",[""]]];

if (playerSide isEqualTo west && {oev_inCombat}) exitWith {};
if !(isNull objectParent player) exitWith {hint "You cannot use placeable objects from inside a vehicle!";};
if (_mode isEqualTo "") exitWith {};
if (playerSide isEqualTo civilian) exitWith {};
if (oev_newsTeam) exitWith {};
if (playerSide isEqualTo independent && call (life_medicLevel) < 2) exitWith {};
if (playerSide isEqualTo west && call (life_coplevel) < 2) exitWith {};

_objectTypes = ["Barrier","Cone","HelipadLight"];

if (playerSide isEqualTo west) then {
	[] spawn{
		while {!isNull oev_medic_placeable} do {
			uiSleep 0.2;
			if (oev_inCombat) then {
				deleteVehicle oev_medic_placeable;
				hint "Please do not use placeable objects while in combat";
			};
		};
	};
};

switch(_mode) do {
	case "Place":{
		if(isNull oev_medic_placeable) exitWith {};
		_collision = [oev_medic_placeable] call OEC_fnc_objectCollides;
		if(_collision) then {
			deleteVehicle oev_medic_placeable;
			hint "Object placement blocked.";
		}else{
			_objType = typeOf oev_medic_placeable;
			_objPos = getPosATL oev_medic_placeable;
			_objDir = getDir oev_medic_placeable;
			deleteVehicle oev_medic_placeable;
			[[player, _objType,_objPos,_objDir],"OES_fnc_spawnMedicPlaceable",false] call OEC_fnc_mp;
		};
		["life_medic_roadKit"] call OEC_fnc_createDialog;
	};
	case "Pickup":{
		_object = param[1,objNull,[objNull]];
		deleteVehicle _object;
	};
	case "":{
		//why tho?
	};
	default {
		if(!isNull oev_medic_placeable) exitWith {};
		if(!(_mode in _objectTypes)) exitWith {};

		private ["_objType","_offSet"];
		switch(_mode) do {
			case "Barrier":{
				_objType = "RoadBarrier_small_F";
				_offSet = [0,1.5,0.8];
			};
			case "Cone":{
				_objType = "RoadCone_F";
				_offSet = [0,1.5,0.3];
			};
			case "HelipadLight":{
				_objType = "PortableHelipadLight_01_yellow_F";
				_offSet = [0,1.5,0.3];
			};
		};
		_obj = _objType createVehicleLocal getPos player;
		_obj attachTo [player,_offSet];
		oev_medic_placeable = _obj;
	};
};