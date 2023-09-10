//	Author: Poseidon
//	Description: Loading screen system

private["_display","_control","_controlGroup"];

disableSerialization;

life_loadingSystemActive = true;
life_loadingSystemFailTime = time + 5;
life_loadingProgress = 0;
life_loadingStatus = "<t color='#FF83FA'>加载中...</t>";
life_loadingSystemReady = false;
life_loadingSystemContinue = false;

waitUntil{(getClientState == "BRIEFING READ")};


["blankDialog"] call OEC_fnc_createDialog;
waitUntil{!isNull (findDisplay 800000)};
_display = findDisplay 800000;
_controlGroup = _display ctrlCreate ["RscControlsGroup", 810001];

_controlGroup ctrlSetPosition [safezoneX, safezoneY, safezoneW, safezoneH];
_controlGroup ctrlCommit 0;

//============================ Background And Title ============================
[_display, "RscPicture", -1, _controlGroup, [0, 0, safezoneW, safezoneH], [1, 1, 1, 1], true, "images\loadingBackground.jpg"] call OEC_fnc_ctrlCreate;

_loadingText = [_display, "RscStructuredText", -1, _controlGroup, [(safezoneW/2 - 0.5),safezoneH*0.025,1,0.1], [0, 0, 0, 0], true, format["<t align='center' size='1.25'>%1</t>", life_loadingStatus]] call OEC_fnc_ctrlCreate;

[_loadingText] spawn{
	private["_loadingTextCtrl"];
	disableSerialization;
	_loadingTextCtrl = (_this select 0);
	while{life_loadingSystemActive} do{
		sleep 0.1;
		if(!isNull _loadingTextCtrl) then {
			_loadingTextCtrl ctrlSetStructuredText (parseText format["<t align='center' size='1.25'>%1</t>", life_loadingStatus]);
			_loadingTextCtrl ctrlCommit 0;
		};
	};
};

//Disable closing the loading screen, after 5 seconds allow players to open pause menu
_display displaySetEventHandler ["KeyDown","_code = _this select 1; if(_code == 1) then {
	true;
};"];


[800100, [safezoneW * 0.9105, safezoneH*0.1135, (safezoneH * 0.075), (safezoneH * 0.075)], _controlGroup, "life_loadingSystemActive", format["<t align='center'>%1</t>", "Loading stuff"], _display] spawn OEC_fnc_loadingScreenIcon;

[_display, _controlGroup] spawn OEC_fnc_loadingScreenContent;


_buttonControl = [_display, "RscButton", -1, _controlGroup, [0 + 0.035, safezoneH - 0.145, 0.35, 0.1], [1, 1, 1, 1], true, "返回大厅"] call OEC_fnc_ctrlCreate;//Box button
_buttonControl buttonSetAction "(findDisplay 800000) closeDisplay 0; if(!(isNull (findDisplay 38500))) then {(findDisplay 38500) closeDisplay 0;}; failMission 'ReturnToLobby';";

_buttonContinue = [_display, "RscButton", 812000, _controlGroup, [safezoneW - 0.035 - 0.40, safezoneH - 0.145, 0.35, 0.1], [1, 1, 1, 1], true, "开始游戏"] call OEC_fnc_ctrlCreate;//Box button
_buttonContinue buttonSetAction "life_loadingSystemContinue = true; ((findDisplay 800000) displayCtrl 812000) ctrlEnable false;";
_buttonContinue ctrlEnable false;

waitUntil{life_loadingSystemReady};
_buttonContinue ctrlEnable true;
_buttonContinue ctrlSetTextColor [0,1,0,1];
_buttonContinue ctrlCommit 0;


waitUntil{!life_loadingSystemActive};
closeDialog 0;
cutText ["","BLACK IN"];