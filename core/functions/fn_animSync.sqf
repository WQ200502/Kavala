if(isServer && isDedicated) exitWith {};

//  File: fn_animSync.sqf
private["_unit","_anim"];
_unit = param [0,ObjNull,[Objnull]];
_anim = param [1,"",[""]];
if(isNull _unit) exitWith {};

if(_unit != player) then {
	_unit switchMove _anim;
}else{
	if(_anim == "ainjpfalmstpsnonwrfldf_carried_dead") then {
		_unit setDir 180;
		//_unit setVectorUp [0,-0.3,1];
	};
	if(_anim in ["ainjpfalmstpsnonwrfldf_carried_dead","UnconsciousReviveMedic_b","AmovPknlMstpSnonWnonDnon",""]) then {
		_unit switchMove _anim;
	};
};