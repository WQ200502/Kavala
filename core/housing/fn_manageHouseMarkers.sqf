//Author: Raykazi
//Description: Creates/Deletes the marker on the map for the house they have just gained/lost keys to.
//	File: fn_manageHouseMarkers.sqf
private["_mode","_house","_housename","_marker"];
params [["_mode",-1, [0]], ["_house",[], [[]]]];
if(_mode isEqualTo -1) exitWith {};
if(count (_house) isEqualTo 0) exitWith { hint "创建房屋标记时出错。一个软日志可以修复它."};
switch(_mode) do {
  case 1:{
    hint format["%1 给了你他们房子的钥匙.", _house select 3];
    _marker = createmarkerlocal [format["house_key_%1", _house select 1], _house select 2];
    _housename = format["%1's house", _house select 3];
    _marker setmarkertextlocal _housename;
    _marker setmarkercolorlocal "ColorKhaki";
    _marker setmarkertypelocal "loc_lighthouse";
    life_house_keys pushBack (_house select 0);
  };
  case 2:{
    hint format["%1 把你家的钥匙拿走了 %2.", _house select 3, mapGridPosition (_house select 0)];
    deletemarkerlocal format["house_key_%1", _house select 1];
    life_house_keys deleteAt (life_house_keys find (_house select 0));
    oev_vehicles deleteAt (oev_vehicles find (_house select 0));
  };
}
