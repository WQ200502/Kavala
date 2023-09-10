_cursorObject = (_this select 0);
_isLocked = _cursorObject getVariable ["isLocked", false];
_hasCode = _cursorObject getVariable ["hasCode", false];
_objectName = typeOf _cursorObject;
_tablet = "Land_Tablet_01_F";
_building = _cursorObject getVariable ["building", nil];
_doorNumber = _cursorObject getVariable ["doorNumber", nil];
_codeEntered = ctrlText 1000;

if (_objectName == _tablet) then
{
	if (!_hasCode) then
	{
		hint "A code must be set to check the building's code";
	}
	else
	{
		_code = _cursorObject getVariable ["theCode", ""];
		if (_code == _codeEntered) then
		{
			if (_isLocked) then
			{
				null = [_building, _doorNumber] execVM "kitty_lockFolder\actions\unlockDoors.sqf";
				_cursorObject setVariable ["isLocked", false, true];
			}
			else
			{
				hint "Doors are already unlocked";
			};
		}
		else
		{
			hint "Invalid code entered";
		};
		ctrlSetText [1000, ""];
	};
};