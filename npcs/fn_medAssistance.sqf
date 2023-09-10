//[this,'STAND'] call NPC_fnc_medAssistance;
params ["_obj_main","_stance"];

if (_obj_main isKindOf "Man") then {
	[_obj_main,_stance,"MEDIC"] call OEC_fnc_ambientAnim;
};

_obj_main addAction ["医疗协助",OEC_fnc_healHospital,"",1.5,false,false,"",'isNull objectParent player',6];