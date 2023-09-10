//  File: fn_seizeMoneyConfirmation.sqf
//	Author: TheCmdrRex
//	Description: Yes this is a script for a confirmation because arma sucks. Probably will change this into a universal cop confirmation script

params [
	["_suspect",objNull,[objNull]]
];

closeDialog 0;

private _action = [
	format ["您确定要扣押%1的现金吗", name _suspect],
	"现金扣押确认书",
	"是",
	"否"
] call BIS_fnc_guiMessage;

if !(_action) exitWith {};

[[3,player],"OEC_fnc_seizePlayerItems",_suspect,false] spawn OEC_fnc_MP;