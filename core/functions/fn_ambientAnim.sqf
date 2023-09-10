//	Author: Jiri Wainar
//	Modified by: Poseidon, for use on Olympus Entertainment servers.
//	Description: Play set of ambient animations on given unit.

//	[_this,'STAND'] call OEC_fnc_ambientAnim;					- standing still, slightly turning to the sides, with rifle weapon
//	[_this,'STAND_IA'] call OEC_fnc_ambientAnim;				- standing still, slightly turning to the sides, with rifle weapon
//	[_this,'STAND_U1-3'] call OEC_fnc_ambientAnim;			- standing still, slightly turning to the sides, no weapon
//	[_this,'WATCH1-2'] call OEC_fnc_ambientAnim;				- standing and turning around, with rifle weapon
//	[_this,'GUARD'] call OEC_fnc_ambientAnim;					- standing still, like on guard with hands behing the body
//	[_this,'LISTEN_BRIEFING'] call OEC_fnc_ambientAnim; 		- standing still, hands behind back, recieving briefing / commands, no rifle.
//	[_this,'LEAN_ON_TABLE'] call OEC_fnc_ambientAnim;			- standing while leaning on the table
//	[_this,'LEAN'] call OEC_fnc_ambientAnim;					- standing while leaning (on wall)
//	[_this,'BRIEFING'] call OEC_fnc_ambientAnim;				- standing, playing ambient briefing loop with occasional random moves
//	[_this,'BRIEFING_POINT_LEFT'] call OEC_fnc_ambientAnim;	- contains 1 extra pointing animation, pointing left & high
//	[_this,'BRIEFING_POINT_RIGHT'] call OEC_fnc_ambientAnim;	- contains 1 extra pointing animation, pointing right & high
//	[_this,'BRIEFING_POINT_TABLE'] call OEC_fnc_ambientAnim;	- contains 1 extra pointing animation, pointing front & low, like at table
//	[_this,'SIT1-3'] call OEC_fnc_ambientAnim;				- sitting on chair or bench, with rifle weapon
//	[_this,'SIT_U1-3'] call OEC_fnc_ambientAnim;				- sitting on chair or bench, without weapon
//	[_this,'SIT_AT_TABLE'] call OEC_fnc_ambientAnim;			- sitting @ table, hands on table
//	[_this,'SIT_HIGH1-2'] call OEC_fnc_ambientAnim; 			- sitting on taller objects like a table or wall, legs not touching the ground. Needs a rifle!
//	[_this,'SIT_LOW'] call OEC_fnc_ambientAnim;				- sitting on the ground, with weapon.
//	[_this,'SIT_LOW_U'] call OEC_fnc_ambientAnim;				- sitting on the ground, without weapon.
//	[_this,'SIT_SAD1-2'] call OEC_fnc_ambientAnim;			- sitting on a chair, looking very sad.
//	[_this,'KNEEL'] call OEC_fnc_ambientAnim;					- kneeling, with weapon.
//	[_this,'PRONE_INJURED_U1-2'] call OEC_fnc_ambientAnim; 	- laying wounded, back on the ground, wothout weapon
//	[_this,'PRONE_INJURED'] call OEC_fnc_ambientAnim;			- laying wounded & still, back on the ground, with or without weapon
//	[_this,'KNEEL_TREAT'] call OEC_fnc_ambientAnim;			- kneeling while treating the wounded
//	[_this,'REPAIR_VEH_PRONE'] call OEC_fnc_ambientAnim;		- repairing vehicle while laying on the ground (under the vehicle)
//	[_this,'REPAIR_VEH_KNEEL'] call OEC_fnc_ambientAnim;		- repairing vehicle while kneeling (like changing a wheel)
//	[_this,'REPAIR_VEH_STAND'] call OEC_fnc_ambientAnim;		- repairing/cleaning a vehicle while standing

//	2: STRING - equipment level id, describing how heavily is the unit equipped.
//	   > "NONE"  		- no goggles, headgear, vest, weapon
//	   > "LIGHT"  		- no goggles, headgear, vest
//	   > "MEDIUM" 		- no goggles, headgear
//	   > "FULL"  		- no goggles
//	   > "ASIS"  		- no touches to the gear
//	   > "RANDOM" 		- gear is randomized according to the animation set
//	   > "GUN"			- default, gives random rifle
//	   > "NOGUN"		- remove any weapon they have

//do the immediate operations ----------------------------------------------------------------------
private["_unit","_animset","_gear","_anims","_anim","_linked","_xSet","_azimutFix","_interpolate","_canInterpolate","_attach","_fnc_log_disable"];
private["_attachOffset","_attachObj","_attachSpecsAuto","_attachSpecs","_attachSnap","_noBackpack","_noWeapon","_randomGear","_weapon","_forcedSnapPoint","_params","_weapons","_faces","_headgears","_wep"];
_fnc_log_disable = false;

_unit = param [0, objNull, [objNull]];
_animset = param [1, "STAND", [""]];
_gear = param [2, "GUN", [""]];
_forcedSnapPoint = param [3, objNull, [objNull]];
_interpolate = param [4, false, [true]];
_attach = param [5, true, [true]];

