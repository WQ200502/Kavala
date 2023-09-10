// File: fn_realCollide.sqf
// Author: Fraali
// Desc: Creates custom bounding box
// Usage: [Object, [x offset,y offset,z offset], (Optional) Boolean if terrain should return collision] call OEC_fnc_realCollide;
// Returns: True/False depending on collision with another object

params [
  ["_obj", objNull, [objNull]],
  ["_offset", [0.5,0.5,0.5], [[]]],
  ["_terrain", false,[false]]
];
_xOff = _offset select 0;
_yOff = _offset select 1;
_zOff = _offset select 2;
_ASL = getPosASL _obj;
_dir = -(getDir _obj);
_return = false;

_lines = [
//Bottom of Model
[[cos(_dir) * (-_xOff) - sin(_dir) * (_yOff) + (_ASL select 0), sin(_dir) * (-_xOff) + cos(_dir) * (_yOff) + (_ASL select 1), _ASL select 2],
[cos(_dir) * (-_xOff) - sin(_dir) * (-_yOff) + (_ASL select 0), sin(_dir) * (-_xOff) + cos(_dir) * (-_yOff) + (_ASL select 1), _ASL select 2]],
[[cos(_dir) * (_xOff) - sin(_dir) * (_yOff) + (_ASL select 0), sin(_dir) * (_xOff) + cos(_dir) * (_yOff) + (_ASL select 1), _ASL select 2],
[cos(_dir) * (-_xOff) - sin(_dir) * (_yOff) + (_ASL select 0), sin(_dir) * (-_xOff) + cos(_dir) * (_yOff) + (_ASL select 1), _ASL select 2]],
[[cos(_dir) * (_xOff) - sin(_dir) * (_yOff) + (_ASL select 0), sin(_dir) * (_xOff) + cos(_dir) * (_yOff) + (_ASL select 1), _ASL select 2],
[cos(_dir) * (_xOff) - sin(_dir) * (-_yOff) + (_ASL select 0), sin(_dir) * (_xOff) + cos(_dir) * (-_yOff) + (_ASL select 1), _ASL select 2]],
[[cos(_dir) * (_xOff) - sin(_dir) * (-_yOff) + (_ASL select 0), sin(_dir) * (_xOff) + cos(_dir) * (-_yOff) + (_ASL select 1), _ASL select 2],
[cos(_dir) * (-_xOff) - sin(_dir) * (-_yOff) + (_ASL select 0), sin(_dir) * (-_xOff) + cos(_dir) * (-_yOff) + (_ASL select 1), _ASL select 2]],
//Corners of Model
[[cos(_dir) * (_xOff) - sin(_dir) * (-_yOff) + (_ASL select 0), sin(_dir) * (_xOff) + cos(_dir) * (-_yOff) + (_ASL select 1), (_ASL select 2)],
[cos(_dir) * (_xOff) - sin(_dir) * (-_yOff) + (_ASL select 0), sin(_dir) * (_xOff) + cos(_dir) * (-_yOff) + (_ASL select 1), (_ASL select 2) + _zOff]],
[[cos(_dir) * (-_xOff) - sin(_dir) * (-_yOff) + (_ASL select 0), sin(_dir) * (-_xOff) + cos(_dir) * (-_yOff) + (_ASL select 1), (_ASL select 2)],
[cos(_dir) * (-_xOff) - sin(_dir) * (-_yOff) + (_ASL select 0), sin(_dir) * (-_xOff) + cos(_dir) * (-_yOff) + (_ASL select 1), (_ASL select 2) + _zOff]],
[[cos(_dir) * (_xOff) - sin(_dir) * (_yOff) + (_ASL select 0), sin(_dir) * (_xOff) + cos(_dir) * (_yOff) + (_ASL select 1), (_ASL select 2)],
[cos(_dir) * (_xOff) - sin(_dir) * (_yOff) + (_ASL select 0), sin(_dir) * (_xOff) + cos(_dir) * (_yOff) + (_ASL select 1), (_ASL select 2) + _zOff]],
[[cos(_dir) * (-_xOff) - sin(_dir) * (_yOff) + (_ASL select 0), sin(_dir) * (-_xOff) + cos(_dir) * (_yOff) + (_ASL select 1), (_ASL select 2)],
[cos(_dir) * (-_xOff) - sin(_dir) * (_yOff) + (_ASL select 0), sin(_dir) * (-_xOff) + cos(_dir) * (_yOff) + (_ASL select 1), (_ASL select 2) + _zOff]],
//Top of Model
[[cos(_dir) * (-_xOff) - sin(_dir) * (_yOff) + (_ASL select 0), sin(_dir) * (-_xOff) + cos(_dir) * (_yOff) + (_ASL select 1), (_ASL select 2) + _zOff],
[cos(_dir) * (-_xOff) - sin(_dir) * (-_yOff) + (_ASL select 0), sin(_dir) * (-_xOff) + cos(_dir) * (-_yOff) + (_ASL select 1), (_ASL select 2) + _zOff]],
[[cos(_dir) * (_xOff) - sin(_dir) * (_yOff) + (_ASL select 0), sin(_dir) * (_xOff) + cos(_dir) * (_yOff) + (_ASL select 1), (_ASL select 2) + _zOff],
[cos(_dir) * (-_xOff) - sin(_dir) * (_yOff) + (_ASL select 0), sin(_dir) * (-_xOff) + cos(_dir) * (_yOff) + (_ASL select 1), (_ASL select 2) + _zOff]],
[[cos(_dir) * (_xOff) - sin(_dir) * (_yOff) + (_ASL select 0), sin(_dir) * (_xOff) + cos(_dir) * (_yOff) + (_ASL select 1), (_ASL select 2) + _zOff],
[cos(_dir) * (_xOff) - sin(_dir) * (-_yOff) + (_ASL select 0), sin(_dir) * (_xOff) + cos(_dir) * (-_yOff) + (_ASL select 1), (_ASL select 2) + _zOff]],
[[cos(_dir) * (_xOff) - sin(_dir) * (-_yOff) + (_ASL select 0), sin(_dir) * (_xOff) + cos(_dir) * (-_yOff) + (_ASL select 1), (_ASL select 2) + _zOff],
[cos(_dir) * (-_xOff) - sin(_dir) * (-_yOff) + (_ASL select 0), sin(_dir) * (-_xOff) + cos(_dir) * (-_yOff) + (_ASL select 1), (_ASL select 2) + _zOff]]
];
{
  //DEBUG
  //drawLine3D [ASLToAGL (_x select 0),ASLToAGL (_x select 1), [0,1,0,1]];
  //DEBUG
  _intersect = lineIntersectsSurfaces [_x select 0, _x select 1, _obj];
  if !(_intersect isEqualTo []) then {
    if !(_terrain) then {
      if !(_intersect select 0 select 2 isEqualTo objNull) exitWith {_return = true;};
    } else {
      _return = true;
    };
  };
  if(_return) exitWith {};
}forEach _lines;

_return;
