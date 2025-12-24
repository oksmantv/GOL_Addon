#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	Import CBA Settings from file

	Usage:
	[] spawn GW_3DEN_fnc_importCBASettings;

	Arguments: NO

	Return Value: NO

	Public: NO

*/

private _settingsFile = "CurrentAddonOptionsImportSettings.txt";

if (fileExists _settingsFile) then {
	// Read settings file
	private _settingsContent = preprocessFileLineNumbers _settingsFile;
	
	if (_settingsContent isEqualTo "") then {
		LOG_1("Error: CBA settings file is empty: %1", _settingsFile);
	} else {
		LOG_2("CBA Settings file loaded: %1 (%2 characters)", _settingsFile, count _settingsContent);
		
		// Open CBA menu first to initialize temp namespaces
		disableUserInput true;
		((findDisplay 313) call CBA_settings_fnc_openSettingsMenu);
		
		waitUntil {!isNull (uiNamespace getVariable ["RscDisplayGameOptions", displayNull])};
		uiSleep 0.1;
		
		// Set source to mission
		uiNamespace setVariable ["cba_settings_source", "mission"];
		
		// Import settings into temp namespace
		[_settingsContent, "mission"] call CBA_settings_fnc_import;
		
		LOG("CBA Settings imported successfully");
		uiSleep 0.1;
		
		// Save the imported settings
		[] call CBA_settings_fnc_gui_saveTempData;
		LOG("CBA Settings saved to mission");
		
		uiSleep 0.1;
		(uiNamespace getVariable "RscDisplayGameOptions") closeDisplay 1;
		uiSleep 0.1;
		disableUserInput false;
	};
} else {
	LOG_1("Warning: CBA settings file not found at: %1", _settingsFile);
};
