//	Description: Checks the gangid of all online players and returns an array of gangs online players
private["_gangID","_memberArray"];
_gangID = _this param [0,0,[0]];
if(_gangID == 0) exitWith {hint "Failed to fetch online members."; [];};

_memberArray = [];

{
	if(!isNil {_x getVariable "gang_data"} && ((_x getVariable "gang_data") select 0 == _gangID)) then {
		_memberArray pushBack _x;
	};
}foreach playableUnits;

_memberArray;