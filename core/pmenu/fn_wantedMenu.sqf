#include <zmacro.h>
//  File: fn_wantedMenu.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Opens the Wanted menu and connects to the APD.
private["_display","_list","_name","_crimes","_bounty","_units"];
disableSerialization;

_display = findDisplay 39000;
_list = _display displayCtrl 39003;
_list2 = _display displayCtrl 39004;
lbClear _list;
lbClear _list2; // prevent any charges from staying after u pardonded them ^___^
ctrlSetText[39001,"****** ****"];
ctrlSetText[39002,"Bounty: $***,***"];
_units = [];

ctrlSetText[39007,"Establishing connection..."];
//I think this is duplicate code from wantedInfo and I will revisit it later
if(__GETC__(life_coplevel) < 3 && __GETC__(life_adminlevel) == 0) then
{
	ctrlShow[39005,false];
};
if(__GETC__(life_coplevel) < 2) then {
	ctrlShow[39006,false];
};

[[player],"OES_fnc_wantedFetch",false,false] spawn OEC_fnc_MP;
