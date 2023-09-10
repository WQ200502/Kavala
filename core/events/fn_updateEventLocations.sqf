//	Description: Updates the available locations for the selected event type
private["_display","_eventType","_eventLocationList"];
disableSerialization;

_display = findDisplay 50000;
_eventType = lbData[50003,lbCurSel (50003)];
_eventLocationList = _display displayCtrl 50004;

lbClear _eventLocationList;

switch (_eventType) do {
	case "derby": {
		_eventLocationList lbAdd "Salt";
		_eventLocationList lbSetData [(lbSize _eventLocationList) - 1,"salt"];

		_eventLocationList lbAdd "Event Area";
		_eventLocationList lbSetData [(lbSize _eventLocationList) - 1,"mainEventArea"];
	};

	case "race": {
		_eventLocationList lbAdd "Kav -> Pyr";
		_eventLocationList lbSetData [(lbSize _eventLocationList) - 1,"kavalaToPyrgos"];

		_eventLocationList lbAdd "Kav -> Sof";
		_eventLocationList lbSetData [(lbSize _eventLocationList) - 1,"kavalaToSofia"];

		_eventLocationList lbAdd "Kav -> Ath";
		_eventLocationList lbSetData [(lbSize _eventLocationList) - 1,"kavalaToAthira"];

		_eventLocationList lbAdd "Pyr -> Kav";
		_eventLocationList lbSetData [(lbSize _eventLocationList) - 1,"pyrgosToKavala"];

		_eventLocationList lbAdd "Pyr -> Sof";
		_eventLocationList lbSetData [(lbSize _eventLocationList) - 1,"pyrgosToSofia"];

		_eventLocationList lbAdd "Pyr -> Ath";
		_eventLocationList lbSetData [(lbSize _eventLocationList) - 1,"pyrgosToAthira"];

		_eventLocationList lbAdd "Ath -> Pyr";
		_eventLocationList lbSetData [(lbSize _eventLocationList) - 1,"athiraToPyrgos"];

		_eventLocationList lbAdd "Ath -> Sof";
		_eventLocationList lbSetData [(lbSize _eventLocationList) - 1,"athiraToSofia"];

		_eventLocationList lbAdd "Ath -> Kav";
		_eventLocationList lbSetData [(lbSize _eventLocationList) - 1,"athiraToKavala"];

		_eventLocationList lbAdd "Sof -> Kav";
		_eventLocationList lbSetData [(lbSize _eventLocationList) - 1,"sofiaToKavala"];

		_eventLocationList lbAdd "Sof -> Pyr";
		_eventLocationList lbSetData [(lbSize _eventLocationList) - 1,"sofiaToPyrgos"];

		_eventLocationList lbAdd "Sof -> Ath";
		_eventLocationList lbSetData [(lbSize _eventLocationList) - 1,"sofiaToAthira"];

		_eventLocationList lbAdd "Terminal Drag";
		_eventLocationList lbSetData [(lbSize _eventLocationList) - 1,"terminalDragRace"];
	};

	case "escort": {
		_eventLocationList lbAdd "My Position";
		_eventLocationList lbSetData [(lbSize _eventLocationList) - 1,"myPosition"];
	};

	case "lastman": {
		_eventLocationList lbAdd "Main LMS Island";
		_eventLocationList lbSetData [(lbSize _eventLocationList) - 1,"makrynisiLMS"];
	};

	case "dogfight": {
		_eventLocationList lbAdd "Main Airport";
		_eventLocationList lbSetData [(lbSize _eventLocationList) - 1,"mainAirport"];

		_eventLocationList lbAdd "Salt Airport";
		_eventLocationList lbSetData [(lbSize _eventLocationList) - 1,"saltAirport"];
	};

	case "ctf": {
		_eventLocationList lbAdd "Storage Facility";
		_eventLocationList lbSetData [(lbSize _eventLocationList) - 1,"Storage Facility"];

		_eventLocationList lbAdd "Ruins";
		_eventLocationList lbSetData [(lbSize _eventLocationList) - 1,"Ruins"];

	};

	case "roulette": {
		_eventLocationList lbAdd "Dome";
		_eventLocationList lbSetData [(lbSize _eventLocationList) - 1,"myLocation"];
	};

	case "tankbattle": {
		_eventLocationList lbAdd "Salt Airport";
		_eventLocationList lbSetData [(lbSize _eventLocationList) - 1,"saltAirport"];
	};

	default {};
};

_eventLocationList lbSetCurSel (oev_eventMenuSelection select 1);
