class yMenuIcons: yMenuBase{
	idd = 87432;
	onLoad = "[2] spawn OEC_fnc_hexIconMaster;";

	class controlsBackground: controlsBackgroundBase {
		class Background: BaseBackground{};
		class Title: BaseTitle{
			text = "十六进制图标菜单";
		};

		class Tab1PictureBackground: BaseTab1PictureBackground{};
		class Tab2PictureBackground: BaseTab2PictureBackground{};
		class Tab3PictureBackground: BaseTab3PictureBackground{};
		class Tab4PictureBackground: BaseTab4PictureBackground{};
		class Tab5PictureBackground: BaseTab5PictureBackground{};
		class Tab6PictureBackground: BaseTab6PictureBackground{};
		class Tab7PictureBackground: BaseTab7PictureBackground{};
		class Tab8PictureBackground: BaseTab8PictureBackground{};
		class Tab9PictureBackground: BaseTab9PictureBackground{};
		class Tab10PictureBackground: BaseTab10PictureBackground{};
		class Tab11PictureBackground: BaseTab11PictureBackground{};
		class Tab12PictureBackground: BaseTab12PictureBackground{};
		class Tab1Picture: BaseTab1Picture{};
		class Tab2Picture: BaseTab2Picture{};
		class Tab3Picture: BaseTab3Picture{};
		class Tab4Picture: BaseTab4Picture{};
		class Tab5Picture: BaseTab5Picture{};
		class Tab6Picture: BaseTab6Picture{};
		class Tab7Picture: BaseTab7Picture{};
		class Tab8Picture: BaseTab8Picture{};
		class Tab9Picture: BaseTab9Picture{};
		class Tab10Picture: BaseTab10Picture{};
		class Tab11Picture: BaseTab11Picture{};
		class Tab12Picture: BaseTab12Picture{};

		class ItemsIcons: Life_RscTitle {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			idc = 79453;
			text = "群组十六进制图标";
			sizeEx = 0.04;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.20;
			w = 0.46;
			h = 0.04;
		};
		class InformationIcons: Life_RscTitle {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			idc = 89564;
			text = "信息";
			sizeEx = 0.04;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.56 + 0.08;
			w = 0.46;
			h = 0.04;
		};
	};

	class controls: controlsBase {
		class Tab1: BaseTab1{};
		class Tab2: BaseTab2{};
		class Tab3: BaseTab3{};
		class Tab4: BaseTab4{};
		class Tab5: BaseTab5{};
		class Tab6: BaseTab6{};
		class Tab7: BaseTab7{};
		class Tab8: BaseTab8{};
		class Tab9: BaseTab9{};
		class Tab10: BaseTab10{};
		class Tab11: BaseTab11{};
		class Tab12: BaseTab12{};

		class IconList: Life_RscListBox {
			idc = 95674;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.25;
			w = 0.46;
			h = 0.39;
			onLBSelChanged = "[1] spawn OEC_fnc_hexIconMaster;";
			sizeEx = 0.035;
		};
		class hexIconsDescription: Life_RscText {
			idc = 86976;
			text = "选择一个十六进制图标，或随机兑换一个！";
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.69;
			w = 0.96;
			h = 0.04;
			sizeEx = 0.035;
		};
		class ButtonChangeIcon: BaseButtonClose {
			idc = 45357;
			text = "装备";
			x = (safeZoneX + safeZoneW) - 0.22;
			y = 0.78;
			w = 0.21;
			h = 0.0475; //.075
			onButtonClick = "[0] spawn OEC_fnc_hexIconMaster;";
		};
		class ButtonUnlockIcons: BaseButtonClose {
			idc = 78609;
			text = "解锁图标";
			x = (safeZoneX + safeZoneW) - 0.22;
			y = 0.84;
			w = 0.21;
			h = 0.0475; //.075
			onButtonClick = "['unlockIconsMenu'] call OEC_fnc_createDialog;";
		};
		class ButtonClose: BaseButtonClose {
			idc = -1;
			text = "关闭";
			onButtonClick = "[87432, 'right', false] spawn OEC_fnc_animateDialog;";
		};
		class IconPreview: Life_RscPicture {
			idc = 874539;
			text = "images\icons\groupIcon.paa";
			x = (safeZoneX + safeZoneW) - 0.41;
			y = 0.75;
			w = 0.1125;
			h = 0.1125 * 4 / 3;
		};
	};
};

