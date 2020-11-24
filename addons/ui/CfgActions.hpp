
class CfgActions {
	class None;
	class Rearm: None {
		show = 0;
	};
	class LoadMagazine;
	class LoadEmptyMagazine : LoadMagazine {
		showWindow = 0;
		textDefault = "";
	};
	class Gear: None {
		shortcut = "Gear";
		textDefault = "";	//	<img image='\A3\ui_f\data\igui\cfg\actions\gear_ca.paa' size='2.5' shadow=2 />
	};
	class GearOpen: None {
		shortcut = "Gear";
		textDefault = "";
	};

	// to pistol
	class HandGunOn: None {
		show = 0;
	};
	// to rifle
	class HandGunOff: None {
		show = 0;
	};

	// to launcher, (also used for binoculars?)
	class SwitchWeapon: None {
		show = 0;
	};
	class SwitchMagazine: SwitchWeapon {
		show = 1;
	};
	// no idea, probably unused
	class HideWeapon: SwitchWeapon {
		show = 0;
	};
};
