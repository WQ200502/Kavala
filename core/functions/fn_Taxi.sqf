	if (!alive player) exitWith {};
	if (isNil "life_last_taxi") then {life_last_taxi = 0};
    if ((life_last_taxi > 0) && ((time - life_last_taxi) < 120)) exitWith{ hint "2分钟内只能呼叫一次滴滴."; };

    life_last_taxi = time;
	_roads = player nearRoads 50;
	
	if(_roads isEqualTo []) exitWith {hint "你必须靠近一条路才能呼叫出租车";};
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
				
				
				_taxi = "C_Hatchback_01_sport_F" createVehicle _location;
				//出租车无敌 Luon
				//_taxi allowDamage false;
				_taxi setVariable ["vehicle_info_owners",[["",""]],true];
				createVehicleCrew _taxi;
				_driver = driver _taxi;
				_group = createGroup (side _driver);
				[_driver] joinSilent _group;
				
				hint "你有10秒钟进出租车!";
				_time = diag_tickTime;
				waitUntil{vehicle player == _taxi || diag_tickTime > (_time + 10)};
				if(vehicle player != _taxi) exitWith {
					deleteGroup _group;
					deleteVehicle _driver;
					deleteVehicle _taxi;
					hint "出租车已经离开了!";
				};
				
				_group move Taxi_Target_Location;
				waitUntil{speed _taxi > 0};
				waitUntil{speed _taxi == 0};
				hint "你到达目的地，请离开出租车!";
				waitUntil{vehicle player == player};
				deleteGroup _group;
				deleteVehicle _driver;
				deleteVehicle _taxi;
				hint "谢谢乘坐，欢迎下次光临!";
			} else {
				hint "你停止叫车!";
			};
		};
	} else {
		hint "你需要个地图才能叫车!";
	};