#include <zmacro.h>
//	Author: Silex (Modified by djwolf)
//	file: fn_smartphone.sqf
private["_display","_units","_type","_data","_rowData","_msg","_sortedPlayers"];
_type = _this param [0,0];
_data = _this param [1,0,["",[],0]];
_idd = param [2,0,[0]];

disableSerialization;
waitUntil {!isNull (findDisplay _idd)};
_display = findDisplay 34000;
_cPlayerList = (findDisplay 34100) displayCtrl 34101;
_cMessageList = _display displayCtrl 34004;
_cMessageHeader = _display displayCtrl 34003;
_cMessageHeader ctrlSetText format["来至:                 消息内容:"];
switch(_type) do
{
	case 0:
	{
		lbClear _cPlayerList;
		_sortedPlayers = [];
		{
			if(alive _x /*&& _x != player*/) then
			{
				switch (side _x) do
				{
					case west: {_type = "Cop"};
					case civilian: {_type = "Civ"};
					case independent: {_type = "Med"};
				};

				_sortedPlayers pushBack [format["%1 (%2)",_x getVariable["realname",name _x],_type],_x];
			};
		} foreach playableUnits;

		_sortedPlayers sort true;

		diag_log format ["%1",_sortedPlayers];

		{
			_cPlayerList lbAdd (_x select 0);
			_cPlayerList lbSetData [(lbSize _cPlayerList)-1,str(_x select 1)];
		} foreach _sortedPlayers;
		ctrlEnable [34102,false];
	};

	case 1:
	{
		private "_pName";
		_pName = _data select 3;
		_msg = [_data select 2,40] call KRON_StrLeft;
		_rowData = [_data select 0, _data select 1, _data select 2, _data select 3];
		if ((count _pName) >= 27) then {
			_pName = format ["%1...",_pName select [0,21]];
		};
		_cMessageList lnbAddRow[_pName,format["%1 ...",_msg]];
		_cMessageList lnbSetData[[((lnbSize _cMessageList) select 0)-1,0],str(_rowData)];
	};

	case 2:
	{
		ctrlEnable[34102,true];
	};

	case 3:
	{
		[[(getPlayerUID player), player],"OES_fnc_msgRequest",false] call OEC_fnc_MP;
		ctrlEnable [34006,false];
	};
};