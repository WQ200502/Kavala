// 	File: fn_houseConfig.sqf
//	Author: Bryan "Tonic" Boardwine
//  Modifications: Fusah
//	Description: Master config file for buyable houses?

private["_house","_info","_price"];
_house = param [0,"",[""]];
if(_house == "") exitWith {[]};

switch (true) do {
	case (_house in ["Land_i_House_Big_02_V1_F","Land_i_House_Big_02_V2_F","Land_i_House_Big_02_V3_F","Land_i_House_Big_02_b_blue_F","Land_i_House_Big_02_b_pink_F","Land_i_House_Big_02_b_whiteblue_F","Land_i_House_Big_02_b_white_F","Land_i_House_Big_02_b_brown_F","Land_i_House_Big_02_b_yellow_F"]): {_info = [1550000,3]};
	case (_house in ["Land_i_House_Big_01_V1_F","Land_i_House_Big_01_V2_F","Land_i_House_Big_01_V3_F","Land_i_House_Big_01_b_yellow_F","Land_i_House_Big_01_b_brown_F","Land_i_House_Big_01_b_white_F","Land_i_House_Big_01_b_whiteblue_F","Land_i_House_Big_01_b_pink_F","Land_i_House_Big_01_b_blue_F"]): {_info = [2200000,4]};
	case (_house in ["Land_i_Garage_V1_F","Land_i_Garage_V2_F"]): {_info = [500000,0]};
	case (_house in ["Land_i_House_Small_01_V1_F","Land_i_House_Small_01_V2_F","Land_i_House_Small_01_V3_F","Land_i_House_Small_01_b_pink_F","Land_i_House_Small_01_b_white_F","Land_i_House_Small_01_b_yellow_F","Land_i_House_Small_01_b_whiteblue_F","Land_i_House_Small_01_b_brown_F","Land_i_House_Small_01_b_yellow_F","Land_i_House_Small_01_b_blue_F"]): {_info = [1050000,2]};
	case (_house in ["Land_i_House_Small_02_V1_F","Land_i_House_Small_02_V2_F","Land_i_House_Small_02_V3_F","Land_i_House_Small_02_b_white_F","Land_i_House_Small_02_b_whiteblue_F","Land_i_House_Small_02_b_yellow_F","Land_i_House_Small_02_b_blue_F","Land_i_House_Small_02_b_pink_F"]): {_info = [1000500,2]};
	case (_house in ["Land_i_House_Small_03_V1_F"]): {_info = [1250000,3]};
	case (_house in ["Land_i_Stone_HouseSmall_V2_F","Land_i_Stone_HouseSmall_V1_F","Land_i_Stone_HouseSmall_V3_F"]): {_info = [750000,1]};
	case (_house in ["Land_i_Addon_02_V1_F","Land_i_Stone_Shed_V1_F","Land_i_Stone_Shed_V2_F","Land_i_Stone_Shed_V3_F","Land_i_Stone_Shed_01_b_clay_F","Land_i_Stone_Shed_01_b_white_F","Land_i_Stone_Shed_01_b_white_F"]): {_info = [450000,0]};
	case (_house in ["Land_i_Shed_Ind_F"]): {_info = [20000000,0]};
	default {_info = []};
};

if ((count _info) isEqualTo 0) exitWith {_info};

_price = _info select 0;

if (life_donation_house) then {
	_info set [0,_price * .85];
};

_info;