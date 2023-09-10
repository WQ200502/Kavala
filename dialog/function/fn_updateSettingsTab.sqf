/*
	Updates the ymenu settings tab when opened
*/
private ["_fnc_setupOnOff"];
disableSerialization;

ctrlSetText[35001,format["%1",tawvd_foot]];
ctrlSetText[35002,format["%1",tawvd_car]];
ctrlSetText[35003,format["%1",tawvd_air]];
ctrlSetText[9000,format["%1",[life_colorRGBA select 0,2] call BIS_fnc_cutDecimals]];
ctrlSetText[9001,format["%1",[life_colorRGBA select 1,2] call BIS_fnc_cutDecimals]];
ctrlSetText[9002,format["%1",[life_colorRGBA select 2,2] call BIS_fnc_cutDecimals]];
ctrlSetText[9003,format["%1",[life_colorRGBA select 3,2] call BIS_fnc_cutDecimals]];
ctrlSetText[35011,format["%1",(50 - life_terrainDetail)]];
ctrlSetText[35013,format["%1%2",life_decorationDetailSetting,"%"]];
((findDisplay 35000) displayCtrl 89675) ctrlSetTextColor life_colorRGBA;
((findDisplay 35000) displayCtrl 784308) ctrlSetTextColor life_colorRGBA;

//hex icon icon preview
if(player getVariable["hexIconName",""] != "") then {
	if(playerSide isEqualTo west) then {
		_tagIcon = switch (player getVariable["hexIconName",""]) do {
			case "dep": {"\a3\ui_f\data\gui\cfg\Ranks\private_gs.paa"};
			case "po": {MISSION_ROOT + "images\PO_tag.paa"};
			case "corp": {"\a3\ui_f\data\gui\cfg\Ranks\corporal_gs.paa"};
			case "sgt": {"\a3\ui_f\data\gui\cfg\Ranks\sergeant_gs.paa"};
			case "lt": {"\a3\ui_f\data\gui\cfg\Ranks\lieutenant_gs.paa"};
			case "depc": {"\a3\ui_f\data\gui\cfg\Ranks\captain_gs.paa"};
			case "chief": {"\a3\ui_f\data\gui\cfg\Ranks\colonel_gs.paa"};
			default {""};
		};
		ctrlSetText[784308,_tagIcon];
	} else {
		ctrlSetText[784308,format["images\icons\hexIcons\%1.paa",player getVariable "hexIconName"]];
	};
};

//Setup Sliders range
{slidersetRange [_x,100,12000];} forEach [35004,35005,35006];
{slidersetRange [_x,0,1.0];} forEach [9004,9005,9006,9007];
slidersetRange [35010,10,50];
slidersetRange [35012,10,100];


//Setup Sliders speed
{sliderSetSpeed [_x,100,100];} forEach [35004,35005,35006];
{sliderSetSpeed [_x,0.01,0.01];} forEach [9004,9005,9006,9007];
sliderSetSpeed [35010,5,5];
sliderSetSpeed [35012,5,5];

//Setup Sliders position
{
	sliderSetPosition[_x select 0, _x select 1];
} forEach [[35004,tawvd_foot],[35005,tawvd_car],[35006,tawvd_air],[9004,life_colorRGBA select 0],[9005,life_colorRGBA select 1],[9006,life_colorRGBA select 2],[9007,life_colorRGBA select 3]];
sliderSetPosition[35010,(50 - life_terrainDetail)];
sliderSetPosition[35012,life_decorationDetailSetting];

private _display = findDisplay 35000;
private _tags = _display displayCtrl 35007;
private _npctags = _display displayCtrl 35042;
private _npcnames = _display displayCtrl 35043;
private _side = _display displayCtrl 35008;
private _gang = _display displayCtrl 35045;
private _gangHeader = _display displayCtrl 35046;
private _objs = _display displayCtrl 35009;
private _ambient = _display displayCtrl 35014;
private _experimental = _display displayCtrl 35015;
private _mapZoom = _display displayCtrl 35016;

private _copSpawnH = _display displayCtrl 35019;
private _bettingDisable = _display displayCtrl 35028;
private _copBldgsH = _display displayCtrl 35020;
private _copSpawn = _display displayCtrl 35017;
private _bettingDis = _display displayCtrl 35029;
private _copBldgs = _display displayCtrl 35018;
private _helpfulHints = _display displayCtrl 35021;
private _deathMsgs = _display displayCtrl 35036;
private _deathMgsH = _display displayCtrl 35037;
private _vehAnim = _display displayCtrl 35069;
private _lottery = _display displayCtrl 35023;
private _copBettingDisable = _display displayCtrl 35031;
private _copBettingDis = _display displayCtrl 35030;
private _copLethalToggle = _display displayCtrl 35034;
private _copLethalTog = _display displayCtrl 35035;
private _skywriteHeader = _display displayCtrl 35099;
private _skywriteDropMenu = _display displayCtrl 35600;
private _hexIcons = _display displayCtrl 35024;
private _spacer = _display displayCtrl 35038;

