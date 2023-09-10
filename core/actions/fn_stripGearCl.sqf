//    File: fn_stripGearCl.sqf
//    Author: Kurt Reanolds
//    Description:
//    Begins stripping the player of their gear.

private["_curTarget","_text","_ui","_progress","_pgText","_cP","_time","_slot"];

_curTarget = param [0,objNull,[objNull]];
_slot = param [1,"",[""]];
_time = param [2,0,[0]];

if (_slot isEqualTo "") exitWith {};
if (_time isEqualTo 0) exitWith {};
_exit = false;
if !((_curTarget getVariable ["beingRobbed", []]) isEqualTo []) then {
  {
    if ((_x select 1) isEqualTo _slot && !((_x select 0) isEqualTo player)) exitWith {_exit = true};
  }forEach (_curTarget getVariable ["beingRobbed", [[player, _slot]]]);
  if (_exit) exitWith {};
  _curTarget setVariable ["beingRobbed", (_curTarget getVariable "beingRobbed") + [[player, _slot]], true];
} else {
  _curTarget setVariable ["beingRobbed", [[player, _slot]], true];
};
if (_exit) exitWith {hint "两个人不能抢同一件东西！"};
_time = _time / 100; //For the progress bar

//Start a progress bar to strip the gear
disableSerialization;
oev_action_inUse = true;
_text = format[localize "STR_NOTF_StrippingPlayer",_slot, name _curTarget];
"progressBar" cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNamespace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format ["%2 (1%1)...","%",_text];
_progress progressSetPosition 0.01;
_cP = 0.01;
["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;
for "_i" from 0 to 1 step 0 do {
    uiSleep _time;
    _cP = _cP + 0.01;
    _progress progressSetPosition _cP;
    _pgText ctrlSetText format ["%3 (%1%2)...",round(_cP * 100),"%",_text];
    if (_cP >= 1) exitWith {};
    if (!alive player) exitWith {};
    if !(isNull objectParent player) exitWith {};
    if (oev_interrupted) exitWith {};
    if ((count (_curTarget getVariable ["beingRobbed", [[player, _slot]]]))>1) then {
      {
        if ((_x select 1) isEqualTo _slot && !((_x select 0) isEqualTo player)) exitWith {oev_interrupted = true};
      }forEach (_curTarget getVariable ["beingRobbed", [[player, _slot]]]);
    };
};

oev_action_inUse = false;
"progressBar" cutText ["","PLAIN DOWN"];
[] spawn OEC_fnc_handleAnim;

if ((_curTarget getVariable "beingRobbed") isEqualTo [[player, _slot]]) then {
  _curTarget setVariable ["beingRobbed", nil, true];
} else {
  _curTarget setVariable ["beingRobbed", (_curTarget getVariable "beingRobbed") - [[player, _slot]], true];
};
if (oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false;};
life_pInact_curTarget = _curTarget;

[_slot,player,life_pInact_curTarget]remoteExec["OES_fnc_seizePlayerItemsCiv",2];
