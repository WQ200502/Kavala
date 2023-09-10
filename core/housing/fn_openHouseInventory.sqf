#include "..\..\macro.h"
#include <interaction.h>
//  File: fn_openHouseInventory.sqf
//	Author: Tonic
//  Modified by: Kurt
//	Description: Building interaction menu with physical items
params [
	["_curTarget",objNull,[objNull]],
	["_isadmin",false,[false]]
];

//Is the trunk being accessed by another player (check if that player is online and atleast 100m near the house)
if (((_curTarget getVariable ["trunk_in_use",""]) != (getPlayerUID player)) && ([_curTarget getVariable ["trunk_in_use",""]] call OEC_fnc_isUIDActive) && ((_curTarget getVariable ["trunk_in_use",""]) != "")) exitWith {hint localize "STR_MISC_VehInvUse"};

//Broadcast who is using the trunk
_curTarget setVariable["trunk_in_use",(getPlayerUID player),true];

//Bunch of checks
if (animationState player in ["ainvpknlmstpslaywrfldnon_medic","ainvpknlmstpslaywnondnon_medic","ainvppnemstpslaywrfldnon_medic","amovpercmstpsnonwnondnon_amovpknlmstpsnonwnondnon","ainvpknlmstpslaywnondnon_medicin"]) exitWith {hint "Wait until you're done healing..."};
if (oev_is_processing) exitWith {hint "You cannot access trunk inventory while processing."};
if (_curTarget getVariable ["trunkLocked",false]) exitWith {hint "Inventory is being saved, you cannot access it.";};
private _isShed = if (typeOf _curTarget isEqualTo "Land_i_Shed_Ind_F") then {true} else {false};
if(isNull _curTarget) exitWith {}; //Bad target
if(oev_newsTeam) exitWith {hint "You cannot perform this action while acting as News Team!";};

oev_trunk_vehicle = _curTarget;

//Is an admin accessing?
private _exit = false;
if (_isadmin && ((call life_adminlevel) >= 3)) then {
	private _wording = if (typeOf _curTarget isEqualTo "Land_i_Shed_Ind_F") then {"shed"} else {"house"};
	private _action = [
		format ["Are you sure you want to force yourself into the inventory of this %1? This feature is intended for compensation purposes. Misuse of this feature will result in administrative action.",_wording],
		"Confirmation",
		"Yes",
		"No"
	] call BIS_fnc_guiMessage;

	waitUntil {!isNil "_action"};
	if (_action) then {
		_bldg = ["House","house_id",_curTarget getVariable ["house_id","<null>"],"owner_id",((_curTarget getVariable ["house_owner","<null>"]) select 0)];
		if (_isShed) then {
			_bldg = ["Shed","shed_id",_curTarget getVariable["bldg_id",-1],"gang_id",_curTarget getVariable ["bldg_gangId","<null>"]];
		};
		[
			["event",format["Admin Force %1", _bldg select 0]],
			["player",name player],
			["player_id",getPlayerUID player],
			[_bldg select 1,_bldg select 2],
			[_bldg select 3,_bldg select 4],
			["location",getPosATL player]
		] call OEC_fnc_logIt;
		oev_adminForce = true;
	} else {
		_exit = true;
		oev_adminForce = false;
		_curTarget setVariable ["trunk_in_use",nil,true];
	};
};
if (_exit) exitWith {};

//Internet check to make sure no lagswitch
oev_didServerRespond = false;
[[player],"OES_fnc_internetCheck",false,false] spawn OEC_fnc_MP;
private _maxDelayTime = time + 5;
waitUntil{time > _maxDelayTime || oev_didServerRespond};
if(time > _maxDelayTime) exitWith {hint "Access to inventory failed, try again."; oev_adminForce = false;};

//Create the dialog
if(!dialog) then {
	["TrunkPhysicalMenu"] call OEC_fnc_createDialog;
};
disableSerialization;

