//  File: fn_casinoSlotsCreate.sqf
//	Author: Tech
//	Description: Creates all inital ctrls for slots machine
params [
  ["_mode", "", [""]]
];

private ["_mode", "_display", "_itemPrefix", "_iconList", "_ctrl", "_pick", "_background", "_moneyBackground", "_color", "_moneyText", "_closeBtn", "_spinBtn"];

_display = findDisplay 20002;

_itemPrefix = "images\icons\items\";

_iconList = ["images\icons\olympus.paa", "images\icons\money.paa", "redgull.paa", "apple.paa", "goldbar.paa", "blastingcharge.paa", "crystalmeth.paa", "epiPen.paa", "defib.paa", "emerald.paa", "frog.paa"];

if(_mode != "background") then {

  //Initial 3 symbols
  {
    _ctrl = _display ctrlCreate ["Casino_RscPicture", 700+_x];
    _pick = (floor (random (count _iconList)));
    if(_pick > 1) then {
      _pick = ([_itemPrefix, (_iconList select _pick)] joinString "");
    } else {
      _pick = _iconList select _pick;
    };
    _ctrl ctrlSetText _pick;
    _ctrl ctrlSetPosition [0.365+(0.134*_x), 0.5, 0.08, 0.105];
    _ctrl ctrlCommit 0;
  } forEach [0,1,2];
};

//Slot machine sprite
if(_mode == "background") then {
  _background = _display displayCtrl 123;
  ctrlDelete _background;
};

_background = _display ctrlCreate ["Casino_RscPicture", 123];
_background ctrlSetText "images\icons\casino\slotsBackground.paa";
_background ctrlSetPosition [0.2, 0.15, 1, 1.3];
_background ctrlCommit 0;

if(_mode == "background") exitWith {};

//Your Money background
_moneyBackground = _display ctrlCreate ["Life_RscText", 2999];
_color = [(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843]), (profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019]), (profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862]), 0.9];
_moneyBackground ctrlSetBackgroundColor _color;
_moneyBackground ctrlSetFade 0;
_moneyBackground ctrlSetPosition [0.2, 0.893, 0.375, 0.08];
_moneyBackground ctrlCommit 0;

//Your Money text
_moneyText = _display ctrlCreate ["Life_RscText", 3000];
_moneyText ctrlSetText "你的资金: ";
_moneyText ctrlSetFade 0;
_moneyText ctrlSetPosition [0.21, 0.893, 0.3375, 0.08];
_moneyText ctrlCommit 0;

//Close button
_closeBtn = _display ctrlCreate ["Casino_RscButton", 3001];
_closeBtn ctrlSetText "关闭";
_closeBtn ctrlSetPosition [0.575, 0.893, 0.3, 0.08];
_closeBtn ctrlCommit 0;
_closeBtn ctrlSetEventHandler ["ButtonClick","['Casino_Slots'] call OEC_fnc_createDialog;oev_inCasino = false;"];

//Spin button
_spinBtn = _display ctrlCreate ["Life_RscButtonTextOnly", 3002];
_spinBtn ctrlSetBackgroundColor [0,0,0,0];
_spinBtn ctrlSetActiveColor [0,0,0,0];
_spinBtn ctrlSetText "";
_spinBtn ctrlSetPosition [0.8, 0.275, 0.11, 0.13];
_spinBtn ctrlCommit 0;
_spinBtn ctrlSetEventHandler ["ButtonClick","['spin'] spawn OEC_fnc_casinoSlots;(_this select 0) ctrlEnable false;"];

//Run next scrupt
['init', controlNull, -1, -1] spawn OEC_fnc_casinoSlots;
