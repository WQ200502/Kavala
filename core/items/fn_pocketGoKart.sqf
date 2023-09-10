//  File: fn_pocketGoKart.sqf
//	Author: Tech
//	Description: Deploy pocket go kart poggers!!!!!
params [
  ["_mode",0,[0]],
  ["_kart",objNull,[objNull]]
];

_lcl_progress = {

  if (oev_action_inUse) exitWith {hint "You're already performing another action!";false;};
  oev_interrupted = false;
  oev_interruptedTab = false;

  oev_action_inUse = true;

  _headTxt = "Deploying Pocket Go-Kart";
  if(_mode isEqualTo 1) then {
    _headTxt = "Picking Up Pocket Go-Kart";
  };

  _cp = 0;
  disableSerialization;
  5 cutRsc ["life_progress","PLAIN DOWN"];
  _ui = uiNameSpace getVariable "life_progress";
  _progress = _ui displayCtrl 38201;
  _pgText = _ui displayCtrl 38202;
  _pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_headTxt];
  _progress progressSetPosition _cp;

  ["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;
  while {true} do {
    uiSleep 0.1;
    _cP = _cP + (0.01);
    _progress progressSetPosition _cP;
    _pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_headTxt];
    if(_cP >= 1) exitWith {};
    if(!alive player) exitWith {};
    if(player != vehicle player) exitWith {};
    if(oev_interrupted) exitWith {};
    if(oev_interruptedTab) exitWith {};
  };

  oev_action_inUse = false;
  5 cutText ["","PLAIN DOWN"];
  [] spawn OEC_fnc_handleAnim;
  if(!alive player) exitWith {false};
  if(oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false;false;};
  if(oev_interruptedTab) exitWith {oev_interruptedTab = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false;false;};
  true;
};

if(_mode isEqualTo 1) exitWith {
  _return = call _lcl_progress;
  if(_return) then {
    deleteVehicle _kart;
    [true,"gokart",1] call OEC_fnc_handleInv;
  };
};

_return = call _lcl_progress;
if !(_return) exitWith {};

_allKarts = ["C_Kart_01_F"];
_veh = createVehicle [selectRandom _allKarts, getPos player];
_veh lock 2;

_uid = getPlayerUID player;
_name = name player;

[_uid,side player,_veh,1] remoteExec ["OES_fnc_keyManagement",2];
[_veh] call OEC_fnc_addVehicle2Chain;

_veh setVariable ["dbInfo",["123",0],true];
_veh setVariable ["vehicle_info_owners",[[_uid,_name]],true];
_veh setVariable ["isBlackwater",false,true];
_veh setVariable ["defaultModMass",(getMass _veh),true];
_veh setVariable ["modifications",[0,0,0,0,0,0,0,0],true];
_veh setVariable ["insured",0,true];
_veh setVariable ["side","civ",true];

_veh addAction ["拾取",{[1,_this select 0] call OEC_fnc_pocketGoKart},nil,1.5,true,true,"","isNull objectParent player",2,false,"",""];

[false,"gokart",1] call OEC_fnc_handleInv;
