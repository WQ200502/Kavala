// File: fn_votingBooth.sqf
// Author:Ozadu
// Handle voting booth

private["_voteList","_descriptionText","_voteButton"];
params[
	["_mode","",[""]]
];

if (O_stats_playtime_civ < 1680) exitWith {closeDialog 0; hint "如果你有超过1680分钟的时间，你只能在平民代表选举中投票！";};
if !(life_voting_active) exitWith {closeDialog 0; hint "投票于本月1日结束！对不起的！看看论坛，看看谁是新当选的平民代表！";};

/*Data received from server*/
if(_mode == "data") exitWith {
	_votes = param[1,[],[[]]];
	_temp = [];
	{
		_temp pushBack (_x select 1);
	} forEach _votes;
	life_votes = _temp;
};

disableSerialization;
waitUntil{!isNull findDisplay 99111};
_voteList = ((findDisplay 99111) displayCtrl 99112);
_descriptionText = ((findDisplay 99111) displayCtrl 99113);
_voteButton = ((findDisplay 99111) displayCtrl 99115);
_fileContents = loadFile "voteCandidates.txt";
_candidates = call compile _fileContents;
hint parseText "你所看到的候选人正在竞选西海岸的民事代表职位。这是一个游戏外的立场，是申请论坛每2个月。这些人将负责代表平民。你有两张票，所以仔细挑选你想投给哪两个人。一旦提交，您不能更改您的投票<br/><br/>更多信息可以在我们的网站上找到：西海岸-娱乐网";

switch(_mode) do {

	/*Initial set up for the voting booth*/
	case "setup":{
		_voteButton ctrlShow false;
		if(isNil "life_votes") then {
			[[player,"data"],"OES_fnc_votingBoothServer",false] call OEC_fnc_MP;
			waitUntil{!isNil "life_votes"};
		};

		if(count (life_votes) > 1) exitWith {closeDialog 0; hint "你已经投票了。"};

		_count = 0;
		for "_i" from 0 to ((count _candidates)-1) do{
			_candidate = _candidates select _i;
			_candidateName = _candidate select 0;
			_candidateId = _candidate select 1;
			if(!(_candidateId in life_votes)) then {
				_voteList lbAdd (_candidateName);
				_voteList lbSetData[_count,_candidateId];
				_count = _count + 1;
			};
		};
	};

	/*On candidate list selection*/
	case "LBSelChanged":{
		_selected = lbCurSel _voteList;
		_pid = _voteList lbData _selected;
		_description = "";
		for "_i" from 0 to ((count _candidates)-1) do {
			_candidate = _candidates select _i;
			_candidateId = _candidate select 1;
			_candidateDescription = _candidate select 2;
			if(_candidateId == _pid) exitWith {
				_description = _candidateDescription;
			};
		};
		_descriptionText ctrlSetStructuredText parseText format ["<t size='0.75'>%1</t>",_description];
		_voteButton ctrlShow true;
	};

	/*Vote button clicked*/
	case "vote":{
		_selected = lbCurSel _voteList;
		_pid = _voteList lbData _selected;
		[[player,"vote",_pid],"OES_fnc_votingBoothServer",false] call OEC_fnc_MP;
		life_votes pushBack _pid;
		closeDialog 0;
	};
};