if (isNull _unit) exitWith {};
{_unit disableAI _x} forEach ["ANIM","AUTOTARGET","FSM","MOVE","TARGET"];

if ((_unit getVariable ["BIS_fnc_ambientAnim__animset",""]) != "") then {
	_unit call OEC_fnc_ambientAnim_terminate;
};

detach _unit;

_params = _animset call OEC_fnc_ambientAnim_getParams;
_anims		= _params select 0;
_azimutFix 	= _params select 1;
_attachSnap 	= _params select 2;
_attachOffset 	= _params select 3;
_noBackpack 	= _params select 4;
_noWeapon 	= _params select 5;
_randomGear 	= _params select 6;
_canInterpolate = _params select 7;

if (count _anims == 0) exitWith {};

if (_gear == "RANDOM") then {
	_gear = _randomGear call BIS_fnc_selectRandom;
};

[_unit,_gear,_noWeapon,_noBackpack] call {
	private["_unit","_gear","_noWeapon","_noBackpack"];
	_unit 		= _this select 0;
	_gear 		= _this select 1;
	_noWeapon 	= _this select 2;
	_noBackpack = true;

	switch (_gear) do {
		case "NONE": {
			removeGoggles _unit;
			removeHeadgear _unit;
			removeVest _unit;
			removeAllWeapons _unit;
			_noWeapon = true;
		};

		case "LIGHT": {
			removeGoggles _unit;
			removeHeadgear _unit;
			removeVest _unit;
		};

		case "MEDIUM": {
			removeGoggles _unit;
			removeHeadgear _unit;
		};

		case "FULL": {
			removeGoggles _unit;
		};

		case "COP": {
			if(primaryWeapon _unit == "") then {
				_weapons = ["arifle_MXM_Black_F","arifle_MX_Black_F","srifle_DMR_02_F","srifle_DMR_03_F","arifle_SPAR_02_blk_F","arifle_ARX_blk_F"];
				_unit addWeapon (_weapons select floor(random(count _weapons)));
				_unit addPrimaryWeaponItem "optic_Arco_blk_F";
			};
			_noBackpack = true;
		};

		case "MEDIC": {
			removeGoggles _unit;
			removeHeadgear _unit;
			removeVest _unit;
			removeBackpack _unit;
			removeAllWeapons _unit;
			_noBackpack = true;
			_noWeapon = true;
		};

		case "REBEL": {
			if(primaryWeapon _unit == "") then {
				_weapons = ["LMG_Mk200_F","srifle_EBR_F","arifle_Katiba_F","arifle_TRG20_F","srifle_DMR_06_olive_F"];
				_unit addWeapon (_weapons select floor(random(count _weapons)));
			};
			_noBackpack = true;
		};

		case "NOGUN": {
			_noWeapon = true;
		};

		default{};
	};

	if(_noBackpack) then{
		removeBackpack _unit;
	};

	if(_noWeapon) then{
		_unit removeWeapon (primaryWeapon _unit);
	};

	true;
};


_linked = _unit nearObjects ["man",5];
_linked = _linked - [_unit];

{
	_xSet = _x getVariable ["BIS_fnc_ambientAnim__animset",""];

	if (_xSet != _animset || _xSet == "") then {
		_linked set [_forEachIndex,objNull];
	}else{
		_xLinked = _x getVariable ["BIS_fnc_ambientAnim__linked",[]];

		if !(_unit in _xLinked) then {
			_xLinked pushBack _unit;
			_x setVariable ["BIS_fnc_ambientAnim__linked",_xLinked];
		};
	};
}forEach _linked; _linked = _linked - [objNull];

if(isNil "animAttachConfig") then {
	animAttachConfig = {
		switch (_this) do {
			case "SIT_AT_TABLE":{
				[
					["Land_CampingChair_V2_F",[0,0.08,-0.02],-180],
					["Land_ChairPlastic_F",[0,0.08,0.02],90],
					["Land_ChairWood_F",[0,0.02,-0.02],-180],
					["Land_RattanChair_01_F",[0,0.06,0.05],-180],
					["Land_OfficeChair_01_F",[0,-0.08,0.12],-180]
				];
			};
			case "SIT";
			case "SIT1";
			case "SIT2";
			case "SIT3";
			case "SIT_U1";
			case "SIT_U2";
			case "SIT_U3":{
				[
					["Land_CampingChair_V2_F",[0,0.08,0.05],-180],
					["Land_ChairPlastic_F",[0,0.08,0.05],90],
					["Land_ChairWood_F",[0,0.02,0.05],-180],
					["Land_RattanChair_01_F",[0,0.06,0.05],-180],
					["Land_OfficeChair_01_F",[0,-0.08,0.12],-180]
				];
			};

			case "SIT_SAD1":{
				[
					["Box_NATO_Wps_F",[0,-0.27,0.03],0]
				];
			};

			case "SIT_SAD2":{
				[
					["Box_NATO_Wps_F",[0,-0.3,0.05],0]
				];
			};

			case "SIT_HIGH1":{
				[
					["Box_NATO_Wps_F",[0,-0.23,0.03],0],
					["Land_CashDesk_F",[-0.365,0.1,0.375],180]
				];
			};

			case "SIT_HIGH";
			case "SIT_HIGH2": {
				[
					["Box_NATO_Wps_F",[0,-0.12,-0.20],0],
					["Land_PaperBox_open_full_F",[0.2,0.35,0.30],180]
				];
			};

			case "LEAN_ON_TABLE": {
				[
					["Land_CashDesk_F",[0.365,-0.55,0.2],180],
					["Land_WoodenTable_large_F",[0,-1,0.04],270]
				];
			};


			default {
				[];
			};
		};
	};
};

