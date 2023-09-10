//  File: fn_clientGetKey

params [
	["_vehicle",objNull,[objNull]],
	["_unit",objNull,[objNull]],
	["_giver","",[""]],
	["_getGangVehKeys",false,[false]]
];

if(isNil "_unit" || isNil "_giver") exitWith {};
if(player == _unit && !(_vehicle in oev_vehicles)) then {
	if !(_getGangVehKeys) then {
		_name = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
		//Error checking for a house with no id set
		private _badHouse = false;
		if (_vehicle isKindOf "House") then {
			if ((_vehicle getVariable ["house_id",-1]) isEqualTo -1) then {
				_badHouse = true;
			};
		};
		if (_badHouse) exitWith {"Error getting keys to the house. Please try again."};
		hint format["%1 has gave you keys for a %2",_giver,_name];
		oev_vehicles pushBack _vehicle;
		[[getPlayerUID player,playerSide,_vehicle,1],"OES_fnc_keyManagement",false,false] spawn OEC_fnc_MP;
	} else {
		private _vehGangID = _vehicle getVariable ["gangID",0];
		private _unitGangID = (_unit getVariable ["gang_data",[0,"",0]]) select 0;
		if (_vehGangID isEqualTo 0) exitWith {};
		if !(_vehGangID isEqualTo _unitGangID) exitWith {};
		_name = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
		hint format["You have acquired keys to your gang's %1",_name];
		oev_vehicles pushBack _vehicle;
		[[getPlayerUID player,playerSide,_vehicle,1],"OES_fnc_keyManagement",false,false] spawn OEC_fnc_MP;
		private _owners = _vehicle getVariable ["vehicle_info_owners",[]];
		_owners pushBack [getPlayerUID player,player getVariable ["realname",name player]];
		_vehicle setVariable ["vehicle_info_owners",_owners];
	};

};
