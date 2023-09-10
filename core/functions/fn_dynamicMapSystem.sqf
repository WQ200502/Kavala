//	Author: Poseidon
//	Description: Dynamic spawning and removal of custom altis life map items
//Dynamic item spawning zones. Dynamic Items in these zones will spawn when you get within range, and delete when you leave the area.

dynamicMap_zoneLocations = [
	[[12208,12308,3.75284], 200, "zone26"],
	[[28271.3,25738.5,17.1068], 300, "zone27"],
	[[19840.9,11880.2,73.0426], 90, "zone28"],
	[[15293,17579.3,16.7297], 50, "zone29"],
	[[15787.3,17460.4,14.514], 50, "zone30"],
	[[12021.3,15815.6,27.6314], 50, "zone33"],
	[[11841.1,14149.7,12.5475], 50, "zone34"],
	[[12834.3,15767.7,17.0434], 20, "zone35"],
	[[12580.8,16376.9,34.31], 20, "zone36"],
	[[12792.9,17452.2,22.4638], 50, "zone37"],
	[[14190.6,16537.5,16.8385], 20, "zone38"],
	[[17326.3,17438.8,72.5361], 20, "zone39"],
	[[7855.98,16128.8,114.538], 20, "zone40"],
	[[20983.3,17943,33.5663], 200, "zone41"],
	[[14237.9,18315.5,18.6096], 20, "zone42"],
	[[30311,276.228,-178.82], 500, "zone43"],//admin island
	[[24062.9,15444.1,7.07322], 300, "zone44"],
	[[14046.1,18741.2,26.0134], 350, "zone31"],
	[[15170.5,17209.9,17.9114], 200, "zone32"],
	[[3852.95,12953,19.1155], 1000, "zone1"],
	[[12516.5,14389.9,14.6618], 500, "zone2"],
	// [[15076.9,17913.7,35.1104], 1900, "zone3"],
	[[17752.3,12759.7,34.3459], 1600, "zone4"],
	[[25414.5,22067.6,48.2492], 3500, "zone5"],
	[[23577,18525,3.19144], 1000, "zone6"],
	[[20819.8,7275.25,27.8811], 2200, "zone7"],
	[[7158.94,20070.8,164.583], 3500, "zone8"],
	[[5051.46,14445.8,16.8183], 50, "zone9"],
	[[4978.47,14543.4,16.3077], 50, "zone10"],
	[[6189.72,15088.3,27.5303], 50, "zone11"],
	[[6590.83,15316.3,36.5619], 50, "zone12"],
	[[6789.46,15582,41.2903], 50, "zone13"],
	[[2963.46,18187.1,3.83094], 200, "zone14"],
	[[15104.6,22622.2,13.9405], 100, "zone15"],
	[[8305.94,10077.2,76.0666], 100, "zone16"],
	[[9206.96,12104,18.1061], 50, "zone17"],
	[[8444.49,12761.8,49.7451], 50, "zone18"],
	[[18384.2,15259.7,27.1253], 100, "zone20"],
	[[16856.2,15473.1,12.4703], 50, "zone21"],
	[[20771.4,16661.8,36.7938], 50, "zone22"],
	[[9033.3,15718.9,111.844], 50, "zone23"],
	[[19964.6,11429.2,60.2268], 50, "zone24"],
	[[6383.32,12376.8,218.528], 450, "zone25"]
];


testRadius = 0;
testRadiusSpawn = 0;
testRadiusDeSpawn = 0;


//Debug information drawn on map to show zones

