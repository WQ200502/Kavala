/**
 * Author: TheGoldyOne
 * Discord: TheGoldyOne#6866
 * GitHub: https://github.com/TheGoldyOne/
 * File: fn_initadmin.sqf
 * Date: 25/04/2021, 15:12:59
 */

[3, "Info", "Ładowanie funkcji administratora", "GUI\data\displays\displayChatMessage\send.paa"] call GW_client_fnc_notificationsAdd;

onMapSingleClick '
			if (_alt) then {
				vehicle player setPos _pos;
				openMap[false,false];
			};
		';

[3, "Info", "Witamy Panie Administratorze", "GUI\data\displays\displayChatMessage\send.paa"] call GW_client_fnc_notificationsAdd;
