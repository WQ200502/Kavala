	if (!alive player) exitWith {};
	if (isNil "life_last_taxi") then {life_last_taxi = 0};
        if ((life_last_taxi > 0) && ((time - life_last_taxi) < 180)) exitWith{ hint "3分钟内只能召唤一次滴滴."; };
	if ((call oev_donator) == 600 ||(call oev_donator) > 600 || (call oev_donator) == 601 ) exitWith{ hint "此功能需要赞助！"; };

    life_last_taxi = time;
	_roads = player nearRoads 50;
	
	if(_roads isEqualTo []) exitWith {hint "你必须靠近一条路才能呼叫飞机";};
	_nearest = objNull;
	_dist = 1e4;
	{
		if(player distance _x < _dist) then {
			_nearest = _x;
			_dist = player distance _x;
		};
	} forEach _roads;
	
	_location = getposatl _nearest;
	
	
	if(openMap true) then {
		_location spawn {
			_location = _this;
			hint "点击你要去的地点，按ESC退出.";
			Taxi_Target_Location = [];
			onMapSingleClick "
				_roads = _pos nearRoads 50;
				if(count(_roads) > 0) then {
					_nearest = objNull;
					_dist = 1e4;
					{
						if(_pos distance _x < _dist) then {
							_nearest = _x;
							_dist = _pos distance _x;
						};
					} forEach _roads;
					
					_location = getposatl _nearest;
				
					openMap false;
					onMapSingleClick """";
					Taxi_Target_Location = _location;
				} else {
					hint ""你需要选择一条附近路的位置!"";
				};
			";
			
			waitUntil{(!(Taxi_Target_Location isEqualTo [])) || (!visibleMap)};
			if !(Taxi_Target_Location isEqualTo []) then {
				
				
				_Air = "O_Heli_Light_02_unarmed_F" createVehicle _location;
				//飞机无敌 
				//_Air allowDamage false;
				_Air setVariable ["vehicle_info_owners",[["",""]],true];
				hint "你有60秒钟进飞机!";
				_time = diag_tickTime;
				waitUntil{vehicle player == _Air || diag_tickTime > (_time + 60)};
				if(vehicle player != _Air) exitWith {
					deleteVehicle _Air;
					hint "飞机已经离开了!";
				};
				
				waitUntil{speed _Air > 0};
				waitUntil{speed _Air == 0};
				hint "你到达目的地，请离开飞机!";
				waitUntil{vehicle player == player};
				deleteVehicle _Air;
				hint "谢谢乘坐，欢迎下次光临!";
			} else {
				hint "你停止叫飞机!";
			};
		};
	} else {
		hint "你需要个地图才能叫飞机!";
	};