/*
[] spawn{
if(isDedicated) exitWith {};
sleep 10;
findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw",
{
	{
		_despawnRadius = 1250;
		if((_x select 1) <= 200) then {
			_despawnRadius = 550;
		};

		_this select 0 drawEllipse [
			(_x select 0), (_x select 1) + _despawnRadius, (_x select 1) + _despawnRadius, 0, [1, 0, 0, 1], "#(rgb,8,8,3)color(1,0,0,0.2)"
		];
	}foreach dynamicMap_zoneLocations;

	{
		_spawnRadius = 1000;
		if((_x select 1) <= 200) then {
			_spawnRadius = 400;
		};

		_this select 0 drawEllipse [
			(_x select 0), (_x select 1) + _spawnRadius, (_x select 1) + _spawnRadius, 0, [0, 1, 0, 1], "#(rgb,8,8,3)color(0,1,0,0.3)"
		];
	}foreach dynamicMap_zoneLocations;

	{
		_this select 0 drawEllipse [
			(_x select 0), (_x select 1), (_x select 1), 0, [0, 0, 1, 1], "#(rgb,8,8,3)color(0,0,1,0.3)"
		];

		(_this select 0) drawIcon [
			'iconStaticMG',
			[1,1,1,1],
			(_x select 0),
			30,
			30,
			0,
			(_x select 2),
			1,
			0.06,
			'EtelkaNarrowMediumPro',
			'right'
		];
	}foreach dynamicMap_zoneLocations;

	_this select 0 drawEllipse [
		(getPosWorld player), testRadius + testRadiusDeSpawn, testRadius + testRadiusDeSpawn, 0, [1, 0, 0, 1], "#(rgb,8,8,3)color(1,0,0,0.2)"
	];

	_this select 0 drawEllipse [
		(getPosWorld player), testRadius + testRadiusSpawn, testRadius + testRadiusSpawn, 0, [0, 1, 0, 1], "#(rgb,8,8,3)color(0,1,0,0.3)"
	];

	_this select 0 drawEllipse [
		(getPosWorld player), testRadius, testRadius, 0, [0, 0, 1, 1], "#(rgb,8,8,3)color(0,0,1,0.3)"
	];

}];
};
*/

dynamicMap_static_status = "idle";
dynamicMap_static_objectList = [];
dynamicMap_static_activeObjects = [];

{
	missionNamespace setVariable [(format["dynamicMap_%1_status",(_x select 2)]),"idle"];
	missionNamespace setVariable [(format["dynamicMap_%1_objectList",(_x select 2)]),[]];
	missionNamespace setVariable [(format["dynamicMap_%1_activeObjects",(_x select 2)]),[]];
}foreach dynamicMap_zoneLocations;

_shitObjects = ["I_Heli_light_03_unarmed_F","I_Heli_Transport_02_F","O_Heli_Light_02_unarmed_F","Headgear_H_Bandanna_sand","Headgear_H_Beret_blk","Headgear_H_Booniehat_mcamo","Headgear_H_Booniehat_oli","Headgear_H_Cap_blk","Headgear_H_Cap_blu","Headgear_H_Cap_grn","Headgear_H_Cap_marshal","Headgear_H_Cap_police","Headgear_H_Cap_red","Headgear_H_Hat_blue","Headgear_H_Hat_brown","Headgear_H_Hat_checker","Headgear_H_Hat_grey","Headgear_H_Hat_tan","Headgear_H_HelmetB_light_desert","Headgear_H_HelmetCrew_I","Headgear_H_HelmetLeaderO_oucamo","Headgear_H_HelmetSpecB","Headgear_H_HelmetSpecO_blk","Headgear_H_MilCap_blue","Headgear_H_MilCap_ocamo","Headgear_H_RacingHelmet_1_blue_F","Headgear_H_RacingHelmet_1_green_F","Headgear_H_RacingHelmet_1_orange_F","Headgear_H_RacingHelmet_1_red_F","Headgear_H_RacingHelmet_1_white_F","Headgear_H_RacingHelmet_3_F","Headgear_H_RacingHelmet_4_F","Headgear_H_ShemagOpen_khk","Headgear_H_ShemagOpen_tan","Headgear_H_Shemag_olive","Headgear_H_StrawHat","Headgear_H_Watchcap_cbr","Vest_V_BandollierB_blk","Vest_V_BandollierB_cbr","Vest_V_PlateCarrier1_blk","Vest_V_PlateCarrierIA2_dgtl","Vest_V_PlateCarrierIAGL_oli","Vest_V_RebreatherB","Vest_V_TacVest_blk_POLICE","Vest_V_TacVest_brn","Vest_V_TacVest_camo","Vest_V_TacVest_khk","Vest_V_TacVest_oli","Weapon_arifle_Katiba_F","Weapon_arifle_MXM_F","Weapon_arifle_MX_F","Weapon_arifle_TRG20_F","Weapon_arifle_TRG21_F","Weapon_hgun_ACPC2_F","Weapon_hgun_P07_F","Weapon_hgun_PDW2000_F","Weapon_hgun_Pistol_heavy_01_F","Weapon_hgun_Pistol_heavy_02_F","Weapon_hgun_Rook40_F","Weapon_launch_Titan_short_F","Weapon_LMG_Mk200_F","Weapon_SMG_01_F","Weapon_SMG_02_F","Weapon_srifle_DMR_01_F","Weapon_srifle_DMR_02_F","Weapon_srifle_DMR_03_F","Weapon_srifle_EBR_F","Weapon_srifle_GM6_F","Box_Syndicate_Wps_F","Box_IND_Wps_F","Box_GEN_Equip_F","Box_NATO_Uniforms_F","Land_OfficeCabinet_01_F","Land_MetalCase_01_small_F","Box_AAF_Uniforms_F","B_Heli_Transport_01_F","B_MBT_01_mlrs_F","Land_MetalCase_01_large_F","C_Offroad_01_repair_F","C_Heli_Light_01_civil_F"];

