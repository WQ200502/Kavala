//	File: fn_listHouse.sqf
//	Author: TheCmdrRex
//	Description: Lists the house for price that was entered

params[
	["_house",objNull,[objNull]],
	["_mode",-1,[0]]
];

if !(_mode == 1 || _mode == 2) exitWith {};
private ["_amount","_price"];
if (_mode == 1) then {
	if(call oev_restrictions) exitWith {hint "你受到限制，不能将你的房子挂牌出售!"};
	_amount = ctrlText 2752;
	closeDialog 0;
	//	Checks
	if(!([_amount] call OEC_fnc_isNumeric)) exitWith {hint localize "STR_Cop_TicketNum"};
	if((parseNumber _amount) < 10000) exitWith {hint "你的房子卖得一定高于 $10,000!"};
	if (isNull _house) exitWith {};
	if !(alive player) exitWith {};
	if (vehicle player != player) exitWith {};
	_price = parseNumber _amount;

	private _action = [
		format ["你确定将要已 $%1的价格出售这个房子么? 这将产生 5%2 或 $75000 的税费",[_price] call OEC_fnc_numberText,"%"],
		"确认菜单",
		"是",
		"否"
	] call BIS_fnc_guiMessage;
	if !(_action) exitWith {};

	private _fee = _price * 0.05;
	if (_fee > 1000000) then {_fee = 1000000;};
	if (_fee < 75000) then {_fee = 75000;};
	if (oev_atmcash < _fee) exitWith {hint "你没有钱把这房子挂牌!";};
	if (oev_cash >= _fee) then {
		oev_cash = oev_cash - _fee;
		oev_cache_cash = oev_cache_cash - _fee;
	} else {
		oev_atmcash = oev_atmcash - _fee;
		oev_cache_atmcash = oev_cache_atmcash - _fee;
	};
	[6] call OEC_fnc_ClupdatePartial;

	// Set house for sale
	_house setVariable ["for_sale",[(getPlayerUID player),_price],true];
	[[player,_house,0],"OES_fnc_houseForSale",false,false] spawn OEC_fnc_MP;
	hint format["Listing your house on the market for $%1...",[_price] call OEC_fnc_numberText];
};

// Mode to take house off of listed
if (_mode == 2) then {
	// Checks
	if (isNull _house) exitWith {};
	if !(alive player) exitWith {};
	if (vehicle player != player) exitWith {};

	private _action = [
		"你确定要取消你房子的挂牌吗?",
		"确定菜单",
		"是",
		"否"
	] call BIS_fnc_guiMessage;
	if !(_action) exitWith {};

	// Take house off of market
	_house setVariable ["for_sale","",true];
	[[player,_house,1],"OES_fnc_houseForSale",false,false] spawn OEC_fnc_MP;
	hint "把你的房子从市场上撤下来...";
};