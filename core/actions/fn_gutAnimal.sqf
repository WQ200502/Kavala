#include "..\..\macro.h"
//	Author: Bryan "Tonic" Boardwine
//  File: fn_gutAnimal.sqf
//	Description: Guts the animal?

private["_animalCorpse","_upp","_ui","_progress","_pgText","_cP","_displayName","_item"];
_animalCorpse = param [0,ObjNull,[ObjNull]];
if(isNull _animalCorpse) exitWith {}; //Object passed is null?

oev_interrupted = false;
if(!((typeOf _animalCorpse) in ["Hen_random_F","Cock_random_F","Goat_random_F","Sheep_random_F","Rabbit_F","Snake_random_F"])) exitWith {};
if(player distance _animalCorpse > 3.5) exitWith {};
oev_action_inUse = true;
switch(typeOf _animalCorpse) do {
	case "Hen_random_F": {_displayName = "Chicken"; _item = "hen_raw";};
	case "Cock_random_F": {_displayName = "Rooster"; _item = "rooster_raw";};
	case "Goat_random_F": {_displayName = "Goat"; _item = "goat_raw";};
	case "Sheep_random_F": {_displayName = "Sheep"; _item = "sheep_raw";};
	case "Rabbit_F": {_displayName = "Rabbit"; _item = "rabbit_raw";};
	case "Snake_random_F": {_displayName = "Snake"; _item = "snake_raw";};
	default {_displayName = ""; _item = "";};
};

if(_displayName == "") exitWith {oev_action_inUse = false;};

_upp = format["Gutting %1",_displayName];
//Setup our progress bar.
disableSerialization;
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNamespace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
_progress progressSetPosition 0.01;
_cP = 0.01;
["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;
while{true} do {
	uiSleep 0.15;
	_cP = _cP + 0.01;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
	if(_cP >= 1) exitWith {};
	if(!alive player) exitWith {};
	if(isNull _animalCorpse) exitWith {};
	if(player != vehicle player) exitWith {};
	if(oev_interrupted) exitWith {};
};

oev_action_inUse = false;
5 cutText ["","PLAIN DOWN"];
[] spawn OEC_fnc_handleAnim;
if(isNull _animalCorpse) exitWith {oev_action_inUse = false;};
if(oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false;};
if(player != vehicle player) exitWith {titleText[localize "STR_NOTF_RepairingInVehicle","PLAIN DOWN"];};

if(([true,_item,1] call OEC_fnc_handleInv)) then {
	deleteVehicle _animalCorpse;
	titleText [format["You have collected some raw %1 meat",_displayName],"PLAIN DOWN"];
} else {
	titleText ["Your inventory is full","PLAIN DOWN"];
};
