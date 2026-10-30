class LMG_RCWS;
class MGun;
class PKT;

class rhs_weap_DSHKM: LMG_RCWS {
	aiDispersionCoefX = 21;
	aiDispersionCoefY = 21;
	class manual: MGun {};
	class close: manual {
		aiBurstTerminable = 0;
		aiDispersionCoefX = 21;
		aiDispersionCoefY = 21;
	};
	class short: close {
		aiBurstTerminable = 0;
	};
	class medium: close {
		aiBurstTerminable = 0;
	};
	class far: close {
		aiBurstTerminable = 0;
	};
};

class rhs_weap_nsvt: rhs_weap_DSHKM {
	aiDispersionCoefX = 21;
	aiDispersionCoefY = 21;
	class manual: MGun {};
	class close: manual {
		aiBurstTerminable = 0;
		aiDispersionCoefX = 21;
		aiDispersionCoefY = 21;
	};
	class short: close {
		aiBurstTerminable = 0;
	};
	class medium: close {
		aiBurstTerminable = 0;
	};
	class far: close {
		aiBurstTerminable = 0;
	};
};

class rhs_weap_pkt: PKT {
	aiDispersionCoefX = 21;
	aiDispersionCoefY = 21;
	class manual: MGun {};
	class close: manual {
		aiBurstTerminable = 0;
		aiDispersionCoefX = 21;
		aiDispersionCoefY = 21;
	};
	class short: close {
		aiBurstTerminable = 0;
	};
	class medium: close {
		aiBurstTerminable = 0;
	};
	class far: close {
		aiBurstTerminable = 0;
	};
};

class rhs_weap_kpvt: MGun {
	aiDispersionCoefX = 21;
	aiDispersionCoefY = 21;
	class manual: MGun {};
	class close: manual {
		aiBurstTerminable = 0;
		aiDispersionCoefX = 21;
		aiDispersionCoefY = 21;
	};
	class short: close {
		aiBurstTerminable = 0;
	};
	class medium: close {
		aiBurstTerminable = 0;
	};
	class far: close {
		aiBurstTerminable = 0;
	};
};
