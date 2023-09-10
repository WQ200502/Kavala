//	File: fn_blastingcharge.sqf
//	Author: Bryan "Tonic" Boardwine
//	Modifications: Jesse "tkcjesse" Schultz, Fusah
//	Description: Blasting charge for blackwater, fed, and jail. Gets handled serverside

params [
	["_vault",objNull,[objNull]]
];
private _fakeBomb = nearestObject [[30087.1,77.889,0.00143886],"Land_CargoBox_V1_F"];
private _fedDome = nearestObject [[16019.5,16952.9,0],"Land_Dome_Big_F"];
private _badWeapons = ["30Rnd_9x21_Mag", "16Rnd_9x21_Mag", "11Rnd_45ACP_Mag", "30Rnd_9x21_Mag_SMG_02", "6Rnd_45ACP_Cylinder", "9Rnd_45ACP_Mag"];
if ((oev_is_arrested select 0) isEqualTo 1) exitWith {hint "You cannot plant a bomb from inside jail.";};
if (isNull _vault) exitWith {}; //Bad object
if (_vault == _fakeBomb) exitWith {hint "Nice try, this vault has nothing in it ;)"}; //yea lets not
private _copCount = [west,2] call OEC_fnc_playerCount;
if (typeOf _vault isEqualTo "Land_CargoBox_V1_F" && (_copCount < 5)) exitWith {hint localize "STR_Civ_NotEnoughCops";};
if (typeOf _vault isEqualTo "CargoNet_01_box_F" && (_copCount < 4)) exitWith {hint localize "STR_Civ_NotEnoughCops";};
if (typeOf _vault isEqualTo "CargoNet_01_box_F" && ((_vault getVariable ["bankCooldown",0]) > serverTime)) exitWith {hint "The bank was recently robbed and has no money in the vault! Try again later.";};
if (typeOf _vault isEqualTo "CargoNet_01_box_F" && (((altis_bank getVariable ["chargeplaced",false]) || (altis_bank_1 getVariable ["chargeplaced",false]) || (altis_bank_2 getVariable ["chargeplaced",false])))) exitWith {hint "Another bank vault is already being robbed!";};
if (typeOf _vault isEqualTo "Land_Dome_Big_F" && (player distance (getMarkerPos "bw_marker") > 150)) exitWith {};//not at a blackwater dome, dont let them plant
if ((typeOf _vault isEqualTo "Land_Dome_Big_F" && (player distance (getMarkerPos "bw_marker") < 150)) && (_copCount < 7)) exitWith {hint "There needs to be 7 or more cops online to continue.";};//are they at BW dome? if so check if enough cops on
if (typeOf _vault isEqualTo "Land_Dome_Big_F" && (_vault getVariable ["bwcooldown",true])) exitWith {hint "The Blackwater Facility has recently been robbed!";};
if (!(typeOf _vault in ["Land_CargoBox_V1_F","Land_Mil_WallBig_4m_battered_F","Land_Dome_Big_F","CargoNet_01_box_F"])) exitWith {hint localize "STR_ISTR_Blast_VaultOnly"};
if (_vault getVariable["chargeplaced",false]) exitWith {hint localize "STR_ISTR_Blast_AlreadyPlaced"};
if (_vault getVariable["safe_open",false]) exitWith {hint localize "STR_ISTR_Blast_AlreadyOpen"};
if (typeOf _vault isEqualTo "Land_CargoBox_V1_F" && ((_fedDome getVariable ["bis_disabled_door_3",0]) isEqualTo 1) && ((_fedDome getVariable ["bis_disabled_door_2",0]) isEqualTo 1) && alive _fedDome) exitWith {hint "You are not able to plant the bomb before dome has been bolt cutted!"};
if (typeOf _vault isEqualTo "CargoNet_01_box_F" && oev_allFederalCooldown > time) exitWith {hint format ["A federal event has happened recently, you can not plant a bomb for %1 more seconds.", round(oev_allFederalCooldown - time)]};
if (typeOf _vault isEqualTo "Land_Dome_Big_F" && oev_allFederalCooldown > time) exitWith {hint format ["Due to the recent robbery at the Federal Reserve/Jail, the Blackwater Facility is under extreme lockdown. You can not plant a bomb for %1 more seconds.", round(oev_allFederalCooldown - time)]};
if (typeOf _vault isEqualTo "Land_CargoBox_V1_F" && oev_allFederalCooldown > time) exitWith {hint format ["Due to the recent robbery at the Blackwater Facility/Jail, the Federal Reserve is under extreme lockdown. You can not plant a bomb for %1 more seconds.", round(oev_allFederalCooldown - time)]};
if (typeOf _vault isEqualTo "Land_Mil_WallBig_4m_battered_F" && oev_allFederalCooldown > time) exitWith {hint format ["Due to the recent robbery at the Blackwater Facility/Federal Reserve, the Jail is under extreme lockdown. You can not plant a bomb for %1 more seconds.", round(oev_allFederalCooldown - time)]};

