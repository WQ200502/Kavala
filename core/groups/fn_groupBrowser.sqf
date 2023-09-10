//  File: fn_groupBrowser.sqf
//	Author: Bryan "Tonic" Boardwine
private["_gangs","_dialog","_gang","_locked","_sortedPlayers"];
disableSerialization;

waitUntil {!isNull (findDisplay 36100)};
_dialog = findDisplay 36100;
_gangs = _dialog displayCtrl 36102;

_sortedPlayers = randomized_life_gang_list;
_sortedPlayers sort true;
{
	_gang = _x;
	if(!isNull (_gang select 1)) then
	{
		if((_gang select 2)) then
		{
			_locked = "Locked";
		}
			else
		{
			_locked = "Unlocked";
		};

		_gangs lbAdd format["%1 [Members: %2] - %3",_gang select 0,count (units(_gang select 1)),_locked];
		_gangs lbSetData [(lbSize _gangs)-1,_gang select 0];
	};
}foreach (_sortedPlayers);

if(((lbSize _gangs)-1) == -1) then
{
	_gangs lbAdd "No groups currently created.";
	(_dialog displayCtrl 36103) ctrlEnable false;
};