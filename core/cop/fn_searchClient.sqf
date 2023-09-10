//  File: fn_searchClient.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Searches the player and he returns information back to the player.
private["_inv","_val","_var","_robber","_weaponText","_backpack",
		"_uniformeItemsText","_primaryWeapon","_handgunWeapon","_vest","_headgear",
		"_bpText","_vestContentText","_unit","_displayName","_lastItem","_itemCount",
		"_secondaryWeapon","_cashAmountText"];
params [
	["_cop",objNull,[objNull]]
];
if(isNull _cop) exitWith {};

_inv = [];
_robber = false;
_unit = player;
_weaponText = "";
_bpText = "";
_vestContentText = "";
_backpack = "";
_uniformeItemsText = "";
_cashAmountText = "";
_lastItem = "";
_itemCount = 1;
_primaryWeapon = primaryWeapon _unit;
_handgunWeapon = handgunWeapon _unit;
_secondaryWeapon = secondaryWeapon _unit;
_vest = vest _unit;
_headgear = headgear _unit;

_weaponText = "";
{
	private ["_weapMagazine", "_weapAccessories"];
	if (_x != "") then {
		_displayName = switch (_x) do {
			case "SMG_01_ACO_F": { "Downing Vermin .45 ACP" };
			case "SMG_01_F": { "Lethal Vermin .45 ACP" };
			default {
				getText(configFile >> "CfgWeapons" >> _x >> "displayName")
			};
		};
		switch (_forEachIndex) do {
			case 0: {
				_weapMagazine = primaryWeaponMagazine _unit;
				_weapAccessories = primaryWeaponItems _unit;
			};
			case 1: {
				_weapMagazine = secondaryWeaponMagazine _unit;
				_weapAccessories = secondaryWeaponItems _unit;
			};
			default {
				_weapMagazine = handgunMagazine _unit;
				_weapAccessories = handgunItems _unit;
			};
		};
		_weaponText = format ["%1%2<br/>", _weaponText, _displayName];
		{
			private _magazineName = getText (configFile >> "CfgMagazines" >> _x >> "displayName");
			_weaponText = _weaponText + _magazineName + "<br/>";
		} forEach _weapMagazine;
	};
} forEach [
	_primaryWeapon,
	_secondaryWeapon,
	_handgunWeapon
];

if (_weaponText == "") then {
    _weaponText = "<t color='#FFFFFF'>No weapons found.</t><br/>";
} else {
	_weaponText = format ["<t color='#FFFFFF'>%1</t>", _weaponText];
};

if (backPack _unit != "") then {
    _backpack = backpackItems _unit;
    if (count _backpack > 0) then {
        {
            if (_lastItem != _x) then {
                _lastItem = _x;
                if (_bpText != "") then {
                    _bpText = format["%1 x%2</t><br/>",_bpText,_itemCount];
                };
                _itemCount = 1;
                if (isClass(configFile >> "CfgWeapons" >> _x)) then {
                    _displayName = getText(configFile >> "CfgWeapons" >> _x >> "displayName");
                    if (_x == "SMG_01_ACO_F") then {_displayName = "Downing Vermin .45 ACP"};
                    if (_x == "SMG_01_F") then {_displayName = "Lethal Vermin .45 ACP"};
                } else {
                    if (isClass(configFile >> "CfgMagazines" >> _x)) then {
                        _displayName = getText(configFile >> "CfgMagazines" >> _x >> "displayName");
                    } else {
                        if (isClass(configFile >> "CfgVehicles" >> "Vest_" + _x)) then {
                            _displayName = getText(configFile >> "CfgVehicles" >> "Vest_" + _x >> "displayName");
                        } else {
                            if (isClass(configFile >> "CfgVehicles" >> "Headgear_" + _x)) then {
                                _displayName = getText(configFile >> "CfgVehicles" >> "Headgear_" + _x >> "displayName");
                            } else {
                                _displayName = _x;
                            };
                        };
                    };
                };
                _bpText = format["<t color='#FFFFFF'>%1%2", _bpText, _displayName];
            } else {
                _itemCount = _itemCount + 1;
            };
        } forEach _backpack;
        _bpText = format["%1 x%2</t><br/>",_bpText,_itemCount];
    } else {
        _bpText = "No items in backpack.<br/>";
    };
} else {
    _bpText = "No backpack.<br/>";
};

_lastItem = "";
_itemCount = 1;

