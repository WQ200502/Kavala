#include "..\..\macro.h"
//  File: fn_houseTakeItem.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Used in the vehicle trunk menu, takes the selected item and puts it in the players virtual inventory
//	if the player has room.
private["_trunkItemSelected","_quantity","_index","_data","_old","_value","_weight","_diff","_mods","_trunk","_itemClass","_marketplace","_illegalIndex","_fnc_updatePhysicalTrunk"];
disableSerialization;

// Lagswitch checks
if!(oev_didServerRespond) exitWith {hint "等待服务器响应，请稍候再试...";};

if(isNull oev_trunk_vehicle || !alive oev_trunk_vehicle) exitWith {hint localize "STR_MISC_VehDoesntExist"};
if(!alive player) exitwith {closeDialog 0;};
if((lbCurSel 4502) == -1) exitWith {hint localize "STR_Global_NoSelection";};

_fnc_updatePhysicalTrunk = {
	params ["_trunkObj", "_items"];
	private _weight = _items call OEC_fnc_physicalInventoryWeight;
	_trunkObj setVariable ["PhysicalTrunk", [_items, _weight], true];
};

//Get the handles
_trunkItemSelected = getSelData(4502);
_quantity = ctrlText 4505;



//guns with default attachments
_weaponWithAttachments = ["arifle_MX_SW_Black_F","arifle_MX_SW_khk_F","arifle_MX_SW_F","arifle_SPAR_02_blk_F","arifle_SPAR_02_khk_F","arifle_SPAR_02_snd_F","arifle_SPAR_03_blk_F","arifle_SPAR_03_khk_F","arifle_SPAR_03_snd_F","SMG_02_ACO_F"];

//A bunch of checks
if(_trunkItemSelected isEqualTo "") exitWith {hint localize "STR_Global_NoSelection";};
if(!([_quantity] call OEC_fnc_isNumeric)) exitWith {hint localize "STR_MISC_WrongNumFormat";};
_quantity = parseNumber(_quantity);
if ((_quantity isEqualTo 0) && (playerSide isEqualTo civilian)) exitWith {hint "您需要输入要接受的金额!";};
if((_quantity < 1) && (playerSide isEqualTo civilian)) exitWith {hint "您不能输入低于1的任何内容!";};

//Distance check
private _vehPos = getPos oev_trunk_vehicle;
private _playerPos = getPos player;
if (_vehPos distance _playerPos > 10) exitWith {hint "You are too far away!"; closeDialog 0;};

//Set the boolean for logging
oev_houseInteract = true;

