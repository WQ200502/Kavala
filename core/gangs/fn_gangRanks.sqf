
//  File: fn_gangRanks.sqf
//	Author: Bryan "Tonic" Boardwine
//  Modifications: Jesse,Fusah
//	Description: Manage Ranks

private["_rank"];
_rank = _this param [0,0,[0]];
oev_gang_data set [2,_rank];
hint format["你的帮派等级现在是: %1",_rank];
player setVariable["gang_data",oev_gang_data,true];

switch(_rank) do {
	case -1: {
		if(!isNull (findDisplay 37000)) then {['yMenuCreateGang'] spawn OEC_fnc_createDialog;};
		hint "你不再是帮派成员了。";		
		if (count oev_gang_data isEqualTo 4) then {
			[1] call OEC_fnc_gangBldgDraw;
			oev_gangShedPos = [];	
		};
		if(!isNil {(group player) getVariable "gang_id"}) then {
			[player] joinSilent (createGroup civilian);
		};
		oev_gang_data = [];
		player setVariable["gang_data",nil,true];
	};
	case 3: {systemChat "你现在可以邀请其他玩家加入你的帮派。";};
	case 4: {systemChat "你现在可以提升，降职，提取资金，并从你的帮派踢出成员。";};
	case 5: {
		hint "你现在是帮派头目了！";
		if(!isNil {(group player) getVariable "gang_id"}) then {
			player setRank "COLONEL";
			group player selectLeader player;
		};
	};
};