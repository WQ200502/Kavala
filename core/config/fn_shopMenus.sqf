//  File: fn_shopMenus.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Master config for a thing that will be gone eventually..
private["_shop"];
_shop = param [0,"",[""]];
if(_shop == "") exitWith {closeDialog 0;};

if(!dialog) then
{
	["shop_menu"] call OEC_fnc_createDialog;
};
disableSerialization;
ctrlSetText[601,format["Cash: $%1",[oev_cash] call OEC_fnc_numberText]];

switch (_shop) do
{
	case "reb":
	{
		ctrlSetText[2505,"Altis Rebel Shop"];
		ctrlShow[2503,false];
		ctrlShow[2513,false];
		ctrlShow[2514,false];
	};

	case "cop":
	{
		ctrlSetText[2505,"Altis Cop Shop"];
		ctrlShow[2503,false];
	};

	case "gun":
	{
		ctrlSetText[2505,"Altis Gun Store"];
		ctrlShow[2503,false];
		ctrlShow[2513,false];
		ctrlShow[2514,false];
	};

	case "wpl":
	{
		ctrlSetText[2505,"Workers Protection Store"];
		ctrlShow[2503,false];
		ctrlShow[2513,false];
		ctrlShow[2514,false];
	};

	case "gang":
	{
		ctrlSetText[2505,"Gang Shop"];
		ctrlShow[2503,false];
		ctrlShow[2513,false];
		ctrlShow[2514,false];
	};

	case "dive":
	{
		ctrlSetText[2505,"Altis Diving Shop"];
		ctrlShow[2503,false];
		ctrlShow[2510,false];
		ctrlShow[2511,false];
		ctrlShow[2513,false];
	};

	case "donator":
	{
		ctrlSetText[2505,"Donator Shop"];
	};

	case "sergeant":
	{
		ctrlSetText[2505,"Sergeants Shop"];
		ctrlShow[2503,false];
	};

	case "gen":
	{
		ctrlSetText[2505,"Altis General Store"];
		ctrlShow[2503,false];
	};

	case "officer":
	{
		ctrlSetText[2505,"Patrol Officer Shop"];
		ctrlShow[2503,false];
	};

	case "admin":
	{
		ctrlSetText[2505,"Admin Shop"];
	};
};

["guns"] call OEC_fnc_shops_changeMenu;
