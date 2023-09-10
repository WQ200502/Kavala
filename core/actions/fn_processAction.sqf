//  File: fn_processAction.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Master handling for processing an item.
private["_vendor","_type","_itemInfo","_oldItem","_newItem","_doublePro","_legalR","_illegalR","_illegalThreeR","_bonusText","_doubleProVal","_buffArr","_buffTime","_buffGrace","_buffPos","_buffPro","_buffPer","_legal","_illegal","_illegalThree","_cost","_upp","_hasLicense","_itemName","_oldVal","_ui","_progress","_pgText","_cP","_vals","_delay","_storeOld","_territory","_cartelDiscount","_flagObject","_flagData"];
_vendor = param [0,ObjNull,[ObjNull]];
_type = param [3,"",[""]];

if (isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if (isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",name player],["player_id",getPlayerUID player],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)],["location",getPosATL player]] call OEC_fnc_logIt;
	[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

if (isNull _vendor || _type == "" || (player distance _vendor > 6)) exitWith {};
if ((vehicle player) != player) exitWith { hint "此操作不能在车内执行。" };
if (side player != civilian) exitWith {hint "Your class cannot perform this action."};
oev_is_processing = true;
oev_interruptedTab = false;

private _isBM = false;
{
	if (player distance2D (getMarkerPos _x) < 30) exitWith {_isBM = true;};
} forEach ["bmOne","bmTwo","bmThree","bmFour"];

if (_isBM && !((typeOf _vendor) isEqualTo "Land_Sink_F")) then {_isBM = false;};

switch (_type) do {
	case "crystalmeth": {_territory = "Meth";};
	case "marijuana": {_territory = "Meth";};
	case "hash": {_territory = "Meth";};
	case "mushroom": {_territory = "Mushroom";};
	case "cocaine": {_territory = "Mushroom";};
	case "crack": {_territory = "Mushroom";};
	case "mushroomu": {_territory = "Mushroom";};
	case "moonshine": {_territory = "Moonshine";};
	case "heroin": {_territory = "Moonshine";};
	case "pheroin": {_territory = "Moonshine";};
	//case "frogp": {_territory = "Frog";};
	default {_territory = "";};
};

_cartelDiscount = 0;
if(_territory != "") then {
	_flagObject = call compile format["%1_flag",_territory];
	if(isNil "_flagObject" || isNull _flagObject) exitWith {};
	_flagData = _flagObject getVariable ["capture_data",[]];
	if(count _flagData isEqualTo 0) exitWith {};

	if(count oev_gang_data > 0) then {
		if(((_flagData select 0) == (oev_gang_data select 0)) && ((_flagData select 2) > 0)) then {
			_cartelDiscount = 0.005; // Value if you own cartel, means process faster
		} else {
			_cartelDiscount = 0; // Value if you own a cartel, but don't own this one
		};
	} else {
		_cartelDiscount = 0; // Value if you own no cartels
	};
};

_legal = [120, 180, 240, 300];
_illegal = [150, 210, 270, 330];
_illegalThree = [50, 70, 90, 110];
_legalR = ["salt", "cement", "sand", "iron", "copper", "silver", "platinum", "oil", "diamond"];
_illegalR = ["marijuana", "frog", "mushroom", "heroin", "cocaine", "hash", "acid", "mushroomu", "pheroin", "crack"];
_illegalThreeR = ["moonshine", "crystalmeth"];
_buffArr = [];

if (_type in _legalR) then {
	_buffArr = _legal;
} else {
	if (_type in _illegalR) then {
		_buffArr = _illegal;
	} else {
		if (_type in _illegalThreeR) then {
			_buffArr = _illegalThree;
		};
	};
};

// resets buff if you process a different item
_doublePro = switch (_type) do {
	case "hash": {"marijuana"};
	case "acid": {"frog"};
	case "mushroomu": {"mushroom"};
	case "pheroin": {"heroin"};
	case "crack": {"cocaine"};
	case "marijuana": {"hash"};
	case "frog": {"acid"};
	case "mushroom": {"mushroomu"};
	case "heroin": {"pheroin"};
	case "cocaine": {"crack"};

	default {"dub"};
};

if (_type != (oev_last_processed select 0) && (oev_last_processed select 0) != _doublePro) then {
	oev_last_processed set [0, _type];
	oev_last_processed set [2, 0];
};

if (license_civ_wpl && _buffArr isEqualTo _legal) then {_buffPer = [.97, .94, .91, .88];};											// legal buffs
if (_buffArr isEqualTo _illegal || _buffArr isEqualTo _illegalThree) then {_buffPer = [.95, .90, .85, .8];};		// illegal buffs
if !((oev_last_processed select 2) in _buffArr) then {
	_buffArr pushBack (oev_last_processed select 2);
} else {
	_buffArr pushBack (0);
};
_buffArr sort true;
_buffPos = _buffArr find (oev_last_processed select 2);
if (_buffPos != 0) then {_buffPro = _buffPer select (_buffPos -1);} else {_buffPro = 1;};												// set buff
if (!license_civ_wpl && _buffArr isEqualTo _legal) then {oev_last_processed = ["", -1, 0]; _buffPro = 1; _bonusText = "";} else {	// if legal and no WPL disable buff, otherwise display hint
	if (_buffPos != 4) then {
		_bonusText = format ["[%1%2 奖金, %3/%4]",((1 - _buffPro) * 100),"%",(_buffArr select (_buffPos)),(_buffArr select (_buffPos + 1))];
	} else {
		_bonusText = format ["[%1%2, 最大奖金]",((1 - _buffPro) * 100),"%"];
	};
};

//unprocessed item(s), processed item, cost if no license, text to display, processing time delay
_itemInfo = switch (_type) do {
	//legal
	case "salt": {[["salt"],"saltr",350,"Processing Salt",0.03 * _buffPro]};
	case "cement": {[["rock"],"cement",450,"Mixing Cement",0.03 * _buffPro]};
	case "sand": {[["sand"],"glass",650,"Processing Sand",0.03 * _buffPro]};
	case "iron": {[["ironore"],"ironr",750,"Processing Iron",0.03 * _buffPro]};
	case "copper": {[["copperore"],"copperr",875,"Processing Copper",0.03 * _buffPro]};
	case "silver": {[["silver"],"silverr",990,"Processing Silver",0.03 * _buffPro]};
	case "platinum": {[["platinum"],"platinumr",1050,"Processing Platinum",0.03 * _buffPro]};
	case "oil": {[["oilu"],"oilp",1130,"Processing Oil",0.03 * _buffPro];};
	case "diamond": {[["diamond"],"diamondc",1200,"Processing Diamond",0.03 * _buffPro]};

	//illegal
	case "marijuana": {[["cannabis"],"marijuana",500,"Processing Marijuana",(0.03 * _buffPro) - _cartelDiscount]};
	case "frog": {[["frog"],"frogp",600,"Processing Frog LSD",0.03 * _buffPro,"illegal"]};
	case "mushroom": {[["mushroom"],"mmushroom",700,"Processing Mushroom",(0.035 * _buffPro) - _cartelDiscount]};
	case "heroin": {[["heroinu"],"heroinp",900,"Processing Heroin",(0.04 * _buffPro) - _cartelDiscount]};
	case "cocaine": {[["cocaine"],"cocainep",1100,"Processing Cocaine",(0.035 * _buffPro) - _cartelDiscount]};
	case "moonshine": {[["sugar","yeast","corn"],"moonshine",2200,"Processing Moonshine",(0.065 * _buffPro) - _cartelDiscount]};
	case "crystalmeth": {[["lithium","phosphorous","ephedra"],"crystalmeth",2400,"Processing Meth",(0.07 * _buffPro) - _cartelDiscount]};

  //double processes
	case "hash": {[["marijuana"],"hash",0,"Processing Hash",(0.015 * _buffPro) - _cartelDiscount]};
	case "acid": {[["frogp"],"acid",0,"Processing Acid",(0.015 * _buffPro)]};
	case "mushroomu": {[["mmushroom"],"mushroomu",0,"Processing Magic Mushrooms",(0.0175 * _buffPro) - _cartelDiscount]};
	case "pheroin": {[["heroinp"],"pheroin",0,"Processing Heroin",(0.02 * _buffPro) - _cartelDiscount]};
	case "crack": {[["cocainep"],"crack",0,"Processing Crack",(0.0225 * _buffPro) - _cartelDiscount]};

	default {[]};
};

if (count _itemInfo == 0) exitWith {oev_is_processing = false;};
_oldItem = [];
_vals = [];
{_oldItem pushBack _x;} foreach (_itemInfo select 0);
if (count _oldItem == 0) exitWith {oev_is_processing = false;};
{_vals pushBack (missionNamespace getVariable ([_x,0] call OEC_fnc_varHandle));} foreach _oldItem;
_oldVal = _vals select 0;
{if (_x < _oldVal) then {_oldVal = _x};} foreach _vals;
if (_oldVal == 0) exitWith {oev_is_processing = false;};
_newItem = _itemInfo select 1;
_cost = _itemInfo select 2;
_upp = _itemInfo select 3;

_buffGrace = 300; // time allotted between processing (not including the time it took to process the previous batch)
_buffTime = (_oldVal * (_itemInfo select 4) * 100) + _buffGrace - 2;		// grace period after processing (-2 b/c of 2 sec delay later to allow proper checking)
if (_type in ["hash","acid","mushroomu","pheroin","crack"]) then {
	_doubleProVal = switch (_type) do {
		case "hash": {(0.03 * _buffPro) - _cartelDiscount};
		case "acid": {0.03 * _buffPro};
		case "mushroomu": {(0.035 * _buffPro) - _cartelDiscount};
		case "pheroin": {(0.04 * _buffPro) - _cartelDiscount};
		case "crack": {(0.035 * _buffPro) - _cartelDiscount};

		default {0};
	};
	_buffTime = (_oldVal * (_doubleProVal) * 100) + _buffGrace -2;				// grace period after processing (-2 b/c of 2 sec delay later to allow proper checking)
};

_hasLicense = missionNamespace getVariable (([_type,0] call OEC_fnc_licenseType) select 0);
if (_type in ["hash","acid","mushroomu","pheroin","crack"]) then {_hasLicense = true;};
if (_isBM) then {_hasLicense = true;};
if (_isBM && _oldVal < 5) exitWith {oev_is_processing = false; hint "You have to process more than 5 ingredients at once when using the Black Market processing!";};

_itemName = [([_newItem,0] call OEC_fnc_varHandle)] call OEC_fnc_varToStr;
_cost = _cost * _oldVal;
if ((!_hasLicense) && (oev_cash < _cost)) exitWith {oev_is_processing = false; hint format["You need $%1 to process without a license!",[_cost] call OEC_fnc_numberText];};
private _copCountCp = 1;
if (_type in oev_illegal_drugs) then {
	_copCountCp = [west,2] call OEC_fnc_playerCount;
	_copCountCp = (_copCountCp / 100) + 1;
	if (_copCountCp > 1.10) then {_copCountCp = 1.10;};
};
//Setup our progress bar.
disableSerialization;
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNameSpace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%3 %2 (1%1)...","%",_upp,_bonusText];
_progress progressSetPosition 0.01;
_cP = 0.01;

closedialog 0;
oev_is_processing = true;
oev_action_inUse = true;

_delay = _oldVal * (_itemInfo select 4);
while {true} do {
	if !(oev_is_processing) then {oev_is_processing = true;};
	uiSleep _delay;
	_cP = _cP + (0.01 * _copCountCp);
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["%4 %3 (%1%2)...",round(_cP * 100),"%",_upp,_bonusText];
	if (_cP >= 1) exitWith {};
	if (player distance _vendor > 10) exitWith {};
	if (vehicle player != player) exitWith {};
	if (player getVariable ["restrained",false]) exitWith {};
	if (oev_interruptedTab) exitWith {};
};

if (player distance _vendor > 10) exitWith {hint "你需要待在10米以内才能加工。"; 5 cutText ["","PLAIN DOWN"]; oev_is_processing = false; oev_action_inUse = false;};
if !(alive player) exitWith {hint "你需要活着才能加工。"; 5 cutText ["","PLAIN DOWN"]; oev_is_processing = false; oev_action_inUse = false;};
if (vehicle player != player) exitWith {hint "你不能在车里加工。"; 5 cutText ["","PLAIN DOWN"]; oev_is_processing = false; oev_action_inUse = false;};
if (player getVariable ["restrained",false]) exitWith {hint "约束时不能加工"; 5 cutText ["","PLAIN DOWN"]; oev_is_processing = false; oev_action_inUse = false;};
if (oev_interruptedTab) exitWith {hint "您中断了加工！"; oev_interruptedTab = false; 5 cutText ["","PLAIN DOWN"]; oev_is_processing = false; oev_action_inUse = false;};

private _exploit = false;
{
	if !([false,_x,_oldVal] call OEC_fnc_handleInv) exitWith {
		5 cutText ["","PLAIN DOWN"];
		oev_is_processing = false;
		oev_action_inUse = false;
		_exploit = true;
	};
} forEach _oldItem;

if (_exploit) exitWith {
	[
		["event","Processing Exploit"],
		["player",name player],
		["player_id",getPlayerUID player],
		["location",getPosATL player]
	] call OEC_fnc_logIt;
	5 cutText ["","PLAIN DOWN"];
	oev_is_processing = false;
	oev_action_inUse = false;
};

if (_isBM) then {
	_storeOld = _oldVal;
	_oldVal = floor(_oldVal * 0.95);
	_storeOld = _storeOld - _oldVal;
};

if !([true,_newItem,_oldVal] call OEC_fnc_handleInv) exitWith {
	5 cutText ["","PLAIN DOWN"];
	{[true,_x,_oldVal] call OEC_fnc_handleInv;} foreach _oldItem;
	oev_is_processing = false;
	oev_action_inUse = false;
};

5 cutText ["","PLAIN DOWN"];

if (_hasLicense) then {
	if (_isBM) then {
		titleText[format["您已将商品加工成%1。黑市减价了%2%1。",_itemName,_storeOld],"PLAIN DOWN"];
	} else {
		titleText[format["您已将商品加工成%1",_itemName],"PLAIN DOWN"];
	};
} else {
	titleText[format["您已将商品以%2元的价格加工成%1",_itemName,[_cost] call OEC_fnc_numberText],"PLAIN DOWN"];
	oev_cash = oev_cash - _cost;
	oev_cache_cash = oev_cache_cash - _cost;
};

oev_is_processing = false;
oev_action_inUse = false;

// buffs for processing
if ((oev_last_processed select 1) == -1) exitWith {uiSleep 2; oev_last_processed = ["", 0, 0]};
oev_last_processed set [2, (oev_last_processed select 2) + _oldVal];

oev_last_processed set [1, (oev_last_processed select 1)+1];
uiSleep 2;
for "_i" from _buffTime to 0 step -1 do {
	if ((oev_last_processed select 1) > 1) exitWith {oev_last_processed set [1, (oev_last_processed select 1)-1];};
	if ((oev_last_processed select 1) == -1) exitWith {};
	uiSleep 1;
	if (_i == 0) then {
		oev_last_processed = ["", 0, 0];
		hint "处理奖金已过期。";
	};
};