_spacer ctrlShow false;	// adds space at the bottom of the menu for format purposes

if (life_revealObjects) then {
	_objs ctrlSetTextColor [0,1,0,1];
	_objs ctrlSetText "开启";
	_objs buttonSetAction "[LIFE_ID_RevealObjects,""onEachFrame""] call BIS_fnc_removeStackedEventHandler; life_revealObjects = false; [] spawn OEC_fnc_updateSettingsTab;";
} else {
	_objs ctrlSetTextColor [1,0,0,1];
	_objs ctrlSetText "关闭";
	_objs buttonSetAction "LIFE_ID_RevealObjects = [""LIFE_RevealObjects"",""onEachFrame"",""OEC_fnc_revealObjects""] call BIS_fnc_addStackedEventHandler; life_revealObjects = true; [] spawn OEC_fnc_updateSettingsTab;";
};

if (life_tagson) then {
	_tags ctrlSetTextColor [0,1,0,1];
	_tags ctrlSetText "开启";
	_tags buttonSetAction "[LIFE_ID_PlayerTags,""onEachFrame""] call BIS_fnc_removeStackedEventHandler; life_tagson = false; [] spawn OEC_fnc_updateSettingsTab;";
} else {
	_tags ctrlSetTextColor [1,0,0,1];
	_tags ctrlSetText "关闭";
	_tags buttonSetAction "LIFE_ID_PlayerTags = [""LIFE_PlayerTags"",""onEachFrame"",""OEC_fnc_playerTags""] call BIS_fnc_addStackedEventHandler; life_tagson = true; [] spawn OEC_fnc_updateSettingsTab;";
};

if (oev_npcTags) then {
	_npctags ctrlSetTextColor [0,1,0,1];
	_npctags ctrlSetText "开启";
} else {
	_npctags ctrlSetTextColor [1,0,0,1];
	_npctags ctrlSetText "关闭";
};
if (oev_npcNames) then {
	_npcnames ctrlSetTextColor [0,1,0,1];
	_npcnames ctrlSetText "开启";
} else {
	_npcnames ctrlSetTextColor [1,0,0,1];
	_npcnames ctrlSetText "关闭";
};
if !(oev_npcTags) then {
	_npcnames ctrlEnable false;
} else {
	_npcnames ctrlEnable true;
};

if (life_sidechat) then {
	_side ctrlSetTextColor [0,1,0,1];
	_side ctrlSetText "开启";
} else {
	_side ctrlSetTextColor [1,0,0,1];
	_side ctrlSetText "关闭";
};

if (life_gangChat) then {
	_gang ctrlSetTextColor [0,1,0,1];
	_gang ctrlSetText "开启";
} else {
	_gang ctrlSetTextColor [1,0,0,1];
	_gang ctrlSetText "关闭";
};

if (life_ambientLife) then {
	_ambient ctrlSetTextColor [0,1,0,1];
	_ambient ctrlSetText "开启";
} else {
	_ambient ctrlSetTextColor [1,0,0,1];
	_ambient ctrlSetText "关闭";
};

if (oev_monitorVehicles) then {
	_experimental ctrlSetTextColor [0,1,0,1];
	_experimental ctrlSetText "开启";
} else {
	_experimental ctrlSetTextColor [1,0,0,1];
	_experimental ctrlSetText "关闭";
};

if (life_mapZoom) then {
	_mapZoom ctrlSetTextColor [0,1,0,1];
	_mapZoom ctrlSetText "开启";
} else {
	_mapZoom ctrlSetTextColor [1,0,0,1];
	_mapZoom ctrlSetText "关闭";
};

if (life_newPlayerHints) then {
	_helpfulHints ctrlSetTextColor [0,1,0,1];
	_helpfulHints ctrlSetText "开启";
} else {
	_helpfulHints ctrlSetTextColor [1,0,0,1];
	_helpfulHints ctrlSetText "关闭";
};

if (life_deathMessages) then {
	_deathMsgs ctrlSetTextColor [0,1,0,1];
	_deathMsgs ctrlSetText "开启";
} else {
	_deathMsgs ctrlSetTextColor [1,0,0,1];
	_deathMsgs ctrlSetText "关闭";
};

if (life_hexIcons) then {
	_hexIcons ctrlSetTextColor [0,1,0,1];
	_hexIcons ctrlSetText "开启";
} else {
	_hexIcons ctrlSetTextColor [1,0,0,1];
	_hexIcons ctrlSetText "关闭";
};

if !(playerSide isEqualTo civilian) then {
	_helpfulHints ctrlEnable false;
};

_fnc_setupOnOff = {
    params [
        ["_ctrlToggle", controlNull, [controlNull]],
        ["_value", true, [true]]
    ];
    if (_value) then {
        _ctrlToggle ctrlSetTextColor [0,1,0,1];
        _ctrlToggle ctrlSetText "开启";
    } else {
        _ctrlToggle ctrlSetTextColor [1,0,0,1];
        _ctrlToggle ctrlSetText "关闭";
    };
};

