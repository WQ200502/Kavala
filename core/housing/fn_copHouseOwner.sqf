#include "..\..\macro.h"
//  File: fn_copHouseOwner.sqf
//	Description: Displays the house owner

params [["_building",objNull,[objNull]]];
if (isNull _building || !(_building isKindOf "House_F")) exitWith {};

if !(typeOf _building isEqualTo "Land_i_Shed_Ind_F") then {
	if (isNil {(_building getVariable "house_owner")}) exitWith {hint localize "STR_building_Raid_NoOwner"};
	if (__GETC__(life_coplevel) >= 2) then {
		private _keys = _building getVariable ["keyPlayers",[]];
		private _names = "";

		if !(count _keys isEqualTo 0) then {
			{
				if ((side _x isEqualTo civilian) && {isPlayer _x} && {getPlayerUID _x in _keys}) then {
					_names = format ["%1<br/>%2",_names,name _x];
				};
			} forEach playableUnits;
		};

		hint parseText format ["<t color='#FF0000'><t size='2'>房主</t></t><br/>%1<br/><br/><t color='#FF0000'><t size='1'>房屋钥匙持有人</t></t>%2",(_building getVariable "house_owner") select 1,_names];
	} else {
		hint parseText format ["<t color='#FF0000'><t size='2'>房主</t></t><br/>%1",(_building getVariable "house_owner") select 1];
	};
} else {
	if (isNil {_building getVariable "bldg_gangName"}) exitWith {};
	hint parseText format ["<t color='#FF0000'><t size='2'>建立帮派</t></t><br/>%1",(_building getVariable "bldg_gangName")];
};