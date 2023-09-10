//    File: fn_saveGear.sqf
//    Author: Bryan "Tonic" Boardwine
//    Full Gear/Y-Menu Save by Vampire
//    Edited: Itsyuka

//    Description:
//    Saves the players gear for syncing to the database for persistence..
private["_return","_uItems","_bItems","_vItems","_pItems","_hItems","_yItems","_uMags","_allMags","_bMags","_pMag","_hMag","_uni","_ves","_bag","_handled","_eFormatInv","_eFormatWeight","_shrt","_val","_itemWeight","_allMagsFormatted","_magArray","_index"];

if((player getVariable ["isInEvent",["no"]] select 0) != "no") exitWith {}; //Don't sync gear if in event
_return = [];
_return pushBack uniform player;
_return pushBack vest player;
_return pushBack backpack player;
_return pushBack goggles player;
_return pushBack headgear player;
_return pushBack assignedItems player;
if(playerSide isEqualTo west || playerSide isEqualTo civilian) then {
	_return pushBack primaryWeapon player;
  _return pushBack handgunWeapon player;
	_return pushBack secondaryWeapon player;
} else {
    if (playerSide isEqualTo independent) then {
        _return pushBack "";
        _return pushBack handgunWeapon player;
        _return pushBack "";
    } else {
        _return pushBack "";
        _return pushBack "";
        _return pushBack "";
    };
};

_uItems = [];
_bItems = [];
_vItems = [];
_allMags = [];
_pItems = [];
_hItems = [];
_yItems = [];
_hMag = [];
_pMag = [];
_uni = [];
_ves = [];
_bag = [];
_launch = "";

if(uniform player != "") then {
    {
        if !(_x in (magazines player)) then {
            _uItems pushBack _x;
        };
    } forEach (uniformItems player);
};

if(backpack player != "") then {
    {
        if !(_x in (magazines player)) then {
            _bItems pushBack _x;
        };
    } forEach (backpackItems player);
};

if(vest player != "") then {
    {
        if !(_x in (magazines player)) then {
            _vItems pushBack _x;
        };
    } forEach (vestItems player);
};


_allMagsFormatted = [];
for "_i" from 0 to ((count (magazinesAmmoFull player)) - 1) do {
	_allMags = [];
	{_allMags pushBack [(_x select 0), (_x select 1)];}foreach (magazinesAmmoFull player);

	_magArray = (_allMags select _i);
	_val = {_x isEqualTo _magArray} count _allMags;
	_magArray pushBack _val;
	_index = _allMagsFormatted find _magArray;

	if(_index == -1) then {
		_allMagsFormatted pushBack _magArray;
	};
};

if(count (primaryWeaponItems player) > 0) then {
    {
        _pItems pushBack _x;
    } forEach (primaryWeaponItems player);
};

if(count (handGunItems player) > 0) then {
    {
        _hItems pushBack _x;
    } forEach (handGunItems player);
};

_eFormatInv = [];
_eFormatWeight = 0;
{
	_shrt = [_x,1] call OEC_fnc_varHandle;
	_val = missionNameSpace getVariable _x;
	_itemWeight = ([_shrt] call OEC_fnc_itemWeight) * _val;
	if(_val > 0) then
	{
		_eFormatInv pushBack [_shrt,_val];
		_eFormatWeight = _eFormatWeight + _itemWeight;
	};
} forEach oev_inv_items;
_yItems = [_eFormatInv,_eFormatWeight];

_return pushBack _uItems;
_return pushBack _bItems;
_return pushBack _vItems;
_return pushBack _allMagsFormatted;
_return pushBack _pItems;
_return pushBack _hItems;
_return pushBack _yItems;

life_gear = _return;
if (_this select 0) then {[3] call OEC_fnc_ClupdatePartial;};
