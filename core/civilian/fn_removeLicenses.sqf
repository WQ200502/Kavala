//  File: fn_removeLicenses.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Used for stripping certain licenses off of civilians as punishment.
private["_state"];
_state = param [0,1,[0]];

switch (_state) do
{
	//jail
	case 0:
	{
		license_civ_gun = false;
		license_civ_wpl = false;
		license_civ_vigilante = false;
	};
};