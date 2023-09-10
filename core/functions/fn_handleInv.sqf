//  File: fn_handleInv.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Do I really need one?
private["_math","_item","_num","_return","_var","_weight","_value","_diff","_totalItemsActual","_hackedItemArray","_hackExit"];
_math = param [0,false,[false]]; //true = add; false = subtract;
_item = param [1,"",[""]]; //The item we are using to add or remove.
_num = param [2,0,[0]]; //Number of items to add or remove.
if(_item == "" || _num == 0) exitWith {false};

_var = [_item,0] call OEC_fnc_varHandle;
if(_math) then {
	_diff = [_item,_num,oev_carryWeight,oev_maxWeight] call OEC_fnc_calWeightDiff;
	_num = _diff;
	if(_num <= 0) exitWith {false};
};
_weight = ([_item] call OEC_fnc_itemWeight) * _num;
_value = missionNamespace getVariable _var;

_totalItemsActual = 0;
{
	_totalItemsActual = _totalItemsActual + (missionNameSpace getVariable _x);
}foreach oev_inv_items;

_hackExit = false;

if(_totalItemsActual > (oev_inventoryMonitor - oev_inventoryRandomVar) || _totalItemsActual >= 150) then {
	_hackExit = true;
	_hackedItemArray = [];
	private "_count";
	_count = 0;

	{
		if((missionNameSpace getVariable _x) > 0) then {
			_hackedItemArray pushBack [_x, (missionNameSpace getVariable _x)];
			_count = _count + (missionNameSpace getVariable _x);
		};
	}foreach oev_inv_items;

	if(_count <= (oev_inventoryMonitor - oev_inventoryRandomVar)) exitWith {
		_hackExit = false;
	};

	[
		["event","Hacked Items"],
		["player",name player],
		["player_id",getPlayerUID player],
		["hackeditems",_hackedItemArray],
		["position",getPosATL player]
	] call OEC_fnc_logIt;
	[[profileName,format["Kicked for hacked items. (Items expected to have = %1) (Actual item count = %2)",(oev_inventoryMonitor - oev_inventoryRandomVar),_totalItemsActual]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

if(_hackExit) exitWith {false};

if(_math) then {
	//Lets add!
	if((oev_carryWeight + _weight) <= oev_maxWeight) then {
		oev_inventoryMonitor = oev_inventoryMonitor + _num;
		missionNamespace setVariable[_var,(_value + _num)];

		if((missionNamespace getVariable _var) > _value) then {
			oev_carryWeight = oev_carryWeight + _weight;
			_return = true;
		} else {
			_return = false;
		};
	} else {
		_return = false;
	};
} else {
	//Lets subtract!
	if((_value - _num) < 0) then {
		_return = false;
	} else {
		missionNamespace setVariable[_var,(_value - _num)];
		oev_inventoryMonitor = oev_inventoryMonitor - _num;

		if((missionNamespace getVariable _var) < _value) then {
			oev_carryWeight = oev_carryWeight - _weight;
			_return = true;
		} else {
			_return = false;
		};
	};
};

_return;
