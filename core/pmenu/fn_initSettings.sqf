//  File: fn_initSettings.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Initializes key parts for the Settings menu for View distance and other stuff.
life_sidechat = true;
life_gangChat = profileNamespace getVariable ["life_gangChat",false];
life_tagson = profileNamespace getVariable ["life_tagson",true];
life_mapZoom = profileNamespace getVariable ["life_mapZoom",true];
life_copSpawnBldgs = profileNamespace getVariable ["life_copSpawnBldgs",false];
life_copSpawnVer = profileNamespace getVariable ["life_copSpawnVer",false];
life_copTogLethal = profileNamespace getVariable ["life_copTogLethal", false];
oev_npcTags = profileNamespace getVariable ["oev_npcTags",true];
oev_npcNames = profileNamespace getVariable ["oev_npcNames",true];
life_bettingVer = profileNamespace getVariable ["life_bettingVer",true];
life_revealObjects = profileNamespace getVariable ["life_revealObjects",true];
tawvd_foot = profileNamespace getVariable ["tawvd_foot",900];
tawvd_car = profileNamespace getVariable ["tawvd_car",1200];
tawvd_air = profileNamespace getVariable ["tawvd_air",1500];
life_terrainDetail = profileNamespace getVariable ["life_terrainDetail",40];
life_ambientLife = profileNamespace getVariable ["life_ambientLife", true];
life_decorationDetailSetting = profileNamespace getVariable ["life_decorationDetailSetting",25];
life_newPlayerHints = profileNamespace getVariable ["life_newPlayerHints",true];
life_deathMessages = profileNamespace getVariable ["life_deathMessages",true];
life_vehAnim = profileNamespace getVariable ["life_vehAnim",false];
life_lottery = profileNamespace getVariable ["life_lottery", true];
life_skywriteColor = profileNamespace getVariable ["life_skywriteColor",'SmokeShell'];
life_colorRGBA = profileNamespace getVariable ["life_colorRGBA",[1,1,1,1]];
life_hexIcons = profileNamespace getVariable ["life_hexIcons",true];
life_hexIcon = profileNamespace getVariable ["life_hexIcon",""];
life_earplugs = profileNamespace getVariable ["life_earplugs",[40,10]];
enableEnvironment life_ambientLife;

oev_monitorVehicles = false;

if(life_terrainDetail > 40) then {
	life_terrainDetail = 40;
};

setTerrainGrid life_terrainDetail;

[] call OEC_fnc_updateViewDistance;
