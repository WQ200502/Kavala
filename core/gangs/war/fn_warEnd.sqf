//  File: fn_warEnd.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Description: Broadcasts on all gang clients to end a war.

params [
	["_gangID",0,[0]],
	["_gangName","",[""]]
];
if (_gangID isEqualTo 0 || _gangName isEqualTo "") exitWith {};

if (_gangID in oev_gang_warAccptIDs) then {
	oev_gang_warAccptIDs deleteAt (oev_gang_warAccptIDs find _gangID);
};

oev_gang_warIDs deleteAt (oev_gang_warIDs find _gangID);

private _index = -1;
{
	if ((_x select 0) isEqualTo _gangID) exitWith {
		_index = _forEachIndex;
	};
} forEach oev_gang_activeWars;

if (_index isEqualTo -1) exitWith {hint "Error Occured: War didn't end correctly.";};
oev_gang_activeWars deleteAt _index;

hint parseText format ["<t color='#00CC00'><t size='2'>War Over</t></t><br/>Your gang is no longer at war with: %1!<br/>RDM Rules will now apply for all engagments between %1 and your gang! This is effective immediately!",_gangName];