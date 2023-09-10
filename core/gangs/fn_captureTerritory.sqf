//	Description: Not sure how its gonna work yet, but this will be called when someone enters a capturable territory
// 	File: fn_captureTerritory.sqf

scopeName "main";
private["_territory","_zoneLocation","_nearbyGangs","_groupGangID","_groupGangName","_groupLeader","_group","_flagObject","_title","_ui","_progressBar","_titleText","_cP","_cpRate","_captureData","_updateTime","_nearGangMembers","_currentDataID","_currentDataName","_currentDataprogress","_markerCustomName","_badWpn","_isCop"];
_territory = _this param [0,"",[""]];
_isCop = _this param [1,false,[false]];
_markerName = format["%1_cartel",_territory];
_zoneLocation = (getMarkerPos format["%1_cartel",_territory]);

_flagObject = call compile format["%1_flag",_territory];
if(isNil {player getVariable "gang_data"}) then {
	player setVariable ["gang_data",oev_gang_data,true];
};
private _notAllowedCapGuns = [
	"hgun_Rook40_F",
	"hgun_PDW2000_F",
	"SMG_05_F",
	"hgun_Pistol_01_F",
	"SMG_01_F",
	"arifle_AKS_F",
	"hgun_ACPC2_F",
	"SMG_02_ACO_F",
	"hgun_P07_F",
	"SMG_02_F",
	"hgun_Pistol_Signal_F"
];
if(_territory == "" || oev_capturingTerritory || (isNil "_flagObject" || isNull _flagObject) || (player getVariable["restrained",false]) || vehicle player != player || (player getVariable ["BIS_revive_incapacitated", false] || (!isNil {player getVariable 'adminesp'})) || (surfaceIsWater position player)) exitWith {};
_captureData = _flagObject getVariable ["capture_data",[0,"Neutral",0.500]]; //[gang id, gang name, capture progess]
oev_capturingTerritory = true;

_markerCustomName = "";
_markerCustomName = switch(_territory) do {
	case "Meth": {"Meth and Weed";};
	case "Moonshine": {"Moonshine and Heroin";};
	case "Mushroom": {"Mushroom and Cocaine";};
	case "Arms": {"Arms Dealer";};
	default {"Ur Mum's"};
};

//sets up progress bar with related title and sets the progress position
disableSerialization;
5 cutRsc ["life_progress","PLAIN DOWN"];
_nearbyGangs = [];
_cpRate = 0;
_ui = uiNamespace getVariable "life_progress";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlShow true;
_progressBar ctrlShow true;
_title = "Entering...";
_titleText ctrlSetText _title;
_currentDataprogress = ((round((_captureData select 2) * 3000)) / 3000);
_progressBar progressSetPosition _currentDataprogress;
_cP = _currentDataprogress;
_updateTime = time + 5;
_badWpn = false;
_noGun = false;
_exit = false;
_group = group player;
_groupLeader = leader(_group);

if(_isCop) then {
	_groupGangID = -5;
	_groupGangName = "Police";
} else {
	if (count (_groupLeader getVariable ["gang_data",[]]) isEqualTo 0) exitWith {_exit = true};
	_groupGangID = ((_groupLeader getVariable "gang_data") select 0);
	_groupGangName = ((_groupLeader getVariable "gang_data") select 1);
};

if(_exit) exitWith {_titleText ctrlShow false; _progressBar ctrlShow false;};

