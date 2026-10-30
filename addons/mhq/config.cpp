#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		author = "GuzzenVonLidl";
		name = "GW - MHQ Component";
		url = "https://github.com/GuzzenVonLidl/";
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {
			"A3_Sounds_F",
				"A3_Sounds_F_Decade",
			"GW_Core",
			"GW_Common",
			"GW_Gear"
		};
		version = VERSION;
		authors[] = {"GuzzenVonLidl"};
	};
};

#include "CfgEventHandlers.hpp"

class CfgSounds {
	class GW_MHQ_ActiveTerminal {
		name = "Mobile HQ Active Terminal";
		sound[] = {"\A3\Sounds_F\SFX\Objects\upload_terminal\upload_terminal_loop.wss", 0.65, 1, 18};
		titles[] = {};
	};
	class GW_MHQ_LockOpen {
		sound[] = {"\A3\Sounds_F_Decade\Assets\Props\LinkTerminal_01_Node_1_F\link_terminal01_lock_open.wss", 1, 1, 25};
		titles[] = {};
	};
	class GW_MHQ_LockClose: GW_MHQ_LockOpen {
		sound[] = {"\A3\Sounds_F_Decade\Assets\Props\LinkTerminal_01_Node_1_F\link_terminal01_lock_close.wss", 1, 1, 25};
	};
	class GW_MHQ_LidOpen: GW_MHQ_LockOpen {
		sound[] = {"\A3\Sounds_F_Decade\Assets\Props\LinkTerminal_01_Node_1_F\link_terminal01_lid_open.wss", 1, 1, 25};
	};
	class GW_MHQ_LidClose: GW_MHQ_LockOpen {
		sound[] = {"\A3\Sounds_F_Decade\Assets\Props\LinkTerminal_01_Node_1_F\link_terminal01_lid_close.wss", 1, 1, 25};
	};
	class GW_MHQ_LaptopOpen: GW_MHQ_LockOpen {
		sound[] = {"\A3\Sounds_F_Decade\Assets\Props\LinkTerminal_01_Node_1_F\link_terminal01_laptop_open.wss", 1, 1, 25};
	};
	class GW_MHQ_LaptopClose: GW_MHQ_LockOpen {
		sound[] = {"\A3\Sounds_F_Decade\Assets\Props\LinkTerminal_01_Node_1_F\link_terminal01_laptop_close.wss", 1, 1, 25};
	};
	class GW_MHQ_AntennaOpen: GW_MHQ_LockOpen {
		sound[] = {"\A3\Sounds_F_Decade\Assets\Props\LinkTerminal_01_Node_1_F\link_terminal01_antenna_open.wss", 1, 1, 25};
	};
	class GW_MHQ_AntennaClose: GW_MHQ_LockOpen {
		sound[] = {"\A3\Sounds_F_Decade\Assets\Props\LinkTerminal_01_Node_1_F\link_terminal01_antenna_close.wss", 1, 1, 25};
	};
	class GW_MHQ_SatelliteOpen: GW_MHQ_LockOpen {
		sound[] = {"\A3\Sounds_F_Decade\Assets\Props\LinkTerminal_01_Node_1_F\link_terminal01_satellite_open_01.wss", 1, 1, 25};
	};
	class GW_MHQ_SatelliteClose: GW_MHQ_LockOpen {
		sound[] = {"\A3\Sounds_F_Decade\Assets\Props\LinkTerminal_01_Node_1_F\link_terminal01_satellite_close_01.wss", 1, 1, 25};
	};
};
