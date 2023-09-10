//[this,'STAND'] call NPC_fnc_civRebelWeapon;
params ["_obj_main","_stance"];

if (_obj_main isKindOf "Man") then {
	[_obj_main,_stance,"REBEL"] call OEC_fnc_ambientAnim;
};

_obj_main addAction ["战争点商店",OEC_fnc_weaponShopMenu,"war_market",1.5,false,false,"",'playerSide isEqualTo civilian',6];