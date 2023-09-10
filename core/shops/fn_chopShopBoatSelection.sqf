#include "..\..\macro.h"
//  File: fn_chopShopBoatSelection.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Displays the pricing for the currently selected vehicle.
disableSerialization;
private["_control","_selection","_price","_priceTag"];
_control = param [0,controlNull,[controlNull]];
_selection = param [1,-1,[0]];

//Error checks
if(isNull _control || _selection == -1) exitWith {};

_price = _control lbValue _selection;

_priceTag = ((findDisplay 39404) displayCtrl 39405);
_priceTag ctrlSetStructuredText parseText format ["<t size='0.8'>" +(localize "STR_GNOTF_Price")+ "<t color='#8cff9b'>$%1</t></t>",[(_price * __GETC__(life_medDis))] call OEC_fnc_numberText];