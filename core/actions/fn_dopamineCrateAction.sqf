//  File: fn_dopamineCrateAction.sqf
//	Author: Ozadu
//	Description: Adds dopamine action to medic crate

params[
	["_crate",objNull,[objNull]],
	["_mode","",[""]]
];
if(isNull _crate) exitWith {};
if(!(_crate getVariable ["dopamineCrate",false])) exitWith {};

switch(_mode) do {
	case "addAction":{
		_crate addAction ["接受多巴胺",OEC_fnc_giveDopamine,nil,1.5,true,true,"","_this getVariable ['epiActive',false]",6];
		_crate addAction ["紧急市场",OEC_fnc_virt_menu,'dopamine',1.5,false,false,"","",6];
		_crate addAction ["紧急装备",OEC_fnc_weaponShopMenu,"dopecratesupplies",1.5,false,false,"",'',6];
		_crate addAction ["充装弹药",OEC_fnc_dopeMagRefill,[_crate,1000],1.5,true,true,"","playerSide != independent",6];
	};
	case "task":{
		if(_crate getVariable ["owner",objNull] != getPlayerUID player) exitWith {};
		life_medic_task = player createSimpleTask ["Dopamine Crate"];
		life_medic_task setSimpleTaskDescription ["Pick up dopamine crate","Pick up crate","Pick up"];
		life_medic_task setSimpleTaskDestination getPos _crate;
		waitUntil{!(isNull ropeAttachedTo _crate) || isNull _crate};
		player removeSimpleTask life_medic_task;
	};
	case "mark":{
		if(playerSide isEqualTo independent || playerSide isEqualTo civilian) then {
			_cratePos = getPos _crate;
			_marker = createMarkerLocal [format["dope_%1",time],_cratePos];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerTypeLocal "hd_warning";
			_marker setMarkerColorLocal "ColorYellow";
			_marker setMarkerTextLocal "Dopamine Crate";
			private _count = 0;
			while {true} do {
				if ((_cratePos distance getPos _crate) > 5) then {
					deleteMarkerLocal _marker;
					_cratePos = getPos _crate;
					_marker = createMarkerLocal [format["dope_%1",time],_cratePos];
					_marker setMarkerShapeLocal "ICON";
					_marker setMarkerTypeLocal "hd_warning";
					_marker setMarkerColorLocal "ColorYellow";
					_marker setMarkerTextLocal "Dopamine Crate";
				};
				uiSleep 60;
				_count = _count + 60;
				if (_count >= 3600) then { // Dopamine Crate Marker Time
					deleteMarkerLocal _marker;
				};
			};
			//uiSleep (60 * 60);
			//deleteMarkerLocal _marker;
		};
	};
};
