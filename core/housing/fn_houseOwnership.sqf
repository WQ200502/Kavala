//	Description: Called when you successfully purchase a house
// File: fn_houseOwnership.sqf

private["_house","_marker","_housename","_numOfDoors","_houseCfg","_index","_position"];
_house = param [0,ObjNull,[ObjNull]];
_mode = param [1,0,[0]];
_playerID = param [2,"",[""]];
_price = param [3,-1,[0]];
_buyer = param [4,objNull,[objNull]];

if(isNull _house || _mode == 0) exitWith {};
if(_playerID != getPlayerUID player) exitWith {};

oev_houseTransaction = false;
oev_action_inUse = false;

_position = (getPosATL _house);
if((count (nearestObjects[_position,["House_F"],10])) > 0) then {
	if((typeof ((nearestObjects[_position,["House_F"],10]) select 0)) == (typeof _house)) then {
		_house = ((nearestObjects[_position,["House_F"],10]) select 0);//u fockin wot m8
	};
};

_houseCfg = [(typeOf _house)] call OEC_fnc_houseConfig;
if(count _houseCfg == 0) exitWith {};

switch (_mode) do {
	case 1: //bought house successfully
	{
		_house setVariable["house_owner",[(getPlayerUID player),profileName],true];
		_house setVariable["locked",true,true];
		_house setVariable["for_sale","",true];
		_house setVariable["Trunk",[[],0],true];
		_house setVariable["PhysicalTrunk",[[],0],true];
		_house setVariable["storageCapacity",100,true];
		_house setVariable["physicalStorageCapacity",100,true];
		_house setVariable["uid",round(random 99999),true];
		oev_vehicles pushBack _house;
		life_houses pushBack [str(getPosATL _house),[]];
		_marker = createMarkerLocal [format["house_%1",(_house getVariable "uid")],getPosATL _house];
		_houseName = getText(configFile >> "CfgVehicles" >> (typeOf _house) >> "displayName");
		_marker setMarkerTextLocal _houseName;
		_marker setMarkerColorLocal "ColorBlue";
		_marker setMarkerTypeLocal "loc_Lighthouse";
		_numOfDoors = getNumber(configFile >> "CfgVehicles" >> (typeOf _house) >> "numberOfDoors");
		for "_i" from 1 to _numOfDoors do {
			_house setVariable[format["bis_disabled_Door_%1",_i],1,true];
		};

		[
			["event","House Purchase"],
			["player",name player],
			["player_id",getPlayerUID player],
			["price",_houseCfg select 0],
			["house_location",str(getPosATL _house)]
		] call OEC_fnc_logIt;

		hint "接受购买请求，这是关键。";
		_house setVariable ["trunk_in_use",nil,true];
	};

	case 2: // sold house successfully
	{
		// Calculate House Mods
		private _virtSize = ((_house getVariable["storageCapacity",100]) - 100) / 700;
		private _physSize = ((_house getVariable["physicalStorageCapacity",100]) - 100) / 200;
		private _modsValue = 0;
		switch (_virtSize) do {
			case 1: {_modsValue = _modsValue + ((_houseCfg select 0)*0.15);};
			case 2: {_modsValue = _modsValue + (((_houseCfg select 0)*0.15) * 2);};
			case 3: {_modsValue = _modsValue + (((_houseCfg select 0)*0.15) * 3);};
			case 4: {_modsValue = _modsValue + (((_houseCfg select 0)*0.15) * 4);};
		};
		switch (_physSize) do {
			case 1: {_modsValue = _modsValue + 200000;};
			case 2: {_modsValue = _modsValue + (200000 * 2);};
			case 3: {_modsValue = _modsValue + (200000 * 3);};
			case 4: {_modsValue = _modsValue + (200000 * 4);};
		};
		if (_house getVariable ["oilstorage",false]) then {_modsValue = _modsValue + 50000;};

		_modsValue = _modsValue * 0.25;

		// Set Default Variables of House and resell.
		_house setVariable["locked",false,true];
		_house setVariable["Trunk",nil,true];
		_house setVariable["PhysicalTrunk",nil,true];
		_house setVariable["storageCapacity",0,true];
		_house setVariable["physicalStorageCapacity",0,true];
		deleteMarkerLocal format["house_%1",_house getVariable "uid"];
		_house setVariable["uid",nil,true];
		_house setVariable["for_sale","",true];

		oev_atmcash = oev_atmcash + (round((_houseCfg select 0)/2)) + _modsValue;
		oev_cache_atmcash = oev_cache_atmcash + (round((_houseCfg select 0)/2)) + _modsValue;

		_index = oev_vehicles find _house;
		if(_index != -1) then {
			oev_vehicles set[_index,-1];
			oev_vehicles = oev_vehicles - [-1];
		};

		_index = [str(getPosATL _house),life_houses] call OEC_fnc_index;
		if(_index != -1) then {
			life_houses set[_index,-1];
			life_houses = life_houses - [-1];
		};
		_numOfDoors = getNumber(configFile >> "CfgVehicles" >> (typeOf _house) >> "numberOfDoors");
		for "_i" from 1 to _numOfDoors do {
			_house setVariable[format["bis_disabled_Door_%1",_i],0,true];
		};

		[
			["event","House Sold"],
			["player",name player],
			["player_id",getPlayerUID player],
			["sell_price",round((_houseCfg select 0)/2)],
			["house_location",str(getPosATL _house)]
		] call OEC_fnc_logIt;

		hint "您的房子已卖给银行了。";
	};

	case 3: //bought house failed
	{
		oev_atmcash = oev_atmcash + (_houseCfg select 0);
		oev_cache_atmcash = oev_cache_atmcash + (_houseCfg select 0);
		[6] call OEC_fnc_ClupdatePartial;
	};

	case 4: // bought a LISTED house successfully
	{
		private _oldUID = ((_house getVariable ["for_sale",""]) select 0);
		if ([_oldUID] call OEC_fnc_isUIDActive) then {
			private _player = objNull;
			{
				if (getPlayerUID _x isEqualTo _oldUID) then {
					_player = _x;
				};
				if !(isNull _player) exitWith {};
			} forEach playableUnits;
			if (isNull _player) exitWith {};
			[_house,6,_oldUID,((_house getVariable ["for_sale",""]) select 1),player] remoteExecCall ["OEC_fnc_houseOwnership",(owner _player),false];
			uiSleep 2; // Sleep to allow above to function on time. (scriptDone will not work here)
		};

		[
			["event","Listed House Purchase"],
			["player",name player],
			["player_id",getPlayerUID player],
			["from_id",_oldUID],
			["sell_price",_price],
			["house_location",str(getPosATL _house)]
		] call OEC_fnc_logIt;
		
		_house setVariable["house_owner",[(getPlayerUID player),profileName],true];
		_house setVariable["locked",true,true];
		_house setVariable["for_sale","",true];
		//_house setVariable["Trunk",[[],0],true];
		//_house setVariable["PhysicalTrunk",[[],0],true];
		//_house setVariable["storageCapacity",100,true];
		//_house setVariable["physicalStorageCapacity",100,true];
		_house setVariable["uid",round(random 99999),true];
		oev_vehicles pushBack _house;
		life_houses pushBack [str(getPosATL _house),[]];
		_marker = createMarkerLocal [format["house_%1",(_house getVariable "uid")],getPosATL _house];
		_houseName = getText(configFile >> "CfgVehicles" >> (typeOf _house) >> "displayName");
		_marker setMarkerTextLocal _houseName;
		_marker setMarkerColorLocal "ColorBlue";
		_marker setMarkerTypeLocal "loc_Lighthouse";
		_numOfDoors = getNumber(configFile >> "CfgVehicles" >> (typeOf _house) >> "numberOfDoors");
		for "_i" from 1 to _numOfDoors do {
			_house setVariable[format["bis_disabled_Door_%1",_i],1,true];
		};

		hint "接受购买请求，这是关键。";
		_house setVariable ["trunk_in_use",nil,true];
	};

	case 5: // Listed bought house failed
	{
		oev_atmcash = oev_atmcash + _price;
		oev_cache_atmcash = oev_cache_atmcash + _price;
		[6] call OEC_fnc_ClupdatePartial;
	};

	case 6: // Listed house was bought, On current server delete marker and notify
	{
		deleteMarkerLocal format["house_%1",_house getVariable "uid"];
		private _index = oev_vehicles find _house;
		if(_index != -1) then {
			oev_vehicles set[_index,-1];
			oev_vehicles = oev_vehicles - [-1];
		};

		_index = [str(getPosATL _house),life_houses] call OEC_fnc_index;
		if(_index != -1) then {
			life_houses set[_index,-1];
			life_houses = life_houses - [-1];
		};

		hint parseText format ["您已收到出售给%2的挂牌房屋的%1元。<br/>你可以去房地产经纪人那里收钱。",[_price] call OEC_fnc_numberText, name _buyer];
	};
};

// [[player],"OES_fnc_aucChecks",false,false] call OEC_fnc_MP;
