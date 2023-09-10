//  File: fn_civInteractionMenu.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: replaces addActions

#include <interaction.h>
if(!dialog) then {
	["pInteraction_Menu"] call OEC_fnc_createDialog;
};
disableSerialization;
params [
	["_curTarget",objNull,[objNull]]
];
if(isNull _curTarget) exitWith {closeDialog 0;}; //Bad target
if(!isPlayer _curTarget && side _curTarget isEqualTo civilian) exitWith {closeDialog 0;}; //Bad side check?
if((format["%1",cursorObject]) in ["civ_news_1","civ_news_2","civ_news_3","civ_news_4","civ_news_5","civ_news_6","civ_news_7","civ_news_8","civ_news_9","civ_news_10"]) then {
	hint "You cannot screw with News Team Members!";
	closeDialog 0;
};

private _display = findDisplay 37400;
private _Btn1 = _display displayCtrl Btn1;
private _Btn2 = _display displayCtrl Btn2;
private _Btn3 = _display displayCtrl Btn3;
private _Btn4 = _display displayCtrl Btn4;
private _Btn5 = _display displayCtrl Btn5;
private _Btn6 = _display displayCtrl Btn6;
private _Btn7 = _display displayCtrl Btn7;
private _Btn8 = _display displayCtrl Btn8;
private _Btn9 = _display displayCtrl Btn9;

life_pInact_curTarget = _curTarget;

if (life_pInact_curTarget getVariable ["restrained",false]) then {
	//Set Unrestrain Button
	_Btn1 ctrlSetText "解除束缚";
	_Btn1 buttonSetAction "[life_pInact_curTarget] spawn OEC_fnc_civUnrestrain; closeDialog 0;";
} else {
	//Set Escort Button
	_Btn1 ctrlSetText "束缚";
	_Btn1 buttonSetAction "[life_pInact_curTarget] spawn OEC_fnc_civRestrain;";
};

_Btn2 ctrlSetText "押送";
_Btn2 buttonSetAction "
	if(player distance life_pInact_curTarget > 4) exitWith {hint '你离的太远了!'};
	[life_pInact_curTarget] spawn OEC_fnc_escortAction; closeDialog 0;
	";

_Btn3 ctrlSetText "送入车内";
_Btn3 buttonSetAction "
	if(player distance life_pInact_curTarget > 4) exitWith {hint '你离的太远了!'};
	[life_pInact_curTarget] call OEC_fnc_putInCar;
	";

_Btn4 ctrlSetText "打劫玩家";
_Btn4 buttonSetAction "
	if(player distance life_pInact_curTarget > 4) exitWith {hint '你离的太远了!'};
	[life_pInact_curTarget] call OEC_fnc_robInteractionMenu;
";
if !(license_civ_vigilante) then {
	_Btn5 ctrlSetText "移除肾脏";
	_Btn5 buttonSetAction "[life_pInact_curTarget] spawn OEC_fnc_removeKidney;";
} else {
	if (isNull oev_vigiBuddyObj) then {
		_Btn5 ctrlSetText "请求结伴";
		_Btn5 buttonSetAction "hint '正在发送好友邀请。。。'; closeDialog 0; [[player, getPlayerUID player, 0],'OEC_fnc_vigiBuddy',life_pInact_curTarget,false] spawn OEC_fnc_MP;";
	} else {
		_Btn5 ctrlSetText "结束结伴"; // Intended to be ended on ANYBODY that is vigi so that you can immediately buddy someone else
		_Btn5 buttonSetAction "hint '正在结束好友协议。。。'; [[player, getPlayerUID player, 1],'OEC_fnc_vigiBuddy',life_pInact_curTarget,false] spawn OEC_fnc_MP;oev_vigiBuddyObj = objNull;oev_vigiBuddyPID = '';";
	};
};

if (life_pInact_curTarget getVariable ["blindfolded",false]) then {
	_Btn6 ctrlSetText "取下眼罩";
	_Btn6 buttonSetAction "
		closeDialog 0;
		if(player distance life_pInact_curTarget > 4) exitWith {hint '你离的太远了!'};
		[life_pInact_curTarget] call OEC_fnc_removeBlindfold;
		";
} else {
	if (life_pInact_curTarget getVariable ["restrained",false]) then {
		_Btn6 ctrlSetText "带上眼罩";
		_Btn6 buttonSetAction "
			closeDialog 0;
			if(player distance life_pInact_curTarget > 4) exitWith {hint '你离的太远了!'};
			[life_pInact_curTarget] call OEC_fnc_blindfold;
			";
	};
};

if (!(life_pInact_curTarget getVariable ["restrained",false]) && !(life_pInact_curTarget getVariable ["blindfolded",false])) then {
	_Btn6 ctrlSetText "带上眼罩";
	_Btn6 buttonSetAction "";
	_Btn6 ctrlEnable false;
};

_Btn7 ctrlSetText "送入监狱";
_Btn7 buttonSetAction "if(player distance life_pInact_curTarget > 4) exitWith {hint '你离的太远了!'}; if(license_civ_vigilante) then {[life_pInact_curTarget,true] spawn OEC_fnc_arrestAction;} else {[life_pInact_curTarget] spawn OEC_fnc_arrestAction;};";

