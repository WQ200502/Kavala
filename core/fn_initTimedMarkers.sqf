/*
    This borrows HEAVILY (read: nigh copy-paste) from S3Savage's (of EUTW) TimeMarkers addon.
    https://github.com/milaq/arma3_timemarkers/blob/master/init.sqf
*/
oev_markerTSEnabled = false;
[] spawn{
    if !(hasInterface) exitWith {};
    waitUntil {!(isNull player)};
    oev_markerTSEnabled = profileNamespace getVariable ["life_markerTSEnabled", false];
    waitUntil {!isNull findDisplay 12};
    findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["MouseButtonDblClick", {
        [] spawn{
            private ["_padding", "_markerDialog", "_ok", "_okPos", "_cancel", "_cancelPos", "_height", "_width", "_extender", "_checkbox", "_desc"];
            disableSerialization;
            waitUntil {!isNull findDisplay 54};
            _markerDialog = findDisplay 54;
            _padding = 0.002 / (getResolution select 5);
            waitUntil {ctrlEnabled (_markerDialog displayCtrl 1)};
            _ok = _markerDialog displayCtrl 1;
            _cancel = _markerDialog displayCtrl 2;
            sleep 0.01;

            _okPos = ctrlPosition _ok;
            _cancelPos = ctrlPosition _cancel;
            _height = _okPos select 3;
            _width = (abs ((_cancelPos select 0) - (_okPos select 0))) + (_cancelPos select 2);

            _ok ctrlSetPosition [_okPos select 0, (_okPos select 1) + _height + _padding];
            _cancel ctrlSetPosition [_cancelPos select 0, (_cancelPos select 1) + _height + _padding];
            { _x ctrlCommit 0; } forEach [_ok, _cancel];

			_extender = [
				_markerDialog, "IGUIBack", -1, controlNull,
				[_okPos select 0, _okPos select 1, _width, _height],
				[0, 0, 0, 0.75]
			] call OEC_fnc_ctrlCreate;

			_checkbox = [
				_markerDialog, "RscCheckBox", -1, controlNull,
				[_okPos select 0, _okPos select 1],
				[0, 0, 0, 0]
			] call OEC_fnc_ctrlCreate;
            _checkbox cbSetChecked oev_markerTSEnabled;
            _checkbox ctrlSetScale (getResolution select 5);
            _checkbox ctrlCommit 0;
            _checkbox ctrlAddEventHandler ["CheckedChanged", {
                oev_markerTSEnabled = ((_this select 1) == 1);
                profileNamespace setVariable ["oev_markerTSEnabled", life_markerTSEnabled];
                saveProfileNamepace;
            }];

			_desc = [
				_markerDialog, "RscText", -1, controlNull,
				[(_okPos select 0) + _height - 0.015, _okPos select 1],
				[0, 0, 0, 0],
				false,
				"Add timestamp"
			] call OEC_fnc_ctrlCreate;
            _desc ctrlSetScale 0.75;
            _desc ctrlCommit 0;

            _ok ctrlAddEventHandler ["ButtonClick", {
                if (oev_markerTSEnabled) then {
                    private _markerDesc = findDisplay 54 displayCtrl 101;
                    private _time = [] call OEC_fnc_timeUntilRestart;
                    private _markerText = ctrlText _markerDesc;
                    _markerText = format ["%1 [%2min]", _markerText, _time];
                    _markerDesc ctrlSetText _markerText;
                };
                false
            }];
        };
    }];
};