class unlockIconsMenu  {
	idd = 795742;
	onLoad = "[] spawn OEC_fnc_rollMenuUpdate";
	class controlsBackground {
		class life_RscTitleBackground: Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0.025;
			y = 0.19 - (1 / 25);
			w = 0.95;
			h = (1 / 25);
		};
		class MainBackground: Life_RscText {
			colorBackground[] = {0.1,0.1,0.1,0.8};
			idc = -1;
			x = 0.025;
			y = 0.19;
			w = 0.95;
			h = 0.66;
		};
		class Title: Life_RscTitle {
			colorBackground[] = {0,0,0,0};
			idc = -1;
			text = "解锁十六进制图标";
			x = 0.025;
			y = 0.19 - (1 / 25);
			w = 0.95;
			h = (1 / 25);
		};
	};

	class controls {
		class backButton: Life_RscButtonMenu {
			idc = 08987;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "返回";
			onButtonClick = "['yMenuSettings'] spawn OEC_fnc_createDialog;";
			x = 0.025;
			y = 0.85;
			w = 0.3125;
			h = (1 / 25);
		};
		class closeButton: Life_RscButtonMenu {
			idc = 64742;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "关闭";
			onButtonClick = "closeDialog 0;";
			x = 0.358;
			y = 0.85;
			w = 0.3125;
			h = (1 / 25);
		};
		class RedemPoints: Life_RscText {
			idc = 68432;
			text = "";
			x = 0.32;
			y = 0.23;
			w = 0.96;
			h = 0.04;
			sizeEx = 0.035;
		};
		class IconRollButton: Life_RscButton {
			idc = 675843;
			text = "随机图标";
			onButtonClick = "[3,-1] spawn OEC_fnc_hexIconMaster;";
			colorText[] = {1, 1, 1, 1.0};
			colorBackground[] = {1,0.843,0,0.8};
			colorBackgroundActive[] = {0.949,0.733,0.133,1};
			colorFocused[] = {0.949,0.733,0.133,0.8};
			colorBackgroundDisabled[] = {0.949,0.733,0.133,0.1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.55)";
			fade = 1;
			period = 1.6;
			periodFocus = 1.4;
			periodOver = 0;
			font = "PuristaSemiBold";
			x = 0.355;
			y = 0.68;
			w = 0.26;
			h = 0.055;
		};
		class treasureIcon: Life_RscPicture {
			idc = 9755321;
			text = "images\icons\treasureChest.paa";
			x = 0.365;
			y = 0.31;
			w = 0.2500;
			h = 0.2500 * 4 / 3;
		};
		class awardedIcon: Life_RscPicture {
			idc = 9745322;
			text = "";
			x = 0.43;
			y = 0.38;
			w = 0.1200;
			h = 0.1200 * 4 / 3;
		};
	};
};

