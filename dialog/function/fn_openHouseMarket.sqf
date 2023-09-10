//  File: fn_openHouseMarket.sqf
//	Author: Kurt
//	Description: Opens the house market map

disableSerialization;

["life_market_location"] call OEC_fnc_createDialog;
((findDisplay 50600) displayCtrl 50681) ctrlSetStructuredText parseText format ["<t size='1.5'><t align='center'><t color='#ff0000'>如何使用</t></t></t><br/>单击地图上的任意位置，以查看可购买的房屋。<br/><br/><t color='#0000b2'>蓝色</t> 标志是空置的房子。<br/><t color='#ffa500'>橙色</t> 标志是空置的车库。<br/><t color='#66009a'>紫色</t> 标志是空的帮派棚子。<br/><br/>双击标记以查看有关房屋的更多详细信息。<br/><br/><t size='1.5'><t align='center'><t color='#ff0000'>房屋详细信息</t></t></t><br/>名称: -<br/>最大虚拟容量: -<br/>最大物理容量: -<br/>询问价格: -"];
//,_storageCap,_crates,[_cost] call OEC_fnc_numberText
waitUntil {!dialog};
{deleteMarkerLocal _x;} foreach oev_houseMarketIcons;
oev_houseMarketIcons = [];
oev_houseSelectPosition = [0,0,0];
oev_selectedHouse = ["",""];