while{true} do {
	//various checks to decide when to exit
	if(!alive player) exitWith {};
	if(_groupLeader != leader(group player) || _group != group player) then {breakTo "main"};
	if(player getVariable ["BIS_revive_incapacitated", false]) exitWith {};
	if([getPos player select 0, getPos player select 1, 0] distance _zoneLocation > 100) exitWith {};//to far
	if((player getVariable["restrained",false])) exitWith {};//restrained
	if ((player getVariable ["isVigi", false])) exitWith {}; // User is vigilante
	if ((!isNil {player getVariable 'adminesp'})) exitWith {}; // User has admin ESP enabled
	if(!oev_capturingTerritory) exitWith {};
	if(vehicle player != player) exitWith {};
	if((surfaceIsWater position player)) exitWith {};
	if ((currentWeapon player in _notAllowedCapGuns) && !(_isCop)) exitWith {_badWpn = true;};
	if ((currentWeapon player isEqualTo "") && !(_isCop)) then {
		if (primaryWeapon player in _notAllowedCapGuns && {((handgunWeapon player isEqualTo "") || (handgunWeapon player in _notAllowedCapGuns))}) then {_badWpn = true;};
		if (handgunWeapon player in _notAllowedCapGuns && {primaryWeapon player isEqualTo ""}) then {_badWpn = true;};
		if((primaryWeapon player isEqualTo "") && (handgunWeapon player isEqualTo "")) then {_noGun = true;};
	};
	if (_badWpn) exitWith {hint "That gun is not allowed to capture a cartel.";};
	if (_noGun) exitWith {hint "Go get a gun.";};
	uiSleep 1;

	if(isNull _ui) then {
		5 cutRsc ["life_progress","PLAIN DOWN"];
		_ui = uiNamespace getVariable "life_progress";
		_progressBar = _ui displayCtrl 38201;
		_titleText = _ui displayCtrl 38202;
	};
	if !(player getVariable ["cappingCart", false]) then {
		player setVariable ["cappingCart", true, true];
	};
	_changeMark = false;
	_captureData = _flagObject getVariable ["capture_data",[0,"Neutral",0.5]];
	_currentDataID = _captureData select 0;
	_currentDataName = _captureData select 1;
	_currentDataprogress = ((round((_captureData select 2) * 3000)) / 3000);
	_nearPlayers = nearestObjects[_zoneLocation,["CAManBase"],100];
	_nearbyGangs = [];
	{
		if ((side _x isEqualTo civilian) && {!((leader(group _x) getVariable "gang_data") select 0 in _nearbyGangs)} && {alive _x} && {!(player getVariable["restrained",false])} && {!(!isNil {_x getVariable 'adminesp'})}) then {
			_nearbyGangs pushBack ((leader(group _x) getVariable "gang_data") select 0);
		};
		if ((side _x isEqualTo west) && {!(-5 in _nearbyGangs)} && {alive _x} && {!(player getVariable["restrained",false])} && {!(!isNil {_x getVariable 'adminesp'})}) then {
			_nearbyGangs pushBack -5;
		};
	} forEach _nearPlayers; //-5 represents west side

	if (((_currentDataID == _groupGangID && _currentDataprogress < 1) || (_currentDataID != _groupGangID) && !(_isCop)) && (count _nearbyGangs == 1 && ((_nearbyGangs select 0) == (_groupGangID)))) then {
		_nearGangMembers = -1;
		{
			if((_groupLeader == leader(group _x)) && alive _x) then {
				_nearGangMembers = _nearGangMembers + 1;
			};
		} forEach _nearPlayers; //CAManBase is player models only. "Man" will also encompass AI like rabbits/snakes etc

		if(_nearGangMembers > 2) then {_nearGangMembers = 2;};

		if(((_currentDataID) != (_groupGangID)) && _cp > 0) then {
			_cpRate = -0.001 - (_nearGangMembers * 0.000375);
			_title = "Uncapping...";
		} else {
			if(_currentDataID != _groupGangID) then {
				_flagObject setVariable["capture_data",[_groupGangID, _groupGangName, 0],true];
				_captureData = [_groupGangID, _groupGangName, 0];
			};
			format["%1_cartel",_territory] setMarkerText format[" %1 Cartel (%2)",_markerCustomName, _groupGangName];
			_title = "Capturing...";
			_cpRate = 0.001 + (_nearGangMembers * 0.000375);
		};

		_cP = _cP + _cpRate;
		_cP = ((round((_cP) * 3000)) / 3000);
		if(_cP > 1) then {_cP = 1;} else {if(_cP < 0) then {_cp = 0;};};
		_progressBar progressSetPosition _cP;
		_titleText ctrlSetText format["%3 (%1%2)",round(_cP * 100),"%",_title];

		if(_currentDataID == _groupGangID && _cp == 1) exitWith {
			_flagObject setVariable["capture_data",[_currentDataID,_currentDataName, _cP],true];
		};

		if(_updateTime <= time) then {
			if(((_currentDataprogress < _cp) && _cpRate > 0) || ((_currentDataprogress > _cp) && _cpRate < 0)) then {
				_flagObject setVariable["capture_data",[_currentDataID,_currentDataName, _cP],true];
				if(isNil {_flagObject getVariable "last_alert"}) then {
					_flagObject setVariable["last_alert",time,true];
				};
				if((_flagObject getVariable["last_alert",serverTime]) < (serverTime - 300)) then {
					if(_currentDataID != _groupGangID) then {
						_onlineMembers = ([_currentDataID] call OEC_fnc_getOnlineMembers);
						if(count _onlineMembers > 0) then {
							[[3,format["<t color='#ffa700'><t size='1.8'><t align='center'>Gang Notification<br/><t color='#ffffff'><t align='center'><t size='1.1'>The %1 gang is capturing your %2 cartel!",_groupGangName,_markerCustomName]],"OEC_fnc_broadcast",_onlineMembers,false] spawn OEC_fnc_MP;
						};
						_flagObject setVariable["last_alert",serverTime,true];
					};
				};
			} else {
				_cP = _currentDataprogress;
			};
			_updateTime = time + 5;
		};
	} else {
        if ((count _nearbyGangs) == 1 && _cP == 1) then {
        	if !(_isCop) then {_title = "Captured!";} else {_title = "Area Clear!";};
		};
		if ((count _nearbyGangs) > 1) then {
			_title = "Contested...";
		};
		_titleText ctrlSetText format["%3 (%1%2)",round(_cP * 100),"%",_title];
		_updateTime = time + 5;
	};
	{
		if (_x getVariable "cappingCart") exitWith {_changeMark = true;};
	}forEach _nearPlayers;
	if(_changeMark) then {
		if ((getMarkerType format["%1_cartel",_territory]) != "mil_warning") then {
			format["%1_cartel",_territory] setMarkerType "mil_warning";
			format["%1_cartel",_territory] setMarkerSize [0.75,0.75];
		};
	};
};
_changeMark = false;
_nearPlayers = nearestObjects[_zoneLocation,["CAManBase"],95];
if (player getVariable ["cappingCart", false]) then {
	player setVariable ["cappingCart", false, true];
};
{
	if (_x getVariable "cappingCart") exitWith {_changeMark = true;};
}forEach _nearPlayers;
if(!(_changeMark)) then {
	if ((getMarkerType format["%1_cartel",_territory]) != "loc_Bunker") then {
		format["%1_cartel",_territory] setMarkerType "loc_Bunker";
		format["%1_cartel",_territory] setMarkerSize [2,2];
	};
};
5 cutText ["","PLAIN DOWN"];
oev_capturingTerritory = false;
if (_badWpn) then {
	uiSleep 5;
	[_territory] spawn OEC_fnc_captureTerritory;
};
