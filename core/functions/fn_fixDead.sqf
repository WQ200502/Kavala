// File: fn_fixDead
// Description: Replace player corpses that have been bugged while dead
//              Happens when the body is stuck in an exploded vehicle,
//              and the body gets deleted with it
// Author: Fraali

params [
["_obj", objNull, [objNull]],
["_vars", [], [[]]],
["_pos", [], [[]]]
];
_pos = if(isNull _obj) then {_pos} else {getPosATL _obj};
_vars = if (isNull _obj) then {_vars} else {allVariables _obj};
_class = switch {playerSide} do {
  case civilian : {"C_man_polo_2_F"};
  case independent : {"I_medic_F"};
  case west : {"B_RangeMaster_F"};
  default {"C_man_polo_2_F"};
};

_obj_main = _class createVehicle _pos; // Create a new object to fix our bugged corpse

waitUntil {!isNil "_obj_main" && {!isNull _obj_main}};
_obj_main hideObject true;
_obj_main setDamage 1;
uiSleep 1;
_obj_main setUnitLoadout [getUnitLoadout _obj, false];
uiSleep 1;
_obj_main hideObject false;

life_corpse = _obj_main;

//Copy variables from previous player. Set true where needed.
_trueVars = ["deslvl","donlvl","dispatchowner","epiactive","restrictions","blindfolded","ziptied","steam64id","bis_randomseed1","bis_fnc_selectrespawntemplate_respawned","restrained","afkcheck","bis_randomseed2","gang_data","escorting","transporting","titlecolor","currenttitle","devlvl","vigilantearrestsstored","supportteam","playeradminlevel","hasgps","statbounty","beingrobbed","hasrequested","realname","jailed","lastspottedtime","episide","randomValue","isinevent","inhouseinventory","name","adminlvl","vigilantearrests","hitmanbounty","infected","responsetype","epifailed","maxrevtime","morale","hexiconname","revive","kidneyharvester","saved3deninventory","dispatchstatus","deathposition"];
{
  _pub = if (_x in _trueVars) then [{true},{false}];
  _obj_main setVariable [_x, _obj getVariable _x, _pub];
}forEach _vars;
player setVariable ["oev_corpse", _obj_main, true];

//Wait for object to get set right for proper camera position
waitUntil {(getPos _obj_main distance2D _pos) < 100};
life_deathCamera camSetTarget _obj_main;
life_deathCamera camCommit 0.5;

deleteVehicle _obj;
