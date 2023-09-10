//	Author: djwolf
//	Date: 11/10/2015
//	File: fn_eventInventory.sqf

//	Description: Designed to handle and keep track of the client's inventory for the duration of the event.
//	Organization: Olympus Entertainment
//	Notes: Case 0 saves the current inventory(x), case 1 loads the event inventory, case 2 loads the (x) inventory from case 0

private ["_mode","_team"];
_mode = param [0,-1,[0]];
_team = param [1,"",[""]];
switch (_mode) do {
	case 0:
	{
		oev_curGear set [0,uniform player];
		oev_curGear set [1,vest player];
		oev_curGear set [2,backPack player];
		oev_curGear set [3,primaryWeapon player];
		oev_curGear set [4,secondaryWeapon player];
		oev_curGear set [5,headGear player];
		oev_curGear set [6,uniformItems player];
		oev_curGear set [7,vestItems player];
		oev_curGear set [8,backpackItems player];
		oev_curGear set [9,primaryWeaponItems player];
		oev_curGear set [10,secondaryWeaponItems player];
		oev_curGear set [11,assignedItems player];
		oev_curGear set [12,uniformMagazines player];
		oev_curGear set [13,vestMagazines player];
		oev_curGear set [14,backpackMagazines player];
	};
	case 1:
	{
		[] call OEC_fnc_stripDownPlayer;
		switch (_team) do {
			case "blue":
			{
				player addUniform "U_B_Protagonist_VR";
			};
			case "red":
			{
				player addUniform "U_O_Protagonist_VR"
			};
		};
		player addWeapon "hgun_Pistol_heavy_01_F";
		player addMagazines ["11Rnd_45ACP_Mag",25];
	};
	case 2:
	{
		[] call OEC_fnc_stripDownPlayer;
		player addUniform (oev_curGear select 0);
		player addVest (oev_curGear select 1);
		player addBackpack (oev_curGear select 2);
		player addWeapon (oev_curGear select 3);
		player addWeapon (oev_curGear select 4);
		player addHeadgear (oev_curGear select 5);
		{player addItemToUniform _x} forEach (oev_curGear select 6);
		{player addItemToVest _x} forEach (oev_curGear select 7);
		{player addItemToBackpack _x} forEach (oev_curGear select 8);
		{player addPrimaryWeaponItem _x} forEach (oev_curGear select 9);
		{player addSecondaryWeaponItem _x} forEach (oev_curGear select 10);
		if ("ItemMap" in (oev_curGear select 11)) then {
			player addItem "ItemMap";
			player assignItem "ItemMap";
		};
		if ("ItemCompass" in (oev_curGear select 11)) then {
			player addItem "ItemCompass";
			player assignItem "ItemCompass";
		};
		if ("ItemWatch" in (oev_curGear select 11)) then {
			player addItem "ItemWatch";
			player assignItem "ItemWatch";
		};
		if ("ItemRadio" in (oev_curGear select 11)) then {
			player addItem "ItemRadio";
			player assignItem "ItemRadio";
		};
		if ("ItemGPS" in (oev_curGear select 11)) then {
			player addItem "ItemGPS";
			player assignItem "ItemGPS";
		};
		if ("NVGoggles" in (oev_curGear select 11)) then {
			player addItem "NVGoggles";
			player assignItem "NVGoggles";
		};
		{player addMagazine _x} forEach (oev_curGear select 12);
		{player addMagazine _x} forEach (oev_curGear select 13);
		{player addMagazine _x} forEach (oev_curGear select 14);
	};
};