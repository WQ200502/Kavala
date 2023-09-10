#include "..\..\macro.h"
//  File: fn_clothingFilter.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Functionality for filtering clothing types in the menu.
disableSerialization;
private["_control","_selection","_list","_filter"];
_control = _this select 0;
_selection = _this select 1;
oev_clothing_filter = _selection;
private _goalDis = 1;
//if (life_donation_active) then {_goalDis = 0.90;};
if((player getVariable ["restrained",false]) || (player getVariable["downed",false])) exitWith {systemChat "你不能在被击倒时进入服装店。"; closeDialog 0;};
if(player getVariable ["zipTied",false]) exitWith {systemChat "你不能在受到限制的情况下进入服装店。"; closeDialog 0;};

//0: clothing
//1: hats
//2: glasses
//3: vest
//4: backpack

switch(_selection) do {
	case 1: {
		life_shop_cam camSetTarget (player modelToWorld [0,0,1.7]);
		life_shop_cam camSetPos (player modelToWorld[0,2,1.7]);
		life_shop_cam camSetFOV .35;
		life_shop_cam camCommit 0;
	};
	case 2: {
		life_shop_cam camSetTarget (player modelToWorld [0,0,1.7]);
		life_shop_cam camSetPos (player modelToWorld[0,2,1.7]);
		life_shop_cam camSetFOV .35;
		life_shop_cam camCommit 0;
	};
	case 4: {
		life_shop_cam camSetTarget (player modelToWorld [0,0,1]);
		life_shop_cam camSetPos (player modelToWorld[-0.5,-1.9,1]);
		life_shop_cam camSetFOV .85;
		life_shop_cam camCommit 0;
	};
	default {
		life_shop_cam camSetTarget (player modelToWorld [0,0,1]);
		life_shop_cam camSetPos (player modelToWorld[-0.5,1.9,1]);
		life_shop_cam camSetFOV .85;
		life_shop_cam camCommit 0;
	};
};

if(isNull (findDisplay 3100)) exitWith {};
_list = (findDisplay 3100) displayCtrl 3101;
lbClear _filter;
lbClear _list;

//Temp code, subjected to become one master config in future
_clothes = switch (life_clothing_store) do {
	case "bruce": {[_selection] call OEC_fnc_clothing_bruce;};
	case "cop": {[_selection] call OEC_fnc_clothing_cop;};
	case "reb": {[_selection] call OEC_fnc_clothing_reb;};
	case "war": {[_selection] call OEC_fnc_clothing_war;};
	case "dive": {[_selection] call OEC_fnc_clothing_dive;};
	case "kart": {[_selection] call OEC_fnc_clothing_kart;};
	case "medic": {[_selection] call OEC_fnc_clothing_medic;};
	case "vig": {[_selection] call OEC_fnc_clothing_vig;};
	case "parachute": {[_selection] call OEC_fnc_clothing_parachute;};
	case "bwadmin": {[_selection] call OEC_fnc_clothing_admin;};
	case "news": {[_selection] call OEC_fnc_clothing_news;};
};

if(count _clothes == 0) exitWith {};

{
	_details = [_x select 0] call OEC_fnc_fetchCfgDetails;
	if(isNil {_x select 1}) then {
		_list lbAdd format["%1",(getText(configFile >> (_details select 6) >> (_x select 0) >> "DisplayName"))];
	} else {
		_list lbAdd format["%1", _x select 1];
	};
	_pic = getText(configFile >> (_details select 6) >> (_x select 0) >> "picture");
	_list lbSetData [(lbSize _list)-1,_x select 0];
	_list lbSetValue [(lbSize _list)-1,(((_x select 2) * __GETC__(life_medDis)) * _goalDis)];
	_list lbSetPicture [(lbSize _list)-1,_pic];
} forEach _clothes;
_clothes;
