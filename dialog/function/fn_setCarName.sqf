//  File: fn_setCarName.sqf
//	Author: Tech
//	Description: Sets a custom name on a vehicle.
params [
  ["_mode","",[""]],
  ["_vehicle",objNull,[objNull]]
];
if(_mode isEqualTo "prompt") then {
  private _vehicle = lbData[2802,(lbCurSel 2802)];
  private _vid = (call compile format["%1",_vehicle]) select 5;
  _className = (call compile format["%1",_vehicle]) select 0;
  if (isNil "_vehicle" || _vehicle isEqualTo "") exitWith {hint "请选择一辆车。";};
  closeDialog 0;
  ["life_custom_car_name"] call OEC_fnc_createDialog;
  _dataBox = (findDisplay 25555) displayCtrl 3000;
  _dataBox ctrlShow false;
  lbClear _dataBox;
  _info = [_className] call OEC_fnc_fetchVehInfo;
  _dataBox lbAdd (_info select 3);
  _dataBox lbSetData [0, _vid];
  _dataBox lbSetCurSel 0;
};
if(_mode isEqualTo "setName") then {
  _name = ctrlText 5000;
  if(_name isEqualTo "") exitWith {hint "Input a name";};
  _nameChar = toArray(_name);
  if(count _nameChar > 15) exitWith {hint "名称不能超过15个字符。";};
  _allowed = toArray("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ ");
  _badChar = false;
  _hasLetters = false;
  {if(!(_x in _allowed)) exitWith {_badChar = true;};} forEach _nameChar;
  {if(_x in (_allowed - (toArray " "))) exitWith {_hasLetters = true;};} forEach _nameChar;
  if(_badChar) exitWith {hint "该名称包含无效字符！ 仅允许使用数字，字母和下划线！";};
  if(!_hasLetters) exitWith {hint "把一些信放进去。";};
  if(oev_atmcash < 25000) exitWith {hint "你需要25000元才能换个车名。";};
  closeDialog 0;
  oev_atmcash = oev_atmcash - 25000;
  oev_cache_atmcash = oev_cache_atmcash - 25000;
  [1] call OEC_fnc_ClupdatePartial;
  _vid = lbData[3000,0];
  _pid = getPlayerUID player;
  [_name,_pid,_vid] remoteExec ["OES_fnc_updateCarName",2];
};
