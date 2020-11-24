#define LAUNCHER \
	aiAmmoUsageFlags = "64 + 128 + 256 + 512"; \
	airLock = 1; \
	allowAgainstInfantry = 1; \
	cost = 40;

class CfgAmmo {
	class Default;
	class GrenadeBase;
	class MissileCore;
	class MissileBase;
	class RocketCore;
	class RocketBase: RocketCore {
		access = 0;
		LAUNCHER
	};
	class R_MRAAWS_HEAT_F: RocketBase {
		LAUNCHER
	};
	class R_MRAAWS_HE_F: R_MRAAWS_HEAT_F {
		LAUNCHER
	};
	class R_PG32V_F: RocketBase {
		LAUNCHER
	};
	class R_TBG32V_F: R_PG32V_F {
		LAUNCHER
	};
	class R_PG7_F: RocketBase {
		LAUNCHER
	};
	class M_SPG9_HEAT: RocketBase {
		LAUNCHER
	};
	class M_SPG9_HE: M_SPG9_HEAT {
		LAUNCHER
	};
	class M_NLAW_AT_F: MissileBase {
		LAUNCHER
	};
	class M_PG_AT: MissileBase {
		LAUNCHER
	};
	class M_AT: M_PG_AT {
		LAUNCHER
	};
	class G_40mm_HE: GrenadeBase {
		LAUNCHER
	};


	//	>>>	CUP	<<<

	class CUP_R_PG7V_AT: RocketBase {
		LAUNCHER
	};
	class CUP_R_PG7VL_AT: RocketBase {
		LAUNCHER
	};
	class CUP_R_PG7VR_AT: RocketBase {
		LAUNCHER
	};
	class CUP_R_OG7_AT: RocketBase {
		LAUNCHER
	};
	class CUP_R_PG9_AT: RocketBase {
		LAUNCHER
	};
	class CUP_R_OG9_HE: CUP_R_PG9_AT {
		LAUNCHER
	};
	class CUP_R_SMAW_HEDP: RocketBase {
		LAUNCHER
	};
	class CUP_R_SMAW_HEAA: CUP_R_SMAW_HEDP {
		LAUNCHER
	};
	class CUP_R_M136_AT: RocketBase {
		LAUNCHER
	};
	class CUP_R_MEEWS_HEDP: RocketBase {
		LAUNCHER
	};
	class CUP_R_MEEWS_HEAT: CUP_R_MEEWS_HEDP {
		LAUNCHER
	};
	class CUP_R_RPG18_AT: RocketBase {
		LAUNCHER
	};
	class CUP_R_SMAW_HEDP_N: RocketBase {
		LAUNCHER
	};
	class CUP_R_SMAW_HEAA_N: CUP_R_SMAW_HEDP_N {
		LAUNCHER
	};
	class CUP_R_M72A6_AT: RocketBase {
		LAUNCHER
	};


	//	>>>	RHS	- AFRF	<<<

	//	>>>	RHS	- USAF	<<<
};
