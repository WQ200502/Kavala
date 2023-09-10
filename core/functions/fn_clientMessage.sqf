// File: fn_clientMessage.sqf
if(isServer) exitWith {};
private["_msg","_from", "_type","_req"];
_msg = param [0,"",[""]];
_from = param [1,"",[""]]; // Who sent message
_type = param [2,-1,[0]];
_req = param [3,ObjNull,[ObjNull]];
private _cop2ems = param [4,false,[false]];
// message does not come from server (ie probably a hacker)
if (remoteExecutedOwner != 2) exitWith {};

if(_from == "" || _msg == "" || _type == -1) exitWith {};

	//Took code below from AgentRev on BI's Wiki
	private _encodeText =
	{
		private _specialChars = [38, 60, 62, 34, 39]; //  & < > " '
		private _convertTo = [[38,97,109,112,59], [38,108,116,59], [38,103,116,59], [38,113,117,111,116,59], [38,97,112,111,115,59]]; //  &amp; &lt; &gt; &quot; &apos;
		private _chars = [];
		private "_i";
		{
			_i = _specialChars find _x;
			if (_i isEqualTo -1) then { _chars pushBack _x } else { _chars append (_convertTo select _i) };
		} forEach toArray param [0,"",[""]];
		toString _chars
	};
	//Took code above from AgentRev on BI's Wiki

