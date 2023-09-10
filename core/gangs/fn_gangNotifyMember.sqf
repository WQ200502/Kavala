//  File: fn_gangNotifyMember.sqf
//	Author: Jesse "tkcjesse" Schultz

//	Description: Notifies gang members of situations

params [
	["_mode",-2,[0]]
];
if (_mode isEqualTo -2) exitWith {};

switch (_mode) do {
	case 1: {
		"帮派警报" hintC ["你的帮派建筑有被卖掉的危险！你需要保持8+个成员来保持你的小屋。。。开始招募！”，“您的库存将作为抵押品，直到您满足会员要求。一旦满足了要求，请等到下一次重新启动后再获得库存访问权。"];
	};

	default
	{};
};