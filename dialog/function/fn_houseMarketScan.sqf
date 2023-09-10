//  File: fn_houseMarketScan.sqf
//	Author: Kurt
//	Description: Scans nearby houses when the user clicks on the location on the map
params [
	"_mapPosition",
	["_doubleClick",false,[false]]
];
disableSerialization;
private _houses = ["Land_i_House_Big_02_V1_F","Land_i_House_Big_02_V2_F","Land_i_House_Big_02_V3_F","Land_i_House_Big_01_V1_F","Land_i_House_Big_01_V2_F","Land_i_House_Big_01_V3_F","Land_i_Garage_V1_F","Land_i_Garage_V2_F","Land_i_House_Small_01_V1_F","Land_i_House_Small_01_V2_F","Land_i_House_Small_01_V3_F","Land_i_House_Small_02_V1_F","Land_i_House_Small_02_V2_F","Land_i_House_Small_02_V3_F","Land_i_House_Small_03_V1_F","Land_i_Stone_HouseSmall_V2_F","Land_i_Stone_HouseSmall_V1_F","Land_i_Stone_HouseSmall_V3_F","Land_i_Addon_02_V1_F","Land_i_Stone_Shed_V1_F","Land_i_Stone_Shed_V2_F","Land_i_Stone_Shed_V3_F"];
private _garages = ["Land_i_Garage_V1_F","Land_i_Garage_V2_F"];

private _scanRadius = 250; //Radius of house search

//Map the clicked position to the world
private _position = _mapPosition select 0 ctrlMapScreenToWorld [ (_mapPosition select 2), (_mapPosition select 3) ];

