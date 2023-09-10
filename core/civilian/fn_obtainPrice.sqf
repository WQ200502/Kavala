//	File: fn_obtainPrice.sqf
//	Author: Fusah
//	Modifications: TheCmdrRex
//	Description: Obtains the price of the loadout

params [
	["_loadout",[],[[]]],
	["_shopType","",[""]]
];

private ["_priceArray","_clothConfig","_wpnConfig","_goalDis","_territory","_flagData","_flagObj","_price","_items","_discount","_perkTier"];

// _loadout select 0 = [Primary Weapon,Suppressor,LaserPointer,Scope,["LoadedMag", select  of rounds],[],"bipod"]
// _loadout select 1 = [Launcher,"","","",["LoadedRocket",1],[],"bipod"]
// _loadout select 2 = [Secondary Weapon,Suppressor,LaserPointer,Scope,["LoadedMag", select  of rounds],[],"bipod"]
// _loadout select 3 = [Uniform,[[Item1,amount],[Item2,amount],[mag1,amount, select of bullets]]]
// _loadout select 4 = [Vest,[[Item1,amount],[Item2,amount],[mag1,amount, select of bullets]]]
// _loadout select 5 = [Backpack,[[Item1,amount],[Item2,amount],[mag1,amount, select of bullets]]]
// _loadout select 6 = "Helmet"
// _loadout select 7 = "Glasses"
// _loadout select 8 = ["Rangefinder","","","",[],[],""],
// _loadout select 9 = ["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]
if (_shopType isEqualTo "") exitWith {hint "Invalid Shop Type";};

_priceArray = [];
// Auto Add Clothing
_clothConfig = switch (_shopType) do {
	case "rebel": {[7,true] call OEC_fnc_clothing_reb;};
	case "vigilante": {[7,true] call OEC_fnc_clothing_vig;};
	case "cop_basic": {[7,true] call OEC_fnc_clothing_cop;};
	case "med_basic": {[7,true] call OEC_fnc_clothing_medic;};
	default {""};
};

{
	_priceArray pushBack [([_x select 0] select 0),([_x select 2] select 0)];
} forEach _clothConfig;

// Auto Add Weapons
_wpnConfig = [_shopType] call OEC_fnc_weaponShopCfgAltis;
if(_wpnConfig isEqualType "") exitWith {hint _wpnConfig;};
// Find discounts and arms discounts
_goalDis = 1;
if (life_donation_active) then {_goalDis = 0.85;};
if (_shopType isEqualTo "rebel") then {
	_territory = "Arms";
	_flagObj = call compile format["%1_flag",_territory];
	if(isNil "_flagObj" || isNull _flagObj) exitWith {};
	_flagData = _flagObj getVariable ["capture_data",[]];
	if(count _flagData == 0) exitWith {};
	oev_armsCartel = [false,0,(_flagData select 0)];
	if(count oev_gang_data > 0) then {
		if(((_flagData select 0) == (oev_gang_data select 0)) && ((_flagData select 2) > 0)) then {
			_goalDis = _goalDis - 0.15;
			oev_armsCartel = [true,0,(_flagData select 0)];
		};
	};
};

// Add prices to all wpns and mags
{
	_priceArray pushBack [_x select 0,((_x select 2) * _goalDis)];
	{
		_priceArray pushBack [([_x select 0] select 0),((_x select 2) * _goalDis)];
	} forEach (_x select 3);
} forEach ([_wpnConfig select 1] select 0);


_price = 0;
_items = [];

// Parse through loadout, adding current items to new array

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

// Loop through items and add them to price
{
	_curItem = _x;
	{
		if ((_x select 0) isEqualTo _curItem) exitWith {
			_discount = 1;
			_perkTier = 0;
			// Add discount for perks
			if (_shopType isEqualTo "rebel") then {
				if (_curItem isKindOf ["Rifle", configFile >> "CfgWeapons"]) then {
					_perkTier = ["civ_kills"] call OEC_fnc_fetchStats;
					_discount = switch (_perkTier) do {
						case 1:{0.975};
						case 2:{0.95};
						case 3:{0.95};
						case 4:{0.95};
						case 5:{0.95};
						default {1};
					};
					_perkTier = ["civ_warKills"] call OEC_fnc_fetchStats;
					switch (_perkTier) do {
						case 1:{_discount = _discount - 0.02;};
						case 2:{_discount = _discount - 0.05;};
						case 3:{_discount = _discount - 0.10;};
						case 4:{_discount = _discount - 0.15;};
						case 5:{_discount = _discount - 0.15;};
						case 6:{_discount = _discount - 0.15;};
						default {_discount = _discount;};
					};
					if (_discount < 0.80) then {_discount = 0.80;}; // Cap at 80%
				};
			};
			if (_shopType isEqualTo "vigilante") then {
				_perkTier = ["civ_vigiArrests"] call OEC_fnc_fetchStats;
				_discount = switch (_perkTier) do {
					case 1:{0.95};
					case 2:{0.925};
					case 3:{0.9};
					default{1};
				};
			};
			if (_shopType isEqualTo "cop_basic") then {
				_perkTier = ["cop_pardons"] call OEC_fnc_fetchStats;
				_discount = switch (_perkTier) do {
					case 1:{0.97};
					case 2:{0.95};
					case 3:{0.93};
					case 4:{0.90};
					default {1};
				};
			};
			if ((2 - (_discount + _goalDis)) > (71 / 340)) then {
				_discount = (16 / 17);
			};
			_price = _price + round ((_x select 1) * _discount);
		};
	} forEach _priceArray;
} forEach _items;

if (_shopType isEqualTo "rebel") then {
	// Give Money to arms cartel
	if !(oev_armsCartel select 0) then {
		private _update = (oev_armsCartel select 1);
		_update = _update + (_price * 0.10);
		oev_armsCartel set [1,_update];
	};
	[[2,(oev_armsCartel select 2),player,(oev_armsCartel select 1),0,0,true],"OES_fnc_gangBank",false,false] spawn OEC_fnc_MP;
};
_price;