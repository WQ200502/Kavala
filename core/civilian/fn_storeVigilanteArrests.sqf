#include "..\..\macro.h"
//  File: fn_storeVigilanteArrests.sqf
//	Author: Horizon

//	Description: Store and claim vigilante arrests.

private ["_mode","_player","_action","_arrests","_pricePerTier","_storePrice"];

_mode = _this select 3;
_player = player;

if (scriptAvailable(5)) exitWith {hint "请稍候，然后再尝试执行此操作！";};
if (oev_action_inUse) exitWith {titleText ["你已经在执行另一个操作了！", "PLAIN DOWN"]};
if (_mode isEqualTo 0 && oev_vigiarrests isEqualTo 0) exitWith {hint "你没有任何逮捕记录！"};
if (_mode isEqualTo 0 && _player getVariable["statBounty",0] > 0) exitWith {hint "不错的尝试！你不能把被捕的人当作通缉犯。";};

_action = false;
_pricePerTier = 400000;
_storePrice = switch (true) do {
  case (oev_vigiarrests >= 200): {_pricePerTier * 5};
  case (oev_vigiarrests >= 100): {_pricePerTier * 4};
  case (oev_vigiarrests >= 50): {_pricePerTier * 3};
  case (oev_vigiarrests >= 25): {_pricePerTier * 2};
  default {_pricePerTier};
};

switch (_mode) do {
  //Store arrests
  case 0: {
    _arrests = _player getVariable ["vigilanteArrests",0];
    _action = [
      format ["您确定要将您的%1私刑逮捕存储为%2元吗？",oev_vigiarrests,[_storePrice] call OEC_fnc_numberText],
    	"确定",
    	"是",
    	"否"
  	] call BIS_fnc_guiMessage;
    if (_action) then {
      uiSleep (random(3));
      if (oev_atmcash < _storePrice) exitWith {hint "你没有足够的钱来储存你的逮捕！"};
      uiSleep (random(3));
      [4, player] remoteExec ["OES_fnc_vigiGetSetArrests",2];
      oev_atmcash = oev_atmcash - _storePrice;
      oev_cache_atmcash = oev_cache_atmcash - _storePrice;
      [1] call OEC_fnc_ClupdatePartial;
    	titleText [format["你以%2元存储了%1次逮捕。",_arrests,[_storePrice] call OEC_fnc_numberText],"PLAIN DOWN"];
    	[2] call OEC_fnc_ClupdatePartial;
    };
  };
  //claim arrests
  case 1: {
    _storedArrests = _player getVariable ["vigilanteArrestsStored",0];
    _action = [
      format ["你确定要宣布逮捕你吗？您当前存储了%1次逮捕。",oev_vigiarrests_stored],
      "确认",
      "是",
      "否"
    ] call BIS_fnc_guiMessage;
    if (_action) then {
      uiSleep (random(3));
      titleText [format["你对你的有效许可证申请了%1次逮捕。",_storedArrests],"PLAIN DOWN"];
      [5, player] remoteExec ["OES_fnc_vigiGetSetArrests",2];
      [2] call OEC_fnc_ClupdatePartial;
    };
  };
};
