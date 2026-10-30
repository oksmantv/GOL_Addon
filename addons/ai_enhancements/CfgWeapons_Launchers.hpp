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
		LAUNCHER_SINGLE_RPG_LONGRANGE_POOR_AIM
	};
};

class launch_RPG32_F: Launcher_Base_F {
	ReadAndWrite
	LAUNCHER_MAIN
	class Single: Mode_SemiAuto {
		LAUNCHER_SINGLE_RPG_LONGRANGE_POOR_AIM
	};
};

class rhs_weap_rpg7: Launcher_Base_F {
	ReadAndWrite
	LAUNCHER_MAIN
	class Single: Mode_SemiAuto {
		LAUNCHER_SINGLE_RPG_LONGRANGE_POOR_AIM
	};
};
