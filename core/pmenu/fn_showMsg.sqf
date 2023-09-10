#include <zmacro.h>
//  File: fn_showMsg.sqf
//	Author: Silex

private["_index","_data"];
_index = _this param [0,0];

disableSerialization;
waitUntil {!isNull (findDisplay 34000)};
_display = findDisplay 34000;
_cMessageList = _display displayCtrl 34004;
_cMessageShow = _display displayCtrl 34005;
_cMessageHeader = _display displayCtrl 34002;

_data = call compile (_cMessageList lnbData[_index,0]);

_cMessageHeader ctrlSetText format["%1的消息内容:",_data select 3];
_cMessageShow ctrlSetText format["%1",_data select 2];