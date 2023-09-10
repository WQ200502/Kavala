//  File: fn_onPutItem.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Opposite of onTakeItem.

params [
	["_unit",objNull,[objNull]],
	["_container",objNull,[objNull]],
	["_item","",[""]]
];
if(isNull _unit || _item isEqualTo "") exitWith {}; //Bad thingies?

if(_container isEqualTo player && ((player canAddItemToVest _item && player canAddItemToBackpack _item) || (player canAddItemToBackpack _item && player canAddItemToUniform _item) || (player canAddItemToUniform _item && player canAddItemToVest _item)) && vehicle player != player) then {
	_item spawn{
		waitUntil{isNull (findDisplay 602)};
		waitUntil{!isNull (findDisplay 602)};
		_vehicle = vehicle player;
		waitUntil{vehicle player == player};
		_logDupe = false;
		switch(true) do {
			case (_this in (weaponCargo _vehicle) && _this in (weaponCargo player)): {
				removeAllWeapons player;
				hint "An item duplication has been detected, and your weapons have been removed.";
				clearWeaponCargoGlobal _vehicle;
				_logDupe = true;
			};
			case (_this in (itemCargo _vehicle) && _this in (itemCargo player)): {
				removeAllItems player;
				hint "An item duplication has been detected, and some of your items have been removed.";
				clearItemCargoGlobal _vehicle;
				_logDupe = true;
			};
			case (_this in (magazineCargo _vehicle) && _this in (magazineCargo player)): {
				removeAllItemsWithMagazines player;
				hint "An item duplication has been detected, and your magazines have been removed.";
				clearMagazineCargoGlobal _vehicle;
				_logDupe = true;
			};
		};
		if(_logDupe) then {
			[
				["event","Vehicle Gear Dupe"],
				["player",name player],
				["player_id",getPlayerUID player],
				["item",_this],
				["position",getPosATL player]
			] call OEC_fnc_logIt;
		}
	};
};

if(_item in ["G_Blindfold_01_black_F","launch_I_Titan_short_F"]) exitWith {
	[_item,false,false,false,false] call OEC_fnc_handleItem;
};

if((playerSide != independent) && (_item in ["I_UAV_01_F","I_UavTerminal"])) exitWith {
	[_item,false,false,false,false] call OEC_fnc_handleItem;
};

private _nearContainers = 0;
private _nearObjects = getPos player nearEntities ["Thing",6];
{
	if((typeOf _x) isEqualTo "IG_supplyCrate_F") then {
		_nearContainers = _nearContainers + 1;
	};
} forEach _nearObjects;

if(typeof _container == "GroundWeaponHolder" && _nearContainers != 0) exitWith {
	// - [_item,true,false,false,false] call OEC_fnc_handleItem;
	deleteVehicle _container;
	hint "You cannot drop items near storage crates, this is to prevent exploiting. Your item has been deleted, no comp 4 u.";
};

if (typeOf _container == "GroundWeaponHolder" && {_nearContainers isEqualTo 0}) then {
	[[_container],"OES_fnc_droppedItemCleanupHandler",false,false] call OEC_fnc_MP;
};

[
	["event","Stored Physical Item"],
	["player",name player],
	["player_id",getPlayerUID player],
	["item",_item],
	["container",typeOf _container],
	["container_cargo",(getWeaponCargo _container + getItemCargo _container + getBackpackCargo _container + getMagazineCargo _container)],
	["position",getPosATL player]
] call OEC_fnc_logIt;
[false] call OEC_fnc_saveGear;
if !(oev_newsTeam) then {
	[3] call OEC_fnc_ClupdatePartial;
};