private["_zone","_zoneCheck"];
{
	_zone = "static";

	if(!(_x select 4)) then {
		if(((_x select 3) find "_isStatic = true") == -1) then {
			if((_x select 1) distance2d oev_jailPos1 > 110) then {
				for "_i" from 0 to ((count dynamicMap_zoneLocations) - 1) do {
					_zoneCheck = (dynamicMap_zoneLocations select _i);

					if(((_zoneCheck select 0) distance2d (_x select 1)) < (_zoneCheck select 1)) exitWith {
						_zone = _zoneCheck select 2;
					};
				};
			};
		};


		if(_x select 0 in life_decorObjects) then {
			if(!(_x select 0 in _shitObjects)) then {
				if(round(random(99)) <= 20) then {
					missionNamespace setVariable [(format["dynamicMap_%1_objectList",_zone]),(missionNamespace getVariable [(format["dynamicMap_%1_objectList",_zone]),[]]) + [_x]];
				};
			};
		}else{
			missionNamespace setVariable [(format["dynamicMap_%1_objectList",_zone]),(missionNamespace getVariable [(format["dynamicMap_%1_objectList",_zone]),[]]) + [_x]];
		};

	};
}foreach allLocalMapEntities;

dynamicMap_fnc_loadArea = {
	_status = (call compile format["dynamicMap_%1_status",_this]);
	if(_status in ["creating", "removing", "active"]) exitWith {};
	(call compile format["dynamicMap_%1_status = 'creating';",_this]);

	{
		_object = objNull;
		_object = _x call OEC_fnc_createVehicleLocal;

		sleep 0.0005;//small sleep to help reduce lag on zone loading


		if(!isNull _object) then {
			missionNamespace setVariable [(format["dynamicMap_%1_activeObjects",_this]),(missionNamespace getVariable [(format["dynamicMap_%1_activeObjects",_this]),[]]) + [_object]];
		};
	}foreach (call compile format["dynamicMap_%1_objectList",_this]);

	//hint format["Dynamicaly loaded %1 objects in zone: %2", count (call compile format["dynamicMap_%1_activeObjects",_this]),_this];

	(call compile format["dynamicMap_%1_status = 'active';",_this]);
};

//dynamicMap_zone25_status = "removing";//Prevent mt Olympus from spawning in, its unfinished.

dynamicMap_fnc_unloadArea = {
	_status = (call compile format["dynamicMap_%1_status",_this]);
	if(_status in ["creating", "idle", "removing"]) exitWith {};
	(call compile format["dynamicMap_%1_status = 'removing';",_this]);

	_objectsRemoved = 0;
	{
		deleteVehicle _x;
		_objectsRemoved = _objectsRemoved + 1;
		sleep 0.002;
	}foreach (call compile format["dynamicMap_%1_activeObjects",_this]);

	(call compile format["dynamicMap_%1_activeObjects = [];",_this]);

	//hint format["Dynamicaly un-loaded %1 objects in zone: %2", _objectsRemoved,_this];

	(call compile format["dynamicMap_%1_status = 'idle';",_this]);
};



[] spawn{
	private["_playerPos","_status"];

	"static" spawn dynamicMap_fnc_loadArea;

	while{true} do {
		sleep 2;
		_playerPos = getPosWorld player;

		if(alive player && ((_playerPos distance2d getMarkerPos("debug_island_marker")) > 600)) then {
			{
				_status = (call compile format["dynamicMap_%1_status",(_x select 2)]);

				switch(_status) do {
					case "idle": {
						_radiusIncrease = 1000;
						if((_x select 1) <= 200) then {
							_radiusIncrease = 400;
						};

						if((_playerPos distance2d (_x select 0)) < ((_x select 1) + _radiusIncrease)) then {
							(_x select 2) spawn dynamicMap_fnc_loadArea;
						};
					};

					case "active": {
						_radiusIncrease = 1250;
						if((_x select 1) <= 200) then {
							_radiusIncrease = 550;
						};

						if((_playerPos distance2d (_x select 0)) > ((_x select 1) + _radiusIncrease)) then {
							(_x select 2) spawn dynamicMap_fnc_unloadArea;

						};
					};
					case "creating": {

					};
					case "removing": {

					};
				};
			}foreach dynamicMap_zoneLocations;
		};
	};
};