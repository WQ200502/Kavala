#include "..\..\macro.h"
//	File: fn_loadoutMenu.sqf
//	Author: Raykazi
//	Description: Adds things to a menu

private["_display","_loadoutList"];
params [
  ["_mode", -1, [0]]
];

disableSerialization;
switch (_mode) do {
  case 1:{ //Save Loadout
    waitUntil {!isNull (findDisplay 634780)};
    _display = findDisplay 634780;
    _loadoutList = _display displayCtrl 634781;
    lbClear _loadoutList;
    {
      _loadoutList lbAdd format["Loadout #%1", _x];
      _loadoutList lbSetData [(lbSize _loadoutList)-1, str(_x)];
    } forEach [1,2,3];
    _loadoutList lbSetCurSel 0;
  };
  case 2:{ //Load Loadout
    waitUntil {!isNull (findDisplay 634790)};
    _display = findDisplay 634790;
    _loadoutList = _display displayCtrl 634791;
    lbClear _loadoutList;
    {
      _loadoutList lbAdd format["Loadout #%1", _x];
      _loadoutList lbSetData [(lbSize _loadoutList)-1, str(_x)];
    } forEach [1,2,3];
    _loadoutList lbSetCurSel 0;
  };
};
