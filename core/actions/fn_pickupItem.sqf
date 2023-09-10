//  File: fn_pickupItem.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Master handling for picking up an item.
private["_obj","_itemInfo","_itemName","_illegal","_diff","_items","_data","_pickupList","_dollarValue","_text","_UINS","_i"];
//Prevent people from rapidly spamming pickup
//if((time - oev_action_delay) < 2) exitWith {hint "你不能快速使用动作键!"};
//Initial params passed, 1 - Object, 2 - Name of picked item, 3 - Number of said item
params [
	["_obj",ObjNull,[ObjNull]],
    ["_var","",[""]],
    ["_val",0,[0]]
];
 if(getPlayerUID (_obj getVariable["inUse", ObjNull]) != (getPlayerUID player)) exitWith{closeDialog 0;};

//Check if brief is still there
if(isNull _obj || isPlayer _obj) exitWith {closeDialog 0;};

//Player must be within 3 meters of the object
if(player distance _obj > 3) exitWith {closeDialog 0;};
((findDisplay 7125) displayCtrl 7127) ctrlEnable false;
((findDisplay 7125) displayCtrl 7128) ctrlEnable false;
//Internet check for duping prevention
[[player],"OES_fnc_internetCheck",false,false] spawn OEC_fnc_MP;
oev_didServerRespond = false;
private _maxDelayTime = time + 5;
waitUntil{time > _maxDelayTime || oev_didServerRespond};
if(time > _maxDelayTime) exitWith {hint "拾取失败，请重试。";};

//Begin picking up object
_itemName = [([_var,0] call OEC_fnc_varHandle)] call OEC_fnc_varToStr;
_illegal = [_var,oev_illegal_items] call OEC_fnc_index;

_items = _obj getVariable "O_droppedItem";

//If you're a cop and items are NOT illegal, OR if you're not a cop then pick it up.
if (playerSide isEqualTo west && _illegal == -1 || !(playerSide isEqualTo west)) then {
	if(_var isEqualTo "money") then {
		if(call oev_restrictions) exitWith {hint "您受到玩家限制，无法执行此操作！如果您认为这是一个错误，请与管理员qfq088联系。";};
		if(isNil {_val}) exitWith {};
		if(isNull _obj || player distance _obj > 3) exitWith {closeDialog 0;};
		if(!isNil {_val}) then {
			player playmove "AinvPknlMstpSlayWrflDnon";
			uiSleep 0.5;
			titleText[format[localize "STR_NOTF_PickedMoney",[_val] call OEC_fnc_numberText],"PLAIN DOWN"];
			[
				["event","Picked up Cash"],
				["player",name player],
				["player_id",getPlayerUID player],
				["value",[_val] call OEC_fnc_numberText],
				["location",getPosATL player]
			] call OEC_fnc_logIt;
			//Remove the item from the array
			{
				if ((_x select 0) isEqualTo "money") then {
				    _items deleteAt _forEachIndex;
				};
				uiSleep (0.1);
			} forEach _items;
			_obj setVariable["O_droppedItem",_items,true];
			oev_cash = oev_cash + _val;
			oev_cache_cash = oev_cache_cash + _val;
			oev_action_delay = time;
		};
	} else {
		//Check if enough room to pick up
		_diff = [_var,_val,oev_carryWeight,oev_maxWeight] call OEC_fnc_calWeightDiff;
		if(_diff <= 0) exitWith {hint localize "STR_NOTF_InvFull";};

		if(_diff != _val) then {
			if(([true,_var,_diff] call OEC_fnc_handleInv)) then {
				player playmove "AinvPknlMstpSlayWrflDnon";
				uiSleep 0.5;

				//Subtract the taken number of items from the array
				{
					if ((_x select 0) isEqualTo _var) then {
					    _x set [1,_val - _diff];
					};
					uiSleep (0.1);
				} forEach _items;
				_obj setVariable["O_droppedItem",_items,true];
				titleText[format[localize "STR_NOTF_Picked",_diff,_itemName],"PLAIN DOWN"];
				[
					["event","Picked up Item"],
					["player",name player],
					["player_id",getPlayerUID player],
					["item",_itemName],["amount",_val],
					["location",getPosATL player]
				] call OEC_fnc_logIt;
			};
		} else {
			if(([true,_var,_val] call OEC_fnc_handleInv)) then
			{
				//waitUntil{isNull _obj};
				player playmove "AinvPknlMstpSlayWrflDnon";
				uiSleep 0.5;
				//Remove the item from the array
				{
					if ((_x select 0) isEqualTo _var) then {
					    _items deleteAt _forEachIndex;
					};
					uiSleep (0.1);
				} forEach _items;
				_obj setVariable["O_droppedItem",_items,true];
				titleText[format[localize "STR_NOTF_Picked",_diff,_itemName],"PLAIN DOWN"];
			};
		};
	};
} else {
	//Seize items if cop and items are illegal
	_value = 0;

	_index = [_var,oev_illegal_items] call OEC_fnc_index;
	if(_index != -1) then {
		_value = _value + (_val * (((oev_illegal_items) select _index) select 1));
	};

	titleText[format[localize "STR_NOTF_PickedEvidence",_itemName,[_value] call OEC_fnc_numberText],"PLAIN DOWN"];

	if(_value > 0) then {
		[player,_value,1,150] call OEC_fnc_splitPay;
	};

	//Remove the item from the array
	{
		if ((_x select 0) isEqualTo _var) then {
			_items deleteAt _forEachIndex;
		};
		uiSleep (0.1);
	} forEach _items;
	_obj setVariable["O_droppedItem",_items,true];
	//waitUntil {isNull _obj};
	oev_action_delay = time;
};
//If there are no more items, delete the object
if !(count _items > 0) then {
	deleteVehicle _obj;
	closeDialog 0;
};

//Update the UI when object picked up
disableSerialization;
waitUntil{!isNull findDisplay 7125};
_pickupList = ((findDisplay 7125) displayCtrl 7126);
_data = _obj getVariable "O_droppedItem";
if !(isNull _obj) then {
	lbClear _pickupList;
	{
		if (_x select 0 isEqualTo "money") then {
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
