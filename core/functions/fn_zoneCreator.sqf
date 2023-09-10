//  File: fn_zoneCreator.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Creates triggers around the map to add the for specific
//	fields such as apples, cocaine, heroin, etc. This method is to reduce
//	CPU load.

//	Note:
//	Triggers are NOT my preferred method so this is considered temporary until a more suitable
//	option is presented.
private["_modShops","_airModShop","_capturableTerritories","_markerName","_illegalZones","_restrictedAirspace"];
_modShops = [];

for "_i" from 1 to 69 do {
	_modShops pushBack format["servicestation%1",_i];
};

_airModShop = ["air_serv_1","boat_serv_jen_eats_poo_1","boat_serv_jen_eats_poo_2","truck_serv_1","truck_serv_2","air_serv_2","air_serv_3","truck_serv_3"];
_capturableTerritories = ["Meth","Mushroom","Moonshine","Arms"];
_illegalZones = [];

//modshop triggers

{
	_zone = createTrigger ["EmptyDetector",(getMarkerPos _x), false];
	switch(playerSide) do {
		case civilian: {_zone setTriggerActivation["CIV","PRESENT",true];};
		case west: {_zone setTriggerActivation["WEST","PRESENT",true];};
		case independent : {_zone setTriggerActivation["GUER","PRESENT",true];};
	};
	if(_x in ["servicestation23","servicestation24","servicestation25","servicestation26","servicestation27","servicestation35","servicestation37","servicestation36","servicestation42","servicestation69"]) then {
		_zone setTriggerArea[10,10,0,true];
		_zone setTriggerStatements["(vehicle player) in thislist && ((vehicle player modelToWorld [0,0,0]) select 2) < 30","[vehicle player,false] spawn OEC_fnc_modShopMenu","modshop_price = 0"];
	}else{
	if(_x in ["servicestation28","servicestation29","servicestation30"]) then {
		_zone setTriggerArea[8,8,0,true];
		_zone setTriggerStatements["(vehicle player) in thislist && ((vehicle player modelToWorld [0,0,0]) select 2) < 20 && (vehicle player isKindOf 'Ship')","[vehicle player,false] spawn OEC_fnc_modShopMenu","modshop_price = 0"];
	}else{
		_zone setTriggerArea[2.5,2.5,0,true];
		_zone setTriggerStatements["(vehicle player) in thislist && ((vehicle player modelToWorld [0,0,0]) select 2) < 5 && (vehicle player isKindOf 'LandVehicle')","[vehicle player,false] spawn OEC_fnc_modShopMenu","modshop_price = 0"];
	};};
} forEach _modShops;

//gang zone triggers
{
	_markerName = format["%1_cartel",_x];
	_zone = createTrigger ["EmptyDetector",(getMarkerPos _markerName), false];
	_zone setTriggerArea[95,95,0,false];
	switch(playerSide) do {
		case civilian: {
			_zone setTriggerActivation["CIV","PRESENT",true];
			_zone setTriggerStatements["(vehicle player) in thislist && (currentWeapon player != '') && !(currentWeapon player in oev_fake_weapons) && isNull objectParent player && !isNil {player getVariable 'gang_data'} && !oev_capturingTerritory && !(surfaceIsWater position player) && !(!isNil {_x getVariable 'adminesp'})",format["['%1'] spawn OEC_fnc_captureTerritory",_x],""];
		};
		case west: {
			_zone setTriggerActivation["WEST","PRESENT",true];
			_zone setTriggerStatements["(vehicle player) in thislist && (currentWeapon player != '') && !(currentWeapon player in oev_fake_weapons) && isNull objectParent player && playerSide isEqualTo west && !oev_capturingTerritory && !(surfaceIsWater position player) && !(!isNil {_x getVariable 'adminesp'})",format["['%1',true] spawn OEC_fnc_captureTerritory",_x],""];
		};
	};
} forEach _capturableTerritories;


//Restricted air Space Warning
_zone = createTrigger ["EmptyDetector",[getPos jailAntiAir select 0, getPos jailAntiAir select 1, (getPos jailAntiAir select 2) + 5], false];
_zone setTriggerArea[750,750,0,false];
_zone setTriggerActivation["CIV","PRESENT",true];
_zone setTriggerStatements["(vehicle player) in thislist && (vehicle player isKindOf 'Air') && !oev_newsTeam","if(jailAntiAir getVariable ['active',true])then{hint parseText ""<t color='#ff0000'><t size='2.2'><t align='center'>WARNING<br/><t color='#FFC966'><t align='center'><t size='1.2'>You are entering restricted air space! Leave immediately or you will be shot down.""}else{hint parseText ""<t color='#ff0000'><t size='2.2'><t align='center'>WARNING<br/><t color='#FFC966'><t align='center'><t size='1.2'>You are entering restricted .... Error: Anti Air system corrupted.""};","hint ''"];

