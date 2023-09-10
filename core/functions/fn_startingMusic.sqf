//	Author: Poseidon
//	Description: Plays a random arma sound track when a player is spawning in
private["_musicTracks","_maxPlayTime"];
_maxPlayTime = time + 60;
_musicTracks = [
	"Defcon",
	"Wasteland",
	"SkyNet",
	"AmbientTrack03_F",
	"AmbientTrack04a_F",
	"BackgroundTrack02_F",
	"LeadTrack04_F",
	"LeadTrack04a_F",
	"LeadTrack05_F",
	"LeadTrack06_F",
	"Track12_StageC_action",
	"LeadTrack02_F_EPA",
	"LeadTrack03_F_EPA",
	"EventTrack02_F_EPA"
];

3 fadeMusic 0.4;

playMusic (_musicTracks call BIS_fnc_selectRandom);

waitUntil{time > _maxPlayTime || !dont_respawn_yet};
if(BIS_fnc_establishingShot_playing) then {
	waitUntil{!BIS_fnc_establishingShot_playing};
};

sleep 10;
5 fadeMusic 0;//Fade music out
sleep 5;
playMusic "";//Stop playing music
0 fadeMusic 1;//Turn music volume back up