//all the hex icons publicly available (no exclusive icons! add those to hexIconMaster.sqf)
class CfgIcons {
	class AHK {
				title = "AHK";
				name = "ahk";
				desc = "Is the MK-1 spread really that hard to control?";
		};
	class Anchor {
				title = "Anchor";
				name = "anchor";
				desc = "If you're really into pirate roleplay, I guess.";
		};
	class Angry {
				title = "Angry";
				name = "angry";
				desc = "Cheer up, its just a video game (smile).";
		};
	class Apple {
				title = "Apple";
				name = "apple_alt";
				desc = "Apple a day keeps the...rdm away?";
		};
	class ATM {
				title = "ATM";
				name = "atm";
				desc = "We get it, you're rich.";
		};
	class Autohover {
				title = "Autohover";
				name = "autohover";
				desc = "Consider investing in a joystick, captain.";
		};
	class Backpack {
				title = "Backpack";
				name = "backpack";
				desc = "You're the kid always running meth, aren't you?";
			};
	class Bandit {
				title = "Bandit";
				name = "bandit";
				desc = "It's a roleplay server xd, totally not wasteland.";
			};
	class Banner {
				title = "Banner";
				name = "banner";
				desc = "Not much to say, just a banner.";
			};
	class BearClaw {
				title = "Bear Claw";
				name = "bear_claw";
				desc = "We on some brother bear shit now.";
			};
	class Binos {
				title = "Binoculars";
				name = "binos";
				desc = "It's okay, combat spotter is a valuable role.";
			};
	class Biohazard {
				title = "Biohazard";
				name = "biohazard";
				desc = "You could roleplay as a zombie. Idk it looks cool.";
			};
	class Bipod {
				title = "Bipod";
				name = "bipod";
				desc = "How an AHK feels without catching a perm.";
			};
	class Blast {
				title = "Blast";
				name = "blast";
				desc = "Explosions are cool, my dog.";
			};
	class Blender {
				title = "Blender";
				name = "blender";
				desc = "By this analogy, your enemies are the fruit.";
			};
	class Blind {
				title = "Blind";
				name = "blind";
				desc = "Ray Charles out here pushing window.";
			};
	class Blood {
				title = "Blood";
				name = "blood";
				desc = "Kinda emo, but you do you.";
			};
	class Bomb {
				title = "Bomb";
				name = "bomb";
				desc = "Because you're the bomb. Not sorry.";
			};
	class Bong {
				title = "Bong";
				name = "bong";
				desc = "Satiate your munchies with some tac bacon.";
			};
	class Bug {
				title = "Bug";
				name = "bug";
				desc = "Not quite a rat, but just as nefarious.";
			};
	class Bullets {
				title = "Bullets";
				name = "bullets";
				desc = "If you don't have Parkinson's, all you need is 20.";
			};
	class Bunker {
				title = "Bunker";
				name = "bunker";
				desc = "Dick so big they call it the bunker buster.";
			};
	class Burn {
				title = "Burn";
				name = "burn";
				desc = "Agregar gasolina para mas fuego, hombre.";
			};
	class Bus {
				title = "Bus";
				name = "bus";
				desc = "Insert joke about LSD.";
			};
	class C4 {
				title = "C4";
				name = "c4";
				desc = "Plastic explosives, baby.";
		};
	class Call {
				title = "Call";
				name = "call";
				desc = "Ring Ring, omw to drop on your forehead.";
		};
	class Camera {
				title = "Camera";
				name = "camera";
				desc = "Yea you're on GoPro, enjoy the ban kiddo.";
		};
	class CameraVideo {
				title = "Video Camera";
				name = "camera_video";
				desc = "Olympus News Team is on the case.";
		};
	class Cannabis {
				title = "Cannabis";
				name = "cannabis";
				desc = "Legal in 11 states, but not Altis.";
		};
	class Car {
				title = "Car";
				name = "car";
				desc = "I'm packing extra toolkits when you drive.";
		};
	class Carrot {
				title = "Carrot";
				name = "carrot";
				desc = "Only for people who rub up on girls in the library.";
		};
	class Cat {
				title = "Cat";
				name = "cat";
				desc = "Nine lives but you still have to follow NLR.";
		};
	class CCTV {
				title = "CCTV";
				name = "cctv";
				desc = "Get your back off that wall, we're watching you.";
		};
	class Chapel {
				title = "Chapel";
				name = "chapel";
				desc = "For all you God-Fearing Altis gamers out there.";
		};
	class ChessBishop {
				title = "Chess Bishop";
				name = "chess_bishop";
				desc = "The king's right hand man. So basically rank 4.";
		};
	class ChessKing {
				title = "Chess King";
				name = "chess_king";
				desc = "Hail to the king, baby.";
		};
	class ChessKnight {
				title = "Chess Knight";
				name = "chess_knight";
				desc = "Move in L's, then give them to your enemies.";
		};
	class ChessPawn {
				title = "Chess Pawn";
				name = "chess_pawn";
				desc = "There's a reason you're the first one to hop out.";
		};
	class ChessQueen {
				title = "Chess Queen";
				name = "chess_queen";
				desc = "Command your simp army.";
		};
	class ChessRook {
				title = "Chess Rook";
				name = "chess_rook";
				desc = "1) Equip. 2) Only play castle. 3) Profit??";
		};
	class Church {
				title = "Church";
				name = "church";
				desc = "Imagine Olympus players actually fighting church.";
		};
	class CollisionLights {
				title = "Collision Lights";
				name = "collision_lights";
				desc = "Night vision for roleplayers and medics.";
		};
	class Compass {
				title = "Compass";
				name = "compass";
				desc = "Enemy. Gamer. Southwest. Bearing 254.";
		};
	class Connect {
				title = "Connect";
				name = "connect";
				desc = "Calling all roleplayers.";
		};
	class ControlPoint {
				title = "Control Point";
				name = "control_point";
				desc = "Your control point is being contested.";
		};
	class CircleTarget {
				title = "Target Circle";
				name = "cool_circle";
				desc = "Enemey spotted.";
		};
	class Ladder {
				title = "Ladder";
				name = "cool_ladder";
				desc = "The single worst combat mechanic in Arma 3.";
		};
	class Cross {
				title = "Cross";
				name = "cross";
				desc = "Light it on fire and catch a fat racism ban.";
		};
	class Cuffs {
				title = "Cuffs";
				name = "cuffs";
				desc = "I can break these cuffs.";
		};
	class Curve {
				title = "Curve";
				name = "curve";
				desc = "Get curved, play Arma, repeat.";
		};
	class Defense {
				title = "Defense";
				name = "defense";
				desc = "Ever tried pushing cap instead?";
		};
	class Dice {
				title = "Dice";
				name = "dice";
				desc = "For all you gambling addicts out there.";
		};
	class Dizzy {
				title = "Sick";
				name = "dizzy";
				desc = "Looking sick af.";
		};
	class Dog {
				title = "Dog";
				name = "dog";
				desc = "Who doesn't like dogs?";
		};
	class DogLeash {
				title = "Dog Leash";
				name = "dog_leash";
				desc = "Again with this furry shit...";
		};
	class DollarSign {
				title = "Dollar Sign";
				name = "dollar_sign";
				desc = "Please bro just 100k more I need to bet.";
		};
	class Dove {
				title = "Dove";
				name = "dove";
				desc = "Elegant. Beautiful. Pure.";
		};
	class Dragon {
				title = "Dragon";
				name = "dragon";
				desc = "Don't look up Alaskan snow dragon.";
		};
	class Driver {
				title = "Driver";
				name = "driver";
				desc = "I promise I'm not AFKing cop time.";
		};
	class Empire {
				title = "Empire";
				name = "empire";
				desc = "Bad guys in Star Wars.";
		};
	class Engine {
				title = "Engine";
				name = "engine";
				desc = "Nobody: ... Red Honda Civics at 3am: ";
		};
	class Exit {
				title = "Exit";
				name = "exit";
				desc = "Boutta hit the boosters and alt-f4.";
		};
	class Explosive {
				title = "Explosive";
				name = "explosive";
				desc = "Baby you're a firework.";
		};
	class Eye {
				title = "Eye";
				name = "eye";
				desc = "You should try opening yours sometime.";
		};
	class Face {
				title = "Face";
				name = "face";
				desc = "Side profile of your head getting ripped.";
		};
	class FighterJet {
				title = "Fighter Jet";
				name = "fighter_jet";
				desc = "2 mill and you can't even bomb cap.";
		};
	class Fire {
				title = "Fire";
				name = "fire";
				desc = "Lil Uzi's new album.";
		};
	class FireExtinguisher {
				title = "Fire Extinguisher";
				name = "fire_extinguisher";
				desc = "When I pull up to cap in the AF1s.";
		};
	class FlagLeft {
				title = "Flag";
				name = "flag_left";
				desc = "USA! USA!";
		};
	class FlagRight {
				title = "Flag (alt)";
				name = "flag_right";
				desc = "Scuffed like every country that's not the USA.";
		};
	class Flaps {
				title = "Flaps";
				name = "flaps";
				desc = "Flaps down. Your controls.";
		};
	class Fountain {
				title = "Fountain";
				name = "fountain";
				desc = "Kinda looks like a penis.";
		};
	class Gang {
				title = "Gang";
				name = "gang";
				desc = "Whole lotta gang shit.";
		};
	class Gavel {
				title = "Gavel";
				name = "gavel";
				desc = "Laying down the law, but also fuck Vigis.";
		};
	class Gear {
				title = "Gear";
				name = "gear";
				desc = "Dupe it and catch a fat perm.";
		};
	class Ghost {
				title = "Ghost";
				name = "ghost";
				desc = "AKA proning in a ghillie suit.";
		};
	class GPS {
				title = "GPS";
				name = "gps";
				desc = "Now useful for the first time since 2013.";
		};
	class Sigma {
				title = "Sigma";
				name = "sigma";
				desc = "Standard deviation. Nerd shit.";
		};
	class Grenade {
				title = "Grenade";
				name = "grenade";
				desc = "50k to get a kill without having to aim.";
		};
	class GrinHearts {
				title = "Hearts Grin";
				name = "grin_hearts";
				desc = "Me when I see bae.";
		};
	class GrinStars {
				title = "Stars Grin";
				name = "grin_stars";
				desc = "Me when I see my favorite e-girl.";
		};
	class Group1 {
				title = "Single Dot";
				name = "group1";
				desc = "Just a dot. Boring AF.";
		};
	class Group2 {
				title = "Double Dot";
				name = "group2";
				desc = "Two dots. Riveting.";
		};
	class Group3 {
				title = "Triple Dot";
				name = "group3";
				desc = "Three fucking dots.";
		};
	class Gunner {
				title = "Gunner";
				name = "gunner";
				desc = "Left gun? HELLO?!";
		};
	class Hack {
				title = "Hack";
				name = "hack";
				desc = "For l33t haxors only.";
		};
	class Hammer {
				title = "Hammer";
				name = "hammer";
				desc = "Use it on nails, or your enemies.";
		};
	class HammerWar {
				title = "War Hammer";
				name = "hammer_war";
				desc = "Lay down the lay space marine style.";
		};
	class HandMiddleFinger {
				title = "Middle Finger";
				name = "hand_middle_finger";
				desc = "To convey that fuck you kinda attitude.";
		};
	class Handgun {
				title = "Handgun";
				name = "handgun";
				desc = "Pulling up to Kavala gun store, packing that 9mm.";
		};
	class Handshake {
				title = "Handshake";
				name = "handshake";
				desc = "Truce for runs? Anyone?";
		};
	class HatCowboy {
				title = "Cowboy Hat";
				name = "hat_cowboy";
				desc = "What in tarnation.";
		};
	class HeadGear {
				title = "Head Gear";
				name = "head_gear";
				desc = "There's a reason Oly has no T5 helmet.";
		};
  class Helicopter {
				title = "Helicopter";
				name = "helicopter";
				desc = "One good hot drop and you're designated pilot.";
		};
  class Hill {
				title = "Hill";
				name = "hill_dot";
				desc = "He's on that hill. No, that other hill.";
		};
  class Horsepower {
				title = "Horsepower";
				name = "horsepower";
				desc = "Hatchback sport. 300 hp. I am speed.";
		};
  class Igloo {
				title = "Igloo";
				name = "igloo";
				desc = "For those Canucks who want to feel at home.";
		};
  class Infantry {
				title = "Infantry";
				name = "infantry";
				desc = "Don't underestimate a good foot push.";
		};
  class JackOLantern {
			  title = "Jack 'O' Lantern";
			  name = "jack_o_lantern";
			  desc = "Enjoy the spirit of Halloween year-round.";
	  };
  class Join {
			  title = "Join";
			  name = "join";
			  desc = "Hop in the coup.";
	  };
  class Key {
			  title = "Key";
			  name = "key";
			  desc = "Unlocks things.";
	  };
  class LandingGear {
			  title = "Landing Gear";
			  name = "landing_gear";
			  desc = "Don't forget it while flying a ghawk.";
	  };
  class Launcher {
			  title = "Launcher";
			  name = "launcher";
			  desc = "Titan, RPG. You name it. No Alamut though.";
	  };
	class LightsOn {
			  title = "Lights";
			  name = "lights_on";
			  desc = "I just flipped a switch. Flip flip.";
	  };
  class Lock {
			  title = "Lock";
			  name = "lock";
			  desc = "I got castle rocks on lockdown, dw.";
	  };
  class Mag {
			  title = "Mag";
			  name = "mag";
			  desc = "No way he pushes me right as I reload.";
	  };
  class MagAlt {
			  title = "Mag (alt)";
			  name = "mag2";
			  desc = "SWAPPING MAGS.";
	  };
  class MagMult {
			  title = "Mags";
			  name = "mag_multiple";
			  desc = "More bullets = win.";
	  };
  class Man {
			  title = "Man";
			  name = "man";
			  desc = "An absolute unit.";
	  };
  class Map {
			  title = "Map";
			  name = "map";
			  desc = "Pro tip: use shift-t instead.";
	  };
  class Marker {
			  title = "Marker";
			  name = "marker";
			  desc = "What do you mean you don't see him?!";
	  };
  class Meh {
			  title = "Meh";
			  name = "meh";
			  desc = "The look of utter apathy.";
	  };
  class Mic {
			  title = "Microphone";
			  name = "mic";
			  desc = "Don't even think about playing ear-rape.";
	  };
  class Missle {
			  title = "Missle";
			  name = "missle";
			  desc = "Tactical nuke inbound.";
	  };
  class MoneyBill {
			  title = "Bill Wave";
			  name = "money_bill_wave";
			  desc = "Make it rain, baby. E-clout.";
	  };
  class Monkey {
			  title = "Monkey";
			  name = "monkey";
			  desc = "For apes and primates alike.";
	  };
  class Mosque {
			  title = "Mosque";
			  name = "mosque";
			  desc = "A muslim place of worship.";
	  };
  class Motorcycle {
			  title = "Motorcycle";
			  name = "motorcycle";
			  desc = "Vroom vroom. Hop on the Harley.";
	  };
  class Mountain {
			  title = "Mountain";
			  name = "mountain";
			  desc = "You can climb that mountain.";
	  };
  class People {
			  title = "People";
			  name = "multiple_people";
			  desc = "A violation of social distancing.";
	  };
  class Muzzle {
			  title = "Muzzle";
			  name = "muzzle";
			  desc = "Buying 7.62 suppressor 2.5 mill.";
	  };
  class Narwal {
			  title = "Narwal";
			  name = "narwhal";
			  desc = "Swimmin' in the ocean.";
	  };
  class Nature {
			  title = "Nature";
			  name = "nature";
			  desc = "The natural beauty of Altis.";
	  };
  class NoFire {
			  title = "No Fire";
			  name = "no_fire";
			  desc = "Anti-arson at its finest.";
	  };
  class NVGs {
			  title = "NVGs";
			  name = "nvgs";
			  desc = "Imagine not using a pilot helmet.";
	  };
  class Person {
			  title = "Person";
			  name = "one_person";
			  desc = "Just a dude, literally just vibing.";
	  };
  class OpenDoor {
			  title = "Open Door";
			  name = "open_door";
			  desc = "Mom close my door please. MOM!";
	  };
  class OpenTriangle {
			  title = "Open Triangle";
			  name = "open_triangle";
			  desc = "Like a normal triangle, but open.";
	  };
	class Optic {
			  title = "Optic";
			  name = "optic";
			  desc = "Eyes on: dead.";
	  };
	class OS {
			  title = "Olympus";
			  name = "os";
			  desc = "Mecca for gamers.";
	  };
	class PaperPlane {
			  title = "Paper Plane";
			  name = "paper_plane";
			  desc = "All I wanna do...";
	  };
	class Parachute {
			  title = "Parachute";
			  name = "parachute";
			  desc = "Fun fact: has never actually worked in combat.";
	  };
	class Paw {
			  title = "Paw";
			  name = "paw";
			  desc = "Not saying you're a furry if you use this, but...";
	  };
	class Peace {
			  title = "Peace Sign";
			  name = "peace";
			  desc = "Why can't we all just get along?";
	  };
	class Pedo {
			  title = "Pedo";
			  name = "pedo";
			  desc = "See something, say something.";
	  };
	class Pegasus {
			  title = "Pegasus";
			  name = "pegasus";
			  desc = "Fictional winged beast.";
	  };
  class Periscope {
			  title = "Periscope";
			  name = "periscope";
			  desc = "Tactical advantage from inside a strider.";
	  };
	class Pig {
			  title = "Pig";
			  name = "pig";
			  desc = "Oink oink. Fuck the police.";
	  };
	class Pills {
			  title = "Pills";
			  name = "pills";
			  desc = "Pop an addy, push cap. Pop a xan and scat.";
	  };
	class Pilot {
			  title = "Pilot";
			  name = "pilot";
			  desc = "Drop me top tower, quick. I'm shot out, nice.";
	  };
	class Plane {
			  title = "Plane";
			  name = "plane";
			  desc = "Strafing cap cause I can't use a real gun.";
	  };
	class Play {
			  title = "Play Button";
			  name = "play";
			  desc = "Arma montages and chill?";
	  };
	class PooSmile {
			  title = "Poop Smile";
			  name = "poo";
			  desc = "From emoji, to plushie, to Olympus hex icon.";
	  };
	class PooStorm {
			  title = "Poop Storm";
			  name = "poo_storm";
			  desc = "I honestly can't think of any context for this.";
	  };
	class Poo {
			  title = "Poop";
			  name = "poop";
			  desc = "Off restrictions? No worries.";
	  };
	class Pulse {
			  title = "Pulse";
			  name = "pulse";
			  desc = "The perfect icon for your local combat medic.";
	  };
	class PulseAlt {
			  title = "Pulse (alt)";
			  name = "pulse2";
			  desc = "Better buy some more epipens...";
	  };
	class PuzzlePiece {
			  title = "Puzzle Piece";
			  name = "puzzle_piece";
			  desc = "Autism logo. By whitelist only.";
	  };
  class PuzzleAngled {
			  title = "Puzzle Piece (angled)";
			  name = "puzzle_angled";
			  desc = "Not a disability, a different ability.";
	  };
  class Rabbit {
			  title = "Rabbit";
			  name = "rabbit";
			  desc = "Pro tip: sell rabbit fur at your local market.";
	  };
	class Radar {
			  title = "Radar";
			  name = "radar";
			  desc = "Blip. Blip.";
	  };
	class Radiation {
			  title = "Radiation";
			  name = "radiation";
			  desc = "You ever see those Chernobyl fish?";
	  };
	class Radio {
			  title = "Radio";
			  name = "radio";
			  desc = "Breaker breaker 1-9, I am currently group-chatting.";
	  };
	class Rearm {
			  title = "Rearm";
			  name = "rearm";
			  desc = "Buy loadout, slam window, repeat.";
	  };
	class Rebel {
			  title = "Rebel";
			  name = "rebel";
			  desc = "Fuck vigis. Fuck cops. Fuck runs. Fight cartels.";
	  };
	class Recon {
			  title = "Recon";
			  name = "recon";
			  desc = "This is Altis combat sharp shooter, no visual.";
	  };
	class Refuel {
			  title = "Refuel";
			  name = "refuel";
			  desc = "Hope you can run, cause you just ran out of gas.";
	  };
	class Reload {
			  title = "Reload";
			  name = "reload";
			  desc = "Just buy a MK-200 and never do this again.";
	  };
	class Remote {
			  title = "Remote";
			  name = "remote";
			  desc = "Orbital strike inbound.";
	  };
  class Repair {
			  title = "Repair";
			  name = "repair";
			  desc = "For all you skilled mechanics out there.";
	  };
	class RepairVeh {
			  title = "Repair Vehicle";
			  name = "repair_vehicle";
			  desc = "Have you tried not crashing? Pro gamer move.";
	  };
	class Rifle {
			  title = "Rifle";
			  name = "rifle";
			  desc = "Yeah I know, its a TRG. Pretty lame.";
	  };
	class RIP {
			  title = "RIP";
			  name = "rip";
			  desc = "Rest in piece. It's ok, we all die sometimes.";
	  };
  class RnR {
			  title = "Rescue & Recovery";
			  name = "rnr";
			  desc = "Walking defibs represent!";
	  };
	class SadCry {
			  title = "Sad Cry";
			  name = "sad_cry";
			  desc = "Sad boi hours out here.";
	  };
	class Search {
			  title = "Search";
			  name = "search";
			  desc = "Get the searchlight out.";
	  };
	class SearchAlt {
			  title = "Search (alt)";
			  name = "search2";
			  desc = "Like the other one, but alt.";
	  };
	class SemiCircle {
			  title = "Semicircle";
			  name = "semi_circle";
			  desc = "Almost a full circle.";
	  };
	class SemiCircleDot {
			  title = "Semicircle (dot)";
			  name = "semi_circle_dot";
			  desc = "Dot gang represent.";
	  };
	class Servers {
			  title = "Servers";
			  name = "servers";
			  desc = "Hacking into the mainframe... I'm in.";
	  };
  class Shades {
			  title = "Shades";
			  name = "shades";
			  desc = "Tactical shades.";
	  };
	class Sheep {
			  title = "Sheep";
			  name = "sheep";
			  desc = "Wake up sheeple.";
	  };
	class ShipWreck {
			  title = "Shipwreck";
			  name = "shipWreck";
			  desc = "Imagine running salvage. Couldn't be me.";
	  };
	class Sickle {
			  title = "Sickle";
			  name = "sickle";
			  desc = "For harvesting wheat. Also looks cool.";
	  };
	class Signal {
			  title = "Signal";
			  name = "signal";
			  desc = "Just give the signal.";
	  };
	class Skull {
			  title = "Skull (angry)";
			  name = "skull";
			  desc = "Like a normal skull, but with anger.";
	  };
	class SkullNoAngry {
			  title = "Skull";
			  name = "skull_no_angry";
			  desc = "For badass gamers.";
	  };
	class Snake {
			  title = "Snake";
			  name = "snake";
			  desc = "Slippery snake. Like a rat, but flatter.";
	  };
	class Snowboarding {
			  title = "Snowboarding";
			  name = "snowboarding";
			  desc = "Shaun White out here playing SSX 3 on PS2.";
	  };
	class Snowflake {
			  title = "Snowflake";
			  name = "snowflake";
			  desc = "For libtards and cuckservatives alike.";
	  };
	class Snowman {
			  title = "Snowman";
			  name = "snowman";
			  desc = "Do you want to push OG arms?";
	  };
	class Sound {
			  title = "Musical Note";
			  name = "sound";
			  desc = "Won't catch me fingering a minor.";
	  };
	class SprayPaint {
			  title = "Spray Paint";
			  name = "spray_paint";
			  desc = "Bout to tag up my hood.";
	  };
	class SquareAngled {
			  title = "Square (angled)";
			  name = "square_angled";
			  desc = "Like a square, but angled.";
	  };
	class SquareDot {
			  title = "Square (dot)";
			  name = "square_dot";
			  desc = "Literally just a square with a dot in it.";
	  };
	class Squirrel {
			  title = "Squirrel";
			  name = "squirrel";
			  desc = "Like the little dood from ice age.";
	  };
	class Star {
			  title = "Star";
			  name = "star";
			  desc = "For star players only.";
	  };
	class StarDavid {
			  title = "Star of David";
			  name = "star_of_david";
			  desc = "A staple of Judaism.";
	  };
	class StarLife {
			  title = "Star of Life";
			  name = "star_of_life";
			  desc = "Anyone need a FAK?";
	  };
	class StarAlt {
			  title = "Star (alt)";
			  name = "star2";
			  desc = "Like a star, but alt.";
	  };
	class Steam {
			  title = "Steam";
			  name = "steam";
			  desc = "Steam powered.";
	  };
	class SupplyDrop {
			  title = "Supply Drop";
			  name = "supply_drop";
			  desc = "Care package inbound.";
	  };
	class Support {
			  title = "Support";
			  name = "support";
			  desc = "Nice little crosshair thing.";
	  };
	class Surprise {
			  title = "Surprise";
			  name = "surprise";
			  desc = "For when you're surprised.";
	  };
	class Swords {
			  title = "Swords";
			  name = "swords";
			  desc = "We on some medieval shit now.";
	  };
	class Syringe {
			  title = "Syringe";
			  name = "syringe";
			  desc = "Olympus does not condone the use of drugs.";
	  };
	class Tank {
			  title = "Tank";
			  name = "tank";
			  desc = "You'll never get one in Altis Life.";
	  };
	class Target {
			  title = "Target";
			  name = "target";
			  desc = "Target crosshair marker thing.";
	  };
  class Teacher {
			  title = "Teacher";
			  name = "teacher";
			  desc = "Educating the youth of Altis since 2014.";
	  };
	class TeamSwitch {
			  title = "Team Switch";
			  name = "team_switch";
			  desc = "We boutta order 66 this fed.";
	  };
	class Tetrahedron {
			  title = "Tetrahedron";
			  name = "tetrahedron";
			  desc = "Probly not actually a tetrahedron, but close enough.";
	  };
	class Textures {
			  title = "Textures";
			  name = "textures";
			  desc = "For all you texture designers out there.";
	  };
	class Thief {
			  title = "Thief";
			  name = "thief";
			  desc = "Snake some shine from the gang shed.";
	  };
	class Timer {
			  title = "Timer";
			  name = "timer";
			  desc = "Yeah, you're on bomb duty bud.";
	  };
	class Toilet {
			  title = "Toilet";
			  name = "toilet";
			  desc = "I get more ass than a toilet seat.";
	  };
	class Tools {
			  title = "Tools";
			  name = "tools";
			  desc = "Some tools and what not.";
	  };
	class TrafficCone {
			  title = "Traffic Cone";
			  name = "traffic_cone";
			  desc = "Literally just a traffic cone.";
	  };
	class TrafficLight {
			  title = "Traffic Light";
			  name = "traffic_light";
			  desc = "Red means dead. I mean stop.";
	  };
	class Transport {
			  title = "Transport";
			  name = "transport";
			  desc = "Some right-pointing arrows.";
	  };
	class Tree {
			  title = "Tree";
			  name = "tree";
			  desc = "Not very great, but still a tree.";
	  };
	class TreeChristmas {
			  title = "Christmas Tree";
			  name = "tree_christmas";
			  desc = "A festive Christmas tree.";
	  };
	class TreePalm {
			  title = "Palm Tree";
			  name = "tree_palm";
			  desc = "A tropical palm tree.";
	  };
	class TreeSharp {
			  title = "Sharp Tree";
			  name = "tree_sharp";
			  desc = "This tree looks pretty pointy.";
	  };
  class Triangle {
			  title = "Triangle";
			  name = "triangle";
			  desc = "Just a triangle. Pretty neat.";
	  };
	class Truck {
			  title = "Truck";
			  name = "truck";
			  desc = "A truck, probably for meth runs.";
	  };
	class TruckCargo {
			  title = "Truck Cargo";
			  name = "truck_cargo";
			  desc = "A truck for carrying cargo.";
	  };
	class TruckCargoAlt {
			  title = "Truck Cargo (alt)";
			  name = "truck_cargo2";
			  desc = "Another truck for carrying cargo.";
	  };
  class Turtle {
			  title = "Turtle";
			  name = "turtle";
			  desc = "The boomer of the animal kingdom.";
	  };
	class Unbind {
			  title = "Broken Chains";
			  name = "unbind";
			  desc = "Oh dear, someone broke my chains.";
	  };
	class Unicorn {
			  title = "Unicorn";
			  name = "unicorn";
			  desc = "Fictional horse with a horn.";
	  };
	class Uniform {
			  title = "Uniform";
			  name = "uniform";
			  desc = "Nice, tidy uniform. Very sharp.";
	  };
	class UserSecret {
			  title = "Espionage";
			  name = "user_secret";
			  desc = "For going undercover, and being sneaky.";
	  };
	class Vectoring {
			  title = "Vectoring";
			  name = "vectoring";
			  desc = "Any blackfish pilots out here?";
	  };
	class Vest {
			  title = "Vest";
			  name = "vest";
			  desc = "Hopefully not a tac vest.";
	  };
	class Vines {
			  title = "Vines";
			  name = "vines";
			  desc = "Some vines, perhaps to climb on.";
	  };
	class Walking {
			  title = "Walking";
			  name = "walking";
			  desc = "Just walkin'.";
	  };
	class Wanted {
			  title = "Wanted";
			  name = "wanted";
			  desc = "Free lethal anyone?";
	  };
  class Watch {
			  title = "Watch";
			  name = "watch";
			  desc = "Issa watch. It tells time.";
	  };
	class Watermelon {
			  title = "Watermelon";
			  name = "watermelon";
			  desc = "Juicy watermelon.";
	  };
	class Wheelchair {
			  title = "Wheelchair";
			  name = "wheelchair";
			  desc = "Multipurpose wheelchair.";
	  };
	class Wrench {
			  title = "Wrench";
			  name = "wrench";
			  desc = "A wrench. Nice.";
	  };
	class X {
			  title = "X";
			  name = "x";
			  desc = "X gon give it to ya.";
	  };
	class YinYang {
			  title = "Yin & Yang";
			  name = "yin_yang";
			  desc = "Asian symbol of balance.";
	  };
};
