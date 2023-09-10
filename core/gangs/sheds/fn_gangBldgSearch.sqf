//  File: fn_gangBldgSearch.sqf
//	Author: Jesse "tkcjesse" Schultz

//	Description: Searches the gang building trunk

params [["_building",objNull,[objNull]]];
if (isNull _building) exitWith {};
if (oev_action_inUse) exitWith {};
if !(typeOf _building isEqualTo "Land_i_Shed_Ind_F") exitWith {};
if !(playerSide isEqualTo west) exitWith {};

_bldgInv = _building getVariable ["Trunk",[[],0]];
private _physicalInv = _building getVariable ["PhysicalTrunk",[[],0]];
if((_bldgInv isEqualTo [[],0]) && (_physicalInv isEqualTo [[],0])) exitWith {hint "There is nothing in this gang building."};
oev_action_inUse = true;

//Setup the progress bar
disableSerialization;
_title = "Searching Gang Building...";
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNamespace getVariable "life_progress";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;
_cpRate = 0.0075;

while {true} do {
	uiSleep 0.26;
	if(isNull _ui) then {
		5 cutRsc ["life_progress","PLAIN DOWN"];
		_ui = uiNamespace getVariable "life_progress";
	};
	_cP = _cP + _cpRate;
	_progressBar progressSetPosition _cP;
	_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
	if(_cP >= 1 || !alive player) exitWith {};
	if(player distance _building > 13) exitWith {};
};

//Kill the UI display and check for various states
5 cutText ["","PLAIN DOWN"];
if(player distance _building > 13) exitWith {oev_action_inUse = false; titleText["You went too far away from the building!","PLAIN DOWN"]};
if(!alive player) exitWith {oev_action_inUse = false;};
oev_action_inUse = false;

_bldgInvData = _bldgInv select 0;
_bldgInvVal = _bldgInv select 1;
_value = 0;

_value = 0;
{
    _var = _x select 0;
    _val = _x select 1;

    _index = [_var,oev_illegal_items] call OEC_fnc_index;
    if(_index != -1) then {
        _marketprice = (((oev_illegal_items) select _index) select 1);
        if(_marketprice != -1) then {
            _value = _value + (_val * _marketprice);
        };
    };
} foreach (_bldgInv select 0);

private _illegalCount = 0;
{
    _var = _x select 0;
    _val = _x select 1;

    if ((getNumber (missionConfigFile >> "CfgWeights" >> (_var)  >> "illegal")) isEqualTo 1) then {
    	_illegalCount = _illegalCount + _val;
    };
} foreach (_physicalInv select 0);

if(_value > 0 || _illegalCount > 0) then {
	[0,format["A gang shed was raided for $%1 worth of drugs/contraband and %2 illegal items.",[_value] call OEC_fnc_numberText, _illegalCount]] remoteExec ["OEC_fnc_broadcast",-2,false];
	   [
			["event","Raided Gang Shed"],
			["player", name player],
			["player_id",getPlayerUID player],
			["gang",_building getVariable ["bldg_gangName","Error: No Gang"]],
			["gang_id",_building getVariable ["bldg_gangid","Error: No Gang"]],
			["profit",_value],
			["itemamount",_illegalCount],
			["location",getPosATL player]
		] call OEC_fnc_logIt;
} else {
	hint "Nothing illegal in this gang building.";
	[
		 ["event","Raided Gang Shed No Profit"],
		 ["player", name player],
		 ["player_id",getPlayerUID player],
		 ["gang",_building getVariable ["bldg_gangName","Error: No Gang"]],
		 ["gang_id",_building getVariable ["bldg_gangid","Error: No Gang"]],
		 ["location",getPosATL player]
 	] call OEC_fnc_logIt;
};
uiSleep 1;
[_building] call OEC_fnc_openHouseInventory;
