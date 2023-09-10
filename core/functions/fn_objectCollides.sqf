//  File: fn_objectIntersects.sqf
//	Author: Ozadu
//	Description:
//		Determines whether a given object collides with any other object, for spawning new objects
//		Average runtime: 	sports hatch - 5ms
//							offroad - 10ms
//							hemtt box - 24ms
//							huron - 381ms
//	Params:
//		_obj, the object to check
//	Returns:
//		true if the object collides with another object
//		false if the object does not collide with another object

params[["_obj",objNull,[objNull]]];

/*Credit to Killzone kid for this function, he is the real hero*/
_bb = {
	_bbx = [_this select 0 select 0, _this select 1 select 0];
	_bby = [_this select 0 select 1, _this select 1 select 1];
	_bbz = [_this select 0 select 2, _this select 1 select 2];
	_bbx sort true;
	_bby sort true;
	_bbz sort true;

	_xPoints = [];
	_yPoints = [];
	_zPoints = [];
	_i = _bbx select 0;
	while{_i < (_bbx select 1)} do {
		_xPoints pushBack _i;
		_i = _i + 1;
	};
	_i = _bby select 0;
	while{_i < (_bby select 1)} do {
		_yPoints pushBack _i;
		_i = _i + 1;
	};
	_i = _bbz select 0;
	while{_i < (_bbz select 1)} do {
		_zPoints pushBack _i;
		_i = _i + 1;
	};
	_arr = [];
	0 = {
		_y = _x;
		0 = {
			_z = _x;
			0 = {
				0 = _arr pushBack (_obj modelToWorld [_x,_y,_z]);
			} count _bbx;
		} count _bbz;
	} count _bby;
	{
		_y = _x;
		{
			_z = _x;
			{
				0 = _arr pushBack (_obj modelToWorld [_x,_y,_z]);
			} forEach _xPoints;
		} forEach _zPoints;
	} forEach _yPoints;
	_arr
};
_box = 0 boundingBoxReal _obj call _bb;
_lines = [];
for "_i" from 0 to 7 do {
	for "_j" from _i+1 to (count _box) - 1 do {
			_lines pushBack[_box select _i,_box select _j];
	};
};

//debug
/*
lines = _lines;
onEachFrame {
	{
		drawLine3D [_x select 0, _x select 1, [1,0,0,1]];
	} forEach lines;
};
*/
//debug

_intersects = false;
{
	if(lineIntersects [AGLToASL (_x select 0),AGLToASL (_x select 1),_obj]) exitWith {
		_intersects = true;
	};
} forEach _lines;
_intersects
