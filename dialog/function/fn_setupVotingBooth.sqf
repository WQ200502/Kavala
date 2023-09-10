// File: fn_setupVotingBooth.sqf
// Author:Ozadu
// Sets up all the voting data

private["_voteList","_descriptionText","_voteButton"];
disableSerialization;
waitUntil{!isNull findDisplay 99111};
_voteList = ((findDisplay 99111) displayCtrl 99112);
_descriptionText = ((findDisplay 99111) displayCtrl 99113);
_voteButton = ((findDisplay 99111) displayCtrl 99115);

//hide vote button
_yesButton ctrlShow false;

_fileContents = loadFile "../../voteCandidates.txt";
_candidates = _fileContents splitString "\n";

for "_i" from 0 to (count _candidates)-1 do{
	_voteList lbAdd (_candidates select 0);
};