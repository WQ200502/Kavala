//  File: fn_warStart.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Description: runs on both gangs after a war invite is accepted.

params [
	["_gangID",0,[0]],
	["_gangName","",[""]],
	["_mode",-1,[0]]
];
if (_gangID isEqualTo 0 || _gangName isEqualTo "" || _mode isEqualTo -1) exitWith {};

if ((oev_gang_warIDs pushBackUnique _gangID) isEqualTo -1) exitWith {};

oev_gang_activeWars pushBackUnique [_gangID,_gangName];
hint parseText format ["<t color='#FF0000'><t size='2'>War Started</t></t><br/>Your gang is now at war with: %1!<br/>RDM Rules will not apply for engagments between %1 and your gang! This is effective immediately and will persist through restarts! You can cancel the war anytime through your gang menu.",_gangName];

if (_mode isEqualTo 1) then {
	oev_gang_warAccptIDs pushBackUnique _gangID;
};