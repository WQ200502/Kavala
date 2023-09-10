// File: fn_giveContraband.sqf
// Author: Jesse "tkcjesse" Schultz
// Description: Gives contraband obtained from fn_trashjail to the prison guard in the jail to reduce jail time.
if ((oev_is_arrested select 0) isEqualTo 0) exitWith {};
//if ((oev_is_arrested select 1) <= 900) exitWith {titleText ["You can only turn in contraband if you have over 15 minutes left on your sentence!","PLAIN DOWN"];};
if (profileNamespace getVariable ["contraband",0] <= 0) exitWith {titleText ["You have no contraband to give to the guard.","PLAIN DOWN"];};

oev_action_inUse = true;
oev_holdJailTime = true;
private _numOfCont = profileNamespace getVariable ["contraband",0];
private _removeTime = (_numOfCont * 60);
["contraband",_numOfCont] call OEC_fnc_statArrUp;
oev_jailTime = oev_jailTime - _removeTime;
profileNamespace setVariable ["contraband",0];
oev_holdJailTime = false;
oev_action_inUse = false;

titleText [format ["You turned in %1 pieces of contraband and have had %1 minutes removed from your sentence!",_numOfCont],"PLAIN DOWN"];

life_bail_amount = (round(oev_jailTime - time)/0.0048);