_zone = createTrigger ["EmptyDetector",[getPos jailAntiAir select 0, getPos jailAntiAir select 1, (getPos jailAntiAir select 2) + 5], false];
_zone setTriggerArea[750,750,0,false];
_zone setTriggerActivation["WEST","PRESENT",true];
_zone setTriggerStatements["(vehicle player) in thislist && (vehicle player isKindOf 'Air')","if(!(jailAntiAir getVariable ['active',true]))then{hint parseText ""<t color='#ff0000'><t size='2.2'><t align='center'>WARNING<br/><t color='#FFC966'><t align='center'><t size='1.2'>You are entering hijacked air space! Leave immediately or you will be shot down.""};","hint ''"];

_zone = createTrigger ["EmptyDetector",[getPos fedAntiAir select 0, getPos fedAntiAir select 1, (getPos fedAntiAir select 2) + 5], false];
_zone setTriggerArea[750,750,0,false];
_zone setTriggerActivation["CIV","PRESENT",true];
_zone setTriggerStatements["(vehicle player) in thislist && (vehicle player isKindOf 'Air') && !oev_newsTeam","if(fedAntiAir getVariable ['active',true])then{hint parseText ""<t color='#ff0000'><t size='2.2'><t align='center'>WARNING<br/><t color='#FFC966'><t align='center'><t size='1.2'>You are entering restricted air space! Leave immediately or you will be shot down.""}else{hint parseText ""<t color='#ff0000'><t size='2.2'><t align='center'>WARNING<br/><t color='#FFC966'><t align='center'><t size='1.2'>You are entering restricted .... Error: Anti Air system corrupted.""};","hint ''"];

_zone = createTrigger ["EmptyDetector",[getPos fedAntiAir select 0, getPos fedAntiAir select 1, (getPos fedAntiAir select 2) + 5], false];
_zone setTriggerArea[750,750,0,false];
_zone setTriggerActivation["WEST","PRESENT",true];
_zone setTriggerStatements["(vehicle player) in thislist && (vehicle player isKindOf 'Air')","if(!(fedAntiAir getVariable ['active',true]))then{hint parseText ""<t color='#ff0000'><t size='2.2'><t align='center'>WARNING<br/><t color='#FFC966'><t align='center'><t size='1.2'>You are entering hijacked air space! Leave immediately or you will be shot down.""};","hint ''"];

_zone = createTrigger ["EmptyDetector",[getPos bwAntiAir select 0, getPos bwAntiAir select 1, (getPos bwAntiAir select 2) + 5], false];
_zone setTriggerArea[750,750,0,false];
_zone setTriggerActivation["CIV","PRESENT",true];
_zone setTriggerStatements["(vehicle player) in thislist && (vehicle player isKindOf 'Air') && !oev_newsTeam","if(bwAntiAir getVariable ['active',true])then{hint parseText ""<t color='#ff0000'><t size='2.2'><t align='center'>WARNING<br/><t color='#FFC966'><t align='center'><t size='1.2'>You are entering restricted air space! Leave immediately or you will be shot down.""}else{hint parseText ""<t color='#ff0000'><t size='2.2'><t align='center'>WARNING<br/><t color='#FFC966'><t align='center'><t size='1.2'>You are entering restricted .... Error: Anti Air system corrupted.""};","hint ''"];

_zone = createTrigger ["EmptyDetector",[getPos bwAntiAir select 0, getPos bwAntiAir select 1, (getPos bwAntiAir select 2) + 5], false];
_zone setTriggerArea[750,750,0,false];
_zone setTriggerActivation["WEST","PRESENT",true];
_zone setTriggerStatements["(vehicle player) in thislist && (vehicle player isKindOf 'Air')","if(!(bwAntiAir getVariable ['active',true]))then{hint parseText ""<t color='#ff0000'><t size='2.2'><t align='center'>WARNING<br/><t color='#FFC966'><t align='center'><t size='1.2'>You are entering hijacked air space! Leave immediately or you will be shot down.""};","hint ''"];