//fixes exploit for multiple people opening the trunk
[_curTarget] spawn{
//fixes exploit where multiple players try to open trunk at same time to dupe items.
	_vehicle = (_this select 0);
	while {!(isNull (findDisplay 4500))} do {
		uiSleep 0.25;
		if(isNull _vehicle) exitWith {while{dialog} do {closeDialog 0; };};
		if(((_vehicle getVariable ["trunk_in_use",""]) != (getPlayerUID player) && (_vehicle getVariable ["trunk_in_use",""]) != "")) exitWith {hint "Someone else has somehow opened the trunk, only one player may use the trunk at a time."; while{dialog} do {closeDialog 0;}; _vehicle setVariable["trunk_in_use","",true];oev_adminForce = false;};
		if((_vehicle getVariable ["trunk_in_use",""]) == "") exitWith {while{dialog} do {closeDialog 0;}; _vehicle setVariable["trunk_in_use","",true];oev_adminForce = false;};
		if(_vehicle getVariable["trunkLocked",false]) exitWith {while{dialog} do {closeDialog 0;}; _vehicle setVariable["trunk_in_use","",true]; hint "Inventory is being saved, you cannot access it.";oev_adminForce = false;};
		if(player getVariable ["restrained",false]) exitWith {while{dialog} do {closeDialog 0;}; _vehicle setVariable["trunk_in_use","",true];oev_adminForce = false;};
		if(player getVariable ["downed",false]) exitWith {while{dialog} do {closeDialog 0;}; _vehicle setVariable["trunk_in_use","",true];oev_adminForce = false;};
		if !(isNull(findDisplay 49)) exitWith {closeDialog 0;oev_adminForce = false;};
		//if (isNil "serverStartTime" || isNil "serverCycleLength") exitWith {while{dialog} do {closeDialog 0;}; _vehicle setVariable["trunk_in_use","",true];oev_adminForce = false;};
		if !(isNil "serverCycleLength") then {
			if ((round((serverCycleLength - (time - serverStartTime)) / 60)) < 4) exitWith {while{dialog} do {closeDialog 0;}; _vehicle setVariable["trunk_in_use","",true]; hint "Inventory is being saved, you cannot access it.";oev_adminForce = false;};
		};
	};
};

oev_virtualItems = true;

((findDisplay 4500) displayCtrl 4518) ctrlSetText "切换到物理库存"; //Initialize switch text

//Logging inventory
life_pInact_curTarget = _curTarget;
get_inv = {
	private _array = [];
	{
		private _str = [_x,1] call OEC_fnc_varHandle;
		private _val = missionNameSpace getVariable _x;
		if(_val > 0) then{
			_array pushBack [_str,_val];
		};
	} forEach oev_inv_items;
	_array;
};
if !(_isShed) then {
	[
		["event","Opened House Trunk"],
		["player",name player],
		["player_id",getPlayerUID player],
		["owner_id",((_curTarget getVariable ["house_owner","<null>"]) select 0)],
		["house_id",life_pInact_curTarget getVariable["house_id",-1]],
		["physical",(_curTarget getvariable["PhysicalTrunk",[[],0]]) select 0],
		["virtual",(_curTarget getvariable["Trunk",[[],0]]) select 0]
	] call OEC_fnc_logIt;
} else {
	[
		["event","Opened Shed Trunk"],
		["player",name player],
		["player_id",getPlayerUID player],
		["gang",_curTarget getVariable ["bldg_gangName","<null>"]],
		["gang_id",_curTarget getVariable ["bldg_gangId","<null>"]],
		["shed_id",life_pInact_curTarget getVariable["bldg_id",-1]],
		["physical",(_curTarget getvariable["PhysicalTrunk",[[],0]]) select 0],
		["virtual",(_curTarget getvariable["Trunk",[[],0]]) select 0]
	] call OEC_fnc_logIt;
};

