//  Title: fn_hackRadioTower
//	Author: Kurt

//	Description: Does what it do.

//Initialize variables
private _terrorDevice = _this select 0;
private _caller = _this select 1;

private _position = getPos _terrorDevice;
private _timeBetweenTerror = 45 * 60; // 45 minutes

//Checks to cancel initial terror
if (isNull _caller) exitWith {};
if (playerSide isEqualTo independent || playerside isEqualTo west) exitWith {hint parseText format["<t color='#ff0000'><t size='2'>恐怖失败</t></t><br/><br/>我不确定你是如何做到这一点的，但是是的......你不能将恐怖称为医生或警察."];};
if (life_terrorStatus select 0) exitWith {hint parseText format["<t color='#ff0000'><t size='2'>恐怖失败</t></t><br/><br/>目前有恐怖现在在一个城市被召唤."];};
if (time < 600) exitWith {hint parseText format["<t color='#ff0000'><t size='2'>恐怖失败</t></t><br/><br/>你可以在服务器重启的前 10 分钟内不要调用恐怖."];};
if ((serverTime < (life_terrorStatus select 2)) && !((life_terrorStatus select 2) isEqualTo 0)) exitWith {hint parseText format["<t color='#ff0000'><t size='2'>恐怖失败</t></t><br/><br/>在过去 45 分钟内调用了一次恐怖。下一次恐怖可以在：:<br/><br/><t size='1.5'>%1</t>",[(life_terrorStatus select 2) - serverTime, "MM:SS"] call BIS_fnc_secondsToString];};
if !(life_inv_hackingterminal > 0) exitWith {hint parseText format["<t color='#ff0000'><t size='2'>恐怖失败</t></t><br/><br/>你不符合开始恐怖活动的要求。您必须有一个黑客终端、一个主要武器，并且附近至少有两个其他拥有主要武器的玩家才能开始这个过程."];};
//This is for atleast 3 weapons near the terminal
private _haveWeapons = 0;
private _exit = false;
{
	if (_haveWeapons >= 3) exitWith {};
	if (((_x distance _terrorDevice) < 20) && {(side _x isEqualTo civilian)} && {!(_x getVariable ["restrained",false])} && {!(_x getVariable ["downed",false])}) then {
		if (!(currentWeapon _x isEqualTo "") && {!(currentWeapon _x in oev_fake_weapons)}) then {
			_haveWeapons = _haveWeapons + 1;
		};
	};
} forEach playableUnits;
if (_haveWeapons < 3) exitWith {hint parseText format["<t color='#ff0000'><t size='2'>恐怖失败</t></t><br/><br/>你做到了不符合启动恐怖的要求。你必须有一个黑客终端，一个没有带枪套的主要武器，并且至少有两个其他玩家在附近没有带主要武器的主要武器才能开始这个过程."];};

//Begin progress bar
disableSerialization;

oev_action_inUse = true;
5 cutRsc ["life_progress","PLAIN DOWN"];
private _ui = uiNamespace getVariable ["life_progress",displayNull];
private _progressBar = _ui displayCtrl 38201;
private _titleText = _ui displayCtrl 38202;
private _title = "Uploading virus";
private _abort = "Virus planting aborted due to moving too far from the device!";
private _close = false;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
private _cP = 0.01;
["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;
for "_i" from 0 to 1 step 0 do {
	uisleep 0.6;
	_cP = _cP + 0.01;
	_progressBar progressSetPosition _cP;
	_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
	if (_cP >= 1 || !alive player) exitWith {};
	if (player distance _position > 4) exitWith {hint format["%1",_abort];oev_action_inUse = false;_close = true;};
	if (oev_interrupted) exitWith {oev_interrupted = false;titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"];oev_action_inUse = false;_close = true;};
	if (player getVariable["restrained",false]) exitWith {oev_action_inUse = false;_close = true;};
};

//Handle animations post virus plant
5 cutText ["","PLAIN DOWN"];
[] spawn OEC_fnc_handleAnim;
oev_action_inUse = false;
if (!alive player) exitWith {};
if (player distance _position > 4) exitWith {};
if (player getVariable ["restrained",false]) exitWith {};
if (_close) exitWith {};
if !([false,"hackingterminal",1] call OEC_fnc_handleInv) exitWith {hint parseText format["<t color='#ff0000'><t size='2'>恐怖失败</t></t><br/><br/>您不符合开始恐怖活动的要求。您必须有一个黑客终端、一个主要武器，并且附近至少有两名其他拥有主要武器的玩家才能开始这个过程."];};

[_terrorDevice,_caller] remoteExec ["OES_fnc_handleTerror",2,false];
