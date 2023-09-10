// Author: Horizon
// Description: After 90 SECONDS on the spawn pad, enable the impound button

params [
  ["_vehicle",objNull,[objNull]]
];

uiSleep 2;
_sp = position _vehicle;
uiSleep 90;
if (position _vehicle distance2D _sp < 8) then {
  _vehicle setVariable ["unblockVeh", true, true];
  while {true} do {
    uiSleep 2;
    if (position _vehicle distance2D _sp > 8) exitWith {
      _vehicle setVariable ["unblockVeh", nil, true];
    };
  };
};
