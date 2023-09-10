//  File: fn_loadingScreenContent
//	Description: fuck

disableSerialization;
params [
	["_display",displayNull,[displayNull]],
	["_masterControlGroup",controlNull,[controlNull]]
];

private _heightShift = safezoneH * 0;
private _controlGroup = [_display, "RscControlsGroup", 820001, _masterControlGroup, [safezoneW * 0.2,(safezoneH * 0.2) + _heightShift,safezoneW * 0.6,(safezoneH * 0.5)], [1, 1, 1, 1], true, ""] call OEC_fnc_ctrlCreate;

//============================ Background And Title ============================
[_display, "RscText", -1, _controlGroup, [0, 0, (safezoneW * 0.6), (safezoneH * 0.5)], [0, 0, 0, 0.7], true, ""] call OEC_fnc_ctrlCreate;


_ctrl = [_display, "RscTree", 830000, _controlGroup, [0.025 * (3/4), 0.025, (safezoneW * 0.2), (safezoneH * 0.475)], [0, 0, 0, 0.45], true, ""] call OEC_fnc_ctrlCreate;
_ctrl ctrlSetFontHeight 0.03;
_ctrl ctrlSetFont "PuristaMedium";


[] spawn{
	while{life_loadingSystemActive} do {
		sleep 0.1;
		if(!isNull findDisplay 38500) then {
			((findDisplay 800000) displayCtrl 830000) ctrlenable False;
			waitUntil{isNull findDisplay 38500};
			((findDisplay 800000) displayCtrl 830000) ctrlenable true;
		};
	};
};


private _colorParent = [1,1,1,1];
private _childOne = [0.9,0.9,0.9,1];
private _childTwo = [0.8,0.8,0.8,1];
private _childThree = [0.7,0.7,0.7,1];
private _directory = "core\contentMenu\";

_ctrl tvAdd [[],"开发变更日志"];
_ctrl tvSetColor [[0], _colorParent];

private _changeLogs = [
];

	{
		_ctrl tvAdd [[0],(_x select 0)];
		_ctrl tvSetColor [[0,_forEachIndex], _childOne];
		_ctrl tvSetData [[0,_forEachIndex], format["%1%2.txt",_directory,(_x select 1)]];
	} forEach _changeLogs;

_ctrl tvAdd [[],"服务器信息"];
_ctrl tvSetColor [[1], _colorParent];

	_ctrl tvAdd [[1],"TeamSpeak and Server Info"];
	_ctrl tvSetColor [[1,0], _childOne];
	_ctrl tvSetData [[1,0], format["%1info_ts_server.txt",_directory]];

_ctrl tvAdd [[],"服务器规则"];
_ctrl tvSetColor [[2], _colorParent];

	_ctrl tvAdd [[2],"General Rules"];
	_ctrl tvSetColor [[2,0], _childOne];
	_ctrl tvSetData [[2,0], format["%1general_rules.txt",_directory]];

	_ctrl tvAdd [[2],"Altis Life Rules"];
	_ctrl tvSetColor [[2,1], _childOne];
	_ctrl tvSetData [[2,1], format["%1rules_server.txt",_directory]];

		/*_ctrl tvAdd [[2,1],"Random Death Match (RDM)"];
		_ctrl tvSetColor [[2,0,0], _childTwo];
		_ctrl tvSetData [[2,0,0], format["%1rules_rdm.txt",_directory]];

		_ctrl tvAdd [[2,1],"Vehicle Death Match (VDM)"];
		_ctrl tvSetColor [[2,1,1], _childTwo];
		_ctrl tvSetData [[2,1,1], format["%1rules_vdm.txt",_directory]];
*/
_ctrl tvAdd [[],"员工名录"];
_ctrl tvSetColor [[3], _colorParent];

	_ctrl tvAdd [[3],"管理员"];
	_ctrl tvSetColor [[3,0], _childOne];
	_ctrl tvSetData [[3,0], format["%1administrators.txt",_directory]];

	_ctrl tvAdd [[3],"设计师"];
	_ctrl tvSetColor [[3,1], _childOne];
	_ctrl tvSetData [[3,1], format["%1designers.txt",_directory]];

	_ctrl tvAdd [[3],"开发者"];
	_ctrl tvSetColor [[3,2], _childOne];
	_ctrl tvSetData [[3,2], format["%1developers.txt",_directory]];

	_ctrl tvAdd [[3],"主持人"];
	_ctrl tvSetColor [[3,3], _childOne];
	_ctrl tvSetData [[3,3], format["%1moderators.txt",_directory]];

	_ctrl tvAdd [[3],"支持团队"];
	_ctrl tvSetColor [[3,4], _childOne];
	_ctrl tvSetData [[3,4], format["%1supportteam.txt",_directory]];

