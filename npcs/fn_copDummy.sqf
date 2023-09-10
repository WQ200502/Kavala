//	[this,'LISTEN_BRIEFING'] call NPC_fnc_copDummy;
params ["_obj_main","_stance"];
if (_obj_main isKindOf "Man") then {
	[_obj_main,_stance,"NOGUN"] call OEC_fnc_ambientAnim;
};