{
    _x call _fnc_setupOnOff;
} forEach [
    [_vehAnim, life_vehAnim],
    [_lottery, life_lottery]
];

if (life_copTogLethal) then {
	_copLethalTog ctrlSetTextColor [0,1,0,1];
	_copLethalTog ctrlSetText "开启";
} else {
	_copLethalTog ctrlSetTextColor [1,0,0,1];
	_copLethalTog ctrlSetText "关闭";
};

if (playerSide isEqualTo west) then {
	_bettingDisable ctrlShow false;
	_bettingDis ctrlShow false;
	_deathMgsH ctrlShow false;
	_deathMsgs ctrlShow false;
	_gangHeader ctrlShow false;
	_gang ctrlShow false;
	_copBettingDisable ctrlShow true;
	_copBettingDis ctrlShow true;
	if (call oev_donator > 1) then {
		_skywriteHeader ctrlShow true;
		_skywriteDropMenu ctrlShow true;
	} else {
		_skywriteHeader ctrlShow false;
		_skywriteDropMenu ctrlShow false;
	};
	if (life_copSpawnVer) then {
		_copSpawn ctrlSetTextColor [0,1,0,1];
		_copSpawn ctrlSetText "开启";
	} else {
		_copSpawn ctrlSetTextColor [1,0,0,1];
		_copSpawn ctrlSetText "关闭";
	};

	if (life_copSpawnBldgs) then {
		_copBldgs ctrlSetTextColor [0,1,0,1];
		_copBldgs ctrlSetText "开启";
	} else {
		_copBldgs ctrlSetTextColor [1,0,0,1];
		_copBldgs ctrlSetText "关闭";
	};

	if !(life_copSpawnVer) then {
		_copBldgs ctrlEnable false;
	} else {
		_copBldgs ctrlEnable true;
	};
	if (life_bettingVer) then {
		_copBettingDis ctrlSetTextColor [0,1,0,1];
		_copBettingDis ctrlSetText "开启";
	} else {
		_copBettingDis ctrlSetTextColor [1,0,0,1];
		_copBettingDis ctrlSetText "关闭";
	};

	if ((((player getVariable ["rank",0]) > 2) || (((player getVariable ["rank",0]) == 2) && (getPos player inPolygon oev_warzonePoly || player getVariable ["lethalsPO",true])))) then {
		_copLethalTog ctrlEnable true;
	} else {
		_copLethalTog ctrlEnable false;
	};
} else {
	_copLethalToggle ctrlShow false;
	_copLethalTog ctrlShow false;
	_copBldgsH ctrlShow false;
	_copSpawnH ctrlShow false;
	_copBldgs ctrlShow false;
	_copSpawn ctrlShow false;
	_copLethalTog ctrlEnable false;
	if (playerSide isEqualTo independent) then {
		_deathMgsH ctrlShow false;
		_deathMsgs ctrlShow false;
		_bettingDisable ctrlShow false;
		_bettingDis ctrlShow false;
		_gangHeader ctrlShow false;
		_gang ctrlShow false;
		_skywriteHeader ctrlShow false;
		_skywriteDropMenu ctrlShow false;
		_copLethalToggle ctrlShow false;
		_copLethalTog ctrlShow false;
	} else {
		if (call oev_donator > 1) then {
			_skywriteHeader ctrlShow true;
			_skywriteDropMenu ctrlShow true;
		} else {
			_skywriteHeader ctrlShow false;
			_skywriteDropMenu ctrlShow false;
		};
	};
	_copBettingDis ctrlShow false;
	_copBettingDisable ctrlShow false;
	if (life_bettingVer) then {
		_bettingDis ctrlSetTextColor [0,1,0,1];
		_bettingDis ctrlSetText "开启";
	} else {
		_bettingDis ctrlSetTextColor [1,0,0,1];
		_bettingDis ctrlSetText "关闭";
	};
};

if !(isNull objectParent player) then {
	_experimental ctrlEnable false;
};

lbClear _skywriteDropMenu;
{
	private _index = _skywriteDropMenu lbAdd (_x select 0);
	_skywriteDropMenu lbSetData [_index,_x select 1];
} forEach [
	["White",'SmokeShell'],
	["Red",'SmokeShellRed'],
	["Green",'SmokeShellGreen'],
	["Yellow",'SmokeShellYellow'],
	["Purple",'SmokeShellPurple'],
	["Blue",'SmokeShellBlue']
];

ctrlSetText[35104,format["%1%2",life_earplugs select 0,"%"]];
ctrlSetText[35105,format["%1%2",life_earplugs select 1,"%"]];
sliderSetPosition[35100,(life_earplugs select 0) / 10];
sliderSetPosition[35101,(life_earplugs select 1) / 10];
