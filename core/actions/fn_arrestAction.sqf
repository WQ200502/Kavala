if(oev_jailCD > time) exitWith {hint "您无法阻止垃圾邮件，请等待3秒钟。";};
oev_jailCD = time + 3;
//  File: fn_arrestAction.sqf

//	Description: Arrests the targeted person.
params [
	["_unit",objNull,[objNull]],
	["_isVigi",false,[false]]
];
if((jailwall getVariable["safe_open",false])) exitWith {hint "监狱坏了，修好了才可以坐牢！";};
if(isNull _unit) exitWith {}; //Not valid
if(isNil "_unit") exitwith {}; //Not Valid
if(!(_unit isKindOf "Man")) exitWith {}; //Not a unit
if(!isPlayer _unit) exitWith {}; //Not a human
if(!(_unit getVariable "restrained")) exitWith {}; //He's not restrained.
if(!((side _unit) in [civilian,independent])) exitWith {}; //Not a civ
if(_unit isEqualTo oev_vigiBuddyObj) exitWith {hint "你不能把你的维吉伙伴送进监狱！";};

private _action = [
	format ["你确定要把%1送进监狱吗？",name _unit],
	"确认",
	"是",
	"否"
] call BIS_fnc_guiMessage;

private _storedBounty = 0;


if (_action) then {
	uiSleep floor random 3;
	if((jailwall getVariable["safe_open",false])) exitWith {hint "监狱被打破了，在修复之前，您不能监禁囚犯！";};
	if(isNil "_unit") exitwith {}; //Not Valid
	if(!(_unit isKindOf "Man")) exitWith {}; //Not a unit
	if(!isPlayer _unit) exitWith {}; //Not a human
	if(!(_unit getVariable "restrained")) exitWith {};
	if(!((side _unit) in [civilian,independent])) exitWith {};
	if(_unit isEqualTo oev_vigiBuddyObj) exitWith {hint "您无法将维吉好友送入监狱！";};
	if!(alive player) exitWith {};
	if (player distance _unit > 10) exitWith {hint "那玩家太远了，您无法逮捕"};

	[[_unit,player,false],"OES_fnc_wantedBounty",false,false] spawn OEC_fnc_MP;
	O_stats_arrestsMade = O_stats_arrestsMade + 1;

	if(isNull _unit) exitWith {};
	detach _unit;
	if (_unit getVariable ["isVigi",false]) then {
		[[2,_unit],"OES_fnc_vigiGetSetArrests",false,false] spawn OEC_fnc_MP; // Wipe their vigi progress
		[
			["event","Lowered a Vigi Tier"],
			["player",name _unit],
			["player_id",getPlayerUID _unit],
			["by",name player],
			["by_id",getPlayerUID player],
			["location",getPosATL player]
		] call OEC_fnc_logIt;

	};
	_storedBounty = (_unit getVariable["statBounty",0]);
	[[_unit,false],"OEC_fnc_jaill",_unit,false] spawn OEC_fnc_MP;
	[[0,"STR_NOTF_Arrested_1",true, [_unit getVariable["realname",name _unit], profileName, [_storedBounty] call OEC_fnc_numberText]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;

	if (playerSide isEqualTo civilian) then {
		[[1,player],"OES_fnc_vigiGetSetArrests",false,false] spawn OEC_fnc_MP;
		["vigiarrest",1] call OEC_fnc_statArrUp;
		if (oev_vigiarrests isEqualTo 24) then { // Subtract 1 so it alerts when they make the initial arrest
			hint parseText format ["<t color='#00CC00'><t size='2'>排名上升: 等级 2</t></t><br/><br/>恭喜，您逮捕了25位嫌疑人！ 现在可以享受以下福利:<br/><br/><t color='#FF0000'><t size='2'>武器类:</t></t><br/>ACP .45<br/><br/><t color='#FF0000'><t size='2'>Backpacks:</t></t><br/>Carryall"];
		};
		if (oev_vigiarrests isEqualTo 49) then { // Subtract 1 so it alerts when they make the initial arrest
			hint parseText format ["<t color='#00CC00'><t size='2'>排名上升: 等级 3</t></t><br/><br/>恭喜，您逮捕了50位嫌疑人！ 现在可以享受以下福利:<br/><br/><t color='#FF0000'><t size='2'>武器类:</t></t><br/>Sting 9mm<br/><br/><t color='#FF0000'><t size='2'>Vests:</t></t><br/>Vigilante Vest"];
		};
		if (oev_vigiarrests isEqualTo 99) then { // Subtract 1 so it alerts when they make the initial arrest
			hint parseText format ["<t color='#00CC00'><t size='2'>排名上升: 等级 4</t></t><br/><br/>恭喜，您逮捕了100位嫌疑人！ 现在可以享受以下福利:<br/><br/><t color='#FF0000'><t size='2'>武器类:</t></t><br/>Spar-16 5.56"];
		};
		if (oev_vigiarrests isEqualTo 199) then { // Subtract 1 so it alerts when they make the initial arrest
			hint parseText format ["<t color='#00CC00'><t size='2'>排名上升: 等级 5</t></t><br/><br/>恭喜，您逮捕了200位嫌疑人！ 现在可以享受以下福利:<br/><br/><t color='#FF0000'><t size='2'>武器类:</t></t><br/>Spar-16 5.56"];
		};
	} else {
		["cop_arrests",1] spawn OEC_fnc_statArrUp;
	};

	[_unit] spawn{
		_player = param [0,ObjNull,[ObjNull]];
		if(isNull _player) exitWith {};
		_player hideObject true;
		uiSleep 30;
		if(isNull _player) exitWith {};
		_player hideObject false;
	};
};