_Btn9 ctrlSetText localize "STR_Global_Give";
_Btn9 buttonSetAction "[] spawn OEC_fnc_giveMenu; closeDialog 0;";


//disable certain buttons depending on if the target is restrained or not
if !(life_pInact_curTarget getVariable["restrained",false]) then {
	_Btn2 ctrlEnable false;
	_Btn3 ctrlEnable false;
	_Btn4 ctrlEnable false;
	if !(license_civ_vigilante) then {
		_Btn5 ctrlEnable false;
	};
	_Btn7 ctrlEnable false;
};

//disable certain buttons depending on if the target is restrained by a ZIPTIE or not
//if (life_pInact_curTarget getVariable["restrained",false]) then {
//	if !(life_pInact_curTarget getVariable["zipTied",false]) then {
//		_Btn4 ctrlEnable false;
//	};
//};

//Can't rob a medic of their gear
if (side life_pInact_curTarget isEqualTo independent) then {
	_Btn4 ctrlEnable false;
};

//if civ only allow restraining of surrendered targets
if(!(life_pInact_curTarget getVariable["playerSurrender",false]) && !(life_pInact_curTarget getVariable["restrained",false])) then {
	_Btn1 ctrlEnable false;
};

//if no weapon is being held disable all actions except stop escort
if(currentWeapon player == "" || currentWeapon player in oev_fake_weapons) then {
	if !(license_civ_vigilante) then {
		//_Btn1 ctrlEnable false;
		_Btn2 ctrlEnable false;
	};
	if(!(_curTarget getVariable["Escorting",false])) then {
		_Btn3 ctrlEnable false;
	};
	_Btn4 ctrlEnable false;
	if !(license_civ_vigilante) then {
		_Btn5 ctrlEnable false;
	};
	hint "你没有枪也不太吓人。";
};

//Check that you are near a place to jail them.
if((!((player distance (getMarkerPos "jailtransport_2") < 25) || (player distance (getMarkerPos "jailtransport_4") < 25) || (player distance (getMarkerPos "jailtransport_5") < 25) || (player distance (getMarkerPos "jailtransport_6") < 25) || (player distance (getMarkerPos "jailtransport_7") < 25))) || ((life_pInact_curTarget getVariable["statBounty",75500]) < 75000)) then {
	_Btn7 ctrlEnable false;
};

//if not vig, disable arrest button and disable buddy requests, if vig always enable restrain while target is not restrained.
if !(license_civ_vigilante) then {
	_Btn7 ctrlEnable false;
};

// If target is not vig, then disable buddy requests
if ((license_civ_vigilante) && !(life_pInact_curTarget getVariable ["isVigi",false])) then {
	_Btn5 ctrlEnable false;
};

// If you gotta vigi buddy, check for him on server and if he gone then fix it
if (!(isNull oev_vigiBuddyObj) && !([oev_vigiBuddyPID] call OEC_fnc_isUIDActive)) exitWith {
	oev_vigiBuddyObj = objNull;
	oev_vigiBuddyPID = "";
	closeDialog 0;
	hint "好友不再存在于服务器上。 正在删除数据...重新打开，然后重试";
};

// Disable send to jail button for vigi buddy
if (life_pInact_curTarget isEqualTo oev_vigiBuddyObj) then {
	_Btn7 ctrlEnable false;
};

if(!(life_pInact_curTarget getVariable["restrained",false]) && {(side life_pInact_curTarget isEqualTo civilian)} && {(currentWeapon player != "")} && {!(currentWeapon player in oev_fake_weapons)} && {(life_pInact_curTarget getVariable ["downed",false])}) then {
	_Btn1 ctrlEnable true;
};

if(!(life_pInact_curTarget getVariable["restrained",false]) && {(side life_pInact_curTarget isEqualTo west)} && {(currentWeapon player != "")} && {!(currentWeapon player in oev_fake_weapons)} && {(life_pInact_curTarget getVariable ["downed",false])}) then {
	private _canRestrain = false;
	_canRestrain = [life_pInact_curTarget] call OEC_fnc_threeToOne;
	if (_canRestrain) then {
		_Btn1 ctrlEnable true;
	} else {
		_Btn1 ctrlEnable false;
	};
};

if((player distance oev_jailPos1) < 34) then {
	_Btn1 ctrlEnable false;
	_Btn3 ctrlEnable false;
};

life_bettingVer = profileNamespace getVariable ["life_bettingVer",true];
_Btn8 ctrlEnable true;
_Btn8 ctrlSetText "扣押现金";
_Btn8 buttonSetAction "if(player distance life_pInact_curTarget > 4) exitWith {hint '你太远了。'}; ['amount'] spawn OEC_fnc_betMoney; closeDialog 0;";
if (life_pInact_curTarget getVariable["restrained",false]) exitWith {_Btn8 ctrlEnable false};
if (side life_pInact_curTarget isEqualTo independent) exitWith {_Btn8 ctrlEnable false};
if (life_bettingVer) exitWith {_Btn8 ctrlEnable false};

private _gangData = life_pInact_curTarget getVariable ["gang_data",[0,"",0]];

_Btn9 ctrlEnable true;