//Switch buttons depending on whether or not a cop is searching
if (playerSide isEqualTo west) then {
	((findDisplay 4500) displayCtrl 4507) ctrlSetText "占领";
	((findDisplay 4500) displayCtrl 4507)  ctrlShow true;
	((findDisplay 4500) displayCtrl 4508)  ctrlShow false;
	((findDisplay 4500) displayCtrl 4505)  ctrlShow false;
	((findDisplay 4500) displayCtrl 4506)  ctrlShow false;
	((findDisplay 4500) displayCtrl 4519)  ctrlShow false;
	((findDisplay 4500) displayCtrl 4520)  ctrlShow false;
} else {
	((findDisplay 4500) displayCtrl 4507)  ctrlSetText "拿取";
	((findDisplay 4500) displayCtrl 4507)  ctrlShow true;
	((findDisplay 4500) displayCtrl 4508)  ctrlShow true;
	((findDisplay 4500) displayCtrl 4519)  ctrlShow true;
	((findDisplay 4500) displayCtrl 4520)  ctrlShow true;
};
if (playerSide isEqualTo civilian) then {
	if (_isShed && !_isadmin) then {
		if (!(_curTarget getVariable ["locked",false]) || (playerSide isEqualTo west) || ((_curTarget getVariable ["bldg_owner",""]) isEqualTo (getPlayerUID player)) || ((oev_gang_data select 2) >= 1)) then { //If not locked, or is owner, or is gang rank 3 or higher, or is cop
			((findDisplay 4500) displayCtrl 4518) ctrlEnable true;
		} else {
			((findDisplay 4500) displayCtrl 4518) ctrlEnable false;
		};
	} else {
		if (!(_curTarget getVariable ["locked",false]) || ((getPlayerUID player) in (_curTarget getVariable ["keyPlayers",[""]])) || (((_curTarget getVariable ["house_owner",[""]]) select 0) isEqualTo (getPlayerUID player)) || (playerSide isEqualTo west)) then { //If not locked, or is owner, or is cop
			((findDisplay 4500) displayCtrl 4518) ctrlEnable true;
		} else {
			((findDisplay 4500) displayCtrl 4518) ctrlEnable false;
		};
	};

	if ((call life_adminlevel) >= 3 && _isadmin) then {
		((findDisplay 4500) displayCtrl 4518) ctrlEnable true;
	};
};
oev_virtualItems = true;

//Set up UI variables
private _vehdata = [0,0];
if !(_isShed) then {
	ctrlSetText[4501,format["House Storage - %1",_curTarget getVariable ["house_id",-1]]];
	if (oev_virtualItems) then {
		_vehdata = [(_curTarget getVariable["storageCapacity",100]),(_curTarget getVariable["Trunk",[[],0]]) select 1];
	} else {
		_vehdata = [(_curTarget getVariable["physicalStorageCapacity",100]),(_curTarget getVariable["PhysicalTrunk",[[],0]]) select 1];
	};
} else {
	ctrlSetText[4501,format["Gang Storage - %1",_curTarget getVariable ["bldg_id",-1]]];
	if (oev_virtualItems) then {
		_vehdata = [(_curTarget getVariable["storageCapacity",1000]),(_curTarget getVariable["Trunk",[[],0]]) select 1];
	} else {
		_vehdata = [(_curTarget getVariable["physicalStorageCapacity",200]),(_curTarget getVariable["PhysicalTrunk",[[],0]]) select 1];
	};
};

//Only allow one person to access at a time
if(_vehdata select 0 == -1 && {!(_curTarget isKindOf "House_F")}) exitWith {closeDialog 0; _curTarget setVariable["trunk_in_use","",true]; hint localize "STR_MISC_NoStorageVeh";oev_adminForce = false;};

ctrlSetText[4504,format[(localize "STR_MISC_Weight")+ " %1/%2",_vehdata select 1,_vehdata select 0]];

//Set up the house inventory
if !(oev_adminForce) then {
	[_curTarget,true] call OEC_fnc_houseInventory;
} else {
	[_curTarget,true] call OEC_fnc_adminHouseInv;
};

