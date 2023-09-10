//  File: fn_ticketPrompt
//	Author: Bryan "Tonic" Boardwine
//	Description: Prompts the player that he is being ticketed.
private["_cop","_val","_display","_control"];
if(!isNull (findDisplay 2600)) exitwith {}; //Already at the ticket menu, block for abuse?
_cop = _this select 0;
if(isNull _cop) exitWith {};
_val = _this select 1;

["life_ticket_pay"] call OEC_fnc_createDialog;
disableSerialization;
waitUntil {!isnull (findDisplay 2600)};
_display = findDisplay 2600;
_control = _display displayCtrl 2601;
life_ticket_paid = false;
life_ticket_val = _val;
life_ticket_cop = _cop;
_control ctrlSetStructuredText parseText format["<t align='center'><t size='.8px'>%1给你开了一张%2元的罚单。<br/>您当前的银行存款为$%3",_cop getVariable["realname",name _cop],[_val] call OEC_fnc_numberText, [oev_atmcash] call OEC_fnc_numberText];
[
	["event","Ticketed"],
	["player",name player],
	["player_id",getPlayerUID player],
	["officer",name _cop],
	["officer_id",getPlayerUID _cop],
	["amount",_val],
	["position",getPosATL player]
] call OEC_fnc_logIt;


[] spawn{
	disableSerialization;
	waitUntil {life_ticket_paid || (isNull (findDisplay 2600))};
	if(isNull (findDisplay 2600) && !life_ticket_paid) then {
		[0,"STR_Cop_Ticket_Refuse",true,[profileName]] remoteExecCall ["OEC_fnc_broadcast",west];
		[1,"STR_Cop_Ticket_Refuse",true,[profileName]] remoteExecCall ["OEC_fnc_broadcast",life_ticket_cop];
		[
			["event","Refused Ticket"],
			["player",name player],
			["player_id",getPlayerUID player],
			["officer",name life_ticket_cop],
			["officer_id",getPlayerUID life_ticket_cop],
			["amount",life_ticket_val],
			["position",getPosATL player]
		] call OEC_fnc_logIt;
	};
};
