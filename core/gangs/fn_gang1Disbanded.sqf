
//	Author: Bryan "Tonic" Boardwine
//	Description: Notifies members that the gang has been disbanded.
private["_gangID","_group"];
_gangID = _this param [0,0,[0]];
if(_gangID == 0) exitWith {}; //wrong gang
if(!isNull (findDisplay 37000)) then {['yMenuCreateGang'] spawn OEC_fnc_createDialog;};

hint "Your gang has been disbanded.";

if(!isNil {(group player) getVariable "gang_id"}) then {
	_group = (group player);
	[player] joinSilent (createGroup civilian);
	if(count units _group == 0) then {
		deleteGroup _group;
	};
};

oev_gang_data = [];
oev_gang_warIDs = [];
player setVariable["gang_data",nil,true];
