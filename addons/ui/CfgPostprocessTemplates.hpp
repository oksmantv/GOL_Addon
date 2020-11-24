
//	https://forums.bohemia.net/forums/topic/210519-color-correction-theme-selections-colorblindness-post-process-effects/

class CfgPostprocessTemplates {
	class MyPurplePP {	// Derpiness
		displayName = "Purple-ish!";
		colorCorrections[] = {1,1,0,{1,1,1,0},{1,0.5,1,0},{0.75,0.25,0,1}};
		filmGrain[] = {0.04,1,1,0,1};
	};
	class ASCZ_MiddleEast {
		displayName = "Middle East";
		colorCorrections[] = {0.9,1,0,{0.1,0.1,0.1,-0.1},{1,1,0.8,0.528},{1,0.2,0,0}};
	};
	class ASCZ_RealIsBrownLight {
		displayName = "Real Is Brown 2";
		colorCorrections[] = {1,1,0,{0.1,0.2,0.3,-0.3},{1,1,1,0.5},{0.5,0.2,0,1}};
	};
	class ASCZ_Nightstalkers {
		displayName = "Nightstalkers";
		colorCorrections[] = {1,1.1,0.0,{0.0,0.0,0.0,0.0},{1.0,0.7,0.6,0.6},{0.2,0.6,0.1,0.0}};
	};
	class ASCZ_GrayTone {
		displayName = "Gray Tone";
		colorCorrections[] = {1.0,1.0,0.0,{1.0,1.0,1.0,0.0},{1.0,1.0,0.9,0.35},{0.3,0.3,0.3,-0.1}};
	};
	class ASCZ_ColdTone {
		displayName = "Cold Tone";
		colorCorrections[] = {1.0,1.0,0.0,{0.2,0.2,1.0,0.0},{0.4,0.75,1.0,0.6},{0.5,0.3,1.0,-0.1}};
	};
};
