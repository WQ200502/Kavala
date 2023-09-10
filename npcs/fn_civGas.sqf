//[this,'STAND'] call NPC_fnc_civGas;
params ["_obj_main","_stance"];

if (_obj_main isKindOf "Man") then {
	[_obj_main,_stance] call OEC_fnc_ambientAnim;
};

_obj_main addAction ["市场",OEC_fnc_virt_menu,"market",1.5,false,false,"",'',6];
_obj_main addAction ["一般商店",OEC_fnc_weaponShopMenu,"genstore",1.5,false,false,"",'',6];
_obj_main addAction ["购买彩票",{["start"] call OEC_fnc_buyLotteryTicket},"",1.5,false,false,"",'',6];