private _exit = false;
private _exit2 = false;
_civCount = 0;
if !(typeOf _vault isEqualTo "Land_Mil_WallBig_4m_battered_F") then {
	private _bwBldg = nearestObject [[20898.6,19221.7,0.00143909],"Land_Dome_Big_F"];
	if ((_bwBldg getVariable ["chargeplaced",false]) || (fed_bank getVariable ["chargeplaced",false]) || (jailwall getVariable ["chargeplaced",false])) exitWith {_exit = true;};
};
if (typeOf _vault in ["Land_CargoBox_V1_F","Land_Mil_WallBig_4m_battered_F","Land_Dome_Big_F","CargoNet_01_box_F"]) then {
	private _poly = switch (typeOf _vault) do {
		case "Land_CargoBox_V1_F": {oev_federalReservePoly};
		case "Land_Mil_WallBig_4m_battered_F": {oev_jailPoly};
		case "Land_Dome_Big_F": {oev_blackwaterPoly};
		case "CargoNet_01_box_F":{oev_bankPoly};
	};
	_civCount = {side _x isEqualTo civilian && (getPos _x) inPolygon _poly && !(player getVariable["jailed",false]) && (!(currentWeapon _x isEqualTo "") || currentMagazine _x in _badWeapons)} count playableUnits;
	if (_civCount < 2 || (typeOf _vault isEqualTo "CargoNet_01_box_F" && _civCount < 3)) exitWith {_exit2 = true;};
};

if (_exit) exitWith {hint "You cannot rob the bank while a Federal Event is taking place!";};
if (_exit2) exitWith {
	private _civs = if(typeOf _vault isEqualTo "CargoNet_01_box_F") then {3} else {2};
	hint format ["You need %1 more armed civilian(s) nearby with 5.56+ to begin planting the bomb!", _civs - _civCount];
};

//prevent all charges from being planted at once
hint "Planting bomb";
uiSleep round(random(1));
uiSleep round(random(1));
uiSleep round(random(1));
if (typeOf _vault isEqualTo "CargoNet_01_box_F" && (((altis_bank getVariable ["chargeplaced",false]) || (altis_bank_1 getVariable ["chargeplaced",false]) || (altis_bank_2 getVariable ["chargeplaced",false])))) exitWith {hint "Another bank vault is already being robbed!";};

if !([false,"blastingcharge",1] call OEC_fnc_handleInv) exitWith {};
[getPlayerUID player, profileName, "55", player] remoteExec ["OES_fnc_wantedAdd", 2];
[_vault, getPlayerUID player] remoteExec ["OES_fnc_handleBombTimer", 2];
[_vault] remoteExec ["OEC_fnc_demoChargeTimer", group player];

switch (typeOf _vault) do {
	case "Land_CargoBox_V1_F": {["blastfed",1] call OEC_fnc_statArrUp;};
	case "CargoNet_01_box_F": {["blastbank",1] call OEC_fnc_statArrUp;};
	case "Land_Mil_WallBig_4m_battered_F": {["blastjail",1] call OEC_fnc_statArrUp;};
	case "Land_Dome_Big_F": {["blastbw",1] call OEC_fnc_statArrUp;};
};
