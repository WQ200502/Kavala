// fn_clientGroupKick

private["_unit","_group"];
_unit = _this select 0;
_group = _this select 1;
if(isNil "_unit" || isNil "_group") exitWith {};
openMap false;
if(player == _unit && (group player) == _group) then{
	oev_my_gang = ObjNull;
	player setVariable ["inGroup",false,true];
	player setVariable ["groupGang",[0,""]];
	profileNameSpace setVariable ["lastGroup",[grpNull,"","",0,0]];
	[player] joinSilent (createGroup civilian);
	hint "You have been kicked out of your group.";
	if(isNil {(group player) getVariable "gang_id"} && (count oev_gang_data != 0)) then {
		oev_action_inUse = true;
		if(!isNull (findDisplay 36000)) then {
			[] spawn OEC_fnc_groupMenu;
		};
		[] spawn OEC_fnc_initGang;
	};
};