_attachSpecsAuto = _animset call animAttachConfig;

if ((count _attachSpecsAuto > 0) && !(_gear in ["NONE","LIGHT"])) then {
	private["_attachPoint","_attachGearFix","_vest"];

	_attachGearFix = 0.06;
	_vest = toLower (vest _unit);

	if (_vest in ["v_platecarrier1_rgr"]) then {
		_attachGearFix = _attachGearFix + 0.08;
	};

	{
		_attachPoint = _x select 1;
		_attachPoint set [1, (_attachPoint select 1) + _attachGearFix];
		_x set [1, _attachPoint];
	}forEach _attachSpecsAuto;
};

_attachSpecsAuto pushBack ["Sign_Pointer_Cyan_F",[0,0,_attachOffset],0];

if!(isNull _forcedSnapPoint) then {
	_attachObj = _forcedSnapPoint;
	_attachSpecs = [typeOf _forcedSnapPoint,[0,0,_attachOffset],0];

	{
		if ((_x select 0) == typeOf _forcedSnapPoint) exitWith {
			_attachSpecs = _x;
		};
	}forEach _attachSpecsAuto;
}else{
	_attachObj = _unit;

	private["_obj"];

	{
		_obj = nearestObject [_unit, _x select 0];

		if (([_obj,_unit] call BIS_fnc_distance2D) < _attachSnap) exitWith {
			_attachSpecs = _x;
			_attachObj = _obj;
		};
	}forEach _attachSpecsAuto;

	if(_attachObj == _unit) then {
		_azimutFix = 0;
		_attachOffset = 0;
		_attachSpecs = [typeOf _unit,[0,0,_attachOffset],0];
	};
};

_unit setVariable ["BIS_fnc_ambientAnim__linked",_linked];
_unit setVariable ["BIS_fnc_ambientAnim__anims",_anims];
_unit setVariable ["BIS_fnc_ambientAnim__animset",_animset];
_unit setVariable ["BIS_fnc_ambientAnim__interpolate",_interpolate && _canInterpolate];
_unit setVariable ["BIS_fnc_ambientAnim__time",0];

_attachObj disableCollisionWith _unit;
_unit disableCollisionWith _attachObj;

[_unit,_attachObj,_attachSpecs,_azimutFix,_attach] spawn{
	private["_unit","_attachObj","_attachSpecs","_azimutFix","_attach"];
	private["_attachPos","_logic","_ehAnimDone","_ehKilled"];

	_unit = _this select 0;
	_attachObj = _this select 1;
	_attachSpecs = _this select 2;
	_azimutFix = (_this select 3) + (_attachSpecs select 2);
	_attach = _this select 4;

	waitUntil{time > 0};

	if (isNil "_unit") exitWith {};
	if (isNull _unit) exitWith {};
	if !(alive _unit && canMove _unit) exitWith {};

	_attachPos = getPosASL _attachObj;
	_logic = "Logic" createVehicleLocal [_attachPos select 0,_attachPos select 1, _attachPos select 2];

	waitUntil{!isNull _logic};

	if(_unit in oev_animatedNpcs) then {
		_logic enableSimulation true;
	}else{
		_logic enableSimulation false;
	};

	_logic allowDamage false;
	_logic setPosASL _attachPos;
	_logic setDir ((getDir _attachObj) + _azimutFix);

	_unit setVariable ["BIS_fnc_ambientAnim__logic",_logic];

	if (_attach) then {
		_unit attachTo [_logic,_attachSpecs select 1];
		_unit setVariable ["BIS_fnc_ambientAnim__attached",true];
	};

	_unit call OEC_fnc_ambientAnim_playAnim;

	_ehAnimDone = _unit addEventHandler
	[
		"AnimDone",
		{
			private["_unit","_anim","_pool"];

			_unit = _this select 0;
			_anim = _this select 1;
			_pool = _unit getVariable ["BIS_fnc_ambientAnim__anims",[]];

			if(alive _unit) then{
				_unit call OEC_fnc_ambientAnim_playAnim;
			}else{
				_unit call OEC_fnc_ambientAnim_terminate;
			};
		}
	];

	_unit setVariable ["BIS_EhAnimDone", _ehAnimDone];
};