//Restricted air Space missile launch
//jailAntiAir
_zone = createTrigger ["EmptyDetector",[getPos jailAntiAir select 0, getPos jailAntiAir select 1, (getPos jailAntiAir select 2) + 5], false];
_zone setTriggerArea[400,400,0,false];
_zone setTriggerActivation["CIV","PRESENT",true];
_zone setTriggerStatements["(vehicle player) in thislist && (vehicle player isKindOf 'Air') && (local (vehicle player)) && !oev_newsTeam && !oev_missileActive && (jailAntiAir getVariable ['active',true])","([[getPos jailAntiAir select 0, getPos jailAntiAir select 1, (getPos jailAntiAir select 2) + 5], 'M_Titan_AA_static', 105, (vehicle player), 600] spawn OEC_fnc_fireMissile)",""];

_zone = createTrigger ["EmptyDetector",[getPos jailAntiAir select 0, getPos jailAntiAir select 1, (getPos jailAntiAir select 2) + 5], false];
_zone setTriggerArea[400,400,0,false];
_zone setTriggerActivation["WEST","PRESENT",true];
_zone setTriggerStatements["(vehicle player) in thislist && (vehicle player isKindOf 'Air') && (local (vehicle player)) && !oev_missileActive && !(jailAntiAir getVariable ['active',true])","([[getPos jailAntiAir select 0, getPos jailAntiAir select 1, (getPos jailAntiAir select 2) + 5], 'M_Titan_AA_static', 105, (vehicle player), 600] spawn OEC_fnc_fireMissile)",""];

//fedAntiAir
_zone = createTrigger ["EmptyDetector",[getPos fedAntiAir select 0, getPos fedAntiAir select 1, (getPos fedAntiAir select 2) + 5], false];
_zone setTriggerArea[400,400,0,false];
_zone setTriggerActivation["CIV","PRESENT",true];
_zone setTriggerStatements["(vehicle player) in thislist && (vehicle player isKindOf 'Air') && (local (vehicle player)) && !oev_newsTeam && !oev_missileActive && (fedAntiAir getVariable ['active',true])","([[getPos fedAntiAir select 0, getPos fedAntiAir select 1, (getPos fedAntiAir select 2) + 5], 'M_Titan_AA_static', 105, (vehicle player), 600] spawn OEC_fnc_fireMissile)",""];

_zone = createTrigger ["EmptyDetector",[getPos fedAntiAir select 0, getPos fedAntiAir select 1, (getPos fedAntiAir select 2) + 5], false];
_zone setTriggerArea[400,400,0,false];
_zone setTriggerActivation["WEST","PRESENT",true];
_zone setTriggerStatements["(vehicle player) in thislist && (vehicle player isKindOf 'Air') && (local (vehicle player)) && !oev_missileActive && !(fedAntiAir getVariable ['active',true])","([[getPos fedAntiAir select 0, getPos fedAntiAir select 1, (getPos fedAntiAir select 2) + 5], 'M_Titan_AA_static', 105, (vehicle player), 600] spawn OEC_fnc_fireMissile)",""];

//bwAntiAir
_zone = createTrigger ["EmptyDetector",[getPos bwAntiAir select 0, getPos bwAntiAir select 1, (getPos bwAntiAir select 2) + 5], false];
_zone setTriggerArea[400,400,0,false];
_zone setTriggerActivation["CIV","PRESENT",true];
_zone setTriggerStatements["(vehicle player) in thislist && (vehicle player isKindOf 'Air') && (local (vehicle player)) && !oev_newsTeam && !oev_missileActive && (bwAntiAir getVariable ['active',true])","([[getPos bwAntiAir select 0, getPos bwAntiAir select 1, (getPos bwAntiAir select 2) + 5], 'M_Titan_AA_static', 105, (vehicle player), 600] spawn OEC_fnc_fireMissile)",""];

_zone = createTrigger ["EmptyDetector",[getPos bwAntiAir select 0, getPos bwAntiAir select 1, (getPos bwAntiAir select 2) + 5], false];
_zone setTriggerArea[400,400,0,false];
_zone setTriggerActivation["WEST","PRESENT",true];
_zone setTriggerStatements["(vehicle player) in thislist && (vehicle player isKindOf 'Air') && (local (vehicle player)) && !oev_missileActive && !(bwAntiAir getVariable ['active',true])","([[getPos bwAntiAir select 0, getPos bwAntiAir select 1, (getPos bwAntiAir select 2) + 5], 'M_Titan_AA_static', 105, (vehicle player), 600] spawn OEC_fnc_fireMissile)",""];

//illegalZones
/*
{
	_zone = createTrigger ["EmptyDetector",(getMarkerPos _x), false];
	_zone setTriggerArea[50,50,0,true];
	_zone setTriggerActivation["CIV","PRESENT",true];
	_zone setTriggerStatements["(vehicle player) in thislist","hint 'Entering an illegal area.'","hint 'Leaving illegal area.'"];
}foreach _capturableTerritories;
*/
