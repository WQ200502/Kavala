//  File: fn_validateGear.sqf
//	Author: Fusah
//	Modifications: TheCmdrRex
//	Description: Validates gear to make sure it is all buyable at the corresponding shop!

params [
	["_loadout",[],[[]]],
	["_shopType","",[""]]
];

private _exit = false;
private _ret = false;
private _loadout = getUnitLoadout [player,true];
if (_loadout isEqualTo "") exitWith {};
if (_shopType isEqualTo "") exitWith {hint "Invalid Shop Type";};

// _loadout select 0 = [Primary Weapon,Suppressor,LaserPointer,Scope,["LoadedMag", select  of rounds],[],"bipod"]
// _loadout select 1 = [Launcher,"","","",["LoadedRocket",1],[],"bipod"]
// _loadout select 2 = [Secondary Weapon,Suppressor,LaserPointer,Scope,["LoadedMag", select  of rounds],[],"bipod"]
// _loadout select 3 = [Uniform,[[Item1,amount],[Item2,amount],[mag1,amount, select of bullets]]]
// _loadout select 4 = [Vest,[[Item1,amount],[Item2,amount],[mag1,amount, select of bullets]]]
// _loadout select 5 = [Backpack,[[Item1,amount],[Item2,amount],[mag1,amount, select of bullets]]]
// _loadout select 6 = "Helmet"
// _loadout select 7 = "Glasses"
// _loadout select 8 = ["Rangefinder","","","",[],[],""]
// _loadout select 9 = ["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]

private _allowedGear = ['',[]];

// Auto Add Weapons and Mags
private _wpnConfig = [_shopType] call OEC_fnc_weaponShopCfgAltis;
if(_wpnConfig isEqualType "") exitWith {hint _wpnConfig;};
{
	_allowedGear pushBack (_x select 0);
	{
		_allowedGear pushBack ([_x select 0] select 0);
	} forEach (_x select 3);
} forEach ([_wpnConfig select 1] select 0);

private _clothConfig = [];

// Auto Add Clothing
_clothConfig = switch (_shopType) do {
	case "rebel": {[7,true] call OEC_fnc_clothing_reb;};
	case "vigilante": {[7,true] call OEC_fnc_clothing_vig;};
	case "cop_basic": {[7,true] call OEC_fnc_clothing_cop;};
	case "med_basic": {[7,true] call OEC_fnc_clothing_medic;};
	default {""};
};

{
	_allowedGear pushBack (_x select 0);
} forEach _clothConfig;

private _items = [];
{
	if (_x isEqualType []) then {
		{
			if (_x isEqualType []) then {
				{
					if (_x isEqualType []) then {
						_items pushBack (_x select 0);
					} else {
						if (typeName _x != "SCALAR") then {
							_items pushBack _x;
						};
					};
				} forEach _x;
			} else {
				_items pushBack _x;
			};
		} forEach _x;
	} else {
		_items pushBack _x;
	};
} forEach _loadout;

{
	if !(_x in _allowedGear) exitWith {systemChat format ["Invalid Gear: %1",(([_x] call OEC_fnc_fetchCfgDetails) select 1)];_exit = true;};
} forEach _items;

if (_exit) exitWith {_ret;};

_ret = true;
_ret;