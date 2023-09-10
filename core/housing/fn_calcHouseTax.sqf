//	File: fn_calcHouseTax.sqf
//	Author: Tech
//	Description: returns the house tax on a given hosue object using its upgrades and distance from high value'd areas
//  Very useful: https://wiki.olympus-entertainment.com/wiki/Houses

params [
  ["_house",objNull,[objNull]],
  ["_mode",0,[0]]
];

if(isNull _house) exitWith {-1};
private _houseID = _house getVariable["house_id",-1];
if(_houseID isEqualTo -1) exitWith {-1};

private _price = ([typeOf _house] call OEC_fnc_houseConfig) select 0;

private _virtTier = 0;
if !((_house getVariable ["storageCapacity",-1]) isEqualTo 100) then {
  _virtTier = ((_house getVariable ["storageCapacity",0]) - 100) / 700;
};

private _virtPrice = switch(_price) do {
  case 750000: {_virtTier * 112500};
  case 1000500: {_virtTier * 150075};
  case 1050000: {_virtTier * 157500};
  case 1250000: {_virtTier * 187500};
  case 1550000: {_virtTier * 232500};
  case 2200000: {_virtTier * 330000};
};

private _physTier = 0;
if !((_house getVariable ["physicalStorageCapacity",-1]) isEqualTo 100) then {
  _physTier = ((_house getVariable ["physicalStorageCapacity",0]) - 100) / 200;
};

private _physPrice = _physTier * 200000;

//Total price of house+upgrades
_price = _price + _virtPrice + _physPrice;

private _multiplier = 0.1;
private _area = [];
private _dist = 0;
{
  _type = _x;
  {
    _index = 1;
    while{true} do {
      _name = format["%1_%2_%3",_type,_x,_index];
      if(_name isEqualTo "field_high_1") then {
        _name = "phosphorous_1";
      };
      if(getMarkerPos _name isEqualTo [0,0,0]) exitWith {};
      if(_house distance2D getMarkerPos _name < _dist || _dist isEqualTo 0) then {
        _area = [_type,_x,_index];
        _dist = _house distance2D getMarkerPos _name;
      };
      _index = _index + 1;
    };
  } forEach ["low","med","high"];
} forEach ["field","pro","dmv","rebel"];


switch (_area select 1) do {
    case "low": {
      _multiplier = parseNumber(1/3*2^-(_dist/1000/3+1) toFixed 3); //Returns multiplier to 3rd decimal
    };
    case "med": {
      _multiplier = parseNumber(1/2*2^-(_dist/1000/3+1) toFixed 3); //Returns multiplier to 3rd decimal
    };
    case "high": {
      _multiplier = parseNumber(2^-(_dist/1000/3+1) toFixed 3); //Returns multiplier to 3rd decimal
    };
};

_multiplier = _multiplier max 0.1;
_multiplier = _multiplier min 0.4;

switch (_mode) do {
    case 0: {(floor (_price * _multiplier))/30};
    case 1: {_multiplier * 100}
};





//--------------PLACE ALL TAX RATES ON MAP SCRIPT--------------

