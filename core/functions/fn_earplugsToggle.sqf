//Default settings: 40%, 10%

if (oev_earplugs) then {
	if (oev_earVol) then {
		oev_earVol = false;
		1 fadeSound ((life_earplugs select 0) / 100);
		hint format["Earplugs partially inserted. %1%2", (life_earplugs select 0), "%"];
	} else {
		oev_earplugs = false;
		hint format["Earplugs fully inserted. %1%2", (life_earplugs select 1), "%"];
		1 fadeSound ((life_earplugs select 1) / 100);
	};
} else {
	oev_earplugs = true;
	oev_earVol = true;
	hint "Earplugs removed";
	1 fadeSound 1;
};
[] call OEC_fnc_hudUpdate;
