//[this,'STAND'] call NPC_fnc_civDMV;
params ["_obj_main","_stance"];

if (_obj_main isKindOf "Man") then {
	[_obj_main,_stance] call OEC_fnc_ambientAnim;
};

_obj_main addAction [format['%1 (%2元)',['license_civ_driver'] call OEC_fnc_varToStr,[(['driver'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,'driver',1.5,false,false,"",'!license_civ_driver && playerSide isEqualTo civilian',6];
_obj_main addAction [format['%1 (%2元)',['license_civ_boat'] call OEC_fnc_varToStr,[(['boat'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,'boat',1.5,false,false,"",'!license_civ_boat && playerSide isEqualTo civilian',6];
_obj_main addAction [format['%1 (%2元)',['license_civ_air'] call OEC_fnc_varToStr,[(['pilot'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,'pilot',1.5,false,false,"",'!license_civ_air && playerSide isEqualTo civilian',6];
_obj_main addAction [format['%1 (%2元)',['license_civ_truck'] call OEC_fnc_varToStr,[(['truck'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,'truck',1.5,false,false,"",'!license_civ_truck && playerSide isEqualTo civilian',6];
_obj_main addAction [format['%1 (%2元)',['license_civ_home'] call OEC_fnc_varToStr,[(['home'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,'home',1.5,false,false,"",'!license_civ_home && playerSide isEqualTo civilian',6];
_obj_main addAction [format['%1 (%2元)',['license_civ_gun'] call OEC_fnc_varToStr,[(['gun'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,'gun',1.5,false,false,"",'!license_civ_gun && playerSide isEqualTo civilian',6];
_obj_main addAction [format['%1 (%2元)',['license_civ_oil'] call OEC_fnc_varToStr,[(['oil'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,'oil',1.5,false,false,"",'!license_civ_oil && playerSide isEqualTo civilian',6];
_obj_main addAction [format['%1 (%2元)',['license_civ_diamond'] call OEC_fnc_varToStr,[(['diamond'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,'diamond',1.5,false,false,"",'!license_civ_diamond && playerSide isEqualTo civilian',6];
_obj_main addAction [format['%1 (%2元)',['license_civ_salt'] call OEC_fnc_varToStr,[(['salt'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,'salt',1.5,false,false,"",'!license_civ_salt && playerSide isEqualTo civilian',6];
_obj_main addAction [format['%1 (%2元)',['license_civ_sand'] call OEC_fnc_varToStr,[(['sand'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,'sand',1.5,false,false,"",'!license_civ_sand && playerSide isEqualTo civilian',6];
_obj_main addAction [format['%1 (%2元)',['license_civ_iron'] call OEC_fnc_varToStr,[(['iron'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,'iron',1.5,false,false,"",'!license_civ_iron && playerSide isEqualTo civilian',6];
_obj_main addAction [format['%1 (%2元)',['license_civ_copper'] call OEC_fnc_varToStr,[(['copper'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,'copper',1.5,false,false,"",'!license_civ_copper && playerSide isEqualTo civilian',6];
_obj_main addAction [format['%1 (%2元)',['license_civ_cement'] call OEC_fnc_varToStr,[(['cement'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,'cement',1.5,false,false,"",'!license_civ_cement && playerSide isEqualTo civilian',6];
_obj_main addAction [format['%1 (%2元)',['license_civ_platinum'] call OEC_fnc_varToStr,[(['platinum'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,'platinum',1.5,false,false,"",'!license_civ_platinum && playerSide isEqualTo civilian',6];
_obj_main addAction [format['%1 (%2元)',['license_civ_silver'] call OEC_fnc_varToStr,[(['silver'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,'silver',1.5,false,false,"",'!license_civ_silver && playerSide isEqualTo civilian',6];