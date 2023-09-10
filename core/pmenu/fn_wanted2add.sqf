//fn_wanted2add.sqf

private["_display","_list","_side","_sortedPlayers"];
disableSerialization;
waitUntil {!isNull (findDisplay 9900)};
_display = findDisplay 9900;
_list = _display displayCtrl 9902;


lbClear _list;
_sortedPlayers = [];
{
	if(side _x isEqualTo civilian) then {
		_sortedPlayers pushBack [format["%1 - %2", name _x,"Civ"],_x];
	};
}foreach playableUnits;

_sortedPlayers sort true;

{
	_list lbAdd (_x select 0);
	_list lbSetData [(lbSize _list)-1,str(_x select 1)];
}foreach _sortedPlayers;

_list2 = _display displayCtrl 9991;
lbClear _list2;

/*
_text = "Abuse of Work Prot. Lic., " + format["%1元",30000*.75];
_data = "53";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

	//Cannot add new crimes to system this easily, this would break stuff, easier in remake

_text = "Abuse of Vigilente Lic., " + format["%1元",30000*.75];
_data = "54";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];
*/


//fn_wanted2add.sqf

private["_display","_list","_side","_sortedPlayers"];
disableSerialization;
waitUntil {!isNull (findDisplay 9900)};
_display = findDisplay 9900;
_list = _display displayCtrl 9902;


lbClear _list;
_sortedPlayers = [];
{
	if(side _x isEqualTo civilian) then {
		_sortedPlayers pushBack [format["%1 - %2", name _x,"Civ"],_x];
	};
}foreach playableUnits;

_sortedPlayers sort true;

{
	_list lbAdd (_x select 0);
	_list lbSetData [(lbSize _list)-1,str(_x select 1)];
}foreach _sortedPlayers;

_list2 = _display displayCtrl 9991;
lbClear _list2;

/*
_text = "Abuse of Work Prot. Lic., " + format["%1元",30000*.75];
_data = "53";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

	//Cannot add new crimes to system this easily, this would break stuff, easier in remake

_text = "Abuse of Vigilente Lic., " + format["%1元",30000];
_data = "54";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];
*/

_text = format["协助越狱, %1元",86000];
_data = "42";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = format["协助制药。 抢劫, %1元",40000];
_data = "68";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = format["协助银行抢劫, %1元",81250];
_data = "72";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "协助抢劫, " + format["%1元",112500];
_data = "44";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = format["协助BW抢劫, %1元",112500];
_data = "59";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "Attp。 BW抢劫, " + format["%1元",82500];
_data = "65";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "Attp. 越狱, " + format["%1元",63750];
_data = "66";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "Attp. 抢劫银行, " + format["%1元",32500];
_data = "71";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "Attp. 过失杀人, " + format["%1元",26250];
_data = "24";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "Attp. 预备抢劫, " + format["%1元",82500];
_data = "45";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "Attp. 抢劫, " + format["%1元",8000];
_data = "21";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "Attp. 车辆盗窃, " + format["%1元",5000];
_data = "23";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "避开检查站, " + format["%1元",30000];
_data = "50";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "财产破坏, " + format["%1元",63750];
_data = "35";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "拒绝配合警察执法, " + format["%1元",8000];
_data = "47";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "扰乱治安, " + format["%1元",1125];
_data = "52";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "无驾照驾驶, " + format["%1元",6250];
_data = "19";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "无灯驾驶, " + format["%1元",2000];
_data = "20";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "无碰撞灯飞行, " + format["%1元",2000];
_data = "70";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "进入警戒区, " + format["%1元",6000];
_data = "34";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "拒捕, " + format["%1元",16500];
_data = "31";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "飞行/悬停在150米以下, " + format["%1元",15000];
_data = "41";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "无飞行员执照飞行, " + format["%1元",10500];
_data = "43";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "肇事逃逸, " + format["%1元",7500];
_data = "30";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "绑架, " + format["%1元",86500];
_data = "39";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "非法区域. 飞行载具。着陆, " + format["%1元",48750];
_data = "28";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "保险欺诈, " + format["%1元",1500];
_data = "46";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "应急系统误用, " + format["%1元",40000];
_data = "58";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "妨碍司法公正, " + format["%1元",15750];
_data = "57";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "交通阻塞, " + format["%1元",4625];
_data = "48";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "驾驶非法载具, " + format["%1元",31500];
_data = "29";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "犯罪份子同伙, " + format["%1元",15000];
_data = "56";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "Pos. 持有警用 "+oev_copForce+" 装备., " + format["%1元",25500];
_data = "27";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "Pos. 持有爆炸物, " + format["%1元",30000];
_data = "69";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "Pos. 无许可证的枪支, " + format["%1元",11000];
_data = "36";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "Pos. 持有非法物品设备, " + format["%1元",15000];
_data = "73";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "Pos. 持有人体器官, " + format["%1元",22500];
_data = "62";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "Pos. 持有非法武器, " + format["%1元",12000];
_data = "37";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "超速行驶, " + format["%1元",1500];
_data = "25";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "恐怖行动, " + format["%1元",93750];
_data = "40";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "公开吸毒, " + format["%1元",10000];
_data = "51";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "在城市内使用枪支, " + format["%1元",5000];
_data = "38";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "非法使用泰瑟枪, " + format["%1元",30000];
_data = "64";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "车辆盗窃, " + format["%1元",17500];
_data = "22";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "言语侮辱, " + format["%1元",3000];
_data = "33";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "口头威胁, " + format["%1元",8000];
_data = "32";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "武器贩运, " + format["%1元",15125];
_data = "49";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "鲁莽驾驶, " + format["%1元",3000];
_data = "26";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "随地小便, " + format["%1元",2500];
_data = "74";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

_text = "麻醉枪击中他人, " + format["%1元",15000];
_data = "75";
_list2 lbAdd format["%1元",_text];
_list2 lbSetData [(lbSize _list2)-1,_data];

lbSort _list2;