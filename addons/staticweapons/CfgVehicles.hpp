class CfgVehicles {
	class ThingX;

	class GW_Item_StaticDummy: ThingX {
		scope = 2;
		scopeCurator = 0;
		displayName = "Static Weapon (Packed - Destroyed)";
		model = "\A3\Weapons_F\Items\Toolkit";
		simulation = "thingX";
		destructType = "DestructNo";
		armor = 100;

		class EventHandlers {
			init = "(_this select 0) setDamage [1, false];";
		};
	};
};