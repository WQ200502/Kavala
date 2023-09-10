// File: fn_pickupAll.sqf
// Author: Horizon
// Picks up everything in a briefcase
disableSerialization;
((findDisplay 7125) displayCtrl 7127) ctrlEnable false;
((findDisplay 7125) displayCtrl 7128) ctrlEnable false;

private["_obj","_itemInfo","_itemName","_illegal","_diff","_items","_data","_pickupList","_dollarValue","_text","_UINS","_i"];

_obj = uiNamespace getVariable lbData[7126,0];
_items = _obj getVariable "O_droppedItem";
_deleteArr = [];

if(getPlayerUID (_obj getVariable["inUse", ObjNull]) != (getPlayerUID player)) exitWith{closeDialog 0;};

//Check if brief is still there
if(isNull _obj || isPlayer _obj) exitWith {closeDialog 0;};

//Player must be within 3 meters of the object
if(player distance _obj > 3) exitWith {closeDialog 0;};

//Internet check for duping prevention
[[player],"OES_fnc_internetCheck",false,false] spawn OEC_fnc_MP;
oev_didServerRespond = false;
private _maxDelayTime = time + 5;
waitUntil{time > _maxDelayTime || oev_didServerRespond};
if(time > _maxDelayTime) exitWith {hint "Pickup failed, try again.";};
{
//Begin picking up object
_itemName = [([_x select 0,0] call OEC_fnc_varHandle)] call OEC_fnc_varToStr;
_illegal = [_x select 0,oev_illegal_items] call OEC_fnc_index;

//If you're a cop and items are NOT illegal, OR if you're not a cop then pick it up.

	if (playerSide isEqualTo west && _illegal == -1 || !(playerSide isEqualTo west)) then {
		if((_x select 0) isEqualTo "money") then {
			if(call oev_restrictions) exitWith {hint "您受到玩家的限制，无法执行此操作！ 如果您认为这是一个错误，请与管理员联系。";};
			if(isNil {_x select 1}) exitWith {};
			if(isNull _obj || player distance _obj > 3) exitWith {closeDialog 0;};
			if(!isNil {_x select 1}) then {
				titleText[format[localize "STR_NOTF_PickedMoney",[_x select 1] call OEC_fnc_numberText],"PLAIN DOWN"];
				[
					["event","Picked up Cash"],
					["player",name player],
					["player_id",getPlayerUID player],
					["value",[_x select 1] call OEC_fnc_numberText],
					["position",getPosATL player]
				] call OEC_fnc_logIt;

				if ((_x select 0) isEqualTo "money") then {
				    _deleteArr pushBack _forEachIndex;
				};
				oev_cash = oev_cash + (_x select 1);
				oev_cache_cash = oev_cache_cash + (_x select 1);
				oev_action_delay = time;
			};
		} else {
			//Check if enough room to pick up
			_diff = [_x select 0,_x select 1,oev_carryWeight,oev_maxWeight] call OEC_fnc_calWeightDiff;
			if(_diff <= 0) exitWith {hint localize "STR_NOTF_InvFull";};

			if(_diff != _x select 1) then {
				if(([true,_x select 0,_diff] call OEC_fnc_handleInv)) then {
					_x set [1,(_x select 1) - _diff];
					titleText[format[localize "STR_NOTF_Picked",_diff,_itemName],"PLAIN DOWN"];
					[
						["event","Picked up Item"],
						["player",name player],
						["player_id",getPlayerUID player],
						["item",_itemName],
						["amount",_x select 1],
						["position",getPosATL player]
					] call OEC_fnc_logIt;
				};
			} else {
				if(([true,_x select 0,_x select 1] call OEC_fnc_handleInv)) then
				{
			    _deleteArr pushBack _forEachIndex;
					titleText[format[localize "STR_NOTF_Picked",_diff,_itemName],"PLAIN DOWN"];
				};
			};
		};
	} else {
		//Seize items if cop and items are illegal
		_value = 0;

		_index = [_x select 0,oev_illegal_items] call OEC_fnc_index;
		if(_index != -1) then {
			_value = _value + ((_x select 1) * (((oev_illegal_items) select _index) select 1));
		};

		titleText[format[localize "STR_NOTF_PickedEvidence",_itemName,[_value] call OEC_fnc_numberText],"PLAIN DOWN"];

		if(_value > 0) then {
			[player,_value,1,150] call OEC_fnc_splitPay;
		};
		_deleteArr pushBack _forEachIndex;
		oev_action_delay = time;
	};
} forEach _items;

_deleteArr sort false;
{
	_items deleteAt _x;
}forEach _deleteArr;
_obj setVariable["O_droppedItem",_items,true];
player playmove "AinvPknlMstpSlayWrflDnon";

//If there are no more items, delete the object
if !(count _items > 0) then {
	deleteVehicle _obj;
	closeDialog 0;
};
sleep 0.5;
//Update the UI when object picked up
disableSerialization;
waitUntil{!isNull findDisplay 7125};
_pickupList = ((findDisplay 7125) displayCtrl 7126);
_data = _obj getVariable "O_droppedItem";
if !(isNull _obj) then {
	lbClear _pickupList;
	{
		if ((_x select 0) isEqualTo "money") then {
			_itemName = "Money";
			_dollarValue = [_x select 1] call OEC_fnc_numberText;
			_text = format["%1 ($%2)",_itemName, _dollarValue];
		} else {
			_itemName = [([_x select 0,0] call OEC_fnc_varHandle)] call OEC_fnc_varToStr;
			_text = format["%1 (%2)",_itemName, _x select 1];
		};
		_UINS = uiNamespace setVariable [_x select 0,_obj];
		_i = _pickupList lbAdd _text;
		_pickupList lbSetData [_i,_x select 0];
	} forEach _data;
};
oev_action_pickingUp = false;
((findDisplay 7125) displayCtrl 7127) ctrlEnable true;
((findDisplay 7125) displayCtrl 7128) ctrlEnable true;
