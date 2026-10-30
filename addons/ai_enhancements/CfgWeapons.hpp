
class CfgWeapons {
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

	#include "CfgWeapons_Launchers.hpp"
	#include "CfgWeapons_TurretTweaks.hpp"
};
