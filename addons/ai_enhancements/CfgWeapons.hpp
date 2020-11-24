
class CfgWeapons {
/*
	class Default;
	class RifleCore;
	class Rifle: RifleCore {
	    RIFLE_DISPERSION
	};

	class MGunCore: Default {
	    MGUN_DISPERSION
	};

	class GrenadeLauncher: Default {
	    NADE_DISPERSION
	};

	class Throw: GrenadeLauncher {
	    class ThrowMuzzle: GrenadeLauncher {
	        NADE_DISPERSION
	    };
	};

	class Rifle_Base_F: Rifle {};
	class Rifle_Short_Base_F : Rifle_Base_F {};
	class Rifle_Long_Base_F: Rifle_Base_F {};

	class HandGunBase: Rifle {
		aiRateOfFire = 1;
		aiRateOfFireDispersion = 1;
		aiRateOfFireDistance = 100;
		maxRange = 70;
		maxRangeProbab = 0.01;
		midRange = 30;
		midRangeProbab = 0.05;
		minRange = 0;
		minRangeProbab = 0.1;
	};
*/

	class Default {
		RIFLE_SINGLE
	};
	class RifleCore;
	class Rifle: RifleCore {
	    aiDispersionCoefX = 15;
		aiDispersionCoefY = 16;
		RIFLE_SINGLE
	};
	class Rifle_Base_F;
	class arifle_Katiba_Base_F: Rifle_Base_F {
		ReadAndWrite
		RIFLE_SINGLE
		class Single: Mode_SemiAuto {
			RIFLE_SINGLE
		};
		class single_medium_optics1: Single {
			RIFLE_SINGLE
		};
		class single_far_optics2: single_medium_optics1 {
			RIFLE_SINGLE
		};
		class FullAuto: Mode_FullAuto {
			RIFLE_FULL
		};
		class fullauto_medium: FullAuto {
			RIFLE_FULL
		};
	};

	class Launcher;
	class Launcher_Base_F: Launcher {
		ReadAndWrite
		LAUNCHER_MAIN
	};
	class launch_MRAWS_base_F: Launcher_Base_F {
		ReadAndWrite
		LAUNCHER_MAIN
		class Single: Mode_SemiAuto {
			LAUNCHER_SINGLE
		};
	};

	class launch_NLAW_F: Launcher_Base_F {
		ReadAndWrite
		LAUNCHER_MAIN
		class Single: Mode_SemiAuto {
			LAUNCHER_SINGLE
		};
		class Overfly: Single {
			LAUNCHER_SINGLE
		};
	};

	class launch_RPG7_F: Launcher_Base_F {
		ReadAndWrite
		LAUNCHER_MAIN
		class Single: Mode_SemiAuto {
			LAUNCHER_SINGLE
		};
	};

	class launch_RPG32_F: Launcher_Base_F {
		ReadAndWrite
		LAUNCHER_MAIN
		class Single: Mode_SemiAuto {
			LAUNCHER_SINGLE
		};
	};
};
