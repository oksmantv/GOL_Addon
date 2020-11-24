
class CfgVehicles {
	class Man;
	class CAManBase: Man {
		class ACE_SelfActions {
			class ACE_Equipment {
				class GW_Place_Static_Mortar {
					displayName = "Place down Static Weapon";
					condition = "[_player] call GW_StaticWeapons_Fnc_canDeploy";
					statement = "[_player] call GW_StaticWeapons_Fnc_Deploy";
				};
			};
		};
	};
	class LandVehicle;
	class StaticWeapon: LandVehicle {
		class ACE_Actions {
			class ACE_MainActions {
				selection = "gunnerview";
				distance = 4;
				condition = "true";
				class GW_Pack_Static_To_Item {
					displayName = "Pack Weapon";
					distance = 4;
					condition = "[_player, _target] call GW_StaticWeapons_Fnc_canPickUp";
					statement = "[_player, _target] call GW_StaticWeapons_Fnc_packStatic";
				};
			};

		};
	};
};
