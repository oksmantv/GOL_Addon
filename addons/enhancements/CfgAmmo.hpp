
class CfgAmmo {
	class GrenadeHand;
	class SmokeShell: GrenadeHand {
		smokeColor[] = {1,1,1,1};
		timeToLive = 45;
	};
	class SmokeShellRed: SmokeShell {
		smokeColor[] = SMOKE_COLOR_RED;
		timeToLive = 45;
	};
	class SmokeShellGreen: SmokeShell {
		smokeColor[] = SMOKE_COLOR_GREEN;
		timeToLive = 45;
	};
	class SmokeShellYellow: SmokeShell {
		smokeColor[] = SMOKE_COLOR_YELLOW;
		timeToLive = 45;
	};
	class SmokeShellPurple: SmokeShell {
		smokeColor[] = SMOKE_COLOR_PURPLE;
		timeToLive = 45;
	};
	class SmokeShellBlue: SmokeShell {
		smokeColor[] = SMOKE_COLOR_BLUE;
		timeToLive = 45;
	};
	class SmokeShellOrange: SmokeShell {
		smokeColor[] = SMOKE_COLOR_ORANGE;
		timeToLive = 45;
	};

	class G_40mm_Smoke: SmokeShell {
		aiAmmoUsageFlags = "2 + 4 + 64";
//		coefGravity = 0.8;
		cost = 10;
		deflecting = 0;
		deflectionSlowDown = 0;
		simulation = "shotSmoke";
		smokeColor[] = {1,1,1,1};
		timeToLive = 45;
	};

	class G_40mm_SmokeRed: G_40mm_Smoke {
		smokeColor[] = SMOKE_COLOR_RED;
		timeToLive = 45;
	};
	class G_40mm_SmokeGreen: G_40mm_Smoke {
		smokeColor[] = SMOKE_COLOR_GREEN;
		timeToLive = 45;
	};
	class G_40mm_SmokeYellow: G_40mm_Smoke {
		smokeColor[] = SMOKE_COLOR_YELLOW;
		timeToLive = 45;
	};
	class G_40mm_SmokePurple: G_40mm_Smoke {
		smokeColor[] = SMOKE_COLOR_PURPLE;
		timeToLive = 45;
	};
	class G_40mm_SmokeBlue: G_40mm_Smoke {
		smokeColor[] = SMOKE_COLOR_BLUE;
		timeToLive = 45;
	};
	class G_40mm_SmokeOrange: G_40mm_Smoke {
		smokeColor[] = SMOKE_COLOR_ORANGE;
		timeToLive = 45;
	};

	class rhs_g_vg40md_white: G_40mm_Smoke {
		aiAmmoUsageFlags = "2 + 4 + 64";
//		coefGravity = 0.8;
		cost = 10;
		deflecting = 0;
		deflectionSlowDown = 0;
		simulation = "shotSmoke";
		smokeColor[] = {1,1,1,1};
		timeToLive = 45;
	}

	class FlareCore;
	class FlareBase: FlareCore {
//		brightness = 1; == intensity = 3000; ?
		coefGravity = 0.25;
		cost = 100;
		flareSize = F_SIZE;
		intensity = F_INTENSITY;		//	Vanila: 500000 ACE: 1250000
		sideairFriction = 0.2;
		simulationStep = 0.1;
		triggerTime = 1;
	};
	class F_20mm_White: FlareBase {		// Flare gun
		aiAmmoUsageFlags = "1 + 2 + 64";
		intensity = 50000;
	};
	class F_40mm_White: FlareBase {		// UGL Flare
		aiAmmoUsageFlags = "1 + 2 + 64";
		flareSize = F_SIZE;
		intensity = F_INTENSITY;
	};
	class Flare_82mm_AMOS_White: FlareCore {	// Mortar Flare
		effectFlare = "FlareShell";		//	CounterMeasureFlare
		fuseDistance = 0;
		coefGravity = 0.6;
		deflectionSlowDown = 0.95;
		flareSize = 8;
		intensity = 150000;
		timeToLive = 93;
	};
	class SmokeShellArty: SmokeShell {
		effectsSmoke="SmokeShellWhiteSmall";
	};
	class F_20mm_Green;
	class F_20mm_Red;
	class F_20mm_Yellow;
	class ACE_F_Hand_White: F_20mm_White {	// Road flares
		timeToLive = 330;
	};
	class ACE_F_Hand_Green: F_20mm_Green {
		timeToLive = 330;
	};
	class ACE_F_Hand_Red: F_20mm_Red {
		timeToLive = 330;
	};
	class ACE_F_Hand_Yellow: F_20mm_Yellow {
		timeToLive = 330;
	};
	class BulletBase;
	class B_65x39_Caseless: BulletBase {
		cartridge = "FxCartridge_65";
	};

	class RocketCore;
	class RocketBase: RocketCore {
		LAUNCHER
	};
	class R_60mm_HE: RocketBase {
		LAUNCHER
	};
	class R_80mm_HE: RocketBase {
		LAUNCHER
	};
	class R_MRAAWS_HE_F: RocketBase {
		LAUNCHER
	};
	class R_MRAAWS_HEAT_F: RocketBase {
		LAUNCHER
	};
	class R_PG32V_F: RocketBase {
		LAUNCHER
	};
	class R_TBG32V_F: RocketBase {
		LAUNCHER
	};
	class R_PG7_F: RocketBase {
		LAUNCHER
	};

	class ShellCore;
	class ShellBase: ShellCore {
		cost = 100;
/*
		soundFly[] = {
			QPATHTOF(data\Shell_Fly1.wav),
			3,		// Volume
			0.85,	// Pitch
			250		// Distance
		};
*/
	};
	class Sh_120mm_HE: ShellBase {
		cost = 100;
	};

	class Sh_120mm_APFSDS: ShellBase {
		cost = 100;
	};

	class Sh_125mm_HE;
	class Sh_125mm_HEAT: Sh_125mm_HE {
		cost = 100;
	};
};
