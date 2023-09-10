//  File: fn_colorVehicle.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Reskins the vehicle
private["_vehicle","_index","_texture","_texture2","_texture3","_texture4","_chrome"];
_vehicle = param [0,Objnull,[Objnull]];
_index = param [1,["Default",0],[]];
_side = param [2,civilian,[civilian]];
if(isNull _vehicle || !alive _vehicle) exitWith {};
// FYI: this is not whitelisting of chroming vehicles, but whitelisting what areas of chrome for certain vehicles
_oneRegionChrome = ["C_Offroad_01_repair_F","B_Heli_Light_01_F","B_Quadbike_01_F","C_Offroad_01_F","B_G_Offroad_01_F","B_G_Offroad_01_armed_F","I_G_Offroad_01_armed_F","I_MRAP_03_F","C_Boat_Civil_01_rescue_F","C_Boat_Civil_01_F","C_Boat_Civil_01_police_F","C_Hatchback_01_sport_F","O_LSV_02_unarmed_viper_F","O_T_LSV_02_armed_F"];
_twoRegionChrome = ["I_Truck_02_transport_F","I_Truck_02_covered_F","B_Heli_Transport_01_camo_F","B_Heli_Transport_03_black_F"];
_threeRegionChrome = ["I_Heli_Transport_02_F"];

//Fetch textures of current vehicle.
_textures = ["allSkins",(typeOf _vehicle)] call OEC_fnc_vehicleSkins;
_texture = ["","",[""]];
_retry = true;
if(isNil "_textures") exitWith {};
if(count _textures == 0) exitWith {};
if (local _vehicle) then {
	//Check the index if we need to default
	{
		if ((_x select 0) isEqualTo (_index select 0)) exitWith {
			_texture = _x select 2;
			_retry = false;
		};
	}forEach _textures;

	if((_index select 0) isEqualType 0 || (_texture select 0)isEqualTo "") then {
		//Set the default if texture in the database isn't valid anymore
		switch (_side) do {
			case west: {_index set [0,"Police"]};
			case independent: {_index set [0,"Rescue"]};
			case civilian: {_index set [0,"Default"]};
		};
	};
} else {
	//Wait for the server to set the color
	waitUntil{!isNil {_vehicle getVariable "oev_veh_color"}};
	_index = _vehicle getVariable "oev_veh_color";
};

if (_retry) then {
	{
		if ((_x select 0) isEqualTo (_index select 0)) exitWith {
			_texture = _x select 2;
		};
	}forEach _textures;
};

//If vehicle is local to server, set it's color.
if(local _vehicle) then
{
	_vehicle setVariable["oev_veh_color",_index,true];
};

if (_index select 1 != 0) then {
	_chrome = (switch (_index select 1) do {
		case 1: {"A3\structures_f\Items\Electronics\Data\electronics_screens.rvmat"}; // glossy shiny texture
		case 2: {"A3\structures_f\Civ\InfoBoards\Data\infostands_chrome.rvmat"}; // full chrome texture
		case 3: {"images\qilin_gold_0.rvmat"}; // gold texture
		case 4: {"a3\data_f\mirror.rvmat"}; // Mirror texture, not available to buy
		default {""};
	});
	switch (true) do {
		case ((typeOf _vehicle) in _oneRegionChrome): {_vehicle setObjectMaterial [0,_chrome];};
		case ((typeOf _vehicle) in _twoRegionChrome): {_vehicle setObjectMaterial [0,_chrome]; _vehicle setObjectMaterial [1,_chrome];};
		case ((typeOf _vehicle) in _threeRegionChrome): {_vehicle setObjectMaterial [0,_chrome]; _vehicle setObjectMaterial [1,_chrome]; _vehicle setObjectMaterial [2,_chrome];};
		default {[]};
	};
};

//If the texture does not exist, default it.
if ((_texture select 0)isEqualTo "") then
{
	_texture = getArray(configfile >> "CfgVehicles" >> typeOf _vehicle >> "hiddenSelectionsTextures");
};
_count = (count _texture)-1;

for "_i" from 0 to _count do
{
	_vehicle setObjectTexture[_i,_texture select _i];
};
