//  File: fn_warTerminate.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Description: Takes war menu selection and terminates war via prompt.

disableSerialization;
if ((lbCurSel 37202) isEqualTo -1) exitWith {hint "You didn't select a war from the list to end!";};
private _control = ((findDisplay 37200) displayCtrl 37202);
private _gangID = _control lbValue (lbCurSel _control);
private _gangName = "";

{
	if ((_x select 0) isEqualTo _gangID) exitWith {_gangName = (_x select 1);};
} forEach oev_gang_activeWars;
if (_gangName isEqualTo "") exitWith {hint "Unable to find an active gang with that name. Try again.";};


private _action = [
	format["Are you sure you want to end the war with the gang %1? The war will end immediately and RDM rules will apply once again.",_gangName],
	"End the War?",
	"End War",
	"Keep War"
] call BIS_fnc_guiMessage;

private _myGangID = (oev_gang_data select 0);
private _myGangName = (oev_gang_data select 1);

if (_action) then {
	[[_gangID,_myGangID],"OES_fnc_warRemoveGang",false,false] spawn OEC_fnc_MP;

	private _enemy = ([_gangID] call OEC_fnc_getOnlineMembers);
	private _ally = ([_myGangID] call OEC_fnc_getOnlineMembers);

	[[_gangID,_gangName],"OEC_fnc_warEnd",_ally,false] spawn OEC_fnc_MP;
	[[_myGangID,_myGangName],"OEC_fnc_warEnd",_enemy,false] spawn OEC_fnc_MP;

	[
		["event","Ended Gang War"],
		["player",name player],
		["player_id",getPlayerUID player],
		["gang",_myGangName],
		["gang_id",_myGangID],
		["target_gang",_gangName],
		["target_gang_id",_gangID],
		["position",getPosATL player]
	] call OEC_fnc_logIt;


} else {
	hint format ["You have declined to end the war between your gang and %1. The war continues on!",_gangName];
};
