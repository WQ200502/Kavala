#include <zmacro.h>
//  File: fn_populateInfo.sqf

disableSerialization;
params [
	["_members",[],[[]]],
	["_bank",[],[[]]]
];

waitUntil {!isNull (findDisplay 37000)};

(getControl(37000,37002)) ctrlSetText format[(localize "STR_GNOTF_Funds")+ " $%1",[_bank select 0] call OEC_fnc_numberText];

if(count _members isEqualTo 0) exitWith {
	hint "Failed to fetch members";
	[37000, 'right', false] spawn OEC_fnc_animateDialog;
};

private _control = getControl(37000,37003);
lbClear _control;
{
	_control lbAdd (format["%1 : %2",_x select 2,_x select 1]);
	_control lbSetData [(lbSize _control)-1,str(_x)];
	_control lbSetTooltip [(lbSize _control)-1,_x select 0];
} forEach _members;

private _rank = (oev_gang_data select 2);

if(_rank > 1) then {
	(getControl(37000,37008)) ctrlEnable true; //Invite Player

	if(_rank > 2) then {
		(getControl(37000,37005)) ctrlEnable true; // Kick
		(getControl(37000,37010)) ctrlEnable true; //promote
		(getControl(37000,37011)) ctrlEnable true; //demote
	};

	if(_rank > 4) then {
		(getControl(37000,37007)) ctrlEnable true; //Disband Gang
		(getControl(37000,37004)) ctrlEnable true; //Set New Leader
	};
};