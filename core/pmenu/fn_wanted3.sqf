private["_unit","_crime"];

ctrlShow[2001,false];
if((lbCurSel 9902) == -1) exitWith {hint "No one was selected!";ctrlShow[2001,true];};
_unit = lbData [9902,lbCurSel 9902];
_unit = call compile format["%1",_unit];
_crime = lbData [9991,lbCurSel 9991];
//_crime = parseNumber(_crime);
if(isNil "_unit") exitWith {ctrlShow[2001,true];};
//if(_unit == player) exitWith {ctrlShow[2001,true];};
if(isNull _unit) exitWith {ctrlShow[2001,true];};
if(side _unit != civilian) exitWith {};

[[1,format["%1 is now wanted.",name _unit,_crime,getPlayerUID _unit]],"OEC_fnc_broadcast",west,false] spawn OEC_fnc_MP;
[[getPlayerUID _unit,_unit getVariable["realname",name _unit],_crime,_unit],"OES_fnc_wantedAdd",false,false] spawn OEC_fnc_MP;

[
  ["event","Charge Added"],
  ["player",name player],
  ["player_id",getPlayerUID player],
  ["target",name _unit],
  ["target_id",getPlayerUID _unit],
  ["position",getPosATL player]
] call OEC_fnc_logIt;