if (_vest != "") then {
    _vestItems = vestItems _unit;
    if (count _vestItems > 0) then {
        {
            if (_lastItem != _x) then {
                _lastItem = _x;
                if (_vestContentText != "") then {
                    _vestContentText = format["%1 x%2</t><br/>",_vestContentText,_itemCount];
                };
                _itemCount = 1;
                if (isClass(configFile >> "CfgWeapons" >> _x)) then {
                    _displayName = getText(configFile >> "CfgWeapons" >> _x >> "displayName");
                } else {
                    if (isClass(configFile >> "CfgMagazines" >> _x)) then {
                        _displayName = getText(configFile >> "CfgMagazines" >> _x >> "displayName");
                    } else {
                        if (isClass(configFile >> "CfgVehicles" >> "Vest_" + _x)) then {
                            _displayName = getText(configFile >> "CfgVehicles" >> "Vest_" + _x >> "displayName");
                        } else {
                            if (isClass(configFile >> "CfgVehicles" >> "Headgear_" + _x)) then {
                                _displayName = getText(configFile >> "CfgVehicles" >> "Headgear_" + _x >> "displayName");
                            } else {
                                _displayName = _x;
                            };
                        };
                    };
                };
                _vestContentText = format["<t color='#FFFFFF'>%1%2", _vestContentText, _displayName];
            } else {
                _itemCount = _itemCount + 1;
            };
        } forEach _vestItems;
        _vestContentText = format["%1 x%2</t><br/>",_vestContentText,_itemCount];
    } else {
        _vestContentText = "No items in vest. <br/>";
    };
} else {
    _vestContentText = "No vest.<br/>";
};

_lastItem = "";
_itemCount = 1;

if (uniform _unit != "") then {
    _uniformItems = uniformItems _unit;
    if (uniform _unit in oev_illegal_gear) then {
        _uniformItems pushBack uniform player;
    };
    if (count _uniformItems > 0) then {
        {
            if (_lastItem != _x) then {
                _lastItem = _x;
                if (_uniformeItemsText != "") then {
                    _uniformeItemsText = format["%1 x%2</t><br/>",_uniformeItemsText,_itemCount];
                };
                _itemCount = 1;
                if (isClass(configFile >> "CfgWeapons" >> _x)) then {
                    _displayName = getText(configFile >> "CfgWeapons" >> _x >> "displayName");
                } else {
                    if (isClass(configFile >> "CfgMagazines" >> _x)) then {
                        _displayName = getText(configFile >> "CfgMagazines" >> _x >> "displayName");
                    } else {
                         if (isClass(configFile >> "CfgVehicles" >> "Vest_" + _x)) then {
                            _displayName = getText(configFile >> "CfgVehicles" >> "Vest_" + _x >> "displayName");
                        } else {
                            if (isClass(configFile >> "CfgVehicles" >> "Headgear_" + _x)) then {
                                _displayName = getText(configFile >> "CfgVehicles" >> "Headgear_" + _x >> "displayName");
                            } else {
                                if (isClass(configFile >> "CfgVehicles" >> "Item_" + _x)) then {
                                    _displayName = getText(configFile >> "CfgVehicles" >> "Item_" + _x >> "displayName");
                                } else {
                                    _displayName = _x;
                                };
                            };
                        };
                    };
                };
                _uniformeItemsText = format["<t color='#FFFFFF'>%1%2", _uniformeItemsText, _displayName];
            } else {
                _itemCount = _itemCount + 1;
            };
        } forEach _uniformItems;
        _uniformeItemsText = format["%1 x%2</t><br/>",_uniformeItemsText,_itemCount];
    } else {
        _uniformeItemsText = "No items in uniform.<br/>";
    };
} else {
    _uniformeItemsText = "No uniform.<br/>";
};

//Illegal items
if(license_civ_vigilante) then {
{
	_var = [_x select 0,0] call OEC_fnc_varHandle;
	_val = missionNamespace getVariable _var;
	if(_val > 0) then
	{
		_inv pushBack [_x select 0,_val];
	};
} foreach oev_illegal_items - [oev_illegal_items select 1]; } else {

{
	_var = [_x select 0,0] call OEC_fnc_varHandle;
	_val = missionNamespace getVariable _var;
	if(_val > 0) then
	{
		_inv pushBack [_x select 0,_val];
	};
} foreach oev_illegal_items; };

if(!oev_use_atm) then
{
	oev_cash = 0;
	oev_cache_cash = oev_random_cash_val;
	_robber = true;
};

if (oev_cash > 0) then {
    _cashAmountText = format["$%1<br/>",[oev_cash] call OEC_fnc_numberText]
} else {
    _cashAmountText = "No cash on hand.<br/>";
};

[[player,_inv,_robber,_weaponText,_bpText,_vestContentText,_uniformeItemsText,_cashAmountText],"OEC_fnc_copSearch",_cop,false] spawn OEC_fnc_MP;
