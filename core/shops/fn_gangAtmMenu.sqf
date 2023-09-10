#include "..\..\macro.h"
//  File: fn_gangAtmMenu.sqf
//	Author: Bryan "Tonic" Boardwine

private["_display","_text","_units","_type"];

["Life_gang_atm_management"] call OEC_fnc_createDialog;
oev_gangfund_ready = false;
oev_gang_funds = -1;
[[0,oev_gang_data select 0,player],"OES_fnc_gangBank",false,false] spawn OEC_fnc_MP;

disableSerialization;
_display = findDisplay 3200;
_text ctrlSetStructuredText parseText format["<img size='1.7' image='images\icons\bank.paa'/> $%1<br/><img size='1.6' image='images\icons\money.paa'/> $%2"," loading...",[oev_cash] call OEC_fnc_numberText];
(getControl(3200,3202)) ctrlEnable false;
(getControl(3200,3203)) ctrlEnable false;

[] spawn{
	waitUntil{oev_gangfund_ready};
	uiSleep 0.5;
	disableSerialization;
	_display = findDisplay 3200;
	_text = _display displayCtrl 3201;
	_text ctrlSetStructuredText parseText format["<img size='1.7' image='images\icons\bank.paa'/> $%1<br/><img size='1.6' image='images\icons\money.paa'/> $%2",[oev_gang_funds] call OEC_fnc_numberText,[oev_cash] call OEC_fnc_numberText];

	if(oev_gang_funds < 1) then {
		(getControl(3200,3203)) ctrlEnable true;
	}else{
		if((oev_gang_data select 2) > 3) then {
			(getControl(3200,3202)) ctrlEnable true;
		};
		(getControl(3200,3203)) ctrlEnable true;
	};
};
