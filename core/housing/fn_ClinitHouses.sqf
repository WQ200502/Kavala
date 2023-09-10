//	Author: Bryan "Tonic" Boardwine
//	Description: Initializes the players houses, mainly throwing down markers. DESCRIPTIONEND

if(count life_houses == 0) exitWith {}; //Nothing to do.
if(oev_newsTeam) exitWith {};

{
	_position = call compile format["%1",_x select 0];

	if((count (nearestObjects[_position,["House_F"],10])) > 0) then {
		_house = ((nearestObjects[_position,["House_F"],10]) select 0);
		if (isNil {_house getVariable "uid"}) then {
			_pUID = (getPlayerUID player) splitString "";
			_pUID deleteRange [0,10];
			_pUID = _pUID joinString "";

			_houseID = [_pUID,_forEachIndex] joinstring "_";
			_house setVariable["uid",_houseID,true];
		};
		_houseName = getText(configFile >> "CfgVehicles" >> (typeOf _house) >> "displayName");

		_marker = createMarkerLocal [format["house_%1",(_house getVariable "uid")],_position];
		_marker setMarkerTextLocal _houseName;
		_marker setMarkerColorLocal "ColorBlue";
		_marker setMarkerTypeLocal "loc_Lighthouse";
	};
} forEach life_houses;
