#include "..\..\macro.h"
//  File: fn_onTakeItem.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Blocks the unit from taking something they should not have.

params [
	["_unit",objNull,[objNull]],
	["_container",objNull,[objNull]],
	["_item","",[""]]
];

if(isNull _unit || _item isEqualTo "") exitWith {}; //Bad thingies?

if (_item in itemCargo ((nearestObjects [player, ["LandVehicle","Air","Ship"], 5]) select 0) && (_item isEqualTo vest player || _item isEqualTo uniform player || _item isEqualTo backpack player)) then {
	_logDupe = false;
	switch(true) do {
		case (vest player isEqualTo _item && !(((nearestObjects [player, ["LandVehicle","Air","Ship"], 5]) select 0) canAdd vest player)): {
			removeVest player;
			hint "Your vest has been duplicated and thus has been removed. The other should still be in your vehicle.";
			_logDupe = true;
		};
		case (uniform player isEqualTo _item && !(((nearestObjects [player, ["LandVehicle","Air","Ship"], 5]) select 0) canAdd uniform player)): {
			removeUniform player;
			hint "Your uniform has been duplicated and thus has been removed. The other should still be in your vehicle.";
			_logDupe = true;
		};
		case (backpack player isEqualTo _item && !(((nearestObjects [player, ["LandVehicle","Air","Ship"], 5]) select 0) canAdd backpack player)): {
			removeBackpack player;
			hint "Your backpack has been duplicated and thus has been removed. The other should still be in your vehicle.";
			_logDupe = true;
		};
	};
	if(_logDupe) then {
		[
			["event","Full Vehicle Cargo Dupe"],
			["player",name player],
			["player_id",getPlayerUID player],
			["item",_item],
			["position",getPosATL player]
		] call OEC_fnc_logIt;
	}
};

if ((__GETC__(life_newslevel) >= 1) && (backpack player isEqualTo "B_AssaultPack_blk")) exitWith {
	backpackContainer player setObjectTextureGlobal [0,""];
};

if(_container isKindOf "Man" && !alive _container) exitWith {
	[_item,false,false,false,false] call OEC_fnc_handleItem;
};

if (_item in ['U_B_Soldier_VR','U_O_Soldier_VR','U_I_Soldier_VR'] && (__GETC__(oev_donator) < 1000)) exitWith {
	[_item,false,false,false,false] call OEC_fnc_handleItem;
	hint "The uniform you just attempted to take is for founders circle only and has been removed.";
};

if((playerSide != independent) && (_item in ["I_UAV_01_F","I_UavTerminal","Medikit"])) exitWith {
	[_item,false,false,false,false] call OEC_fnc_handleItem;
};

if(_item in ["B_UavTerminal","Laserdesignator","V_Press_F","H_Cap_press","G_Blindfold_01_black_F","launch_I_Titan_short_F"]) exitWith {
	[_item,false,false,false,false] call OEC_fnc_handleItem;
};

if((local _container) && (netid _container == "0:0")) exitWith {
	hint "You cannot pickup decorative items.";
};

[
	["event","Took Physical Item"],
	["player",name player],
	["player_id",getPlayerUID player],
	["item",_item],
	["container",typeOf _container],
	["container_cargo",(getWeaponCargo _container + getItemCargo _container + getBackpackCargo _container + getMagazineCargo _container)],
	["position",getPosATL player]
] call OEC_fnc_logIt;


_isPack = getNumber(configFile >> "CfgVehicles" >> _item >> "isBackpack");
_itemType = getNumber(configFile >> "CfgWeapons" >> _item >> "ItemInfo" >> "type");

if(_isPack isEqualTo 1) exitWith {
	[] spawn{
		private["_nearPlayers"];
		oev_action_inUse = true;

		sleep 1.5;

		_nearPlayers = player nearEntities ["Man",100];

		{
			if(isPlayer _x && _x != player && (backpack player != "") &&((backpackContainer _x) == (backpackContainer player))) exitWith {
				sleep 0.5;
				removeBackpack player;
				hint "The item you picked up was duplicated and has now been removed. This action has been logged.";
				// [[1,format["%1 Was caught attempting to exploit/dupe with %2. Shame on you two.",player getVariable["realname",name player], _x getVariable["realname",name _x]],false],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
				[
					["event","Backpack Exploit"],
					["player",name player],
					["player_id",getPlayerUID player],
					["with",name _x],
					["with_id",getPlayerUID _x],
					["position",getPosATL player]
				] call OEC_fnc_logIt;
			};
		}foreach _nearPlayers;

		[false] call OEC_fnc_saveGear;
		if !(oev_newsTeam) then {
			[3] call OEC_fnc_ClupdatePartial;
		};
		oev_action_inUse = false;
	};
};

if(_itemType isEqualTo 701) exitWith {
	[] spawn{
		private["_nearPlayers"];
		oev_action_inUse = true;

		sleep 1.5;

		_nearPlayers = player nearEntities ["Man",100];

		{
			if(isPlayer _x && _x != player && (vest player != "") &&((vestContainer _x) == (vestContainer player))) exitWith {
				sleep 0.5;
				removeVest player;
				hint "The item you picked up was duplicated and has now been removed. This action has been logged.";
				[[1,format["%1 Was caught attempting to exploit/dupe with %2. Shame on you two.",player getVariable["realname",name player], _x getVariable["realname",name _x]],false],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
				[
					["event","Vest Exploit"],
					["player",name player],
					["player_id",getPlayerUID player],
					["with",name _x],
					["with_id",getPlayerUID _x],
					["position",getPosATL player]
				] call OEC_fnc_logIt;
			};
		}foreach _nearPlayers;

		[false] call OEC_fnc_saveGear;
		if !(oev_newsTeam) then {
			[3] call OEC_fnc_ClupdatePartial;
		};
		oev_action_inUse = false;
	};
};

if(_itemType isEqualTo 801) exitWith {
	[] spawn{
		private["_nearPlayers"];
		oev_action_inUse = true;

		sleep 1.5;

		_nearPlayers = player nearEntities ["Man",100];

		{
			if(isPlayer _x && _x != player && (uniform player != "") &&((uniformContainer _x) == (uniformContainer player))) exitWith {
				sleep 0.5;
				removeUniform player;
				hint "The item you picked up was duplicated and has now been removed. This action has been logged.";
				// [[1,format["%1 Was caught attempting to exploit/dupe with %2. Shame on you two.",player getVariable["realname",name player], _x getVariable["realname",name _x]],false],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
				[
					["event","Uniform Exploit"],
					["player",name player],
					["player_id",getPlayerUID player],
					["with",name _x],
					["with_id",getPlayerUID _x],
					["position",getPosATL player]
				] call OEC_fnc_logIt;
			};
		}foreach _nearPlayers;

		[false] call OEC_fnc_saveGear;
		if !(oev_newsTeam) then {
			[3] call OEC_fnc_ClupdatePartial;
		};
		oev_action_inUse = false;
	};
};

[false] call OEC_fnc_saveGear;
if !(oev_newsTeam) then {
	[3] call OEC_fnc_ClupdatePartial;
};
