//  File: fn_licenseCheck.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Returns the licenses to the cop.
private["_cop"];
_cop = param [0,ObjNull,[ObjNull]];
if(isNull _cop) exitWith {}; //Bad entry

_licenses = "";
_tier = "";
_mode = 0;
//Licenses
{
	if(missionNamespace getVariable (_x select 0) && _x select 1 == "civ") then
	{
		_licenses = _licenses + ([_x select 0] call OEC_fnc_varToStr) + "<br/>";
	};
} foreach oev_licenses;

switch(true) do {
	case ((player getVariable ["isVigi",false]) && oev_vigiarrests < 25): {_tier = "Tier 1"; _mode = 1;};
	case ((player getVariable ["isVigi",false]) && (oev_vigiarrests >= 25 && oev_vigiarrests < 50)): {_tier = "Tier 2"; _mode = 1;};
	case ((player getVariable ["isVigi",false]) && (oev_vigiarrests >= 50 && oev_vigiarrests < 100)): {_tier = "Tier 3"; _mode = 1;};
	case ((player getVariable ["isVigi",false]) && (oev_vigiarrests >= 100 && oev_vigiarrests < 200)): {_tier = "Tier 4"; _mode = 1;};
	case ((player getVariable ["isVigi",false]) && oev_vigiarrests >= 200): {_tier = "Tier 5"; _mode = 1;};
	default {_tier = ""; _mode = 0;};
};

if(_licenses == "") then {_licenses = (localize "STR_Cop_NoLicensesFound");};

[[profileName,_licenses,_tier,_mode],"OEC_fnc_licensesRead",_cop,FALSE] spawn OEC_fnc_MP;

[[2,"STR_NOTF_LicenseSearch",true,[_cop getVariable ["realname",name _cop]]],"OEC_fnc_broadcast",player,false] spawn OEC_fnc_MP;