if (oev_virtualItems) then {
	 //Getting the type of item
 	_itemClass = ([_trunkItemSelected] call BIS_fnc_itemType) select 1;
	_index = [_trunkItemSelected,((oev_trunk_vehicle getVariable "Trunk") select 0)] call OEC_fnc_index;

	_data = (oev_trunk_vehicle getVariable "Trunk") select 0;
	_old = oev_trunk_vehicle getVariable "Trunk";
	if(_index == -1) exitWith {};
	_value = _data select _index select 1;
	if((_quantity > _value) && (playerSide IsEqualTo civilian)) exitWith {hint localize "STR_MISC_NotEnough"};
	_quantity = [_trunkItemSelected,_quantity,oev_carryWeight,oev_maxWeight] call OEC_fnc_calWeightDiff;
	if(_quantity == 0 && (playerSide IsEqualTo civilian)) exitWith {hint localize "STR_NOTF_InvFull"};
	_weight = ([_trunkItemSelected] call OEC_fnc_itemWeight) * _quantity;
	if (playerSide isEqualTo west) then {
		//Get the price of the illegal item (if it is illegal)
		_illegalIndex = [_trunkItemSelected,oev_illegal_items] call OEC_fnc_index;
		if (_illegalIndex isEqualTo -1) exitWith {hint format["This is not an illegal item, no need to seize this!"];};
		_marketplace = (((oev_illegal_items) select _illegalIndex) select 1);
		//If it is illegal
		if(_marketplace != -1) then {
			//Remove all of the item from the house
			_data set[_index,-1];
			_data = _data - [-1];
			//Log it
			[
				["event","House Raid"],
				["player",name player],
				["player_id",getPlayerUID player],
				["seized",_trunkItemSelected],
				["location",getPosATL player]
			] call OEC_fnc_logIt;
			//Give the sAPD member all the cash
			oev_atmcash = oev_atmcash + (_value * _marketplace);
			oev_cache_atmcash = oev_cache_atmcash + (_value * _marketplace);
			//Title text notification
			titleText[format ["$%1 has been added to your bank account for an action performed by %2!",[(_marketplace * _value)] call OEC_fnc_numberText,name player],"PLAIN DOWN"];
			//Set that variable back on thehouse
			_newWeight = (_old select 1) - (([_trunkItemSelected] call OEC_fnc_itemWeight) * _value);
			if (_newWeight < 0) then {_newWeight = 0;};
			oev_trunk_vehicle setVariable["Trunk",[_data,_newWeight],true];
			[oev_trunk_vehicle] call OEC_fnc_houseInventory;
		} else {
			//Otherwise tell them to get their filthy hands off of it.
			hint format["This is not an illegal item, no need to seize this!"];
		};
	} else {
		if([true,_trunkItemSelected,_quantity] call OEC_fnc_handleInv) then {
			if(_quantity == _value) then {
				_data set[_index,-1];
				_data = _data - [-1];
			} else {
				_data set[_index,[_trunkItemSelected,(_value - _quantity)]];
			};
			_newWeight = (_old select 1) - _weight;
			if (_newWeight < 0) then {_newWeight = 0;};
			oev_trunk_vehicle setVariable["Trunk",[_data,_newWeight],true];
			[oev_trunk_vehicle] call OEC_fnc_houseInventory;
		} else {
			hint localize "STR_NOTF_InvFull";
		};
	};
} else {
	_trunk = (oev_trunk_vehicle getVariable ["PhysicalTrunk",[[],0]]);
	_data = _trunk select 0;
	_old = _trunk select 1;
	private _weight = getNumber (missionConfigFile >> "CfgWeights" >> (_trunkItemSelected)  >> "weight");
	 //Getting the type of item
	_itemClass = ([_trunkItemSelected] call BIS_fnc_itemType) select 1;
	private _maxValue = lbValue[4502,(lbCurSel 4502)];
	if (playerSide isEqualTo west) then {_quantity = 1;}; //Only need one iteration to wipe all the physical items selected for cop searches

	//Pilot helmet array (for NVG taking)
	private _pilotHelms = ["H_PilotHelmetFighter_B","H_PilotHelmetFighter_O","H_PilotHelmetFighter_I"];

	//Capping the loop
	if (_quantity > _maxValue) then {_quantity = _maxValue};

	//Function to adjust the inventory array
	private _fnc_adjustArray = {
		params ["_item","_array"];
		private _index = -1;
		{
			if !(_index isEqualTo -1) exitWith {};
			if (_item isEqualTo (_x select 0)) exitWith {_index = _forEachIndex;};
		} forEach _array;
		if (_index isEqualTo -1) exitWith {};
		if (((_array select _index) select 1) > 1) then {
			_array set [_index,[_item,((_array select _index) select 1) - 1]];
		} else {
			_array set [_index,-1];
		};
		_array = _array - [-1];
		_array;
	};
	for "_i" from 1 to _quantity do {
		switch(true) do {
			if (playerSide isEqualTo civilian) then {
				case(_trunkItemSelected isKindOf ["Rifle", configFile >> "CfgWeapons"]): {
					if ((primaryWeapon player) isEqualTo "") then {
						_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
						[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
					     player addWeapon _trunkItemSelected;
						if (_trunkItemSelected in _weaponWithAttachments) then {
							removeAllPrimaryWeaponItems player;
						};
					} else {
						if ((player canAdd _trunkItemSelected) && !(_trunkItemSelected in _weaponWithAttachments)) then {
							_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
							[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
							player addItem _trunkItemSelected;
						} else {
							if !(_trunkItemSelected in _weaponWithAttachments) then {
								hint "你没有足够的空间来放那个东西!";
							}else{
								hint "你手上应该没有什么东西来选择这武器"
							};
						};
					};
				};
				case(_trunkItemSelected isKindOf ["Launcher", configFile >> "CfgWeapons"]): {
					if ((secondaryWeapon player) isEqualTo "") then {
						_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
						[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
						player addWeapon _trunkItemSelected;
					} else {
						if (player canAdd _trunkItemSelected) then {
							_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
							[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
							player addItem _trunkItemSelected;
						} else {
							hint format["You don't have enough space to hold that item!"];
						};
					};
				};
				case(_trunkItemSelected isKindOf ["Pistol", configFile >> "CfgWeapons"]): {

					if ((handgunWeapon player) isEqualTo "") then {
						_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
						[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
						player addWeapon _trunkItemSelected;
					} else {
						if (player canAdd _trunkItemSelected) then {
							_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
							[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
							player addItem _trunkItemSelected;
						} else {
							hint format["你没有足够的空间来放那个东西!"];
						};
					};
				};
				case(_itemClass isEqualTo "Headgear"): {
					if ((headgear player) isEqualTo "") then {
						private _isNVG = false;
						if ((!((hmd player) isEqualTo "")) &&  (_trunkItemSelected in _pilotHelms)) then {
							_isNVG = true;
							if (player canAdd _trunkItemSelected) then {
								_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
								[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
								player addItem _trunkItemSelected;
							} else {
								hint format["你没有足够的空间来放那个东西!"];
							};
						};
						if (_isNVG) exitWith {};
						_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
						[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
						player addHeadgear _trunkItemSelected;
					} else {
						if (player canAdd _trunkItemSelected) then {
							_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
							[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
							player addItem _trunkItemSelected;
						} else {
							hint format["你没有足够的空间来放那个东西!"];
						};
					};
				};
				case(_itemClass isEqualTo "Glasses"): {
					if ((goggles player) isEqualTo "") then {
						_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
						[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
						player addGoggles _trunkItemSelected;
					} else {
						if (player canAdd _trunkItemSelected) then {
							_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
							[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
							player addItem _trunkItemSelected;
						} else {
							hint format["你没有足够的空间来放那个东西!"];
						};
					};
				};
				case(_itemClass isEqualTo "Vest"): {
					if ((vest player) isEqualTo "") then {
						_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
						[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
						player addVest _trunkItemSelected;
					} else {
						if (player canAdd _trunkItemSelected) then {
							_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
							[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
							player addItem _trunkItemSelected;
						} else {
							hint format["你没有足够的空间来放那个东西!"];
						};
					};
				};
				case(_itemClass isEqualTo "Backpack"): {
					if ((backpack player) isEqualTo "") then {
						_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
						[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
						player addBackpackGlobal _trunkItemSelected;
					} else {
						hint format["You must get rid of your current backpack first!"];
					};
				};
				case(_itemClass isEqualTo "Uniform"): {
					if ((uniform player) isEqualTo "") then {
						_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
						[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
						player addUniform _trunkItemSelected;
					} else {
						if (player canAdd _trunkItemSelected) then {
							_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
							[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
							player addItem _trunkItemSelected;
						} else {
							hint format["你没有足够的空间来放那个东西!"];
						};
					};
				};
				case(_itemClass isEqualTo "NVGoggles"): {
					if ((hmd player) isEqualTo "") then {
						private _isPilot = false;
						if ((headgear player) in _pilotHelms) then {
							_isPilot = true;
							if (player canAdd _trunkItemSelected) then {
								_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
								[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
								player addItem _trunkItemSelected;
							} else {
								hint format["你没有足够的空间来放那个东西!"];
							};
						};
						if (_isPilot) exitWith {};
						_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
						[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
						player addWeapon _trunkItemSelected;
					} else {
						if (player canAdd _trunkItemSelected) then {
							_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
							[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
							player addItem _trunkItemSelected;
						} else {
							hint format["你没有足够的空间来放那个东西!"];
						};
					};
				};
				default {
					//Check if it is a magazine and if the user is holstering a weapon with the same caliber and its unloaded -> load the gun
					private _magazineAdded = false;
					if !(primaryWeapon player isEqualTo "") then {
						//Check if the item is a magazine and can fit into the magazine slot of its respective weapon currently brandished by the player
						private _weaponMagazines = getArray(configFile >> "cfgWeapons" >> primaryWeapon player >> "Magazines");
						private _weaponItems = (primaryWeapon player) call BIS_fnc_compatibleItems;
						//If it matches the weapon magazine type and there is no magazine currently loaded
						if ((_trunkItemSelected in _weaponMagazines) && (count (primaryWeaponMagazine player) isEqualTo 0)) then {
							_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
							[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
							player addPrimaryWeaponItem _trunkItemSelected;
							_magazineAdded = true;
						} else {
							//If it is a weapon attachment that can be equipped on the gun
							private _canAttach = false;
							{
								if (_trunkItemSelected == _x) exitWith {
									_canAttach = true;
								};
							} forEach _weaponItems;
							if (_canAttach) then {
								//Which type?
								switch(true) do {
									//Optic
									case((["optic_",_trunkItemSelected] call BIS_fnc_inString) && (((primaryWeaponItems player) select 2) isEqualTo "")): {
										_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
										[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
										player addPrimaryWeaponItem _trunkItemSelected;
										_magazineAdded = true;
									};
									//Laser or flashlight
									case((["acc_",_trunkItemSelected] call BIS_fnc_inString) && (((primaryWeaponItems player) select 1) isEqualTo "")): {
										_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
										[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
										player addPrimaryWeaponItem _trunkItemSelected;
										_magazineAdded = true;
									};
									//Bipod
									case((["bipod_",_trunkItemSelected] call BIS_fnc_inString) && (((primaryWeaponItems player) select 3) isEqualTo "")): {
										_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
										[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
										player addPrimaryWeaponItem _trunkItemSelected;
										_magazineAdded = true;
									};
								};
							};
						};
					};
					if (!(secondaryWeapon player isEqualTo "") && !(_magazineAdded)) then {
						//Check if the item is a magazine and can fit into the magazine slot of its respective weapon currently brandished by the player
						private _weaponMagazines = getArray(configFile >> "cfgWeapons" >> secondaryWeapon player >> "Magazines");
						private _weaponItems = (secondaryWeapon player) call BIS_fnc_compatibleItems;
						//If it matches the weapon magazine type and there is no magazine currently loaded
						if (((_trunkItemSelected in _weaponMagazines) && (count (secondaryWeaponMagazine player) isEqualTo 0))) then {
							_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
							[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
							player addSecondaryWeaponItem _trunkItemSelected;
							_magazineAdded = true;
						} else {
							//If it is a weapon attachment that can be equipped on the gun
							private _canAttach = false;
							{
								if (_trunkItemSelected == _x) exitWith {
									_canAttach = true;
								};
							} forEach _weaponItems;
							if (_canAttach) then {
								//Which type?
								switch(true) do {
									//Optic
									case((["optic_",_trunkItemSelected] call BIS_fnc_inString) && (((secondaryWeaponItems player) select 2) isEqualTo "")): {
										_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
										[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
										player addSecondaryWeaponItem _trunkItemSelected;
										_magazineAdded = true;
									};
									//Laser or flashlight
									case((["acc_",_trunkItemSelected] call BIS_fnc_inString) && (((secondaryWeaponItems player) select 1) isEqualTo "")): {
										_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
										[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
										player addSecondaryWeaponItem _trunkItemSelected;
										_magazineAdded = true;
									};
									//Bipod
									case((["bipod_",_trunkItemSelected] call BIS_fnc_inString) && (((secondaryWeaponItems player) select 3) isEqualTo "")): {
										_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
										[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
										player addSecondaryWeaponItem _trunkItemSelected;
										_magazineAdded = true;
									};
								};
							};
						};
					};
					if (!(handgunWeapon player isEqualTo "") && !(_magazineAdded)) then {
						//Check if the item is a magazine and can fit into the magazine slot of its respective weapon currently brandished by the player
						private _weaponMagazines = getArray(configFile >> "cfgWeapons" >> handgunWeapon player >> "Magazines");
						private _weaponItems = (handgunWeapon player) call BIS_fnc_compatibleItems;
						//If it matches the weapon magazine type and there is no magazine currently loaded
						if (((_trunkItemSelected in _weaponMagazines) && (count (handgunMagazine player) isEqualTo 0))) then {
							_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
							[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
							player addhandgunItem _trunkItemSelected;
							_magazineAdded = true;
						} else {
							//If it is a weapon attachment that can be equipped on the gun
							private _canAttach = false;
							{
								if (_trunkItemSelected == _x) exitWith {
									_canAttach = true;
								};
							} forEach _weaponItems;
							if (_canAttach) then {
								//Which type?
								switch(true) do {
									//Optic
									case((["optic_",_trunkItemSelected] call BIS_fnc_inString) && (((handGunItems player) select 2) isEqualTo "")): {
										_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
										[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
										player addhandgunItem _trunkItemSelected;
										_magazineAdded = true;
									};
									//Laser or flashlight
									case((["acc_",_trunkItemSelected] call BIS_fnc_inString) && (((handGunItems player) select 1) isEqualTo "")): {
										_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
										[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
										player addhandgunItem _trunkItemSelected;
										_magazineAdded = true;
									};
									//Bipod
									case((["bipod_",_trunkItemSelected] call BIS_fnc_inString) && (((handGunItems player) select 3) isEqualTo "")): {
										_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
										[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
										player addhandgunItem _trunkItemSelected;
										_magazineAdded = true;
									};
								};
							};
						};
					};
					if !(_magazineAdded) then {
						if (player canAdd _trunkItemSelected) then {
							_data = [_trunkItemSelected,_data] call _fnc_adjustArray;
							[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
							player addItem _trunkItemSelected;

						} else {
							hint format["你没有足够的空间来放那个东西!"];
						};
					};
				};
			} else {
				private _itemCount = 1;
				_index = -1;
				{
					if !(_index isEqualTo -1) exitWith {};
					if (_trunkItemSelected isEqualTo (_x select 0)) exitWith {_index = _forEachIndex;_itemCount=(_x select 1);};
				} forEach _data;
				if (_index isEqualTo -1) exitWith {};
				_data set [_index,-1];
				_data = _data - [-1];
				[oev_trunk_vehicle, _data] call _fnc_updatePhysicalTrunk;
			};
		};
	};
	[oev_trunk_vehicle, false] call OEC_fnc_houseInventory;
};
