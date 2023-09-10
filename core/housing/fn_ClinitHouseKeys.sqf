//	Author: Raykazi
//	Description: Initializes the players houses that they were given keys to and places a marker.

if(count life_house_keys == 0) exitWith {}; //Nothing to do.
if(oev_newsTeam) exitWith {};

{
	_position = call compile format["%1",_x select 0];

	if((count (nearestObjects[_position,["House_F"],10])) > 0) then {
		_house = ((nearestObjects[_position,["House_F"],10]) select 0);
		if (isNil {_house getVariable "uid"}) then {
			_pUID = (getPlayerUID player) splitString "";
			_pUID deleteRange [0,10];
			_pUID = _pUID joinString "";

			_houseID = [_pUID,_forEachIndex + 10] joinstring "_";
			_house setVariable["uid",_houseID,true];
		};
		_houseName = format["%1's house", _x select 1];

		_marker = createMarkerLocal [format["house_key_%1",(_house getVariable "uid")],_position];
		_marker setMarkerTextLocal _houseName;
		_marker setMarkerColorLocal "ColorKhaki";
		_marker setMarkerTypeLocal "loc_Lighthouse";
	};
} forEach life_house_keys;
