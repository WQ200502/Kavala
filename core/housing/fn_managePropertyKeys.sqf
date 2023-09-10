//	Author: Poseidon
//  Modifications: Raykazi
//	Description: Manages keys for a player owned property. Creates/delete markers for the player when they gain/lose keys to a house
//	File: fn_managePropertyKeys.sqf


private["_property","_mode","_keyPlayers","_keyPlayer","_selectedPlayer","_dialog","_nearPlayers","_uid","_nearUnits","_display","_houseKeyholders","_removedPlayer","_playerName"];
params [["_mode",-1, [0]]];
if(_mode isEqualTo -1) exitWith {};
disableSerialization;


_property = life_pInact_curTarget;
if(isNull _property) exitWith {hint "错误：目标为空."};
if(!(_property isKindOf "House_F")) exitWith {hint "Error: Target is not type house_f."};
if(!(_property in oev_vehicles) || isNil {_property getVariable "house_owner"}) exitWith {hint "你必须是这房子的主人."; closeDialog 0;};
switch(_mode) do {
	case 0:{//Open key management menu and set it up.
		waitUntil {!isNull (findDisplay 37500)};

		_display = findDisplay 37500;
		_nearPlayers = _display displayCtrl 37501;
		lbClear _nearPlayers;
		_nearUnits = [];
		{if(player distance _x < 20) then {_nearUnits pushBack _x};} foreach playableUnits;

		{
			if(!isNull _x && alive _x && (side _x isEqualTo civilian) && player distance _x < 20 && _x != player) then{
				_nearPlayers lbAdd format["%1",_x getVariable["realname",name _x]];
				_nearPlayers lbSetData [(lbSize _nearPlayers)-1,str(_x)];
			};
		}foreach _nearUnits;

		_keyPlayers = _property getVariable["keyPlayers",[]];
		_houseKeyholders = _display displayCtrl 37502;
		lbClear _houseKeyholders;
		{
			if(!isNull _x && (side _x isEqualTo civilian) && _x != player && ((getPlayerUID _x) in _keyPlayers)) then{
				_houseKeyholders lbAdd format["%1",_x getVariable["realname",name _x]];
				_houseKeyholders lbSetData [(lbSize _houseKeyholders)-1,str(getPlayerUID _x)];
				_keyPlayers = _keyPlayers - [(getPlayerUID _x)];
			};
		} forEach playableUnits;

		{
			_houseKeyholders lbAdd format["%1 - Offline",_x];
			_houseKeyholders lbSetData [(lbSize _houseKeyholders)-1,str(_x)];
		} forEach _keyPlayers;
	};

	case 1:{//Give selected player key
		_keyPlayers = _property getVariable["keyPlayers",[]];
		if(count _keyPlayers >= 20) exitWith {hint "您已达到此属性的20个密钥限制."};

		_dialog = findDisplay 37500;
		_nearPlayers = _dialog displayCtrl 37501;

		_selectedPlayer = _nearPlayers lbData (lbCurSel _nearPlayers);
		_selectedPlayer = call compile format["%1", _selectedPlayer];
		if(isNil "_selectedPlayer") exitWith {hint "无效的玩家选择."};
		if(isNull _selectedPlayer) exitWith {hint "无效的玩家选择."};

		_uid = getPlayerUID _selectedPlayer;

		if(_keyPlayers find _uid != -1) exitWith {hint format["%1 已经有了这个钥匙.",_selectedPlayer getVariable["realname",name _selectedPlayer]];};
		_keyPlayers pushBack _uid;

		hint format["%1 已获得此属性的密钥.",_selectedPlayer getVariable["realname",name _selectedPlayer]];
		[[life_pInact_curTarget,_keyPlayers,player],"OES_fnc_propertyUpdateKeys",false,false] spawn OEC_fnc_MP;
		_property setVariable ["trunk_in_use",nil,true];
		[1, [_property, format["%1",(_property getVariable "uid")], getPosATL _property, (player getVariable["realname",name player])]] remoteExecCall ["OEC_fnc_manageHouseMarkers", _selectedPlayer, false];
	};

	case 2:{//Change locks (wipe stored keys)
		_property = life_pInact_curTarget;
		_keyPlayers = _property getVariable["keyPlayers",[]];
		{
			if((getPlayerUID _x) in _keyPlayers) then {
				_keyPlayer = call compile format["%1", _x];
				[2,[_property, format["%1",(_property getVariable "uid")], [], (player getVariable["realname",name player])]] remoteExecCall ["OEC_fnc_manageHouseMarkers", _keyPlayer, false];
			};
		} forEach playableUnits;
		[[life_pInact_curTarget,[],player],"OES_fnc_propertyUpdateKeys",false,false] spawn OEC_fnc_MP;
		hint "Locks have been changed. Anyone previously given a key will not be able to access this property.";
	};

	case 3:{//Remove selected player key
		_keyPlayers = _property getVariable["keyPlayers",[]];
		_dialog = findDisplay 37500;
		_houseKeyholders = _dialog displayCtrl 37502;

		_removedPlayer = _houseKeyholders lbData (lbCurSel _houseKeyholders);
		_removedPlayer = call compile format["%1", _removedPlayer];
		if(isNil "_removedPlayer") exitWith {hint "无效的玩家选择."};

		if(!(_removedPlayer in _keyPlayers)) exitWith {hint format["您已删除此人的密钥."];};

		_keyPlayers = _keyPlayers - [_removedPlayer];
		_playerName = _removedPlayer;
		{
			if ((getPlayerUID _x) isEqualTo _removedPlayer) exitWith {
				_keyPlayer = call compile format["%1", _x];
				[2,[_property, format["%1",(_property getVariable "uid")], [], (player getVariable["realname",name player])]] remoteExecCall ["OEC_fnc_manageHouseMarkers", _keyPlayer, false];
				_playerName = _x getVariable["realname",name _x];
			};
		} forEach playableUnits;
		hint format["%1 has had their keys to this property removed.",_playerName];
		[[life_pInact_curTarget,_keyPlayers,player],"OES_fnc_propertyUpdateKeys",false,false] spawn OEC_fnc_MP;
	};
};