if (currentWeapon player == "Binocular" || currentWeapon player == "Rangefinder") then {
	life_curWep_h = currentWeapon player;
	player action ["SwitchWeapon", player, player, 100];
	uiSleep 1;
	player switchCamera cameraView;
	player playActionNow "Gear";
} else {
	player playActionNow "Gear";
};

//On dialog close
if !(_isShed) then {
	(findDisplay 4500) displayAddEventHandler ["unload", "player switchMove '';if (oev_houseInteract) then {[true] call OEC_fnc_saveGear;[[""event"",""House Inventory Updated""],[""player"",name player],[""player_id"",getPlayerUID player],[""house_id"",life_pInact_curTarget getVariable[""house_id"",-1]],[""owner"",oev_trunk_vehicle getVariable[""house_owner"",[""No pid var"",""No name var""]] select 1],[""owner_id"",oev_trunk_vehicle getVariable[""house_owner"",[""No pid var"",""No name var""]] select 0],[""new_house_virtual"",life_pInact_curTarget getVariable[""Trunk"",[[],0]] select 0],[""new_house_physical"",life_pInact_curTarget getVariable[""PhysicalTrunk"",[[],0]] select 0],[""new_player_virtual"",[] call get_inv],[""new_player_physical"",getUnitLoadout player]] call OEC_fnc_logIt;oev_houseInteract = false;}; if (oev_movedHouseItem) then {oev_trunk_vehicle setVariable [""Trunk"",(oev_trunk_vehicle getVariable ""Trunk""),true]; oev_trunk_vehicle setVariable [""PhysicalTrunk"",(oev_trunk_vehicle getVariable ""PhysicalTrunk""),true];oev_movedHouseItem = false;}; oev_trunk_vehicle setVariable[""trunk_in_use"","""",true];if(oev_trunk_vehicle isKindOf ""House_F"") then { [[oev_trunk_vehicle],""OES_fnc_updateHouseTrunk"",false,false] spawn OEC_fnc_MP;};oev_adminForce = false;player setVariable [""inHouseInventory"",[false, 0],true];"];
} else {
	(findDisplay 4500) displayAddEventHandler ["unload", "player switchMove '';if (oev_houseInteract) then {[true] call OEC_fnc_saveGear;[[""event"",""Shed Inventory Updated""],[""player"",name player],[""player_id"",getPlayerUID player],[""shed_id"",life_pInact_curTarget getVariable[""bldg_id"",-1]],[""owner_id"",oev_trunk_vehicle getVariable[""bldg_owner"",""No pid set""]],[""gang_id"",oev_trunk_vehicle getVariable[""bldg_gangid"",""No gangid set""]],[""new_shed_virtual"",life_pInact_curTarget getVariable[""Trunk"",[[],0]] select 0],[""new_shed_physical"",life_pInact_curTarget getVariable[""PhysicalTrunk"",[[],0]] select 0],[""new_player_virtual"",[] call get_inv],[""new_player_physical"",getUnitLoadout player],[[] call get_inv,getUnitLoadout player]] call OEC_fnc_logIt;oev_houseInteract = false;}; if (oev_movedHouseItem) then {oev_trunk_vehicle setVariable [""Trunk"",(oev_trunk_vehicle getVariable ""Trunk""),true]; oev_trunk_vehicle setVariable [""PhysicalTrunk"",(oev_trunk_vehicle getVariable ""PhysicalTrunk""),true];oev_movedHouseItem = false;}; oev_trunk_vehicle setVariable[""trunk_in_use"","""",true];if(oev_trunk_vehicle isKindOf ""Land_i_Shed_Ind_F"") then { [[oev_trunk_vehicle],""OES_fnc_updateGangTrunk"",false,false] spawn OEC_fnc_MP;};oev_adminForce = false;player setVariable [""inHouseInventory"",[false, 0],true];"];
};
