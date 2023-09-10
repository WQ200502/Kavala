#include "..\..\macro.h"
//  File: fn_clothingMenu.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Opens and initializes the clothing store menu.
if(scriptAvailable(3)) exitWith {};
private["_list","_clothes","_pic","_filter"];
life_clothing_store = _this select 3;

//Cop / Civ Pre Check
if((_this select 3) in ["bruce","dive","reb","kart","vigilante"] && playerSide != civilian) exitWith {hint localize "STR_Shop_NotaCiv";};
if(oev_newsTeam && {(_this select 3) in ["bruce","dive","reb","kart","vigilante","medic"]}) exitWith {hint "您不能作为新闻成员访问此存储！";};
if((_this select 3) == "reb" && !license_civ_rebel) exitWith {hint localize "STR_Shop_NotaReb";};
if((_this select 3) in ["cop"] && playerSide != west) exitWith {hint localize "STR_Shop_NotaCop";};
if((_this select 3) in ["dive"] && !license_civ_dive) exitWith { hint localize "STR_Shop_NotaDive";};
if((_this select 3) in ["medic"] && playerSide != independent) exitWith {hint "你必须是医生才能进入这家商店。";};
if((_this select 3) == "vigilante" && !license_civ_vigilante) exitWith {hint "你一定是个警员才能进入这家商店。";};
if((_this select 3) == "bwadmin" && (__GETC__(life_adminlevel) < 3)) exitWith {hint "你不是管理员！";};
if((_this select 3) == "news" && (__GETC__(life_newslevel) isEqualTo 0)) exitWith {hint "你不是新闻组成员！";};
if((player getVariable ["restrained",false]) || (player getVariable["downed",false])) exitWith {systemChat "你不能在被击倒时进入服装店。";};
if(player getVariable ["zipTied",false]) exitWith {systemChat "你不能在受到限制的情况下进入服装店。";};

//License Check?
_var = [life_clothing_store,0] call OEC_fnc_licenseType;
if(_var select 0 != "") then {
	if(!(missionNamespace getVariable (_var select 0))) exitWith {hint format[localize "STR_Shop_YouNeed",[_var select 0] call OEC_fnc_varToStr];};
};

if (life_clothing_store isEqualTo "war") then {
	oev_warpts_count = -999;
	hint "正在获取战争点数。。。";
	[[0,0,player],"OES_fnc_warGetSetPts",false,false] spawn OEC_fnc_MP;
	waitUntil {!(oev_warpts_count isEqualTo -999)};
	uiSleep 0.5;
	hint format ["你有%1个战争点数要花！",oev_warpts_count];
};

// Store Old Clothing
life_oldClothes = uniform player;
life_oldBackpack = backpack player;
life_oldVest = vest player;
life_oldGlasses = goggles player;
life_oldHat = headgear player;
life_oldMagazines = player call OEC_fnc_getMags;

_items = [];
{
	if !(_x in (magazines player)) then {
		_items pushBack _x;
	};
} forEach (uniformItems player);
life_oldUniformItems = _items;

_items = [];
{
	if !(_x in (magazines player)) then {
		_items pushBack _x;
	};
} forEach (vestItems player);
life_oldVestItems = _items;

_items = [];
{
	if !(_x in (magazines player)) then {
		_items pushBack _x;
	};
} forEach (backpackItems player);
life_oldBackpackItems = _items;

{
	player removeMagazines (_x select 0);
} forEach life_oldMagazines;

// Create Dialog
["Life_Clothing"] call OEC_fnc_createDialog;
disableSerialization;

//init camera view
life_shop_cam = "CAMERA" camCreate getPos player; 
showCinemaBorder false; 
life_shop_cam cameraEffect ["Internal", "Back"]; 
life_shop_cam camSetTarget (player modelToWorld [0,0,1]); 
life_shop_cam camSetPos (player modelToWorld[1.9,0,1]); 
life_shop_cam camSetFOV .85; 
life_shop_cam camSetFocus [50, 0]; 
life_shop_cam camCommit 0;

