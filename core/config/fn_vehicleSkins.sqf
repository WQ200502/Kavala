#include "..\..\macro.h"
//	Description: Master config for all vehicle information, this will create a simpler system for fetching vehicle skins, prices, availability, etc.

private["_side","_slotName","_skinsArray","_vehicleArray","_return","_copLevel","_medicLevel","_donatorLevel","_adminLevel","_gang_data"];
params [
	["_mode","",[""]],
	["_vehicle","",[""]]
];
_texList = [];
switch (_mode) do {
    case "access": {
			_sup = if (__GETC__(life_supportlevel) > 0) then {true} else {false};
			_texStaff = if (__GETC__(oev_designerlevel) >= 2) then {true} else {false};
			_vigi = if (oev_vigiarrests > 0) then {true} else {false};
			_civCou = if (__GETC__(oev_civcouncil) > 0) then {true} else {false};
			_gang_data = if (playerSide isEqualTo civilian && !(oev_gang_data isEqualTo [])) then {oev_gang_data} else {[0,"",0]};
			_pID = getPlayerUID player;

			_copLevel = __GETC__(life_coplevel);
			_medicLevel = __GETC__(life_medicLevel);
			_adminLevel = __GETC__(life_adminlevel);
			_donatorLevel = __GETC__(oev_donator);

			_num = -1;
			_shop = "";
			_lvl = 0;

			switch (playerSide) do {
				case west: {_num = 0; _shop = "cop"; _lvl = _copLevel};
				case independent: {_num = 1; _shop = "med"; _lvl = _medicLevel};
				case civilian: {_shop = "civ"};
			};

			_lcl_checks = {
				_ranks = getArray(_x >> 'rank');
				_special = getArray(_x >> 'special');
				if(_num != -1) then {(_ranks select _num) <= _lvl} else {true} &&
				(_shop in (getArray(_x >> 'faction'))) &&
				((_ranks select 2) <= _adminLevel && (_ranks select 3) <= _donatorLevel ||
				((_pID in _special || ((_gang_data select 0) in _special) || (_sup && "sup" in _special) || (_texStaff && "tex" in _special) || (_vigi && "vigi" in _special) || (_civCou && "civCou" in _special))))
			};

			_texList = configProperties [(missionConfigFile >> "CfgSkins" >> "VehicleSkins" >> _vehicle),"call _lcl_checks",true];
		};
		case "allSkins": {
			_texList = configProperties [(missionConfigFile >> "CfgSkins" >> "VehicleSkins" >> _vehicle),"true",true];
		};
		case "bttArmed": {
			if(playerSide isEqualTo west) then {
				_texList pushBack (missionConfigFile >> "CfgSkins" >> "VehicleSkins" >> _vehicle >> "Police");
			} else {
				_texList pushBack (missionConfigFile >> "CfgSkins" >> "VehicleSkins" >> _vehicle >> "P51DMustang");
				_texList pushBack (missionConfigFile >> "CfgSkins" >> "VehicleSkins" >> _vehicle >> "German");
				_texList pushBack (missionConfigFile >> "CfgSkins" >> "VehicleSkins" >> _vehicle >> "Japanese");
			};
		};
		case "bttUnarmed": {
			if(playerSide isEqualTo west) then {
				_texList pushBack (missionConfigFile >> "CfgSkins" >> "VehicleSkins" >> _vehicle >> "Police");
			} else {
				_texList pushBack (missionConfigFile >> "CfgSkins" >> "VehicleSkins" >> _vehicle >> "Redline");
			};
		};
		default {};
};

_all = [];
{
	_arr = [configName _x,getText(_x select 0),getArray(_x select 3)];
	_all pushback _arr;
}forEach _texList;

//Array of Arrays [[Config name, Skin name, Skin path], [...], ...];
_all;
