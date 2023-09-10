#include <zmacro.h>
//	Description: Opens presents under christmas trees, gives players items
//  File: fn_openPresent.sqf
private["_target","_item"];
_target = _this param [0,objNull,[objNull]];

if(isNull _target) exitWith {};
if(!isNil {_target getVariable "receiver"}) exitWith {};

if(scriptAvailable(300)) exitWith {hint "不要贪心;)";};

_target setVariable ["receiver",getPlayerUID player,true];

titleText ["正在展开礼物。。。","PLAIN DOWN"];

sleep random(3);

titleText ["节日快乐!\n感谢您加入西海岸娱乐社区。","PLAIN DOWN"];

if(isNull _target) exitWith {};
if(_target getVariable ["receiver",""] != getPlayerUID player) exitWith {};
deleteVehicle _target;

[[player,"party_horn"],"OEC_fnc_say3D",-2,false] spawn OEC_fnc_MP;

switch(playerSide) do {
	case west: {
		_item = ["donuts","coffee","salt","potato"] call BIS_fnc_selectRandom;

		[true,_item,1 + round(random(4))] call OEC_fnc_handleInv;
		[true,"fireworks",2 + round(random(5))] call OEC_fnc_handleInv;
	};
	case independent: {
		_item = ["donuts","coffee","salt"] call BIS_fnc_selectRandom;

		[true,_item,1 + round(random(4))] call OEC_fnc_handleInv;
		[true,"fireworks",2 + round(random(5))] call OEC_fnc_handleInv;
	};
	case civilian: {
		switch(true) do {
			case ((O_stats_crimes select 0) > 100000): {
				hint "HoHoho! You've been naughty this year! The APD have been notified of your position, you're welcome.";
				[[3,format["<t color='#66ccff'><t size='1.8'><t align='center'>圣诞老人警报<br/><t color='#ffffff'><t align='center'><t size='1'>哈哈哈！ 我发现犯罪分子%%2试图窃取礼物，抢救他们！", (player getVariable["realname",name player]), ((getPos player) call BIS_fnc_locationDescription)],false,[]],"OEC_fnc_broadcast",west,false] spawn OEC_fnc_MP;

				[true,"potato",1 + round(random(4))] call OEC_fnc_handleInv;
				[true,"salt",1 + round(random(4))] call OEC_fnc_handleInv;
				[true,"fireworks",2 + round(random(5))] call OEC_fnc_handleInv;
			};
			case ((oev_is_arrested select 0) == 1): {
				hint "呵呵！你今年真淘气！";

				[true,"rock",1 + round(random(4))] call OEC_fnc_handleInv;
				[true,"salt",1 + round(random(4))] call OEC_fnc_handleInv;
				[true,"fireworks",2 + round(random(5))] call OEC_fnc_handleInv;
			};
			case (oev_atmcash > 1250000):{
				hint "哈哈哈！ 您已经是百万富翁！ 最好的礼物是送给不幸的人。";

				[true,"salt",1 + round(random(4))] call OEC_fnc_handleInv;
				[true,"fireworks",2 + round(random(5))] call OEC_fnc_handleInv;
			};
			default {
				hint "哈哈哈！ 我有一件特别的东西要给你...";
				_item = ["goldbar","diamondc","silverr"] call BIS_fnc_selectRandom;

				if((missionNamespace getVariable "life_inv_fireworks") < 15) then {
					[true,_item,5 + round(random(10))] call OEC_fnc_handleInv;
				}else{
					[true,"diamondc",3 + round(random(5))] call OEC_fnc_handleInv;
				};

				[true,"fireworks",3 + round(random(5))] call OEC_fnc_handleInv;
			};
		};
	};
	default {};
};