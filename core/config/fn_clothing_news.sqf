#include "..\..\macro.h"
//  File: fn_clothing_news.sqf
//	Author: Jesse "tkcjesse" Schultz

//	Description: Clothing shop configuration file for Altis News Shop.

params [
	["_filter",0,[0]]
];
//Classname, Custom Display name (use nil for Cfg->DisplayName, price

//Shop Title Name
ctrlSetText[3103,"News Station Wardrobe"];

private _ret = [];
switch (_filter) do {
	//Uniforms
	case 0:	{
		_ret = [
			["U_C_Journalist","Reporter Uniform",1000]
		];
		if (__GETC__(life_newslevel) >= 2) then {
			_ret pushBack ["U_C_Poor_2","Senior Reporter Uniform",1000];
		};
		if (__GETC__(life_newslevel) >= 3) then {
			_ret pushBack ["U_IG_Guerilla2_1","Anchor Uniform",1000];
		};
		if (__GETC__(life_newslevel) >= 4) then {
			_ret pushBack ["U_Competitor","Managing Editor Uniform",1000];
			_ret pushBack ["U_Marshal","Senior Member Uniform",1000];
		};
		if (__GETC__(life_newslevel) >= 5) then {
			_ret pushBack ["U_B_GEN_Soldier_F","Editor Uniform",1000];
		};
	};

	//Hats
	case 1: {
		_ret = [
			["H_Cap_press","Press Hat",500]
		];
	};

	//Glasses
	case 2: {
		_ret =
		[
			["G_Shades_Black",nil,25],
			["G_Shades_Blue",nil,20],
			["G_Sport_Blackred",nil,20],
			["G_Sport_Checkered",nil,20],
			["G_Sport_Blackyellow",nil,20],
			["G_Sport_BlackWhite",nil,20],
			["G_Sport_Red",nil,20],
			["G_Sport_Greenblack",nil,20],
			["G_Squares",nil,10],
			["G_Aviator",nil,100],
			["G_Lady_Mirror",nil,150],
			["G_Lady_Dark",nil,150],
			["G_Lady_Blue",nil,150],
			["G_Lowprofile",nil,30],
			["G_Combat",nil,55],
			["G_Spectacles_Tinted","Tinted Spectacles",55]
		];
	};

	//Vest
	case 3: {
		_ret = [
			["V_Rangemaster_belt","Utility Belt",500]
		];
		if (__GETC__(life_newslevel) >= 2) then {
			_ret pushBack ["V_Press_F","Press Vest",3000];
		};
	};

	//Backpacks
	case 4: {
		_ret = [
			["B_AssaultPack_blk","Toolkit Briefcase",1000]
		];
	};
};

_ret;