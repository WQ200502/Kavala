_cursorObject = (_this select 0);
_hasCode = _cursorObject getVariable ["hasCode", false];
_isLocked = _cursorObject getVariable ["isLocked", false];

createDialog "dialogTest";
_ctrlIndicator = (findDisplay 1234) displayCtrl 1001;


if (_isLocked) then
{
	ctrlSetText [1001, "Locked"];
	_ctrlIndicator ctrlSetTextColor [1, 0, 0, 1];
}
else
{
	ctrlSetText [1001, "UN-Locked"];
	_ctrlIndicator ctrlSetTextColor [0, 1, 0, 1];
};


if (!_hasCode) then
{
	ctrlSetText [1000, "Please Set A Code"];
};