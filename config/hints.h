class CfgHints {
	class Introduction {
		displayName = "Introduction";
		displayNameShort = "Introduction";
		logicalOrder = 1;
		class NewPlayers {
			// Hint title, filled by arguments from 'arguments' param
			displayName = "1. New to the game mode?";
			// Structured text, filled by arguments from 'arguments' param
			description = "<t align='center'><t size='2'> Welcome to %1 <t size='5'>WW2Rush</t></t> %1 I'm %3A.Roman%4, the creator of this game mode and I'd like you to spend a few minutes to learn how this game mode works.</t>";
			// Optional structured text, filled by arguments from 'arguments' param (first argument is %11, see notes bellow), grey color of text
			tip = "<t align='center'>WW2Rush is inspired from the homonymous game-mode featured in the Battlefield series, which defined the entire FPS gendre with its first appereance in Battlefield: Bad Company.</t>";
			// Optional image
			image = "\a3\ui_f\data\gui\cfg\hints\Miss_icon_ca.paa";
			// optional parameter for not showing of image in context hint in mission (default false))
			noImage = false;
			// -1 Creates no log in player diary, 0 Creates diary log ( default when not provided )
			// if a dlc's appID Number is used ( see getDLCs ) and the user does not have the required dlc installed then the advHint will be replaced with
			// configfile >> "CfgHints" >> "DlcMessage" >> "Dlc#"; where # is this properties ( dlc appID ) number
			dlc = 0;
			logicalOrder = 1;
		};
		class Context {
			// Hint title, filled by arguments from 'arguments' param
			displayName = "2. Context";
			// Structured text, filled by arguments from 'arguments' param
			description = "%3WW2Rush%4 is an exclusive game-mode of %3IFA3%4 alongside many others. %1 %1 WW2Rush focuses around fast-paced, infantry as well as vehicular combat. The game-mode itself was firstly introduced by %3OptiX%4 as a vanilla game-mode. %1 %1 After he granted me white paper on the usage of his files, the WW2Rush mission that you are about to play was the result of about a year of further development. %1 %1";
			// Optional structured text, filled by arguments from 'arguments' param (first argument is %11, see notes bellow), grey color of text
			image = "\a3\ui_f\data\gui\cfg\hints\Miss_icon_ca.paa";
			// optional parameter for not showing of image in context hint in mission (default false))
			noImage = false;
			// -1 Creates no log in player diary, 0 Creates diary log ( default when not provided )
			// if a dlc's appID Number is used ( see getDLCs ) and the user does not have the required dlc installed then the advHint will be replaced with
			// configfile >> "CfgHints" >> "DlcMessage" >> "Dlc#"; where # is this properties ( dlc appID ) number
			dlc = 0;
			logicalOrder = 2;

		};
		class Objectives {
			displayName = "3. Objectives";
			description = "The objectives around which this game-mode revolves are the following: %1 <t align='center'>%11 %12</t> %1 <t align='center'>Most of the times the objective is some radio asset, like a radio truck or a simple strategic point, with a small man-portable radio.</t>";
			arguments[] = {{"<img size='8' shadow='0' color='#99ffffff' image = '\WW2\Core_t\IF_EditorPreviews_t\LIB_Static_opelblitz_radio.jpg' />"}, {"<img size='8' shadow='0' color='#99ffffff' image = '\WW2\Core_t\IF_EditorPreviews_t\LIB_GerRadio.jpg' />"}};
			tip = "But let's take a look at what each side specific objectives are and how they can achieve victory over their opponents.";
			image = "\a3\ui_f\data\gui\cfg\hints\Tactical_view_ca.paa";
			logicalOrder = 3;
		};
		class Attackers {
			// Hint title, filled by arguments from 'arguments' param
			displayName = "3.1 Attackers' Goal";
			// Optional hint subtitle, filled by arguments from 'arguments' param
			displayNameShort = "How to win as attacker";
			// Structured text, filled by arguments from 'arguments' param
			description = "The goal of the attackers is to seize the %3 4 %4 different objectives and destroy them by planting explosive on them before the tickets or the time run out.";
			// Optional image
			image = "\a3\ui_f\data\gui\cfg\hints\IEDs_ca.paa";
			// optional parameter for not showing of image in context hint in mission (default false))
			noImage = false;
			// -1 Creates no log in player diary, 0 Creates diary log ( default when not provided )
			// if a dlc's appID Number is used ( see getDLCs ) and the user does not have the required dlc installed then the advHint will be replaced with
			// configfile >> "CfgHints" >> "DlcMessage" >> "Dlc#"; where # is this properties ( dlc appID ) number
			dlc = 0;
			logicalOrder = 4;
		};
		class Defenders {
			// Hint title, filled by arguments from 'arguments' param
			displayName = "3.2 Defenders' Goal";
			// Optional hint subtitle, filled by arguments from 'arguments' param
			displayNameShort = "How to win as defender";
			// Structured text, filled by arguments from 'arguments' param
			description = "The goal of the defenders is to protect their objectives from the attackers trying to blow them up. In order to succeed they have two ways: %1 %2 %3Bleedout%4: Reduce the enemy tickets by killing them (%3 1 Life = 1 Ticket less %4); %1 %2 %3Timeout%4: Defend a single objective for more than a set amount of time";
			// Optional image
			image = "\a3\ui_f\data\gui\cfg\hints\Disarm_ca.paa";
			// optional parameter for not showing of image in context hint in mission (default false))
			noImage = false;
			// -1 Creates no log in player diary, 0 Creates diary log ( default when not provided )
			// if a dlc's appID Number is used ( see getDLCs ) and the user does not have the required dlc installed then the advHint will be replaced with
			// configfile >> "CfgHints" >> "DlcMessage" >> "Dlc#"; where # is this properties ( dlc appID ) number
			dlc = 0;
			logicalOrder = 5;
		};
		class Tickets {
			// Hint title, filled by arguments from 'arguments' param
			displayName = "4. Tickets";
			// Optional hint subtitle, filled by arguments from 'arguments' param
			displayNameShort = "What are they and how to preserve them";
			// Structured text, filled by arguments from 'arguments' param
			description = "The tickets are %3the lives that attackers have at disposal%4. This means that whenever an attacker is killed he will make his team lose one ticket point. %1 When the tickets hit 0, the attackers lose the round, thus the attacker should be considerate in their tactics and avoid wasting too many tickets in reckless actions.";
			tip = "Did you know? A medic reviving a downed unit avoids his team losing a ticket!";
			// Optional image
			image = "\a3\ui_f\data\gui\cfg\hints\Injury_ca.paa";
			// optional parameter for not showing of image in context hint in mission (default false))
			noImage = false;
			// -1 Creates no log in player diary, 0 Creates diary log ( default when not provided )
			// if a dlc's appID Number is used ( see getDLCs ) and the user does not have the required dlc installed then the advHint will be replaced with
			// configfile >> "CfgHints" >> "DlcMessage" >> "Dlc#"; where # is this properties ( dlc appID ) number
			dlc = 0;
			logicalOrder = 6;
		};
		class Time {
			// Hint title, filled by arguments from 'arguments' param
			displayName = "5. Time";
			// Optional hint subtitle, filled by arguments from 'arguments' param
			displayNameShort = "How does it influences the battlefield?";
			// Structured text, filled by arguments from 'arguments' param
			description = "The attackers will have a limited amount of time to capture each objective, when the clock hits zero the game is over and the round is won by the defenders.";
			tip = "When the objective has been (or is being) armed the time freezes, keep that in mind!";
			// Optional image
			image = "\a3\ui_f\data\gui\cfg\hints\Timing_ca.paa";
			// optional parameter for not showing of image in context hint in mission (default false))
			noImage = false;
			// -1 Creates no log in player diary, 0 Creates diary log ( default when not provided )
			// if a dlc's appID Number is used ( see getDLCs ) and the user does not have the required dlc installed then the advHint will be replaced with
			// configfile >> "CfgHints" >> "DlcMessage" >> "Dlc#"; where # is this properties ( dlc appID ) number
			dlc = 0;
			logicalOrder = 7;
		};
	};
	class Interface {
		displayName = "Interface";
		logicalOrder = 2;
	};
	class Gameplay {
		displayName = "Gameplay";
		logicalOrder = 3;
		class Playarea {
			// Hint title, filled by arguments from 'arguments' param
			displayName = "Battlefield Restrictions";
			// Optional hint subtitle, filled by arguments from 'arguments' param
			displayNameShort = "How to not be a deserter 101";
			// Structured text, filled by arguments from 'arguments' param
			description = "Press %11 to open the Map and check where the current play area is. %1You should find yourself at all times within the blue rectangle marked on the map, if you aren't you'll be prompted to return to the battlefield and you'll be killed shortly after if you do not obey.";
			// Optional structured text, filled by arguments from 'arguments' param (first argument is %11, see notes bellow), grey color of text
			tip = "Did you know? Defenders will often find themselves outside of the play area shortly after losing an objective, they have extra time to fallback!";
			arguments[] = {{{"showMap"}}};
			// Optional image
			image = "\a3\ui_f\data\gui\cfg\hints\ShootingBoxes_ca.paa";
			// optional parameter for not showing of image in context hint in mission (default false))
			noImage = false;
			// -1 Creates no log in player diary, 0 Creates diary log ( default when not provided )
			// if a dlc's appID Number is used ( see getDLCs ) and the user does not have the required dlc installed then the advHint will be replaced with
			// configfile >> "CfgHints" >> "DlcMessage" >> "Dlc#"; where # is this properties ( dlc appID ) number
			dlc = 0;
			logicalOrder = 1;
		};
		class obj_interactions {
			// Hint title, filled by arguments from 'arguments' param
			displayName = "Arming/Defusing Explosives";
			// Optional hint subtitle, filled by arguments from 'arguments' param
			displayNameShort = "Safety or doom of an objective";
			// Structured text, filled by arguments from 'arguments' param
			description = "When you are next to an objective, look directly at it and press %11 to begin interacting with it. %1This will initiate the procedure for arming (or defusing) the bomb. %1%1For the %3Attackers%4:%1%2If you are arming the bomb, you should hear an alarm going off and the time should be frozen; %1For the %3Defenders%4:%1%2The alarm should stop as soon as you complete your defusal and the time should resume ticking for the attackers.";
			// Optional structured text, filled by arguments from 'arguments' param (first argument is %11, see notes bellow), grey color of text
			tip = "Tip: Take cover after arming an objective, its blast can be deadly if you happen to be too close!";
			arguments[] = {{{"action"}}};
			// Optional image
			image = "\a3\ui_f\data\gui\cfg\hints\Mines_ca.paa";
			// optional parameter for not showing of image in context hint in mission (default false))
			noImage = false;
			// -1 Creates no log in player diary, 0 Creates diary log ( default when not provided )
			// if a dlc's appID Number is used ( see getDLCs ) and the user does not have the required dlc installed then the advHint will be replaced with
			// configfile >> "CfgHints" >> "DlcMessage" >> "Dlc#"; where # is this properties ( dlc appID ) number
			dlc = 0;
			logicalOrder = 2;
		};
		class general_interactions {
			// Hint title, filled by arguments from 'arguments' param
			displayName = "Other Interactions";
			// Structured text, filled by arguments from 'arguments' param
			description = "The objectives are not the only objects with which you can interact. You can press %11 in the following cases to trigger an interaction: %1%2 As a %3Medic%4, when being close to a downed ally, looking at him you'll be able to revive him; %1%2 As a %3Support%4, being close to an ally and looking at him will allow you to replenish his ammunition or replenish your own ammo when no-one else's around; %1%2 As a %3Engineer%4 when being close to a vehicle and aiming at it, it will allow you to repair it if you have the %3Repair Toolkit%4 perk.";
			// Optional structured text, filled by arguments from 'arguments' param (first argument is %11, see notes bellow), grey color of text
			tip = "Did you know? Some perks influence the amount taken by an interaction to be completed!";
			arguments[] = {{{"action"}}};
			// Optional image
			image = "\a3\ui_f\data\gui\cfg\hints\ActionMenu_ca.paa";
			// optional parameter for not showing of image in context hint in mission (default false))
			noImage = false;
			// -1 Creates no log in player diary, 0 Creates diary log ( default when not provided )
			// if a dlc's appID Number is used ( see getDLCs ) and the user does not have the required dlc installed then the advHint will be replaced with
			// configfile >> "CfgHints" >> "DlcMessage" >> "Dlc#"; where # is this properties ( dlc appID ) number
			dlc = 0;
			logicalOrder = 3;
		};
		class Groups {
			// Hint title, filled by arguments from 'arguments' param
			displayName = "Group Management";
			// Optional hint subtitle, filled by arguments from 'arguments' param
			displayNameShort = "How to manage a group";
			// Structured text, filled by arguments from 'arguments' param
			description = "Press %11 to open the Group Management interface. In this panel you can see all the teams present in your faction. %1Playing within a team provides you with several benefits, amongst which there is an extra spawn-point on the leader. %1%1If there are no teams available, you can create your own one by click on %3CREATE%4, or alternatively you can %3JOIN%4 or %3LEAVE%4 already existing groups. %1%1 If you so wish, you can invite other players to your group by clicking on their names and then hitting %3INVITE%4. %1You can also change the name of your group by selecting the current name, replacing it and pressing %3ENTER%4 on your keyboard.";
			// Optional structured text, filled by arguments from 'arguments' param (first argument is %11, see notes bellow), grey color of text
			tip = "Tip: Always be respectful of the other team members and join your efforts in conquering the enemy objective by using the VoIP.";
			arguments[] = {{{"teamSwitch"}}};
			// Optional image
			image = "\a3\ui_f\data\gui\cfg\hints\Commanding_ca.paa";
			// optional parameter for not showing of image in context hint in mission (default false))
			noImage = false;
			// -1 Creates no log in player diary, 0 Creates diary log ( default when not provided )
			// if a dlc's appID Number is used ( see getDLCs ) and the user does not have the required dlc installed then the advHint will be replaced with
			// configfile >> "CfgHints" >> "DlcMessage" >> "Dlc#"; where # is this properties ( dlc appID ) number
			dlc = 0;
			logicalOrder = 4;
		};
		class GroupsPerks {
			// Hint title, filled by arguments from 'arguments' param
			displayName = "Group Perks";
			// Structured text, filled by arguments from 'arguments' param
			description = "The group perks are benefits that are shared among the squad, which can greatly benefit the combat effectiveness of a group. %1<t size='1.5'>%3Squad Perks%4</t>%1%2 %3Sprint%4: Increases the reload and sprint speed by 5 percent; %1%2 %3Fast Swim%4: Dramatically increases your swimming speed; %1%2 %3Extended Ammunition%4: Deploys you with more ammunition than normal; %1%2 %3Smoke Grenades%4: Allows you to carry two smoke grenades for cover.";
			// Optional structured text, filled by arguments from 'arguments' param (first argument is %11, see notes bellow), grey color of text
			// Optional image
			image = "\a3\ui_f\data\gui\cfg\hints\Commanding_ca.paa";
			// optional parameter for not showing of image in context hint in mission (default false))
			noImage = false;
			// -1 Creates no log in player diary, 0 Creates diary log ( default when not provided )
			// if a dlc's appID Number is used ( see getDLCs ) and the user does not have the required dlc installed then the advHint will be replaced with
			// configfile >> "CfgHints" >> "DlcMessage" >> "Dlc#"; where # is this properties ( dlc appID ) number
			dlc = 0;
			logicalOrder = 5;
		};
		class Arsenal {
			// Hint title, filled by arguments from 'arguments' param
			displayName = "Arsenal";
			// Structured text, filled by arguments from 'arguments' param
			description = "When you start off in this game-mode you'll have access to a limited variety of weapons depending on your class: %1%2%3Medics%4 and %3Assault%4 have bolt-actions and semi-automatic rifles; %1%2%3Engineers%4 have sub-machine guns; %1%2%3Supports%4 have access to light machine guns. %1%1The more points you score, the better the arsenal that you'll have access to.";
			// Optional structured text, filled by arguments from 'arguments' param (first argument is %11, see notes bellow), grey color of text
			tip = "Whenever a player reaches his faction's end-tier, he'll begin unlocking another's faction weapons!";
			// Optional image
			image = "\A3\Ui_f\data\GUI\Cfg\Hints\Automatic_ca.paa";
			// optional parameter for not showing of image in context hint in mission (default false))
			noImage = false;
			// -1 Creates no log in player diary, 0 Creates diary log ( default when not provided )
			// if a dlc's appID Number is used ( see getDLCs ) and the user does not have the required dlc installed then the advHint will be replaced with
			// configfile >> "CfgHints" >> "DlcMessage" >> "Dlc#"; where # is this properties ( dlc appID ) number
			dlc = 0;
			logicalOrder = 6;
		};
		class Earplugs {
			// Hint title, filled by arguments from 'arguments' param
			displayName = "Using Earplugs";
			// Optional hint subtitle, filled by arguments from 'arguments' param
			displayNameShort = "How to preserve your hearing";
			// Structured text, filled by arguments from 'arguments' param
			description = "Press %11 to gradually lower the sound effects. There can be three different settings: 100, 50 and 10 percent.";
			// Optional structured text, filled by arguments from 'arguments' param (first argument is %11, see notes bellow), grey color of text
			tip = "This can helpful when trying to communicate without always having your sound effects on low.";
			arguments[] = {{{"curatorInterface"}}};
			// Optional image
			image = "\a3\ui_f\data\gui\cfg\hints\Voice_ca.paa";
			// optional parameter for not showing of image in context hint in mission (default false))
			noImage = false;
			// -1 Creates no log in player diary, 0 Creates diary log ( default when not provided )
			// if a dlc's appID Number is used ( see getDLCs ) and the user does not have the required dlc installed then the advHint will be replaced with
			// configfile >> "CfgHints" >> "DlcMessage" >> "Dlc#"; where # is this properties ( dlc appID ) number
			dlc = 0;
			logicalOrder = 7;
		};
	};
	class Classes {
		displayName = "Classes";
		logicalOrder = 4;
		class Medic {
			// Hint title, filled by arguments from 'arguments' param
			displayName = "Medic";
			// Optional hint subtitle, filled by arguments from 'arguments' param
			displayNameShort = "'... Let's go practice medicine.'";
			// Structured text, filled by arguments from 'arguments' param
			description = "The Medic focuses his game-play assisting his own team, by means of reviving the fallen and by setting up spawn-beacons closer to the objective for the members of his squad to spawn on it.%1%1<t size='1.5'>%3Class Perks%4</t>%1%2 %3Epinephrine Injector%4: Speeds up the revive process by three times; %1%2 %3Spawn Beacon%4: Allows the medic to place down spawn beacons.";
			// Optional structured text, filled by arguments from 'arguments' param (first argument is %11, see notes bellow), grey color of text
			tip = "Medics are very welcome amongst most squads as they are likely to be good team players.";
			arguments[] = {};
			// Optional image
			// optional parameter for not showing of image in context hint in mission (default false))
			noImage = true;
			// -1 Creates no log in player diary, 0 Creates diary log ( default when not provided )
			// if a dlc's appID Number is used ( see getDLCs ) and the user does not have the required dlc installed then the advHint will be replaced with
			// configfile >> "CfgHints" >> "DlcMessage" >> "Dlc#"; where # is this properties ( dlc appID ) number
			dlc = 0;
			logicalOrder = 1;
		};
		class Assault {
			// Hint title, filled by arguments from 'arguments' param
			displayName = "Assault";
			// Optional hint subtitle, filled by arguments from 'arguments' param
			// Structured text, filled by arguments from 'arguments' param
			description = "The Assault class is the best at dealing with the bomb at the objective site, mainly because of its perks. %1%1<t size='1.5'>%3Class Perks%4</t>%1%2 %3Grenadier%4: Allows the player to carry fragmentation grenades as well as rifle grenades (if the equipped rifle is compatible); %1%2 %3Quick Hands%4: Dramatically decreases the amount of time required to arm/defuse a bomb.";
			// Optional structured text, filled by arguments from 'arguments' param (first argument is %11, see notes bellow), grey color of text
			tip = "Assault is usually picked by the lone wolves or individuals who want to clutch the game on its very last seconds.";
			arguments[] = {};
			// Optional image
			// optional parameter for not showing of image in context hint in mission (default false))
			noImage = true;
			// -1 Creates no log in player diary, 0 Creates diary log ( default when not provided )
			// if a dlc's appID Number is used ( see getDLCs ) and the user does not have the required dlc installed then the advHint will be replaced with
			// configfile >> "CfgHints" >> "DlcMessage" >> "Dlc#"; where # is this properties ( dlc appID ) number
			dlc = 0;
			logicalOrder = 2;
		};
		class Support {
			// Hint title, filled by arguments from 'arguments' param
			displayName = "Support";
			// Optional hint subtitle, filled by arguments from 'arguments' param
			// Structured text, filled by arguments from 'arguments' param
			description = "The Support class is most useful throughout prolonged shootouts when your team starts running low on ammo. The support class is the only way for players and vehicles to replenish their ammo without meeting their creator.";
			// Optional structured text, filled by arguments from 'arguments' param (first argument is %11, see notes bellow), grey color of text
			tip = "Once you try the LMGs you'll find it hard to switch class again.";
			arguments[] = {};
			// Optional image
			// optional parameter for not showing of image in context hint in mission (default false))
			noImage = true;
			// -1 Creates no log in player diary, 0 Creates diary log ( default when not provided )
			// if a dlc's appID Number is used ( see getDLCs ) and the user does not have the required dlc installed then the advHint will be replaced with
			// configfile >> "CfgHints" >> "DlcMessage" >> "Dlc#"; where # is this properties ( dlc appID ) number
			dlc = 0;
			logicalOrder = 3;
		};
		class Engineer {
			// Hint title, filled by arguments from 'arguments' param
			displayName = "Engineer";
			// Optional hint subtitle, filled by arguments from 'arguments' param
			// Structured text, filled by arguments from 'arguments' param
			description = "The Engineer class is the most versatile one, since it can adapt to many different scenarios. His aim is to support the team throughout the neutralisation of specific threats. %1%1 <t size='1.5'>%3Class Perks%4</t>%1%2 %3Repair Toolkit%4: Allows the player to repair vehicles; %1%2 %3Anti-Tank Launcher%4: Spawns the player with a rocket launcher capable of taking out the thickest armours; %1%2 %3Explosives Expert%4: Allows the player to carry some charges that he can detonate at a close distance.";
			// Optional structured text, filled by arguments from 'arguments' param (first argument is %11, see notes bellow), grey color of text
			tip = "Tip: Beware of your surroundings and team-mates when handling explosives!";
			arguments[] = {};
			// Optional image
			// optional parameter for not showing of image in context hint in mission (default false))
			noImage = true;
			// -1 Creates no log in player diary, 0 Creates diary log ( default when not provided )
			// if a dlc's appID Number is used ( see getDLCs ) and the user does not have the required dlc installed then the advHint will be replaced with
			// configfile >> "CfgHints" >> "DlcMessage" >> "Dlc#"; where # is this properties ( dlc appID ) number
			dlc = 0;
			logicalOrder = 4;
		};
	};
};
