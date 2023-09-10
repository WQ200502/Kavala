//  File: fn_houseInventory.sqf
//	Author: Kurt
//	Description: Physical items displayed on y-menu
private["_tInv","_pInv","_data","_icon","_storeBtn","_takeBtn","_details","_pEdit","_tEdit"];
params [
	["_veh",objNull,[objNull]],
	["_isVirtual",true,[true]]
];
if(isNull _veh || !alive _veh) exitWith {closeDialog 0;}; //If null / dead exit menu
disableSerialization;

//Set up the buttons and inventory interfaces
_tInv = (findDisplay 4500) displayCtrl 4502;
_pInv = (findDisplay 4500) displayCtrl 4503;
_storeBtn = (findDisplay 4500) displayCtrl 4508;
_takeBtn = (findDisplay 4500) displayCtrl 4507;
_pEdit = (findDisplay 4500) displayCtrl 4506;
_tEdit = (findDisplay 4500) displayCtrl 4505;

if (playerSide isEqualTo west) then {
	_storeBtn ctrlShow false;
	_pEdit ctrlShow false;
	_tEdit ctrlShow false;
};

//Initially clear all interfaces
lbClear _tInv;
lbClear _pInv;

/* Commenting out for now cause not sure what this portion is actually used for in game.
 --- It is used for comepnsation crates to prevent people not allowed to take/store items in them based on uid, see Jesse for further help
if (typeOf _veh isEqualTo "IG_supplyCrate_F") then {
	_storeBtn ctrlEnable false;
	if (((_veh getVariable ["owner",["",""]]) select 0) isEqualTo (getPlayerUID player)) then {
		_takeBtn ctrlEnable false;
	};
};*/

