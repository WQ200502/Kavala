#include "..\..\macro.h"
//	Description: Tp To a selected spot on map
//  File: fn_adminTpMap.sqf
//	Notice: Heavily Modified by djwolf for Olympus Entertainment

if(__GETC__(life_adminlevel) < 2) exitWith {hint "Insufficient Permissions"};
if (!("itemMap" in (assignedItems player))) then {
	player addItem "itemMap";
	player assignItem "itemMap";
};
openMap [true, false];
onMapSingleClick "
private '_action';
[_pos select 0, _pos select 1, _pos select 2] spawn{
	private _prevlocationPos = getPos player;
	_action = ['你确定要传送到此位置吗？','传送警告',localize 'STR_Global_Yes',localize 'STR_Global_No'] call BIS_fnc_guiMessage;
	if (_action) then {
		_pos = [_this select 0, _this select 1, _this select 2];
		(vehicle player) setPos [_pos select 0, _pos select 1, 0];
		player setVariable['lastPos',1];
		player setVariable['lastPos',[]];
		onMapSingleClick '';
		openMap [false, false];

		_nearPlayersString = '( Near units: ';

		{
			if(_x distance vehicle player < 800) then {
				_nearPlayersString = format['%3 [%1 _ %2m] -', _x getVariable['realname',name _x], _x distance vehicle player, _nearPlayersString];
			};
		}foreach playableUnits;

		_nearPlayersString = _nearPlayersString + ')';

		[
			['event', 'ADMIN TP Map'],
			['player', name player],
			['player_id', getPlayerUID player],
			['position', getPos player],
			['prev_position', _prevlocationPos]
		] call OEC_fnc_logIt;
		O_stats_teleports = O_stats_teleports + 1;
	};
};
true";
waitUntil {!visibleMap};
onMapSingleClick "";