switch (_type) do {
	case 0: {
		private "_message";
		_msg = _msg call _encodeText;
		_message = format["MESSAGE FROM %1: %2",_from,_msg];
		hint parseText format ["<t color='#FFCC00'><t size='2'><t align='center'>新消息<br/><br/><t color='#33CC33'><t align='left'><t size='1'>发送给: <t color='#ffffff'>你<br/><t color='#33CC33'>来至: <t color='#ffffff'>%1<br/><br/><t color='#33CC33'>消息内容:<br/><t color='#ffffff'>%2",_from,_msg];

		["TextMessage",[format["您收到来自的新私人消息 %1",_from]]] call bis_fnc_showNotification;
		systemChat _message;
		player setVariable ["lastMessageID",_req,false];
		_hint = player getVariable "lastMessageID";
	};

	case 1: {
		if(side player != west) exitWith {};
		private "_message";
		_msg = _msg call _encodeText;
		_message = format["A.P.D. DISPATCH FROM %1: %2",_from,_msg];
		hint parseText format ["<t color='#316dff'><t size='2'><t align='center'>新派遣<br/><br/><t color='#33CC33'><t align='left'><t size='1'>发送给: <t color='#ffffff'>所有人员<br/><t color='#33CC33'>来至: <t color='#ffffff'>%1<br/><br/><t color='#33CC33'>消息内容:<br/><t color='#ffffff'>%2",_from,_msg];

		if (!((getMarkerPos format["%1_marker",_req]) isEqualTo [0,0,0])) then {
			private _markName = format["%1_marker",_req];
			deleteMarkerLocal _markName;
			player setVariable [_markName,true,false];
		};
		_marker = createMarkerLocal [format["%1_marker",_req],visiblePositionASL _req];
		_marker setMarkerColorLocal "ColorBlue";
		_marker setMarkerTypeLocal "Mil_dot";
		_marker setMarkerTextLocal format["%1 请求911急救", _req getVariable["realname",name _req]];

		[format["%1_marker",_req]] spawn{
			_marName = param [0,"",[""]];
			private _exit = false;
			for "_i" from 1 to 60 do {
				uiSleep 5;
				if (player getVariable [_marName,false]) exitWith {_exit = true; player setVariable [_marName,nil]};
			};
			if (_exit) exitWith {};
			deleteMarkerLocal _marName;
		};

		["PoliceDispatch",[format["新的警方报告来自: %1",_from]]] call bis_fnc_showNotification;
		systemChat _message;
	};

	case 2: {
		if(isNil "life_adminlevel") exitWith {};
		if((call life_adminlevel) < 1) exitWith {};
		if (oev_streamerMode) exitWith {};
		private "_message";
		_msg = _msg call _encodeText;
		_message = format["工作人员请求 %1: %2",_from,_msg];
		hint parseText format ["<t color='#ffcefe'><t size='2'><t align='center'>工作人员请求<br/><br/><t color='#33CC33'><t align='left'><t size='1'>发送给: <t color='#ffffff'>Olympus Staff<br/><t color='#33CC33'>来至: <t color='#ffffff'>%1<br/><br/><t color='#33CC33'>消息内容:<br/><t color='#ffffff'>%2",_from,_msg];

		_marker = createMarkerLocal [format["%1_marker",_req],visiblePositionASL _req];
		_marker setMarkerColorLocal "ColorRed";
		_marker setMarkerTypeLocal "Mil_dot";
		_marker setMarkerTextLocal format["%1 请求人员", _req getVariable["realname",name _req]];

		[format["%1_marker",_req]] spawn{
			_marName = param [0,"",[""]];
			uiSleep 300;
			deleteMarkerLocal _marName;
		};

		["AdminDispatch",[format["%1 已请求工作人员！",_from]]] call bis_fnc_showNotification;
		systemChat _message;
	};

	case 3: {
		private "_message";
		_message = format["员工消息: %1",_msg];
		_admin = format["由工作人员发送: %1", _from];
		hint parseText format ["<t color='#FF0000'><t size='2'><t align='center'>员工消息<br/><br/><t color='#33CC33'><t align='left'><t size='1'>发送给: <t color='#ffffff'>You<br/><t color='#33CC33'>来至: <t color='#ffffff'>西海岸员工<br/><br/><t color='#33CC33'>消息内容:<br/><t color='#ffffff'>%1",_msg];

		["AdminMessage",["您收到了一个工作人员的消息！"]] call bis_fnc_showNotification;
		systemChat _message;
		if(isNil "life_adminlevel") exitWith {};
		if((call life_adminlevel) > 0) then {systemChat _admin;};
	};

	case 4: {
		private ["_message","_admin"];
		_message = format["员工消息: %1",_msg];
		_admin = format["由工作人员发送: %1", _from];
		hint parseText format ["<t color='#FF0000'><t size='2'><t align='center'>员工消息<br/><br/><t color='#33CC33'><t align='left'><t size='1'>发送给: <t color='#ffffff'>所有玩家<br/><t color='#33CC33'>来至: <t color='#ffffff'>西海岸员工<br/><br/><t color='#33CC33'>消息内容:<br/><t color='#ffffff'>%1",_msg];

		["AdminMessage",["您收到了一个工作人员的消息！"]] call bis_fnc_showNotification;
		systemChat _message;
		if(isNil "life_adminlevel") exitWith {};
		if((call life_adminlevel) > 0) then {systemChat _admin;};
	};

	case 5: {
		if (oev_newsTeam) exitWith {};
		if(side player != independent) exitWith {hint "没有派遣给您";};
		private "_message";
		_msg = _msg call _encodeText;
		_message = format["来自的R.N.R请求 %1: %2",_from,_msg];
		if (_cop2ems) then {
			hint parseText format ["<t color='#316dff'><t size='2'><t align='center'>R.N.R. Request<br/><br/><t color='#33CC33'><t align='left'><t size='1'>发送给: <t color='#ffffff'>全部R.N.R. 单位<br/><t color='#33CC33'>来至: <t color='#316dff'>%1 [APD 人员]<br/><br/><t color='#33CC33'>消息内容:<br/><t color='#ffffff'>%2",_from,_msg];

			if (!((getMarkerPos format["%1_marker_ems",_req]) isEqualTo [0,0,0])) then {
				private _markName = format["%1_marker_ems",_req];
				deleteMarkerLocal _markName;
				player setVariable [_markName,true,false];
			};
			_marker = createMarkerLocal [format["%1_marker_ems",_req],visiblePositionASL _req];
			_marker setMarkerColorLocal "ColorBlue";
			_marker setMarkerTypeLocal "o_maint";
			_marker setMarkerTextLocal format["%1 请求R.N.R. [APD 人员]", _req getVariable["realname",name _req]];

			[format["%1_marker_ems",_req]] spawn{
				_marName = param [0,"",[""]];
				private _exit = false;
				for "_i" from 1 to 60 do {
					uiSleep 5;
					if (player getVariable [_marName,false]) exitWith {_exit = true; player setVariable [_marName,nil]};
				};
				if (_exit) exitWith {};
				deleteMarkerLocal _marName;
			};

			["TextMessage",[format["来自%1的R.N.R.请求",_from]]] call bis_fnc_showNotification;
			systemChat _message;

		} else {
			hint parseText format ["<t color='#FFCC00'><t size='2'><t align='center'>R.N.R.请求<br/><br/><t color='#33CC33'><t align='left'><t size='1'>发送给: <t color='#ffffff'>所有R.N.R.人员<br/><t color='#33CC33'>来至: <t color='#ffffff'>%1<br/><br/><t color='#33CC33'>消息内容:<br/><t color='#ffffff'>%2",_from,_msg];

			if (!((getMarkerPos format["%1_marker_ems",_req]) isEqualTo [0,0,0])) then {
				private _markName = format["%1_marker_ems",_req];
				deleteMarkerLocal _markName;
				player setVariable [_markName,true,false];
			};
			_marker = createMarkerLocal [format["%1_marker_ems",_req],visiblePositionASL _req];
			_marker setMarkerColorLocal "ColorYellow";
			_marker setMarkerTypeLocal "o_maint";
			_marker setMarkerTextLocal format["%1请求R.N.R。", _req getVariable["realname",name _req]];

			[format["%1_marker_ems",_req]] spawn{
				_marName = param [0,"",[""]];
				private _exit = false;
				for "_i" from 1 to 60 do {
					uiSleep 5;
					if (player getVariable [_marName,false]) exitWith {_exit = true; player setVariable [_marName,nil]};
				};
				if (_exit) exitWith {};
				deleteMarkerLocal _marName;
			};

			["TextMessage",[format["来自%1的R.N.R.请求",_from]]] call bis_fnc_showNotification;
			systemChat _message;
		};
	};
	case 7: {
		private "_message";
		_message = format["事件通知: %1",_msg];
		hint parseText format ["<t color='#00CCCC'><t size='2'><t align='center'>事件消息<br/><br/><t color='#33CC33'><t align='left'><t size='1'>发送给: <t color='#ffffff'>All Players<br/><t color='#33CC33'>来至: <t color='#ffffff'>%1<br/><br/><t color='#33CC33'>消息内容:<br/><t color='#ffffff'>%2",_from,_msg];

		["TextMessage",[format["来自%1的事件消息",_from]]] call bis_fnc_showNotification;
	};

	case 8: {
		if(((player getVariable ["isInEvent",["no"]]) select 0) == "no") exitWith {};
		private["_message"];
		_message = format["事件通知: %1",_msg];
		hint parseText format ["<t color='#00CCCC'><t size='2'><t align='center'>事件消息<br/><br/><t color='#33CC33'><t align='left'><t size='1'>发送给: <t color='#ffffff'>All Participants<br/><t color='#33CC33'>来至: <t color='#ffffff'>%1<br/><br/><t color='#33CC33'>消息内容:<br/><t color='#ffffff'>%2",_from,_msg];

		["TextMessage",[format["来自%1的事件消息",_from]]] call bis_fnc_showNotification;
	};

	case 9: {
		if(side player != west) exitWith {};
		private "_message";
		_message = format["紧急按钮被%1激活",_from];
		hint parseText format ["<t color='#316dff'><t size='2'><t align='center'>紧急按钮警报<br/><br/><t color='#33CC33'><t align='left'><t size='1'>发送给: <t color='#ffffff'>All Officers<br/><t color='#33CC33'>来至: <t color='#ffffff'>%1<br/><br/><t color='#33CC33'>消息内容:<br/><t color='#ffffff'>%2",_from,_msg];

		deleteMarkerLocal (format["%1_marker",_req]);
		_marker = createMarkerLocal [format["%1_marker",_req],visiblePositionASL _req];
		_marker setMarkerColorLocal "ColorBlue";
		_marker setMarkerTypeLocal "Mil_dot";
		_marker setMarkerTextLocal format["%1 - 紧急按钮启动！", _req getVariable["realname",name _req]];

		[format["%1_marker_panic",_req]] spawn{
			_marName = param [0,"",[""]];
			uiSleep 300;
			deleteMarkerLocal _marName;
		};

		["PoliceDispatch",[format["新紧急按钮激活来自：%1",_from]]] call bis_fnc_showNotification;
		systemChat _message;
	};

	case 10: {
		disableSerialization;
		["TextMessage",[format["来自%1的新RnR响应",_from]]] call bis_fnc_showNotification;
		titleText[_msg,"PLAIN DOWN"];
		systemChat _msg;

		_dispatchReply = ((findDisplay 7300) displayCtrl 7306);
		_dispatchReply ctrlSetStructuredText parseText format["<t align='center'>%1</t>",_msg];
	};

	case 11: {
		private ["_message","_admin"];
		_message = format["员工信息: %1",_msg];
		_admin = format["由工作人员发送: %1", _from];
		hint parseText format ["<t color='#FF0000'><t size='2'><t align='center'>员工消息<br/><br/><t color='#33CC33'><t align='left'><t size='1'>发送给: <t color='#ffffff'>All Civilians<br/><t color='#33CC33'>来至: <t color='#ffffff'>西海岸员工<br/><br/><t color='#33CC33'>消息内容:<br/><t color='#ffffff'>%1",_msg];

		["AdminMessage",["您收到了一个工作人员的消息！"]] call bis_fnc_showNotification;
		systemChat _message;
		if(isNil "life_adminlevel") exitWith {};
		if((call life_adminlevel) > 0) then {systemChat _admin;};
	};

	default {
		hint "文本消息错误，诊断信息已记录。";
		diag_log format["短信错误: %1", _this];

	};
};
