//Author:  Raykazi
//Description: Draws the ganghsed when the player logs in or joins/leaves the gang,
//File:	fn_drawGangShed


private["_building","_gangID","_gangOwner","_marker"];
params [
["_mode", -1,[-1]]
];
switch(_mode) do {
	case 0:{
		if(count (oev_gang_data select 3) isequalto 0) exitwith {}; //fucked up. Draw marker on relog.
		_building = nearestBuilding (oev_gang_data select 3);
		if !(typeOf _building isEqualTo "Land_i_Shed_Ind_F") then {
			// for gangsheds created with createVehicle
			_building = (oev_gang_data select 3) nearestObject "Land_i_Shed_Ind_F";
		};
		_gangID = _building getVariable ["bldg_gangid",-1];
		_gangOwner = _building getVariable ["bldg_owner",-2];
		if !(typeOf _building isEqualTo "Land_i_Shed_Ind_F") exitWith {};
		if (_gangID isEqualTo -1 || _gangOwner isEqualTo -2) exitWith {};

		oev_gangShedPos pushBack (getPosATL _building);
		_marker = createMarkerLocal [format["house_%1%2",_gangID,_gangOwner],getPosATL _building];
		_marker setMarkerTextLocal "Gangshed";
		_marker setMarkerColorLocal "ColorGreen";
		_marker setMarkerTypeLocal "n_hq";
	};
	case 1:{
		_building = nearestBuilding (oev_gang_data select 3);
		if !(typeOf _building isEqualTo "Land_i_Shed_Ind_F") then {
			// for gangsheds created with createVehicle
			_building = (oev_gang_data select 3) nearestObject "Land_i_Shed_Ind_F";
		};
		deletemarkerlocal format["house_%1%2", _building getVariable ["bldg_gangid",-1], _building getVariable ["bldg_owner",-2]];
	};
}
