//  File: fn_gangBldgMembers.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Description: Adds gang buildings to all online members

params [
	["_building",objNull,[objNull]],
	["_mode",-1,[0]]
];
if (isNull _building) exitWith {};
if !(typeOf _building isEqualTo "Land_i_Shed_Ind_F") exitWith {};

private _gangID = _building getVariable ["bldg_gangid",-1];
private _gangOwner = _building getVariable ["bldg_owner",-2];
if (_gangID isEqualTo -1 || _gangOwner isEqualTo -2) exitWith {};

if (_mode isEqualTo 1) then {
	oev_gangShedPos pushBack (getPosATL _building);
	_marker = createMarkerLocal [format["house_%1%2",_gangID,_gangOwner],getPosATL _building];
	_marker setMarkerTextLocal "Gangshed";
	_marker setMarkerColorLocal "ColorGreen";
	_marker setMarkerTypeLocal "n_hq";
};

// Sets position of building empty when disbanded/removed...
if (_mode isEqualTo 2) then {
	oev_gang_data set [3,[]];
	player setVariable ["gang_data",oev_gang_data,true];
	deleteMarkerLocal format["house_%1%2",_gangID,_gangOwner];

	oev_gangShedPos = [];
};