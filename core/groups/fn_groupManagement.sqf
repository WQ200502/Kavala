//  File: fn_groupManagement.sqf
//	Author: Bryan "Tonic" Boardwine
private["_uiSleep","_group","_gang","_ownerID","_units","_dialog","_members"];
disableSerialization;

_uiSleep = _this param [0,false,[false]];
if(_uiSleep) then { uiSleep 1;};

_group = oev_my_gang;
if(isNull _group) exitWith {[] spawn OEC_fnc_groupMenu;};
_gang = [_group,randomized_life_gang_list] call OEC_fnc_index;
_gang = randomized_life_gang_list select _gang;
_ownerID = _gang select 3;
_units = units (group player);
waitUntil {!isNull (findDisplay 36000)};
_dialog = findDisplay 36000;
_members = _dialog displayCtrl 36002;
_count = _dialog displayCtrl 36010;

_count ctrlSetText format ['%1',count units group player];
lbClear _members;

switch (true) do
{
	case (player == leader(group player)) :
	{
		if((_gang select 2)) then
		{
			ctrlShow[36004,false];
			ctrlShow[36005,true];
		}
			else
		{
			ctrlShow[36004,true];
			ctrlShow[36005,false];
		};
	};

	case ((getPlayerUID player) == _ownerID) :
	{
		if((_gang select 2)) then
		{
			ctrlShow[36004,false];
			ctrlShow[36005,true];
		}
			else
		{
			ctrlShow[36004,true];
			ctrlShow[36005,false];
		};
	};

	default
	{
		if((_gang select 2)) then
		{
			ctrlShow[36004,false];
			ctrlShow[36005,true];
		}
			else
		{
			ctrlShow[36004,true];
			ctrlShow[36005,false];
		};
		ctrlEnable[36004,false];
		ctrlEnable[36005,false];
		ctrlEnable[36006,false];
		ctrlEnable[36007,false];
		ctrlEnable[36008,false]; // if not in group take away password
	};
};

ctrlSetText[36001,(_gang select 0)];

for "_i" from 0 to (count _units)-1 do
{
	switch (true) do
	{
		case ((_units select _i) == leader(group player)) :
		{
			_members lbAdd format["%1 [Leader]",name (_units select _i)];
		};

		case ((getPlayerUID (_units select _i)) == _ownerID) :
		{
			_members lbAdd format["%1 [Founder]", name (_units select _i)];
		};

		default
		{
			_members lbAdd format["%1",name (_units select _i)];
		};
	};

	_members lbSetData [(lbSize _members)-1,str(_units select _i)];
};
