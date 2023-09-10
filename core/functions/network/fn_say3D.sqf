//  File: fn_say3D.sqf
//	Description: Plays a selected sound via say3D so everyone can hear it.
//  Example: [[_veh,"carUnlock"],"OEC_fnc_say3D",-2,true] spawn OEC_fnc_MP;

private["_object","_sound","_sirenObj"];
_object = param [0,ObjNull,[ObjNull]];
_sound = param [1,"",[""]];
_sirenObj = param [2,ObjNull,[ObjNull]];
_sirenOwner = param [3,ObjNull,[ObjNull]];
if(isNull _object) exitWith {};

switch(_sound) do {
	case "apdWail": {
		if(isNil {_object getVariable "siren"}) exitWith {};
		// Continue while we have a siren, the inside check for crew and destruction
		while {(_object getVariable "siren")} do {
			if(count (crew (_object)) == 0) then {_object setVariable["siren",false,true]};
			if(!alive _object) exitWith {};
			if(isNull _sirenObj) exitWith {};
			_sirenObj say3D ["APD_Wail",300,1];
			uiSleep 5;
		};
		// Prevent from everyone trying to delete it (mainly on clean up)
		if (_sirenOwner isEqualTo player) then {
			deleteVehicle _sirenObj;
		};
	};

	case "medicWail": {
		if(isNil {_object getVariable "siren"}) exitWith {};
		// Continue while we have a siren, the inside check for crew and destruction
		while {(_object getVariable "siren")} do {
			if(count (crew (_object)) == 0) then {_object setVariable["siren",false,true]};
			if(!alive _object) exitWith {};
			if(isNull _sirenObj) exitWith {};
			_sirenObj say3D ["Med_Wail",300,1];
			uiSleep 5.5;
		};
		// Prevent from everyone trying to delete it (mainly on clean up)
		if (_sirenOwner isEqualTo player) then {
			deleteVehicle _sirenObj;
		};
	};

	case "apdYelp": {
		if(isNil {_object getVariable "yelp"}) exitWith {};
		// Continue while we have a siren, the inside check for crew and destruction
		while {(_object getVariable "yelp")} do {
			if(count (crew (_object)) == 0) then {_object setVariable["yelp",false,true]};
			if(!alive _object) exitWith {};
			if(isNull _sirenObj) exitWith {};
			_sirenObj say3D ["APD_Yelp",300,1];
			uiSleep 6.5;
		};
		// Prevent from everyone trying to delete it (mainly on clean up)
		if (_sirenOwner isEqualTo player) then {
			deleteVehicle _sirenObj;
		};
	};

	case "medicYelp": {
		if(isNil {_object getVariable "yelp"}) exitWith {};
		// Continue while we have a siren, the inside check for crew and destruction
		while {(_object getVariable "yelp")} do {
			if(count (crew (_object)) == 0) then {_object setVariable["yelp",false,true]};
			if(!alive _object) exitWith {};
			if(isNull _sirenObj) exitWith {};
			_sirenObj say3D ["Med_Yelp",300,1];
			uiSleep 7;
		};
		// Prevent from everyone trying to delete it (mainly on clean up)
		if (_sirenOwner isEqualTo player) then {
			deleteVehicle _sirenObj;
		};
	};

	case "radiotower": {
		if (isNull(_object)) exitWith{};
		if (isNull(_sirenObj)) exitWith{};
		_sirenObj say3D ["radiotower",300,1];
	};

	case "apdHorn": {
		_object say3D "apd_Horn";
	};

	case "medicHorn": {
		_object say3D "med_Horn";
	};

	case "carAlarm": {
		for [{_x=1},{_x<=2},{_x=_x+1}] do {
			_object say3D ["car_alarm",150,1];
			uiSleep 10;
		};
	};

	case "carUnlock": {
		if(player distance _object > 100) exitWith {};
		_object say3D "unlock";
	};

	case "carLock": {
		if(player distance _object > 100) exitWith {};
		_object say3D "car_lock";
	};

	case "handcuff": {
		if(player distance _object > 10) exitWith {};
		_object say3D "cuff";
	};

	//case "taze": {
	//	if(player distance _object > 100) exitWith {};
	//	_object say3D "Tazersound";
	//};

	case "tempestDevice": {
		if(player distance _object > 2000) exitWith {}; //Don't run it... They're to far out..

		while {true} do {
			if(isNull _object || !alive _object) exitWith {};
			if(isNil {_object getVariable "mining"}) exitWith {};
			_object say3D "Device_disassembled_loop";
			uiSleep 28.6;
		};
	};

	case "ticket": {
		if(player distance _object > 10) exitWith {};
		_object say3D "ticket";
	};

	case "fedAlarm": {
		for [{_x=1},{_x<=13},{_x=_x+1}] do {
			_object say3D ["bank_alarm",300,1];
			uiSleep 24;
		};
	};
	case "kick_balls": {
		if(player distance _object > 100) exitWith {};
		_object say3D "kick_balls";
	};

	case "galleryAlarm": {
		for "_i" from 0 to 26 do {
			_object say3D "gallery_siren";
			uiSleep 2.3;
			if !(oev_artGallery) exitWith {};
		};
	};

	case "gamblingWin": {
		_object say3D "gamblingWin";
	};

	case "gamblingLose": {
		_object say3D "gamblingLose";
	};
	//case "eventSound": {
	//	if(player distance _object > 100) exitWith {};
	//	_object say3D "event_sound";
	//	uiSleep 18;
	//};

	//case "cream": {
	//	if(isNil {_object getVariable "siren"}) exitWith {};
		// Continue while we have a siren, the inside check for crew and destruction
	//	while {(_object getVariable "siren")} do {
	//		if(count (crew (_object)) == 0) then {_object setVariable["siren",false,true]};
	//		if(!alive _object) exitWith {};
	//		if(isNull _sirenObj) exitWith {};
	//		_sirenObj say3D ["ice_cream",170,1];
	//		sleep 13.5;
	//	};
	//	// Prevent from everyone trying to delete it (mainly on clean up)
	//	if (_sirenOwner isEqualTo player) then {
	//		deleteVehicle _sirenObj;
	//	};
	// };

	//case "beer": {
	//	if(isNil {_object getVariable "siren"}) exitWith {};
	//	// Continue while we have a siren, the inside check for crew and destruction
	//	while {(_object getVariable "siren")} do {
	//		if(count (crew (_object)) == 0) then {_object setVariable["siren",false,true]};
	//		if(!alive _object) exitWith {};
	//		if(isNull _sirenObj) exitWith {};
	//		_sirenObj say3D "beer_song";
	//		sleep 18.5;
	//	};
	//	// Prevent from everyone trying to delete it (mainly on clean up)
	//	if (_sirenOwner isEqualTo player) then {
	//		deleteVehicle _sirenObj;
	//	};
	//};

	//case "party_horn": {
	//	_object say3D "party_horn";
	//};
	case "dillifu": {
		_object say3D "dillifu";
	};
	case "noots": {
		_object say3D "noot_horn";
	};
	case "dochorn": {
		_object say3D "doc_horn";
	};
	case "peterhorn": {
		_object say3D "peter_horn";
	};
	case "zonda": {
		_object say3D "zonda";
	};
	case "rexhorn": {
		_object say3D "rex_horn";
	};
	case "ryanhorn": {
		_object say3D "ryan_horn";
	};
	case "rapidhorn": {
		_object say3D "rapid_horn";
	};
	case "destructbark": {
		_object say3D "destructbark";
	};
	case "zahzihorn": {
		_object say3D "zahzi_horn";
	};
	case "trimohorn": {
		_object say3D "trimohorn";
	};
	case "horizonhorn": {
		_object say3D "horizonhorn";
	};
	case "fraalihorn": {
		_object say3D "fraalihorn";
	};
	case "rayHorn": {
		_object say3D "rayHorn";
	};
	case "techHorn": {
		_object say3D "bank_alarm";
	};
};