_ctrl tvAdd [[],"新玩家信息"];
_ctrl tvSetColor [[4], _colorParent];
_ctrl tvSetData [[4], format["%1newplayer.txt",_directory]];

	_ctrl tvAdd [[4],"报告玩家"];
	_ctrl tvSetColor [[4,0], _childOne];
	_ctrl tvSetData [[4,0], format["%1reporting.txt",_directory]];

	_ctrl tvAdd [[4],"运行信息"];
	_ctrl tvSetColor [[4,1], _childOne];
	_ctrl tvSetData [[4,1], format["%1runInformation.txt",_directory]];

	_ctrl tvAdd [[4],"黑水信息"];
	_ctrl tvSetColor [[4,2], _childOne];
	_ctrl tvSetData [[4,2], format["%1bwInfo.txt",_directory]];

	_ctrl tvAdd [[4],"监狱信息"];
	_ctrl tvSetColor [[4,3], _childOne];
	_ctrl tvSetData [[4,3], format["%1jailInfo.txt",_directory]];

	_ctrl tvAdd [[4],"美联储信息"];
	_ctrl tvSetColor [[4,4], _childOne];
	_ctrl tvSetData [[4,4], format["%1fedInfo.txt",_directory]];

	_ctrl tvAdd [[4],"肾上腺素和多巴胺"];
	_ctrl tvSetColor [[4,5], _childOne];
	_ctrl tvSetData [[4,5], format["%1dopamine.txt",_directory]];

	_ctrl tvAdd [[4],"车辆改装"];
	_ctrl tvSetColor [[4,6], _childOne];
	_ctrl tvSetData [[4,6], format["%1vehInfo.txt",_directory]];

	_ctrl tvAdd [[4],"治安规则"];
	_ctrl tvSetColor [[4,7], _childOne];
	_ctrl tvSetData [[4,7], format["%1vigiInfo.txt",_directory]];


_ctrl tvAdd [[],"警察局信息"];
_ctrl tvSetColor [[5], _colorParent];
_ctrl tvSetData [[5], format["%1apd.txt",_directory]];

_ctrl tvAdd [[],"救援和恢复信息"];
_ctrl tvSetColor [[6], _colorParent];
_ctrl tvSetData [[6], format["%1RNR.txt",_directory]];

//tvExpandAll _ctrl;

_controlGroupHtml = [_display, "RscControlsGroup", 830001, _controlGroup, [0.05 * (3/4) + (safezoneW * 0.2), 0.025, (safezoneW * 0.375), (safezoneH * 0.475)], [1, 1, 1, 1], true, ""] call OEC_fnc_ctrlCreate;
_sqf = [_display, "RscStructuredText", 830002, _controlGroupHtml, [0, 0, (safezoneW * 0.370), 4], [0, 0, 0, 0.45], true, ""] call OEC_fnc_ctrlCreate;
_sqf ctrlSetStructuredText parseText([format["%1%2.txt", _directory, _changeLogs select 0 select 1]] call OEC_fnc_processSQF);

_ctrl ctrlAddEventHandler ["TreeSelChanged", {_treePath = tvData [830000,_this select 1]; if(_treePath isEqualTo "") then {_treePath = "core\contentMenu\thanks.txt";}; ((findDisplay 800000) displayCtrl 830002) ctrlSetStructuredText parseText([_treePath] call OEC_fnc_processSQF);}];
