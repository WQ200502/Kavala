//  File: fn_crimeName2Number.sqf
//  Author: Fusah
//	Description: ITS IN THE NAME!!!

params ["_crimeName"];
private ["_crimeNumber"];

_crimeNumber = switch (_crimeName) do {
	case "逃脱监狱": {3};
	case "使用非法爆炸物": {7};
	case "抢劫": {8};
	case "绑架": {9};
	case "偷车": {11};
	case "肇事逃逸": {13};
	case "拥有违禁品": {14};
	case "贩毒": {16};
	case "器官交易": {18};
	case "无执照驾驶": {19};
	case "Attp.抢劫": {21};
	case "车辆盗窃": {22};
	case "Attp.过失杀人": {24};
	case "Pos. 持有警用设备。": {27};
	case "非法飞机降落": {28};
	case "驾驶非法车辆": {29};
	case "肇事逃逸": {30};
	case "抗拒逮捕": {31};
	case "口头侮辱": {33};
	case "在城市内使用枪支": {38};
	case "飞行/悬停在150米以下": {41};
	case "协助越狱": {42};
	case "不配合警察执法": {47};
	case "交通阻塞": {48};
	case "武器贩运": {49};
	case "避开检查站": {50};
	case "公开吸毒": {51};
	case "扰乱治安": {52};
	case "过失杀人": {53};
	case "政府网络攻击": {54};
	case "破坏政府财产": {55};
	case "犯罪方": {56};
	case "妨碍司法公正": {57};
	case "应急系统滥用": {58};
	case "协助BW抢劫": {59};
	case "抢劫加油站": {60};
	case "器官采集": {61};
	case "Pos 非法持有器官": {62};
	case "帮派杀人案": {63};
	case "非法使用泰瑟枪": {64};
	case "Attp.BW抢劫": {65};
	case "Attp.越狱": {66};
	case "绑架政府官员": {67};
	case "协助制药。 抢劫": {68};
	case "Pos 炸药": {69};
	case "不带防撞灯飞行": {70};
	case "Attp.抢银行": {71};
	case "协助抢劫银行": {72};
	case "Pos. 持有非法装备": {73};
	case "击晕他人": {75};
	default {-1;};
};

_crimeNumber;