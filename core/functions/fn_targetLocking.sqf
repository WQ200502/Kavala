//  File: fn_targetLocking.sqf
//	Author: Kurt

//	Description: Gets the targets name after being locked on for 5 seconds.
params [
	["_obj",objNull,[objNull]],
	["_mode",0,[0]]
];
switch (_mode) do {
	case 0: {
		if ((life_currTarget select 0) isEqualTo _obj) then {
			private _timeLocked = time - (life_currTarget select 1);
			private _vehicleHoldTime = 1;
			switch (true) do {
				case (_timeLocked < _vehicleHoldTime): {
					hintSilent parseText format ["<t color='#ffdd00'><t size='2'><t align='center'>Acquiring Target</t></t></t><br/><br/><t color='#FFFFFF'><t size='1'><t align='center'>Keep your crosshair locked on the target!</t></t></t>"];
				};
				case (_timeLocked >= _vehicleHoldTime): {
					_obj = (fullCrew [_obj,"driver",false] select 0) select 0;
					if(((_obj getVariable ["gang_data",[0,"",0]]) select 0) in oev_gang_warIDs) then {
						hintSilent parseText format ["<t color='#00CC00'><t size='2'><t align='center'>Target Acquired</t></t></t><br/><br/><t color='#D61414'><t size='1'><t align='center'>%1</t></t></t>",name _obj];
					} else {
						hintSilent parseText format ["<t color='#00CC00'><t size='2'><t align='center'>Target Acquired</t></t></t><br/><br/><t color='#FFFFFF'><t size='1'><t align='center'>%1</t></t></t>",name _obj];
					};
					if (isNull(life_targetCache)) then {
						life_targetCache = _obj;
						life_acquireTargetCooldown = true;
						[] spawn{
							uiSleep 3;
							if (life_acquireTargetCooldown) then {
								life_acquireTargetCooldown = false;
							};
						};
					};
				};
			};
		} else {
			if !(isNull(life_currTarget select 0)) then {
				life_currTarget = [objNull,0];
				hintSilent "";
			};
		};
	};
	case 1: {
		if ((life_currTarget select 0) isEqualTo _obj) then {
			private _timeLocked = time - (life_currTarget select 1);
			private _groundHoldTime = 0.5;
			switch (true) do {
				case (_timeLocked < _groundHoldTime): {
					hintSilent parseText format ["<t color='#ffdd00'><t size='2'><t align='center'>Acquiring Target</t></t></t><br/><br/><t color='#FFFFFF'><t size='1'><t align='center'>Keep your crosshair on the target!</t></t></t>"];
				};
				case (_timeLocked >= _groundHoldTime): {
					if(((_obj getVariable ["gang_data",[0,"",0]]) select 0) in oev_gang_warIDs) then {
						hintSilent parseText format ["<t color='#00CC00'><t size='2'><t align='center'>Target Acquired</t></t></t><br/><br/><t color='#D61414'><t size='1'><t align='center'>%1</t></t></t>",name _obj];
					} else {
						hintSilent parseText format ["<t color='#00CC00'><t size='2'><t align='center'>Target Acquired</t></t></t><br/><br/><t color='#FFFFFF'><t size='1'><t align='center'>%1</t></t></t>",name _obj];
					};
					if (isNull(life_targetCache)) then {
						life_targetCache = _obj;
						life_acquireTargetCooldown = true;
						[] spawn{
							uiSleep 3;
							if (life_acquireTargetCooldown) then {
								life_acquireTargetCooldown = false;
							};
						};
					};
				};
			};
		} else {
			if !(isNull(life_currTarget select 0)) then {
				life_currTarget = [objNull,0];
				hintSilent "";
			};
		};
	};
	case 2: {
		if ((life_currTarget select 0) isEqualTo _obj) then {
			private _timeLocked = time - (life_currTarget select 1);
			private _airHoldTime = 0.1;
			switch (true) do {
				case (_timeLocked < _airHoldTime): {
					hintSilent parseText format ["<t color='#ffdd00'><t size='2'><t align='center'>Acquiring Target</t></t></t><br/><br/><t color='#FFFFFF'><t size='1'><t align='center'>Keep your crosshair locked on the target!</t></t></t>"];
				};
				case (_timeLocked >= _airHoldTime): {
					_obj = (fullCrew [_obj,"driver",false] select 0) select 0;
					if(((_obj getVariable ["gang_data",[0,"",0]]) select 0) in oev_gang_warIDs) then {
						hintSilent parseText format ["<t color='#00CC00'><t size='2'><t align='center'>Target Acquired</t></t></t><br/><br/><t color='#D61414'><t size='1'><t align='center'>%1</t></t></t>",name _obj];
					} else {
						hintSilent parseText format ["<t color='#00CC00'><t size='2'><t align='center'>Target Acquired</t></t></t><br/><br/><t color='#FFFFFF'><t size='1'><t align='center'>%1</t></t></t>",name _obj];
					};
					if (isNull(life_targetCache)) then {
						life_targetCache = _obj;
						life_acquireTargetCooldown = true;
						[] spawn{
							uiSleep 3;
							if (life_acquireTargetCooldown) then {
								life_acquireTargetCooldown = false;
							};
						};
					};
				};
			};
		} else {
			if !(isNull(life_currTarget select 0)) then {
				life_currTarget = [objNull,0];
				hintSilent "";
			};
		};
	};
	default {};
};
