_keyPad = (_this select 0);

_building = (nearestBuilding _keyPad);
_doorCount = getNumber (configFile >> "cfgVehicles" >> typeOf _building >> "numberOfDoors");
_doorList = [];

for "_i" from 1 to _doorCount do
{
	_data = [];
	_door = format ["Door_%1_trigger", _i];
	_tempPos = _building selectionPosition _door;	
	_doorPos = _building modelToWorld _tempPos;
	_num = _i;
	_data pushBack _door;
	_data pushBack _doorPos;
	_data pushBack _num;
	_doorList pushBack _data;
};

_index = nil;
_holderDist = 50000;
{
	_pos = _x select 1;
	_distance = _keyPad distance [_pos select 0, _pos select 1, _pos select 2];
	if (_distance < _holderDist) then
	{
		_index = _forEachIndex;
		_holderDist = _distance;
	};
} forEach _doorList;

_tempSel = _doorList select _index;
_closestDoor = _tempSel select 0;
_doorNumber = _tempSel select 2;

_keyPad setVariable ["building", _building, true];
_keyPad setVariable ["doorNumber", _doorNumber, true];
_keyPad setVariable ["theCode", "", true];
_keyPad setVariable ["hasCode", false, true];
_keyPad setVariable ["isLocked", false, true];

[_keyPad, ["Open KeyPad", 
{
	null = [_this select 0] execVM "kitty_lockFolder\dialog\openDialog.sqf";
}, [], 6, false, true, "", "_this distance _target < 2.2"]] remoteExec ["addAction", 0, true];