if(isNull (findDisplay 3100)) exitWith {life_shop_cam cameraEffect ["TERMINATE","BACK"];camDestroy life_shop_cam;};
_list = (findDisplay 3100) displayCtrl 3101;
_filter = (findDisplay 3100) displayCtrl 3105;
lbClear _filter;
lbClear _list;

_filter lbAdd localize "STR_Shop_UI_Clothing";
_filter lbAdd localize "STR_Shop_UI_Hats";
_filter lbAdd localize "STR_Shop_UI_Glasses";
_filter lbAdd localize "STR_Shop_UI_Vests";
_filter lbAdd localize "STR_Shop_UI_Backpack";

_filter lbSetCurSel 0;



waitUntil {isNull (findDisplay 3100)};
life_shop_cam cameraEffect ["TERMINATE","BACK"];
camDestroy life_shop_cam;
oev_clothing_filter = 0;
if(isNil "life_clothesPurchased") exitWith {
	oev_clothing_purchase = [-1,-1,-1,-1,-1];
	oev_clothing_data = ["","","","",""];
	if(life_oldClothes != "") then {player addUniform life_oldClothes;} else {removeUniform player};

	if(life_oldHat != "") then {player addHeadgear life_oldHat} else {removeHeadgear player;};
	if(life_oldGlasses != "") then {player addGoggles life_oldGlasses;} else {removeGoggles player};
	if(backpack player != "") then {
		if(life_oldBackpack == "") then {
			removeBackpack player;
		} else {
			removeBackpack player;
			player addBackpack life_oldBackpack;
			clearAllItemsFromBackpack player;
			if(count life_oldBackpackItems > 0) then {
				{
					[_x,true,true] call OEC_fnc_handleItem;
				} forEach life_oldBackpackItems;
			};
		};
	};

	if(count life_oldUniformItems > 0) then {
		{[_x,true,false,false,true] call OEC_fnc_handleItem;} forEach life_oldUniformItems;
	};

	if(vest player != "") then {
		if(life_oldVest == "") then {
			removeVest player;
		} else {
				player addVest life_oldVest;
				if(count life_oldVestItems > 0) then {
				{[_x,true,false,false,true] call OEC_fnc_handleItem;} forEach life_oldVestItems;
			};
		};
	};

	{
		for "_i" from 0 to ((_x select 2) - 1) do {
			player addMagazine [(_x select 0),(_x select 1)];
		};
	} forEach life_oldMagazines;
};
life_clothesPurchased = nil;

//Check uniform purchase.
if((oev_clothing_purchase select 0) == -1) then {
	if(life_oldClothes != uniform player) then {player addUniform life_oldClothes;};
};
//Check hat
if((oev_clothing_purchase select 1) == -1) then {
	if(life_oldHat != headgear player) then {if(life_oldHat == "") then {removeHeadGear player;} else {player addHeadGear life_oldHat;};};
};
//Check glasses
if((oev_clothing_purchase select 2) == -1) then {
	if(life_oldGlasses != goggles player) then {
		if(life_oldGlasses == "") then {
			removeGoggles player;
		} else {
			player addGoggles life_oldGlasses;
		};
	};
};
//Check Vest
if((oev_clothing_purchase select 3) == -1) then {
	if(life_oldVest != vest player) then {
		if(life_oldVest == "") then {
			removeVest player;
		} else {
			player addVest life_oldVest;
			{[_x,true,false,false,true] call OEC_fnc_handleItem;} forEach life_oldVestItems;
		};
	};
};

//Check Backpack
if((oev_clothing_purchase select 4) == -1) then {
	if(life_oldBackpack != backpack player) then {
		if(life_oldBackpack == "") then {
			removeBackpack player;
		} else {
			removeBackpack player;
			player addBackpack life_oldBackpack;
			{[_x,true,true] call OEC_fnc_handleItem;} forEach life_oldBackpackItems;
		};
	};
};

oev_clothing_purchase = [-1,-1,-1,-1,-1];
oev_clothing_data = ["","","","",""];

{
	for "_i" from 0 to ((_x select 2) - 1) do {
		player addMagazine [(_x select 0),(_x select 1)];
	};
} forEach life_oldMagazines;

[false] call OEC_fnc_saveGear;