//private _bungalow = ["Land_i_House_Small_03_V1_F"];
//private _garage = ["Land_i_Garage_V1_F","Land_i_Garage_V2_F"];
//private _zeroCrater = ["Land_i_Addon_02_V1_F","Land_i_Stone_Shed_V1_F","Land_i_Stone_Shed_V2_F","Land_i_Stone_Shed_V3_F","Land_i_Stone_Shed_01_b_clay_F","Land_i_Stone_Shed_01_b_white_F"];
//private _oneCrater = ["Land_i_Stone_HouseSmall_V2_F","Land_i_Stone_HouseSmall_V1_F","Land_i_Stone_HouseSmall_V3_F"];
//private _twoCrater = ["Land_i_House_Small_01_V1_F","Land_i_House_Small_01_V2_F","Land_i_House_Small_01_V3_F","Land_i_House_Small_01_b_pink_F","Land_i_House_Small_01_b_white_F","Land_i_House_Small_01_b_yellow_F","Land_i_House_Small_01_b_whiteblue_F","Land_i_House_Small_01_b_brown_F","Land_i_House_Small_01_b_yellow_F","Land_i_House_Small_01_b_blue_F"];
//private _longTwoCrater = ["Land_i_House_Small_02_V1_F","Land_i_House_Small_02_V2_F","Land_i_House_Small_02_V3_F","Land_i_House_Small_02_b_white_F","Land_i_House_Small_02_b_whiteblue_F","Land_i_House_Small_02_b_yellow_F","Land_i_House_Small_02_b_blue_F","Land_i_House_Small_02_b_pink_F"];
//private _threeCrater = ["Land_i_House_Big_02_V1_F","Land_i_House_Big_02_V2_F","Land_i_House_Big_02_V3_F","Land_i_House_Big_02_b_blue_F","Land_i_House_Big_02_b_pink_F","Land_i_House_Big_02_b_whiteblue_F","Land_i_House_Big_02_b_white_F","Land_i_House_Big_02_b_brown_F","Land_i_House_Big_02_b_yellow_F"];
//private _fourCrater = ["Land_i_House_Big_01_V1_F","Land_i_House_Big_01_V2_F","Land_i_House_Big_01_V3_F","Land_i_House_Big_01_b_yellow_F","Land_i_House_Big_01_b_brown_F","Land_i_House_Big_01_b_white_F","Land_i_House_Big_01_b_whiteblue_F","Land_i_House_Big_01_b_pink_F","Land_i_House_Big_01_b_blue_F"];
//{
//  _house = _x;
//  private _multiplier = 0.1;
//  private _area = [];
//  private _dist = 0;
//  {
//    _type = _x;
//    {
//      _index = 1;
//      while{true} do {
//        _name = format["%1_%2_%3",_type,_x,_index];
//        if(_name isEqualTo "field_high_1") then {
//          _name = "phosphorous_1";
//        };
//        if(getMarkerPos _name isEqualTo [0,0,0]) exitWith {};
//        if(_house distance2D getMarkerPos _name < _dist || _dist isEqualTo 0) then {
//          _area = [_type,_x,_index];
//          _dist = _house distance2D getMarkerPos _name;
//        };
//        _index = _index + 1;
//      };
//    } forEach ["low","med","high"];
//  } forEach ["field","pro","dmv","rebel"];
//
//  if (count _area isEqualTo 3 && typeOf _x in (_bungalow + _oneCrater + _twoCrater + _longTwoCrater + _threeCrater + _fourCrater)) then {
//    _maxDist = switch (_area select 1) do {
//        case "low": {3000};
//        case "med": {5000};
//        case "high": {8000};
//    };
//
//    if(_dist <= _maxDist) then {
//      switch (_area select 1) do {
//          case "low": {
//            _multiplier = [1/3*2^-(_dist/1000/3+1),3] call BIS_fnc_cutDecimals; //Returns multiplier to 3rd decimal
//          };
//          case "med": {
//            _multiplier = [1/2*2^-(_dist/1000/3+1),3] call BIS_fnc_cutDecimals; //Returns multiplier to 3rd decimal
//          };
//          case "high": {
//            _multiplier = [2^-(_dist/1000/3+1),3] call BIS_fnc_cutDecimals; //Returns multiplier to 3rd decimal
//          };
//      };
//    } else {
//      _multiplier = 0.1;
//    };
//
//    if(_multiplier > 0.4) then {
//      _multiplier = 0.4;
//    };
//    if(_multiplier < 0.1) then {
//      _multiplier = 0.1;
//    };
//
//    deleteMarker str _forEachIndex;
//    _marker = createMarkerLocal [str _forEachIndex,getPos _house];
//    _marker setMarkerShapeLocal "ICON";
//    _marker setMarkerTypeLocal "hd_dot";
//    _marker setMarkerSizeLocal [1, 1];
//    _color = "";
//    _color = switch (true) do {
//        case (_multiplier isEqualTo 0.4): {"ColorRed"};
//        case (_multiplier isEqualTo 0.1): {"ColorGreen"};
//        case (_multiplier > 0.1 && _multiplier <= 0.15): {"ColorBLUFOR"};
//        case (_multiplier > 0.15 && _multiplier <= 0.2): {"ColorBlue"};
//        case (_multiplier > 0.2 && _multiplier <= 0.25): {"ColorYellow"};
//        case (_multiplier > 0.25 && _multiplier <= 0.3): {"ColorOrange"};
//        case (_multiplier > 0.3 && _multiplier < 0.35): {"ColorPink"};
//        case (_multiplier > 0.35): {"ColorRed"};
//    };
//    systemChat str _area;
//    _marker setMarkerColorLocal _color;
//    _marker setMarkerTextLocal (str _multiplier);
//    //(["ColorRed","ColorOrange","ColorYellow","ColorGreen","ColorPink","ColorBlue","ColorCIV","ColorBLUFOR"] select _i-1);
//    //_marker setMarkerPosLocal getMarkerPos "pro_high_1";
//  };
//} forEach nearestObjects [player, ["house"], 200];
