//  File: fn_escortAction.sqf
private["_target","_weaponArray"];
_target = param [0,ObjNull,[ObjNull]];

if (player distance _target > 3) exitWith {};
if (!isNull (player getVariable ["TransportingPlayer", objNull])) exitWith {hint "你一次只能押送一个人。";};
if (isNil "_target" || isNull _target || !isPlayer _target) exitWith {};
if (_target getVariable ["Escorting",false]) exitWith {hint "那个玩家已经有人押送了。";};
if (!isNull (_target getVariable["TransportingPlayer",objNull])) exitWith {hint "那个玩家已经在押送另一个玩家了。";};
if (oev_action_inUse) exitWith {hint "你已经在执行另一个操作了。";};
if (animationState _target != "AmovPercMstpSnonWnonDnon_Ease") exitWith {hint "你不能押送一个玩家，直到他们在正确的动画。";};
oev_action_inUse = true;

_obj_main = player;

_target setPos ((getPos player) vectorAdd (vectorDir player));
_target attachTo [player, [0, 1, 0.1]];//civ_2 attachTo [player, [0, 0.2, -1.2], "leftshoulder"];
waitUntil {_target in (attachedObjects player)};
player reveal _target;

player setVariable ["TransportingPlayer", _target, true];
_target setVariable["Escorting",true,true];

life_stopEscortAction = _obj_main addAction [format ["<t color='#FF0000'>%1</t>", "Stop Escorting"], "player removeAction life_stopEscortAction; life_stopEscortAction = nil;", nil, 20, false, true, "", ""];
waitUntil{uiSleep 0.3; _target = (player getVariable ["TransportingPlayer", objNull]); ((vehicle player != player) || (player getVariable["playerSurrender",false]) || !(_target getVariable["restrained",false]) || (player getVariable["restrained",false]) || (_target != vehicle _target) || (isNull _target) || !(alive player) || !(alive _target) || (isNil "life_stopEscortAction") || (player getVariable["downed",false]))};
_target = (player getVariable ["TransportingPlayer", objNull]);
if(!isNull _target) then {
	detach _target;
	/*
	if(alive _target) then {
		_target setpos (player ModelToWorld [0,1.9,0]);
	};
	*/
	_target setVariable["Escorting",false,true];
};
player setVariable ['TransportingPlayer', objNull, true];

if(!isNil "life_stopEscortAction") then {
	player removeAction life_stopEscortAction;
	life_stopEscortAction = nil;
};

oev_action_inUse = false;