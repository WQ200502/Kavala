//	Author: Poseidon
//  File: fn_hackAntiAir.sqf
//	Description: Does what it do.

params [
	["_object",objNull,[objNull]]
];
private ["_perkTier","_cpRateChange"];

if (isNull _object) exitWith {};
if (playerSide isEqualTo independent) exitWith {};
if (playerSide isEqualTo civilian && {((_object getVariable ["virus",""]) isEqualTo "CIV")}) exitWith {hint "系统已感染病毒。"};
if (playerSide isEqualTo civilian && {!(_object getVariable["active",true])} && {((_object getVariable ["virus",""]) isEqualTo "")}) exitWith {hint "系统已被禁用。"};
//private _copCount = [west,2] call OEC_fnc_playerCount;
//if (playerSide isEqualTo civilian && (_object isEqualTo fedAntiAir) && (_copCount < 5)) exitWith {hint localize "STR_Civ_NotEnoughCops";};
//if (playerSide isEqualTo civilian && (_object isEqualTo bwAntiAir) && (_copCount < 7)) exitWith {hint "There needs to be 7 or more cops online to continue.";};
if (playerSide isEqualTo civilian && {life_inv_hackingterminal isEqualTo 0} && {((_object getVariable ["virus",""]) isEqualTo "")}) exitWith {hint "你需要一个黑客终端来关闭防空系统！"};
_fin = false;
if (playerSide isEqualTo west && !(_object isEqualTo islandAntiAir_1)) then {
	if (playerSide isEqualTo west && (_object getVariable ["active",true]) && {((_object getVariable ["virus",""]) isEqualTo "")}) exitWith {hint "系统处于工作状态."; _fin = true};
	if (playerSide isEqualTo west && !(_object getVariable ["active",true]) && {((_object getVariable ["virus",""]) isEqualTo "APD")}) exitWith {hint "系统修复."; _fin = true};
};
if (_fin) exitWith {};

private _position = getPos _object;
private _close = false;
disableSerialization;

oev_action_inUse = true;
5 cutRsc ["life_progress","PLAIN DOWN"];
private _ui = uiNamespace getVariable ["life_progress",displayNull];
private _progressBar = _ui displayCtrl 38201;
private _titleText = _ui displayCtrl 38202;
private _title = "正在上载病毒";
private _abort = "由于距离设备太远，病毒植入中止！";
if (playerSide isEqualTo west) then {
	_title = "重置防空系统";
	_abort = "由于移动距离设备太远，重置中止！"
};
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
private _cP = 0.01;
if (playerSide isEqualTo civilian) then {
	_perkTier = ["civ_hackedAAs"] call OEC_fnc_fetchStats;
	_cpRateChange = switch (_perkTier) do {
		case 1: {1.05};
		case 2: {1.10};
		case 3: {1.25};
		default {1};
	};
};
if (playerSide isEqualTo west) then {
	_perkTier = ["cop_repairedAAs"] call OEC_fnc_fetchStats;
	_cpRateChange = switch (_perkTier) do {
		case 1: {1.025};
		case 2: {1.05};
		case 3: {1.075};
		case 4: {1.10};
		case 5: {1.125};
		default {1};
	};
};

["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;
for "_i" from 0 to 1 step 0 do {
	uisleep 0.3;
	_cP = _cP + (0.01 * _cpRateChange);
	_progressBar progressSetPosition _cP;
	_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
	if (_cP >= 1 || !alive player) exitWith {};
	if (player distance _position > 4) exitWith {hint format["%1",_abort];oev_action_inUse = false;_close = true;};
	if (oev_interrupted) exitWith {oev_interrupted = false;titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"];oev_action_inUse = false;_close = true;};
	if (player getVariable["restrained",false]) exitWith {oev_action_inUse = false;_close = true;};
};

5 cutText ["","PLAIN DOWN"];
[] spawn OEC_fnc_handleAnim;
oev_action_inUse = false;
if (!alive player) exitWith {};
if (player distance _position > 4) exitWith {};
if (player getVariable ["restrained",false]) exitWith {};
if (_close) exitWith {};

if (playerSide isEqualTo civilian) then {
	if ((_object getVariable ["virus",""]) isEqualTo "CIV") exitWith {hint "系统已感染病毒。"};
	if (!(_object getVariable ["active",true]) && ((_object getVariable ["virus",""]) isEqualTo "")) exitWith {hint "System is already disabled."};
	if (((_object getVariable ["virus",""]) isEqualTo "") && {!([false,"hackingterminal",1] call OEC_fnc_handleInv)}) exitWith {};

	if ((_object getVariable ["virus",""]) isEqualTo "") then {
		[[getPlayerUID player,profileName,"54",player],"OES_fnc_wantedAdd",false,false] spawn OEC_fnc_MP;
	};
	["AA_hacked",1] spawn OEC_fnc_statArrUp;
	[[_object,1],"OES_fnc_handleAntiAir",false,false] spawn OEC_fnc_MP;
} else {
	if (_object isEqualTo islandAntiAir_1) exitWith {hint parseText "<t color='#ff2222'><t size='2.2'><t align='center'>成功!<br/><t color='#FFC966'><t align='center'><t size='1.2'>这个联邦防空系统正在维修中。"};
	if (playerSide isEqualTo west && (_object getVariable ["active",true]) && {((_object getVariable ["virus",""]) isEqualTo "")}) exitWith {hint "系统处于工作状态."};
	if (playerSide isEqualTo west && !(_object getVariable ["active",true]) && {((_object getVariable ["virus",""]) isEqualTo "APD")}) exitWith {hint "系统修复."};
	["AA_repaired",1] spawn OEC_fnc_statArrUp;
	[[_object,2],"OES_fnc_handleAntiAir",false,false] spawn OEC_fnc_MP;
};