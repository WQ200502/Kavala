#include "..\..\macro.h"
//  File: fn_buyDopamineCrate.sqf
//	Author: Ozadu
//	Description: Takes money from the player and sends a request for a crate to the server.

params[
	["_target",objNull,[objNull]],
	["_caller",objNull,[objNull]],
	["_id",-1,[0]],
	["_args",[],[[]]]
];

private _isNeo = false;
private _exit = false;
private _targetPos = [0,0,0];

if(playerSide != independent) exitWith {};
if(__GETC__(life_medicLevel) < 4) exitWith {hint "此功能当前仅限于搜索和救援+"};
_price = 50000;
_confirm = [format["你想用%1元买一个多巴胺箱吗？",_price],"购买多巴胺板条箱","Buy",true] call BIS_fnc_guiMessage;
if(!_confirm) exitWith {};

if ((player distance2D [11104.9,13092.6,0.7526]) < 100) then {_isNeo = true};

/*Check if anything is in the way of spawn*/
if !(_isNeo) then {
	_targetPos = getPosATL _target;
	_hs = nearestObjects[_targetPos,["Land_Hospital_side2_F"],175];
	if(count _hs == 0) exitWith {};
	_hs = _hs select 0;
	_crateType = "Land_Cargo10_yellow_F";
	_crate = _crateType createVehicleLocal [0,0,0];
	_crate setPosATL (_hs modelToWorld [12.6616,-3.1123,10.6315]);
	_collides = [_crate] call OEC_fnc_objectCollides;
	deleteVehicle _crate;
	if(_collides) exitWith {_exit = true};
} else {
	_targetPos = [12104.4,14068.8,-0.00708389];
	_crateType = "Land_Cargo10_yellow_F";
	_crate = _crateType createVehicleLocal [0,0,0];
	_crate setPos [12104.4,14068.8,-0.00708389];
	_collides = [_crate] call OEC_fnc_objectCollides;
	deleteVehicle _crate;
	if(_collides) exitWith {_exit = true};
};

if(_exit) exitWith {hint "有东西挡住了生成"};

//take some money
if(_price > oev_atmcash) exitWith {hint localize "STR_NOTF_NotEnoughMoney"};
oev_atmcash = oev_atmcash - _price;
oev_cache_atmcash = oev_cache_atmcash - _price;
[1] call OEC_fnc_ClupdatePartial;
hint format["多巴胺板条箱已以%1元的价格购买。它会在医院顶上生成。",_price];

[[player,_targetPos,_isNeo],"OES_fnc_spawnDopamineCrate",false,false] call OEC_fnc_mp;
