//  File: fn_robPerson.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Getting tired of adding descriptions...
private["_robber","_robbedValue","_robbedPlayer","_robbedUID"];
_robber = param [0,ObjNull,[ObjNull]];
_robbedPlayer = player;
_robbedUID = getPlayerUID player;
if(isNull _robber) exitWith {};

if(oev_cash > 0) then {
	if((call oev_restrictions) || _robber getVariable ["restrictions", false]) then {
		_robbedValue = round(oev_cash * 0.5);
	} else {
		_robbedValue = oev_cash;
	};
	oev_cash = 0;
	oev_cache_cash = oev_random_cash_val;
	[0] call OEC_fnc_ClupdatePartial;

	sleep 3;

	[[_robbedValue,_robbedPlayer,_robbedUID],"OEC_fnc_robReceive",_robber,false] spawn OEC_fnc_MP;
	[[getPlayerUID _robber,_robber getVariable["realname",name _robber],"8",_robber],"OES_fnc_wantedAdd",false,false] spawn OEC_fnc_MP;
	[[1,"STR_NOTF_Robbed",true,[_robber getVariable["realname",name _robber],profileName,[_robbedValue] call OEC_fnc_numberText]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;

	[
		["event", "Got Robbed"],
		["player", name player],
		["player_id", getPlayerUID player],
		["by", name _robber],
		["by_id", getPlayerUID _robber],
		["amount", _robbedValue],
		["position", getPos player]
	]	call OEC_fnc_logIt;
}
	else
{
	[[2,"STR_NOTF_RobFail",true,[profileName]],"OEC_fnc_broadcast",_robber,false] spawn OEC_fnc_MP;
};
