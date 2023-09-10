//	File: fn_upgradePlane.sqf
//	Author: Tech
//	Description: Upgrades unarmed BTT to armed BTT
params ["_vehicle"];
private ["_vehicle","_cost","_exit","_action","_origPosition","_ui","_progressBar","_titleText","_cP","_color","_insurance","_msg"];

_exit = false;
if(isNull _vehicle) then {_exit = true;};
if(typeOf _vehicle != "C_Plane_Civil_01_racing_F") then {_exit = true;};
if(playerSide isEqualTo independent) then {_exit = true;};

_modArray = _vehicle getVariable ["modifications", [0,0,0,0,0,0,0,0]];
if(_modArray select 3 isEqualTo 1) then {_exit = true;};

_curColor = (_vehicle getVariable ["oev_veh_color",["Redline",0]]);
_color = [];
switch(_curColor select 0) do {
    case "Redline": {_color = ["P51DMustang",_curColor select 1]};
    case "Police": {_color = ["Police",_curColor select 1]};
    default {_exit = true;};
};
if(_exit) exitWith {hint "Error";};

_cost = 1500000;

_insurance = _vehicle getVariable ["insured",0];
_msg = format["你确定要升级你的飞机吗？这将添加一把机关枪并花费你%1元。",[_cost] call OEC_fnc_numberText];
if(_insurance != 0) then {
  _msg = format["你确定要升级你的飞机吗？这将添加一把机关枪并花费你%1元。你也会失去你的保险",[_cost] call OEC_fnc_numberText];
  _insurance = 0;
};

_action = [
  _msg,
  "Confirmation",
  "Yes",
  "No"
] call BIS_fnc_GUImessage;

if(_action) then {
  closeDialog 0;
  if (oev_cash < _cost && oev_atmcash < _cost) exitWith {titleText ["你没有足够的钱。","PLAIN DOWN"];};

  _origPosition = getPos player;
  disableSerialization;
  5 cutRsc ["life_progress","PLAIN DOWN"];
  _ui = uiNamespace getVariable "life_progress";
  _progressBar = _ui displayCtrl 38201;
  _titleText = _ui displayCtrl 38202;
  _titleText ctrlSetText format["%2 (1%1)...","%","升级飞机"];
  _progressBar progressSetPosition 0.01;
  _cP = 0.01;

  while {true} do {
    uiSleep 0.15;
    _cP = _cP + 0.01;
    _progressBar progressSetPosition _cP;
    _titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%","升级飞机"];
    if (_cP >= 1 || !alive player) exitWith {};
    if ((player getVariable["restrained",false])) exitWith {};
    if (oev_interruptedTab) exitWith {};
    if (player distance _origPosition > 10) exitWith {};
    if (isNull objectParent player) exitWith {titleText["升级车辆时，您必须留在车内。","PLAIN DOWN"]};
  };
  5 cutText ["","PLAIN DOWN"];

  if (player distance _origPosition > 10) exitWith {titleText["你需要待在10米以内才能升级车辆。","PLAIN DOWN"]; oev_action_inUse = false;};
  if (!alive player) exitWith {oev_action_inUse = false;};
  if ((player getVariable["restrained",false])) exitWith {oev_action_inUse = false;};
  if (oev_interruptedTab) exitWith {oev_interruptedTab = false; titleText["操作已取消","PLAIN DOWN"]; oev_action_inUse = false;};

  oev_action_inUse = false;

  _exit2 = false;

  if (oev_cash >= _cost) then {
    oev_cash = oev_cash - _cost;
    oev_cache_cash = oev_cache_cash - _cost;
    [0] call OEC_fnc_ClupdatePartial;
  } else {
    if(oev_atmcash >= _cost) then {
      oev_atmcash = oev_atmcash - _cost;
      oev_cache_atmcash = oev_cache_atmcash - _cost;
      [1] call OEC_fnc_ClupdatePartial;
    } else {
      _exit2 = true;
    };
  };

  if(_exit2) exitWith {titleText ["你没有足够的钱。","PLAIN DOWN"];};
  titleText ["你成功地升级了飞机。","PLAIN DOWN"];

  _modArray set [3, 1];
  [_vehicle,_insurance,_color,_modArray] remoteExec ["OES_fnc_updateVehicleMods",2];

  _vehicle setVariable ["modifications",_modArray,true];
  _vehicle setVariable ["insured",_insurance,true];
  _vehicle setVariable ["oev_veh_color", _color, true];
  [_vehicle,_color] remoteExec ["OEC_fnc_colorVehicle",0];

  [_vehicle, "civ"] call OEC_fnc_clearVehicleAmmo;
};
