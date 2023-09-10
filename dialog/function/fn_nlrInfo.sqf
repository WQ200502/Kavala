//	Author: djwolf
//	Date: 6/19/2016
//	File: fn_nlrInfo.sqf

//	Description: Performs the actions when the client clicks to view more info next to the spawn button
//	Organization: Olympus Entertainment

private ["_display","_focusButton","_defText","_defCtrl"];
_display = findDisplay 38500;

_display displayRemoveEventHandler ["KeyDown",0];

uiNamespace setVariable ["nlrInfoBox",[_display, "RscControlsGroup", 38600, controlNull, [0, 0, 1, 1], [0, 0, 0, 0], true, ""] call OEC_fnc_ctrlCreate];
uiNamespace getVariable ["nlrInfoBox",controlNull];

_display displaySetEventHandler ["KeyDown","_code = _this select 1; if (_code == 1) then {ctrlDelete (uiNamespace getVariable ['nlrInfoBox',controlNull]); (findDisplay 38500) displaySetEventHandler ['keyDown','_this call OEC_fnc_displayHandler']; true};"];

_focusButton = [_display, "RscButtonMenu",38601, (uiNamespace getVariable ["nlrInfoBox",controlNull]), [0, 0, 0, 0], [0, 0, 0, 0], true, ""] call OEC_fnc_ctrlCreate;//Need to make a stupid button so we can focus the window
ctrlSetFocus _focusButton;

[_display, "RscFrame", -1, (uiNamespace getVariable ["nlrInfoBox",controlNull]), [0.1, 0.3, 0.775, 0.35], [0.5, 0.3, 0.3, 1], true, ""] call OEC_fnc_ctrlCreate;

[_display, "RscText", -1, (uiNamespace getVariable ["nlrInfoBox",controlNull]), [0.1, 0.3, 0.775, 0.35], [0,0,0,1], true, ""] call OEC_fnc_ctrlCreate;
[_display, "RscText", -1, (uiNamespace getVariable ["nlrInfoBox",controlNull]), [0.1, 0.3, 0.775, 0.05], [(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843]), (profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019]), (profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862]), (profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])], true, "NLR信息"] call OEC_fnc_ctrlCreate; //title text

[_display, "RscText", -1, (uiNamespace getVariable ["nlrInfoBox",controlNull]), [0.12,0.065, 0.775, 0.7], [0,0,0,0], true, "您可能有或可能没有计时器阻止您在某个位置生成载具。"] call OEC_fnc_ctrlCreate;
[_display, "RscText", -1, (uiNamespace getVariable ["nlrInfoBox",controlNull]), [0.12,0.09, 0.775, 0.7], [0,0,0,0], true, "这是因为您在过去15分钟内在该位置附近死亡。 已知规则"] call OEC_fnc_ctrlCreate;
[_display, "RscText", -1, (uiNamespace getVariable ["nlrInfoBox",controlNull]), [0.12,0.115, 0.775, 0.7], [0,0,0,0], true, "因为NLR（新生活规则）在这里是为了防止您在您离开后立即返回"] call OEC_fnc_ctrlCreate;
[_display, "RscText", -1, (uiNamespace getVariable ["nlrInfoBox",controlNull]), [0.12,0.14, 0.775, 0.7], [0,0,0,0], true, "死了 如果选择另一个生成点，则可能可以在那里生成。"] call OEC_fnc_ctrlCreate;

_defCtrl = [_display, "RscStructuredText", -1, (uiNamespace getVariable ["nlrInfoBox",controlNull]), [0.12, 0.56, 0.7, 0.05], [0,0,0,0], true, ""] call OEC_fnc_ctrlCreate;

_defText = parseText format["-<t colorLink='#0B92D1'><a href='%1'>西海岸Altis生活规则</a></t>", "http:/" + "/QQ群：870988619"];

_defCtrl ctrlSetStructuredText _defText;

private _closeButton = [_display, "RscButton", -1, (uiNamespace getVariable ["nlrInfoBox",controlNull]), [0.70, 0.53, 0.11, 0.08], [0,0,0,0], true, "[ESC] Close"] call OEC_fnc_ctrlCreate;
_closeButton buttonSetAction "ctrlDelete (uiNamespace getVariable ['nlrInfoBox',controlNull]);";