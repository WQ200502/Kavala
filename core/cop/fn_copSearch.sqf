#include "..\..\macro.h"
//  File: fn_copSearch.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Returns information on the search.

oev_action_inUse = false;
private["_license","_guns","_gun","_index"];
params [
	["_civ",objNull,[objNull]],
	["_invs",[],[[]]],
	["_robber",false,[false]],
	["_weaponText","",[""]],
	["_bpText","",[""]],
	["_vestContentText","",[""]],
	["_uniformeItemsText","",[""]],
	["_cashAmountText","",[""]]
];

if(isNull _civ) exitWith {};

_illegal = 0;
_inv = "";
if(count _invs > 0) then {
	{
		_inv = _inv + format["%2 x%1<br/>",_x select 1,[([_x select 0,0] call OEC_fnc_varHandle)] call OEC_fnc_varToStr];
		_index = [(_x select 0),oev_illegal_items] call OEC_fnc_index;
		if (_index != -1) then {
			_illegal = _illegal + ((_x select 1) * (((oev_illegal_items) select _index) select 1));
		};
	} foreach _invs;

	[[0,"STR_Cop_Contraband",true,[(_civ getVariable["realname",name _civ]),[_illegal] call OEC_fnc_numberText]],"OEC_fnc_broadcast",west,false] spawn OEC_fnc_MP;
} else {
	_inv = localize "STR_Cop_NoIllegal";
};

if(!alive _civ || player distance _civ > 5) exitWith {hint format[localize "STR_Cop_CouldntSearch",_civ getVariable ["realname",name _civ]]};
//hint format["%1",_this];
hint parseText format["
	<t color='#FF0000'><t size='2'>%1</t></t><br/>
	<t color='#FFD700'><t size='1.5'>Weapons</t></t><br/>
	%4<br/>
	<t color='#FFD700'><t size='1.5'>Backpack Content</t></t><br/>
	%5<br/>
	<t color='#FFD700'><t size='1.5'>Vest Content</t></t><br/>
	%6<br/>
	<t color='#FFD700'><t size='1.5'>Uniform Content</t></t><br/>
	%7<br/>
	<t color='#FFD700'><t size='1.5'>Cash On Hand</t></t><br/>
	%8<br/>
	<t color='#FFD700'><t size='1.5'>" + (localize "STR_Cop_IllegalItems") + "</t></t><br/>%2<br/><br/><br/><br/><t color='#FF0000'>%3</t>"
,(_civ getVariable ["realname",name _civ]),_inv,if(_robber) then {"Robbery Suspect"} else {""},_weaponText,_bpText,_vestContentText,_uniformeItemsText,_cashAmountText];

if(_robber) then {
	[[0,"STR_Cop_Robber",true,[(_civ getVariable["realname",name _civ])]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
};

[
	["event", "Searched Player"],
	["player", name player],
	["player_id", getPlayerUID player],
	["target", name _civ],
	["target_id", getPlayerUID _civ],
	["position", getPos player]
]	call OEC_fnc_logIt;
