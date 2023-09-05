class CfgWeapons {
	class ItemCore;
	class InventoryFirstAidKitItem_Base_F;
	class GW_Item_StaticDummy: ItemCore {
		scope = 2;
		_generalMacro = "GW_Item_StaticDummy";
		displayName = "Static Weapon (Packed)";
		descriptionUse = "Extreme packing";
		descriptionShort = "Static Weapon (Packed)";
		picture = "\A3\Weapons_F\Items\data\UI\gear_Toolkit_CA.paa";
		model = "\A3\Weapons_F\Items\Toolkit";
		class ItemInfo: InventoryFirstAidKitItem_Base_F {
			mass = 60;
		};
	};
};