if (_isVirtual) then {
	_data = _veh getVariable ["Trunk",[]];
	private _curWeight = 0;
	if(count _data == 0) then {_veh setVariable["Trunk",[[],0],true]; _data = [];} else {_curWeight = _data select 1; _data = _data select 0;};
	private _vehdata = [0,0];
	private _mWeight = 0;
	if !(typeOf _veh isEqualTo "Land_i_Shed_Ind_F") then {
		ctrlSetText[4501,format["House Storage - %1",_veh getVariable ["house_id",-1]]];
		_vehdata = [(_veh getVariable["storageCapacity",100]),(_veh getVariable["Trunk",[[],0]]) select 1];
	} else {
		ctrlSetText[4501,format["Gang Storage - %1",_veh getVariable ["bldg_id",-1]]];
		_vehdata = [(_veh getVariable["storageCapacity",1000]),(_veh getVariable["Trunk",[[],0]]) select 1];
	};
	ctrlSetText[4504,format[(localize "STR_MISC_Weight")+ " %1/%2",_vehdata select 1,_vehdata select 0]];
	//Player Inventory Items
	{
		//Money Handle
		if(_x != "oev_cash") then {
			_str = [_x] call OEC_fnc_varToStr;
			_shrt = [_x,1] call OEC_fnc_varHandle;
			_icon = [_x] call OEC_fnc_iconConfig;
			_val = missionNameSpace getVariable _x;
			if(_val > 0) then {
				_pInv lbAdd format["[%1] - %2",_val,_str];
				_pInv lbSetData [(lbSize _pInv)-1,_shrt];
				_pInv lbSetPicture [(lbSize _pInv)-1,_icon];
			};
		} else {
			if(oev_cash > 0) then {
				_pInv lbAdd format["$%1",[oev_cash] call OEC_fnc_numberText];
				_pInv lbSetData [(lbSize _pInv)-1,"money"];
			};
		};
	} forEach oev_inv_items;

	//Trunk Inventory Items
	{
		if((_x select 0) != "money") then {
			_var = [_x select 0,0] call OEC_fnc_varHandle;
			_name = [_var] call OEC_fnc_varToStr;
			_icon = [_var] call OEC_fnc_iconConfig;
			_val = _x select 1;
			if(_val > 0) then {
				_tInv lbAdd format["[%1] - %2",_val,_name];
				_tInv lbSetData [(lbSize _tInv)-1,_x select 0];
				_tInv lbSetPicture [(lbSize _tInv)-1,_icon];
			};
		} else {
			_val = _x select 1;
			if(_val > 0) then {
				_tInv lbAdd format["$%1",[_val] call OEC_fnc_numberText];
				_tInv lbSetData [(lbSize _tInv)-1,"money"];
			};
		};
	} forEach _data;
} else {
	_data = _veh getVariable ["PhysicalTrunk",[]];
	private _curWeight = 0;
	if(count _data == 0) then {
		_veh setVariable["PhysicalTrunk",[[],0],true]; _data = [];
	} else {
		_data = _data select 0;
	};
	private _vehdata = [0,0];
	if !(typeOf _veh isEqualTo "Land_i_Shed_Ind_F") then {
		ctrlSetText[4501,format["House Storage - %1",_veh getVariable ["house_id",-1]]];
		_vehdata = [(_veh getVariable["physicalStorageCapacity",100]),(_veh getVariable["PhysicalTrunk",[[],0]]) select 1];
		player setVariable ["inHouseInventory",[true, _veh getVariable ["house_id",-1]],true];
	} else {
		ctrlSetText[4501,format["Gang Storage - %1",_veh getVariable ["bldg_id",-1]]];
		_vehdata = [(_veh getVariable["physicalStorageCapacity",300]),(_veh getVariable["PhysicalTrunk",[[],0]]) select 1];
		player setVariable ["inHouseInventory",[true, _veh getVariable ["house_id",-1]],true];
	};
	ctrlSetText[4504,format[(localize "STR_MISC_Weight")+ " %1/%2",_vehdata select 1,_vehdata select 0]];
	private _pCache = [];
	private _index = -1;
	private _tempItem = "";
	//Player physical Items
	//Headgear
	private _headgear = headgear player;
    if !(_headgear IsEqualTo "") then {
    	_index = -1;
    	{
    		if !(_index isEqualTo -1) exitWith {};
    		if (_headgear isEqualTo (_x select 0)) exitWith {
    			_index = _forEachIndex;
    		};
		} forEach _pCache;
		if (_index isEqualTo -1) then {
			_pCache pushBack [_headgear,1];
		} else {
			_pCache set [_index,[_headgear,((_pCache select _index) select 1) + 1]];
		};
    };
    //Goggles
	private _goggles = goggles player;
    if !(_goggles IsEqualTo "") then {
    	_index = -1;
    	{
    		if !(_index isEqualTo -1) exitWith {};
    		if (_goggles isEqualTo (_x select 0)) exitWith {
    			_index = _forEachIndex;
    		};
		} forEach _pCache;
		if (_index isEqualTo -1) then {
			_pCache pushBack [_goggles,1];
		} else {
			_pCache set [_index,[_goggles,((_pCache select _index) select 1) + 1]];
		};
    };
    private _uniform = uniform player;
    //Uniform Slot
    if !(_uniform IsEqualTo "") then {
    	_index = -1;
    	{
    		if !(_index isEqualTo -1) exitWith {};
    		if (_uniform isEqualTo (_x select 0)) exitWith {
    			_index = _forEachIndex;
    		};
		} forEach _pCache;
		if (_index isEqualTo -1) then {
			_pCache pushBack [_uniform,1];
		} else {
			_pCache set [_index,[_uniform,((_pCache select _index) select 1) + 1]];
		};
    };
    private _vest = vest player;
    //Vest Slot
    if !(_vest IsEqualTo "") then {
    	_index = -1;
    	{
    		if !(_index isEqualTo -1) exitWith {};
    		if (_vest isEqualTo (_x select 0)) exitWith {
    			_index = _forEachIndex;
    		};
		} forEach _pCache;
		if (_index isEqualTo -1) then {
			_pCache pushBack [_vest,1];
		} else {
			_pCache set [_index,[_vest,((_pCache select _index) select 1) + 1]];
		};
    };
    private _bag = backpack player;
    //Backpack contents
    if (count (backpackItems player) > 0) then {
        {
        	_tempItem = _x;
        	_index = -1;
	    	{
	    		if !(_index isEqualTo -1) exitWith {};
	    		if (_tempItem isEqualTo (_x select 0)) exitWith {
	    			_index = _forEachIndex;
	    		};
			} forEach _pCache;
			if (_index isEqualTo -1) then {
				_pCache pushBack [_tempItem,1];
			} else {
				_pCache set [_index,[_tempItem,((_pCache select _index) select 1) + 1]];
			};
        } forEach (backpackItems player);
    };
    //Backpack Slot
    if !(_bag IsEqualTo "") then {
    	_index = -1;
    	{
    		if !(_index isEqualTo -1) exitWith {};
    		if (_bag isEqualTo (_x select 0)) exitWith {
    			_index = _forEachIndex;
    		};
		} forEach _pCache;
		if (_index isEqualTo -1) then {
			_pCache pushBack [_bag,1];
		} else {
			_pCache set [_index,[_bag,((_pCache select _index) select 1) + 1]];
		};
    };
    private _primaryWeapon = primaryWeapon player;
    private _secondaryWeapon = secondaryWeapon player;
    private _handgunWeapon = handgunWeapon player;
    //Weapon slot
    if !(_primaryWeapon isEqualTo "") then {
        {
            if (_x != "") then {
            	_tempItem = _x;
            	_index = -1;
		    	{
		    		if !(_index isEqualTo -1) exitWith {};
		    		if (_tempItem isEqualTo (_x select 0)) exitWith {
		    			_index = _forEachIndex;
		    		};
				} forEach _pCache;
				if (_index isEqualTo -1) then {
					_pCache pushBack [_tempItem,1];
				} else {
					_pCache set [_index,[_tempItem,((_pCache select _index) select 1) + 1]];
				};
            };
        } forEach (primaryWeaponItems player);
        {
        	_tempItem = _x;
        	_index = -1;
	    	{
	    		if !(_index isEqualTo -1) exitWith {};
	    		if (_tempItem isEqualTo (_x select 0)) exitWith {
	    			_index = _forEachIndex;
	    		};
			} forEach _pCache;
			if (_index isEqualTo -1) then {
				_pCache pushBack [_tempItem,1];
			} else {
				_pCache set [_index,[_tempItem,((_pCache select _index) select 1) + 1]];
			};
        } forEach (primaryWeaponMagazine player);
        _index = -1;
    	{
    		if !(_index isEqualTo -1) exitWith {};
    		if (_primaryWeapon isEqualTo (_x select 0)) exitWith {
    			_index = _forEachIndex;
    		};
		} forEach _pCache;
		if (_index isEqualTo -1) then {
			_pCache pushBack [_primaryWeapon,1];
		} else {
			_pCache set [_index,[_primaryWeapon,((_pCache select _index) select 1) + 1]];
		};
    };
    if !(_secondaryWeapon isEqualTo "") then {
        {
            if (_x != "") then {
            	_tempItem = _x;
            	_index = -1;
		    	{
		    		if !(_index isEqualTo -1) exitWith {};
		    		if (_tempItem isEqualTo (_x select 0)) exitWith {
		    			_index = _forEachIndex;
		    		};
				} forEach _pCache;
				if (_index isEqualTo -1) then {
					_pCache pushBack [_tempItem,1];
				} else {
					_pCache set [_index,[_tempItem,((_pCache select _index) select 1) + 1]];
				};
            };
        } forEach (secondaryWeaponItems player);
        {
        	_tempItem = _x;
			_index = -1;
	    	{
	    		if !(_index isEqualTo -1) exitWith {};
	    		if (_tempItem isEqualTo (_x select 0)) exitWith {
	    			_index = _forEachIndex;
	    		};
			} forEach _pCache;
			if (_index isEqualTo -1) then {
				_pCache pushBack [_tempItem,1];
			} else {
				_pCache set [_index,[_tempItem,((_pCache select _index) select 1) + 1]];
			};
        } forEach (secondaryWeaponMagazine player);
        _index = -1;
    	{
    		if !(_index isEqualTo -1) exitWith {};
    		if (_secondaryWeapon isEqualTo (_x select 0)) exitWith {
    			_index = _forEachIndex;
    		};
		} forEach _pCache;
		if (_index isEqualTo -1) then {
			_pCache pushBack [_secondaryWeapon,1];
		} else {
			_pCache set [_index,[_secondaryWeapon,((_pCache select _index) select 1) + 1]];
		};
    };
    if !(_handgunWeapon isEqualTo "") then {
        {
        	if (_x != "") then {
	        	_tempItem = _x;
	            _index = -1;
		    	{
		    		if !(_index isEqualTo -1) exitWith {};
		    		if (_tempItem isEqualTo (_x select 0)) exitWith {
		    			_index = _forEachIndex;
		    		};
				} forEach _pCache;
				if (_index isEqualTo -1) then {
					_pCache pushBack [_tempItem,1];
				} else {
					_pCache set [_index,[_tempItem,((_pCache select _index) select 1) + 1]];
				};
			};
        } forEach (handgunItems player);
        {
        	_tempItem = _x;
        	_index = -1;
	    	{
	    		if !(_index isEqualTo -1) exitWith {};
	    		if (_tempItem isEqualTo (_x select 0)) exitWith {
	    			_index = _forEachIndex;
	    		};
			} forEach _pCache;
			if (_index isEqualTo -1) then {
				_pCache pushBack [_tempItem,1];
			} else {
				_pCache set [_index,[_tempItem,((_pCache select _index) select 1) + 1]];
			};
        } forEach (handgunMagazine player);
        _index = -1;
    	{
    		if !(_index isEqualTo -1) exitWith {};
    		if (_handgunWeapon isEqualTo (_x select 0)) exitWith {
    			_index = _forEachIndex;
    		};
		} forEach _pCache;
		if (_index isEqualTo -1) then {
			_pCache pushBack [_handgunWeapon,1];
		} else {
			_pCache set [_index,[_handgunWeapon,((_pCache select _index) select 1) + 1]];
		};
    };
    //Uniform contents
     if (count (uniformItems player) > 0) then {
     	{
     		_tempItem = _x;
        	_index = -1;
	    	{
	    		if !(_index isEqualTo -1) exitWith {};
	    		if (_tempItem isEqualTo (_x select 0)) exitWith {
	    			_index = _forEachIndex;
	    		};
			} forEach _pCache;
			if (_index isEqualTo -1) then {
				_pCache pushBack [_tempItem,1];
			} else {
				_pCache set [_index,[_tempItem,((_pCache select _index) select 1) + 1]];
			};
    	} forEach (uniformItems player);
    };
    //Vest contents
     if (count (vestItems player) > 0) then {
        {
        	_tempItem = _x;
        	_index = -1;
	    	{
	    		if !(_index isEqualTo -1) exitWith {};
	    		if (_tempItem isEqualTo (_x select 0)) exitWith {
	    			_index = _forEachIndex;
	    		};
			} forEach _pCache;
			if (_index isEqualTo -1) then {
				_pCache pushBack [_tempItem,1];
			} else {
				_pCache set [_index,[_tempItem,((_pCache select _index) select 1) + 1]];
			};
    	} forEach (vestItems player);
    };
    //Assigned items
    private _assignedItems = assignedItems player;
    if !(count _assignedItems IsEqualTo 0) then {
     	{
        	_tempItem = _x;
        	_index = -1;
	    	{
	    		if !(_index isEqualTo -1) exitWith {};
	    		if (_tempItem isEqualTo (_x select 0)) exitWith {
	    			_index = _forEachIndex;
	    		};
			} forEach _pCache;
			if (_index isEqualTo -1) then {
				_pCache pushBack [_tempItem,1];
			} else {
				_pCache set [_index,[_tempItem,((_pCache select _index) select 1) + 1]];
			};
    	} forEach _assignedItems;
	};
    {
    	_details = [_x select 0] call OEC_fnc_fetchCfgDetails;
    	_str = format["%1",(getText(configFile >> (_details select 6) >> _x select 0 >> "DisplayName"))];
		_shrt = _x select 0;
		_icon = getText(configFile >> (_details select 6) >> _x select 0 >> "picture");
		_pInv lbAdd format["[%1] - %2",_x select 1,_str];
		_pInv lbSetData [(lbSize _pInv)-1,_shrt];
		_pInv lbSetValue [(lbSize _pInv)-1,_x select 1];
		_pInv lbSetPicture [(lbSize _pInv)-1,_icon];
	} forEach _pCache;
	//Trunk Inventory Items
	{
		_details = [_x select 0] call OEC_fnc_fetchCfgDetails;
    	_str = format["%1",(getText(configFile >> (_details select 6) >> _x select 0 >> "DisplayName"))];
		_shrt = _x select 0;
		_icon = getText(configFile >> (_details select 6) >> _x select 0 >> "picture");
		_tInv lbAdd format["[%1] - %2",_x select 1,_str];
		_tInv lbSetData [(lbSize _tInv)-1,_shrt];
		_tInv lbSetValue [(lbSize _tInv)-1,_x select 1];
		_tInv lbSetPicture [(lbSize _tInv)-1,_icon];
	} foreach _data;
};


