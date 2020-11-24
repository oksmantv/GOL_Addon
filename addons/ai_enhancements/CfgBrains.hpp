
class CfgBrains {
	class DefaultSoldierBrain {
		class Components {
			class AIBrainAimingErrorComponent {
				maxAngularError = 0.15;
				maxAngularErrorTurret = 0.25;
				worstDecreaseTime = 3.2;
				bestDecreaseTime = 0.8;
				lostTargetTimeMin = 0.5;
				lostTargetTimeMax = 3;
				shootingInfluence = 0.4;
				movingInfluence = 1;
				turningInfluence = 1;
				damageCoef = 10;
				fatigueCoef = 10;
				suppressionCoef = 0.7;
			};
/*
			class AIBrainCountermeasuresComponent {
				useSmokeGrenadeDelay = 20;
				CMCheckDelay = 0.8;
				suppressionThreshold = 0.8;
				nonLeaderSmokeProbability = 0.2;
				CMOnTargettedProbability = 0.1;		// 0.5
				suppressionTimerMax = 5;
				minimalThrowDistance = 900;
				minReactionTime = 0.5;				// 0.1
				maxReactionTime = 3;				// 3.0
				randomReactionTimePercent = 0.2;	// 0.3
			};
*/
			class AIBrainSuppressionComponent {
				maxSuppression = 1;
				worstDecreaseTime = 25;
				bestDecreaseTime = 5.0;
				SuppressionRange = 1;
				CauseHitWeight = 0.5;
				CauseExplosionWeight = 1.25;
				CauseBulletCloseWeight = 0.25;
				SuppressionThreshold = 0.7;
			};
//			class AIBrainTargetSelectorComponent {};
		};
	};
};
