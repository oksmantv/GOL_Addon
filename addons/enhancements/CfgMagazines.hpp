
class CfgMagazines {
	class CA_Magazine;
	class 150Rnd_762x51_Box: CA_Magazine {
		descriptionShort = "Caliber: 7.62x51 mm<br/>Rounds: 150<br />Used in: Zafir";
	};
	class 150Rnd_762x51_Box_Tracer: 150Rnd_762x51_Box {
		displayName = "7.62 mm 150Rnd Tracer Box (Green)";
		descriptionShort = "Caliber: 7.62x51 mm Tracer - Green<br/>Rounds: 150<br />Used in: Zafir";
	};
	class 150Rnd_762x51_Box_Tracer_Red: 150Rnd_762x51_Box_Tracer {
		author = "GuzzenVonLidl";
		displayName = "7.62 mm 150Rnd Tracer Box (Red)";
		descriptionShort = "Caliber: 7.62x51 mm Tracer - Red<br/>Rounds: 150<br />Used in: Zafir";
		ammo = "B_762x51_Tracer_Red";
	};
	class 150Rnd_762x51_Box_Tracer_Yellow: 150Rnd_762x51_Box_Tracer {
		author = "GuzzenVonLidl";
		displayName = "7.62 mm 150Rnd Tracer Box (Yellow)";
		descriptionShort = "Caliber: 7.62x51 mm Tracer - Yellow<br/>Rounds: 150<br />Used in: Zafir";
		ammo = "B_762x51_Tracer_Yellow";
	};
	class 150Rnd_762x54_Box: CA_Magazine {
		scope = 2;
		count = 150;
		displayName = "7.62 mm 150Rnd Tracer Box";
		descriptionShort = "Caliber: 7.62x54 mm<br/>Rounds: 150<br />Used in: Zafir";
		lastRoundsTracer = 4;
		nameSound = "mgun";
		picture = "\A3\Weapons_F_Beta\Data\UI\m_150Rnd_762x51_CA.paa";
		tracersEvery = 5;
	};
	class 150Rnd_762x54_Box_Tracer: 150Rnd_762x54_Box {
		displayName = "7.62 mm 150Rnd Tracer Box (Green)";
	};
	class 150Rnd_762x54_Box_Tracer_Red: 150Rnd_762x54_Box_Tracer {
		author = "GuzzenVonLidl";
		displayName = "7.62 mm 150Rnd Tracer Box (Red)";
		ammo = "B_762x54_Tracer_Red";
		descriptionShort = "Caliber: 7.62x54 mm Tracer - Red<br/>Rounds: 150<br />Used in: Zafir";
	};
	class 150Rnd_762x54_Box_Tracer_Yellow: 150Rnd_762x54_Box_Tracer {
		author = "GuzzenVonLidl";
		displayName = "7.62 mm 150Rnd Tracer Box (Yellow)";
		ammo = "B_762x54_Tracer_Yellow";
		descriptionShort = "Caliber: 7.62x54 mm Tracer - Yellow<br/>Rounds: 150<br />Used in: Zafir";
	};
	class 30Rnd_545x39_Mag_F: CA_Magazine {
		descriptionShort = "Caliber: 5.45x39 mm<br />Rounds: 30<br />Used in: AK-12/AK-74/AKS-74U";
	};
};
