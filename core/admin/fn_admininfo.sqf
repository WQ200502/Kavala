//  File: fn_admininfo.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Output information received to admin menu.
private["_display","_ret","_text","_unit","_prim","_sec","_vest","_uni","_bp","_attach","_tmp","_timePlayed","_timeText"];
_ret = _this;
disableSerialization;
_display = findDisplay 2900;
_text = _display displayCtrl 2903;
_unit = _ret select 3;
_timePlayed = param [4,-1,[0]];

if(_timePlayed == -1) then {
	_timeText = "Unkown";
}else{
	_timeText = format["%1 hours, %2 mins",((_timePlayed - (_timePlayed % 60)) / 60), (_timePlayed % 60)];
};


_prim = if(primaryWeapon _unit != "") then { getText(configFile >> "CfgWeapons" >> (primaryWeapon _unit) >> "DisplayName")} else {"None"};
_sec = if(handgunWeapon _unit != "") then { getText(configFile >> "CfgWeapons" >> (handgunWeapon _unit) >> "DisplayName")} else {"None"};
_vest = if(vest _unit != "") then { getText(configFile >> "CfgWeapons" >> (vest _unit) >> "DisplayName")} else {"None"};
_uni = if(uniform _unit != "") then { getText(configFile >> "CfgWeapons" >> (uniform _unit) >> "DisplayName")} else {"None"};
_bp = if(backpack _unit != "") then { getText(configFile >> "CfgWeapons" >> (backpack _unit) >> "DisplayName")} else {"None"};

_attach = [];
if(primaryWeapon _unit != "") then
{
	{
		if(_x != "") then
		{
			_tmp = getText(configFile >> "CfgWeapons" >> _x >> "displayName");
			_attach pushBack _tmp;
		};
	} foreach (primaryWeaponItems _unit);
};

if(count _attach == 0) then {_attach = "None"};
_text ctrlSetStructuredText parseText format["姓名: %1<br/>总游戏时长: %2<br/>存款: %3<br/>现金: %4<br/>衣服: %5<br/>背心: %6<br/>背包: %7<br/>主要武器: %8<br/>副武器: %9<br/><t align='center'>主要附件</t><br/>%10",
_unit getVariable["realname",name _unit], _timeText, [_ret select 0] call OEC_fnc_numberText,[_ret select 1] call OEC_fnc_numberText,_uni,_vest,_bp,_prim,_sec,_attach];