if !(_doubleClick) then {
	oev_houseSelectPosition = _position;
	//Move to that position on the display
	[((findDisplay 50600) displayCtrl 50678),1,0.025,_position] call OEC_fnc_setMapPosition;
	uiSleep 0.5;
	if !(dialog) exitWith{};
	//Loops through all the houses nearby
	{
		if ((typeOf _x) in _houses) then {
			if (isNil {_x getVariable "house_owner"}) then {
				if((oev_conquestData select 0 && (getPos _x inPolygon (oev_conquestData select 1 select 1))) || _x getVariable["restricted_house",false]) exitWith {};
				private _marker = createMarkerLocal [format["%1_house",visiblePositionASL _x],visiblePositionASL _x];
				if ((typeOf _x) in _garages) then {
					_marker setMarkerColorLocal "ColorOrange";
				} else {
					_marker setMarkerColorLocal "ColorBlue";
				};
				_marker setMarkerTypeLocal "loc_Lighthouse";
				oev_houseMarketIcons pushBack _marker;
			};

			if !((_x getVariable "for_sale") isEqualTo "") then {
				private _marker = createMarkerLocal [format["%1_house",visiblePositionASL _x],visiblePositionASL _x];
				if ((typeOf _x) in _garages) then {
					_marker setMarkerColorLocal "ColorOrange";
				} else {
					_marker setMarkerColorLocal "ColorBlue";
				};
				_marker setMarkerTypeLocal "loc_Church";
				oev_houseMarketIcons pushBack _marker;
			};
		};
		if ((typeOf _x) isEqualTo "Land_i_Shed_Ind_F") then {
			if ((_x getVariable ["bldg_owner",""]) isEqualTo "") then {
				private _marker = createMarkerLocal [format["%1_house",visiblePositionASL _x],visiblePositionASL _x];
				_marker setMarkerColorLocal "ColorCIV";
				_marker setMarkerTypeLocal "loc_Lighthouse";
				oev_houseMarketIcons pushBack _marker;
			};
		};
	} forEach (nearestObjects [_position,["House_F","Land_i_Shed_Ind_F"],_scanRadius]);
	private _searchCircle = createMarkerLocal [format["searchCircle"],_position];
	_searchCircle setMarkerColorLocal "ColorRed";
	_searchCircle setMarkerShapeLocal "ELLIPSE";
	_searchCircle setMarkerBrush "Border";
	_searchCircle setMarkerSizeLocal [_scanRadius, _scanRadius];
	oev_houseMarketIcons pushBack _searchCircle;
} else {
	if (oev_houseSelectPosition isEqualTo [0,0,0]) exitWith {};
	if ((oev_houseSelectPosition distance2D _position) > _scanRadius) exitWith {};

	private _nearbyHouses = nearestObjects [_position,["House_F"],_scanRadius];
	if (count _nearbyHouses iSequalTo 0) exitWith {};
	private _selectedHouse = _nearbyHouses select 0;
	if !((typeOf _selectedHouse in _houses) || (typeOf _selectedHouse isEqualTo "Land_i_Shed_Ind_F")) exitWith {};
	if ((_position distance2D (getPos _selectedHouse)) > 10) exitWith {};
	if((((_selectedHouse getVariable ["house_owner",""]) isEqualTo "") && (typeOf _selectedHouse in _houses)) || (((_selectedHouse getVariable ["bldg_owner",""]) isEqualTo "") && (typeOf _selectedHouse isEqualTo "Land_i_Shed_Ind_F"))) then {
		private _houseConfig = [(typeOf _selectedHouse)] call OEC_fnc_houseConfig;
		//Make the marker colour green when it is selected
		if !((oev_selectedHouse select 0) isEqualTo "") then {
			if ((oev_selectedHouse select 1) in _houses) then {
				if ((oev_selectedHouse select 1) in _garages) then {
					(oev_selectedHouse select 0) setMarkerColorLocal "ColorOrange";
				} else {
					(oev_selectedHouse select 0) setMarkerColorLocal "ColorBlue";
				};
			} else {
				(oev_selectedHouse select 0) setMarkerColorLocal "ColorCIV";
			};
		};
		oev_selectedHouse set [0,format["%1_house",visiblePositionASL _selectedHouse]];
		(oev_selectedHouse select 0) setMarkerColorLocal "ColorGreen";
		oev_selectedHouse set [1,typeOf _selectedHouse];
		[((findDisplay 50600) displayCtrl 50678),1,0.0075,(getPos _selectedHouse)] call OEC_fnc_setMapPosition;
		if ((typeOf _selectedHouse) in _houses) then {
			((findDisplay 50600) displayCtrl 50681) ctrlSetStructuredText parseText format ["<t size='1.5'><t align='center'><t color='#ff0000'>如何使用</t></t></t><br/>单击地图上的任意位置可查看可供购买的房屋。<br/><br/><t color='#0000b2'>蓝色</t> 标记是空房子。<br/><t color='#ffa500'>橙色</t> 标记是空置的车库。<br/><t color='#66009a'>紫色</t> 标记是空的帮派工棚。<br/><br/>双击标记可查看有关房子的更多详细信息。<br/><br/><t size='1.5'><t align='center'><t color='#ff0000'>房屋详细信息</t></t></t><br/>名称: %1<br/>最大虚拟容量: %2<br/>最大物理容量: %3<br/>询问价格: %4元",getText(configFile >> "CfgVehicles" >> (typeOf _selectedHouse) >> "displayName"),(_houseConfig select 1) * 700,(_houseConfig select 1) * 100,[_houseConfig select 0] call OEC_fnc_numberText];
		} else {
			((findDisplay 50600) displayCtrl 50681) ctrlSetStructuredText parseText format ["<t size='1.5'><t align='center'><t color='#ff0000'>如何使用</t></t></t><br/>单击地图上的任意位置，以查看可购买的房屋。<br/><br/><t color='#0000b2'>蓝色</t> 标志是空置的房子。<br/><t color='#ffa500'>橙色</t> 标记是空置的车库。<br/><t color='#66009a'>紫色</t> 标记是空的帮派工棚。<br/><br/>双击标记以查看有关房屋的更多详细信息。<br/><br/><t size='1.5'><t align='center'><t color='#ff0000'>房屋详细信息</t></t></t><br/>名称: %1<br/>最大虚拟容量: %2<br/>最大物理容量: %3<br/>询问价格: $%4",getText(configFile >> "CfgVehicles" >> (typeOf _selectedHouse) >> "displayName"),10000,900,[_houseConfig select 0] call OEC_fnc_numberText];
		};


	};
	// Double Click for listed houses
	if (!((_selectedHouse getVariable ["for_sale",""]) isEqualTo "") && (typeOf _selectedHouse in _houses)) then {
		private _houseConfig = [(typeOf _selectedHouse)] call OEC_fnc_houseConfig;
		//Make the marker colour green when it is selected
		if !((oev_selectedHouse select 0) isEqualTo "") then {
			if ((oev_selectedHouse select 1) in _houses) then {
				if ((oev_selectedHouse select 1) in _garages) then {
					(oev_selectedHouse select 0) setMarkerColorLocal "ColorOrange";
				} else {
					(oev_selectedHouse select 0) setMarkerColorLocal "ColorBlue";
				};
			} else {
				(oev_selectedHouse select 0) setMarkerColorLocal "ColorCIV";
			};
		};
		oev_selectedHouse set [0,format["%1_house",visiblePositionASL _selectedHouse]];
		(oev_selectedHouse select 0) setMarkerColorLocal "ColorGreen";
		oev_selectedHouse set [1,typeOf _selectedHouse];
		[((findDisplay 50600) displayCtrl 50678),1,0.0075,(getPos _selectedHouse)] call OEC_fnc_setMapPosition;
		if ((typeOf _selectedHouse) in _houses) then {
			((findDisplay 50600) displayCtrl 50681) ctrlSetStructuredText parseText format ["<t size='1.5'><t align='center'><t color='#ff0000'>如何使用</t></t></t><br/>单击地图上的任意位置，以查看可购买的房屋。<br/><br/><t color='#0000b2'>蓝色</t> 标志是空置的房子。<br/><t color='#ffa500'>橙色</t> 标记是空置的车库。<br/><t color='#66009a'>紫色</t> 标记是空的帮派工棚。<br/><br/>双击标记以查看有关房屋的更多详细信息。<br/><br/><t size='1.5'><t align='center'><t color='#ff0000'>房屋详细信息</t></t></t><br/>名称: %1<br/>最大虚拟容量: %2<br/>最大物理容量: %3<br/>询问价格: $%4",((_selectedHouse getVariable ["house_owner",""]) select 1),(_selectedHouse getVariable ["storageCapacity",10000]),(_selectedHouse getVariable ["physicalStorageCapacity",10000]),([(_selectedHouse getVariable ["for_sale",""]) select 1] call OEC_fnc_numberText),getText(configFile >> "CfgVehicles" >> (typeOf _selectedHouse) >> "displayName")];
		} else {
			((findDisplay 50600) displayCtrl 50681) ctrlSetStructuredText parseText format ["<t size='1.5'><t align='center'><t color='#ff0000'>如何使用</t></t></t><br/>单击地图上的任意位置，以查看可购买的房屋。<br/><br/><t color='#0000b2'>蓝色</t> 标志是空置的房子。<br/><t color='#ffa500'>橙色</t> 标记是空置的车库。<br/><t color='#66009a'>紫色</t> 标记是空的帮派工棚。<br/><br/>双击标记以查看有关房屋的更多详细信息。<br/><br/><t size='1.5'><t align='center'><t color='#ff0000'>房屋详细信息</t></t></t><br/>名称: %1<br/>最大虚拟容量: %2<br/>最大物理容量: %3<br/>询问价格: $%4",((_selectedHouse getVariable ["house_owner",""]) select 1),(_selectedHouse getVariable ["storageCapacity",10000]),(_selectedHouse getVariable ["physicalStorageCapacity",10000]),([(_selectedHouse getVariable ["for_sale",""]) select 1] call OEC_fnc_numberText),getText(configFile >> "CfgVehicles" >> (typeOf _selectedHouse) >> "displayName")];
		};
	};
};

