//  File: fn_medicTicketPrompt.sqf
//	Author: [OS] Odin
//	Description: Prompts the player that he is being written an invoice.

private["_cop","_val"];
if(!isNull (findDisplay 2650)) exitwith {}; //Already at the ticket menu, block for abuse?
_cop = _this select 0;
if(isNull _cop) exitWith {};
_val = _this select 1;

["life_invoice_pay"] call OEC_fnc_createDialog;
disableSerialization;
waitUntil {!isnull (findDisplay 2600)};
_display = findDisplay 2600;
_control = _display displayCtrl 2601;
life_ticket_paid = false;
life_ticket_val = _val;
life_ticket_cop = _cop;
_control ctrlSetStructuredText parseText format["<t align='center'><t size='.8px'>" +(localize "STR_Medic_Invoice_GUI_Given"),_cop getVariable["realname",name _cop],[_val] call OEC_fnc_numberText];

[] spawn{
	disableSerialization;
	waitUntil {life_ticket_paid || (isNull (findDisplay 2600))};
	if(isNull (findDisplay 2600) && !life_ticket_paid) then
	{
		[[0,"STR_Medic_Invoice_Refuse",true,[profileName]],"OEC_fnc_broadcast",west,false] call OEC_fnc_MP;
		[[1,"STR_Medic_Invoice_Refuse",true,[profileName]],"OEC_fnc_broadcast",life_ticket_cop,false] call OEC_fnc_MP;
	};
};