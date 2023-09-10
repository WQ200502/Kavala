//  File: fn_warLoadActive.sqf
//	Author: Jesse "tkcjesse" Schultz

//	Description: Runs after a player has recieved the active gang war array from the server
//	oev_gang_warIDs = [_gangID];
//	oev_gang_activeWars = [_gangID,_gangName];
//	oev_gang_warAccptIDs = [_accpt_id]; List of wars that were initated by your gang

params [
	["_queryResult",[],[[]]]
];

private _myGangID = (oev_gang_data select 0);
private _myGangName = (oev_gang_data select 1);

{
	_x params ["_init_id","_init_name","_acpt_id","_acpt_name"];

	if (_init_id isEqualTo _myGangID) then {
		oev_gang_activeWars pushBackUnique [_acpt_id,_acpt_name];
		oev_gang_warIDs pushBackUnique _acpt_id;
		oev_gang_warAccptIDs pushBackUnique _acpt_id;
	} else {
		oev_gang_activeWars pushBackUnique [_init_id,_init_name];
		oev_gang_warIDs pushBackUnique _init_id;
	};
} forEach _queryResult;

diag_log format ["ACTIVE WARS ARRAY:  %1",oev_gang_activeWars];
diag_log format ["ACTIVE WARS IDS:  %1",oev_gang_warIDs];