//[this,'BRIEFING_POINT_LEFT'] call NPC_fnc_civRebelClothing;
params ["_obj_main","_stance"];
if (_obj_main isKindOf "Man") then {
	[_obj_main,_stance,"REBEL"] call OEC_fnc_ambientAnim;
};

_obj_main addAction ["叛军服装商店",OEC_fnc_clothingMenu,"reb",1.5,false,false,"",'license_civ_rebel && playerSide isEqualTo civilian',6];
_obj_main addAction ["战点服装商店",OEC_fnc_clothingMenu,"war",1.5,false,false,"",'playerSide isEqualTo civilian',6];
_obj_main addAction ["医疗救助",OEC_fnc_healHospital,"",1.5,false,false,"",'',6];
_obj_main addAction[format['%1 ($%2)',['license_civ_rebel'] call OEC_fnc_varToStr,[(['rebel'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,"rebel",2,false,false,"",'!license_civ_rebel && playerSide isEqualTo civilian',6];