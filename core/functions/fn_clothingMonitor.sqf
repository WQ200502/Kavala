//	Author: Poseidon
//	Description: Uniform texturing system DESCRIPTIONEND

private["_lastUpdatedUniform","_lastUpdatedBackpack","_lastUniformTexture","_lastBackpackTexture","_uniformTexture","_backpackTexture","_updateSkins"];
_lastUpdatedUniform = objNull;
_lastUpdatedBackpack = objNull;
_lastUniformTexture = "";
_lastBackpackTexture = "";
_uniformTexture = "";
_backpackTexture = "";
_updateSkins = false;

sleep 3;

while{true} do {
	waitUntil{(uniformContainer player != _lastUpdatedUniform) || (backpackContainer player != _lastUpdatedBackpack)};
	_uniformTexture = (getObjectTextures player) select 0;
	_backpackTexture = (getObjectTextures (unitBackpack player)) select 0;

	if(!isNull (uniformContainer player)) then {
		if(_lastUpdatedUniform != (uniformContainer player)) then {
			_lastUpdatedUniform = (uniformContainer player);
			_updateSkins = true;
		};
	};

	if(!isNull (backpackContainer player)) then {
		if(_lastUpdatedBackpack != (backpackContainer player)) then {
			_lastUpdatedBackpack = (backpackContainer player);
			_updateSkins = true;
		};
	};

	if(_updateSkins) then {
		_updateSkins = false;
		[player] call OEC_fnc_skinUniform;
	};
	sleep 1;
};