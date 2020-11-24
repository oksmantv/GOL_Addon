
class CfgAILevelPresets {
	class AILevelCustom {
		displayName = "GOL";
		precisionAI = 0.3;
		skillAI = 0.5;
	};
};

class CfgDifficultyPresets {
	defaultPreset = "Regular";
	myArmorCoef = 1.5;
	divingLimitMultiplier = 2;

	class Regular {
		description = "Custom difficulty defined by GOL Clan.";
		displayName = "GOL Difficulty Preset";
		levelAI = "AILevelCustom";
		optionDescription = "Custom difficulty defined by GOL Clan.";
		optionPicture = "\A3\Ui_f\data\Logos\arma3_white_ca.paa";
		class Options {
			autoReport=0;
			cameraShake=1;
			commands=0;
			deathMessages=0;
			detectedMines=0;
			enemyTags=0;
			friendlyTags=0;
			groupIndicators=0;
			mapContent=0;
			mapContentEnemy = 0;
			mapContentFriendly = 0;
			mapContentMines = 0;
			mapContentPing = 0;
			multipleSaves=0;
			reducedDamage=0;
			scoreTable=0;
			squadRadar = 0;
			staminaBar=0;
			stanceIndicator=1;
			tacticalPing = 0;
			thirdPersonView=0;
			visionAid=0;
			vonID=0;
			waypoints=0;
			weaponCrosshair=0;
			weaponInfo=1;
		};
	};

	class Regular_old {
		description = "Just finished training, no real combat experience.";
		displayName = "Regular";
		levelAI = "AILevelMedium";
		optionDescription = "Just finished training, no real combat experience.";
		optionPicture = "\A3\Ui_f\data\Logos\arma3_white_ca.paa";
		class Options {
			autoReport = 1;
			cameraShake = 1;
			commands = 1;
			deathMessages = 1;
			detectedMines = 1;
			enemyTags = 0;
			friendlyTags = 1;
			groupIndicators = 1;
			mapContent = 1;
			multipleSaves = 1;
			reducedDamage = 0;
			scoreTable = 1;
			squadRadar = 1;
			staminaBar = 1;
			stanceIndicator = 2;
			tacticalPing = 1;
			thirdPersonView = 1;
			visionAid = 0;
			vonID = 1;
			waypoints = 2;
			weaponCrosshair = 1;
			weaponInfo = 2;
		};
	};
};

class CfgSurfaces {
	class Default {
		AIAvoidStance = 2;
	};
};
