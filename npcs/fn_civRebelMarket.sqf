//[this,'LEAN'] call NPC_fnc_civRebelMarket;
params ["_obj_main","_stance"];
if (_obj_main isKindOf "Man") then {
	[_obj_main,_stance,"REBEL"] call OEC_fnc_ambientAnim;
};

_obj_main addAction ["叛军市场",OEC_fnc_virt_menu,"rebel",1.5,false,false,"",'license_civ_rebel && playerSide isEqualTo civilian',6];
_obj_main addAction ["医疗救助",OEC_fnc_healHospital,"",1.5,false,false,"",'',6];
_obj_main addAction[format['%1 (%2元)',['license_civ_rebel'] call OEC_fnc_varToStr,[(['rebel'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,"rebel",2,false,false,"",'!license_civ_rebel && playerSide isEqualTo civilian',6];