#include "..\..\..\macro.h"
//  File: fn_warMenu.sqf
//	Author: Jesse "tkcjesse" Schultz

//	Description: initalizes war menu stuff

disableSerialization;
private _display = findDisplay 37200;
private _statsBtn = _display displayCtrl 37204;
private _endBtn = _display displayCtrl 37203;
private _list = _display displayCtrl 37202;
private _invite = _display displayCtrl 37205;
private _combo = _display displayCtrl 37206;

_endBtn ctrlEnable false;
_invite buttonSetAction "[1,lbData[37206,lbCurSel(37206)]] spawn OEC_fnc_warSendInv;";

lbClear _list;
{
	_list lbAdd (_x select 1);
	_list lbSetValue [(lbSize _list)-1,(_x select 0)];
} forEach oev_gang_activeWars;
lbSort _list;
if ((oev_gang_data select 2) >= 3) then {
	_endBtn ctrlEnable true;
	_endBtn buttonSetAction "[] spawn OEC_fnc_warTerminate;";
};

_statsBtn buttonSetAction "[] spawn OEC_fnc_warGetStats;";

private _warableGangs = [];
private _warableIDs = [];
{
	if (side _x isEqualTo civilian) then {
		_gangData = _x getVariable ["gang_data",[0,"",0]];
		if ((_gangData select 2) >= 3) then {
			if !((_gangData select 0) in oev_gang_warIDs) then {
				if !((_gangData select 0) isEqualTo (oev_gang_data select 0)) then {
					_index = _warableIDs pushBackUnique (_gangData select 0);
					if !(_index isEqualTo -1) then {
						_warableGangs pushBack [_x,(_gangData select 1)];
					};
				};
			};
		};
	};
} forEach playableUnits;

lbClear _combo;
{
	_combo lbAdd (_x select 1);
	_combo lbSetData [(lbSize _combo)-1,str(_x select 0)];
} forEach _warableGangs;