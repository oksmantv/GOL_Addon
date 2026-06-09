// GW Gear — Standard Faction Switcher (Addon Authoritative)
// Included from mission's factions_addon.sqf default case.
// Mirrors mission's original factions.sqf switch, minus the CUSTOM-* cases
// (those remain mission-local and are dispatched by factions_addon.sqf).
// Uses addon-relative #include paths into scripts/Factions/.

switch (_side) do {
	case "AAF-W": {
		#include "Factions\AAF-W.sqf"
	};
	case "AAF-SF-W": {
		#include "Factions\AAF-SF-W.sqf"
	};
	case "IRISH-UN": {
		#include "Factions\IRISH-UN.sqf"
	};
	case "CBRN-WINTER": {
		#include "Factions\CBRN-WINTER.sqf"
	};
	case "BAF-W": {
		#include "Factions\BAF-W.sqf"
	};
	case "BAF-D": {
		#include "Factions\BAF-D.sqf"
	};
	case "CTRG-W": {
		#include "Factions\CTRG-W.sqf"
	};
	case "CTRG-D": {
		#include "Factions\CTRG-D.sqf"
	};
	case "BAF-W-FALK": {
		#include "Factions\BAF-W-FALK.sqf"
	};
	case "FRANCE-D": {
		#include "Factions\FRANCE-D.sqf"
	};
	case "FRANCE-W": {
		#include "Factions\FRANCE-W.sqf"
	};
	case "RWANDA-W": {
		#include "Factions\RWANDA-W.sqf"
	};
	case "UKRAINE-W": {
		#include "Factions\UKRAINE-W.sqf"
	};
	case "CIVI-AFRICA": {
		#include "Factions\CIVI-AFRICA.sqf"
	};
	case "CIVI-ALTIS": {
		#include "Factions\CIVI-ALTIS.sqf"
	};
	case "CIVI-CHERNARUS": {
		#include "Factions\CIVI-CHERNARUS.sqf"
	};
	case "CIVI-TAKISTAN": {
		#include "Factions\CIVI-TAKISTAN.sqf"
	};
	case "FINLAND-W": {
		#include "Factions\FINLAND-W.sqf"
	};
	case "LIVONIA-W": {
		#include "Factions\LIVONIA-W.sqf"
	};
	case "CZECH-W": {
		#include "Factions\CZECH-W.sqf"
	};
	case "CZECH-D": {
		#include "Factions\CZECH-D.sqf"
	};
	case "CZECH-SOVIET-W": {
		#include "Factions\CZECH-SOVIET-W.sqf"
	};
	case "TURKEY-D": {
		#include "Factions\TURKEY-D.sqf"
	};
	case "TANOA-SF": {
		#include "Factions\TANOA-SF.sqf"
	};
	case "TANOA-ARMY": {
		#include "Factions\TANOA-ARMY.sqf"
	};
	case "SYRIA-W": {
		#include "Factions\SYRIA-W.sqf"
	};
	case "CDF-W": {
		#include "Factions\CDF-W.sqf"
	};
	case "CHDKZ-SF-W": {
		#include "Factions\CHDKZ-SF-W.sqf"
	};
	case "CSAT-H": {
		#include "Factions\CSAT-H.sqf"
	};
	case "CSAT-SF-W": {
		#include "Factions\CSAT-SF-W.sqf"
	};
	case "CSAT-W": {
		#include "Factions\CSAT-W.sqf"
	};
	case "CSAT-U": {
		#include "Factions\CSAT-U.sqf"
	};
	case "ISLAMICSTATE": {
		#include "Factions\ISLAMICSTATE.sqf"
	};
	case "TAKISTAN-D": {
		#include "Factions\TAKISTAN-D.sqf"
	};
	case "TAKISTAN-SF-D": {
		#include "Factions\TAKISTAN-SF-D.sqf"
	};
	case "AFRICAN-ARMY": {
		#include "Factions\AFRICAN-ARMY.sqf"
	};
	case "INSURGENT-ME": {
		#include "Factions\INSURGENT-ME.sqf"
	};
	case "INSURGENT-CHDKZ": {
		#include "Factions\INSURGENT-CHDKZ.sqf"
	};
	case "INSURGENT-AFRICA": {
		#include "Factions\INSURGENT-AFRICA.sqf"
	};
	case "INSURGENT-TANOA": {
		#include "Factions\INSURGENT-TANOA.sqf"
	};
	case "INSURGENT-FIA": {
		#include "Factions\INSURGENT-FIA.sqf"
	};
	case "INSURGENT-MALDEN": {
		#include "Factions\INSURGENT-MALDEN.sqf"
	};
	case "AUS-TAN": {
		#include "Factions\AUS-TAN.sqf"
	};
	case "IRAQ-SF": {
		#include "Factions\IRAQ-SF.sqf"
	};
	case "AFGHAN-W": {
		#include "Factions\AFGHAN-W.sqf"
	};
	case "NATO-D": {
		#include "Factions\NATO-D.sqf"
	};
	case "NATO-W": {
		#include "Factions\NATO-W.sqf"
	};
	case "MALDEN-W": {
		#include "Factions\MALDEN-W.sqf"
	};
	case "GERMAN-W": {
		#include "Factions\GERMAN-W.sqf"
	};
	case "GERMAN-D": {
		#include "Factions\GERMAN-D.sqf"
	};
	case "PMC": {
		#include "Factions\PMC.sqf"
	};
	case "SOVIET-D": {
		#include "Factions\SOVIET-D.sqf"
	};
	case "SOVIET-SF-D": {
		#include "Factions\SOVIET-SF-D.sqf"
	};
	case "SOVIET-W": {
		#include "Factions\SOVIET-W.sqf"
	};
	case "RUSSIAN-W": {
		#include "Factions\RUSSIAN-W.sqf"
	};
	case "RUSSIAN-SF-W": {
		#include "Factions\RUSSIAN-SF-W.sqf"
	};
	case "USA-CW-W": {
		#include "Factions\USA-CW-W.sqf"
	};
	case "USA-W": {
		#include "Factions\USA-W.sqf"
	};
	case "USA-D": {
		#include "Factions\USA-D.sqf"
	};
	case "USMC-D": {
		#include "Factions\USMC-D.sqf"
	};
	case "USMC-W": {
		#include "Factions\USMC-W.sqf"
	};
	case "SWEDISH": {
		#include "Factions\SWEDISH.sqf"
	};
	case "ISRAELI": {
		#include "Factions\ISRAELI.sqf"
	};
	case "CHINA": {
		#include "Factions\CHINA.sqf"
	};
	case "CUSTOM-W": {
		if (fileExists "CustomGear\CUSTOM-W.sqf") then {
			call compile preProcessFileLineNumbers "CustomGear\CUSTOM-W.sqf";
		} else {
			_errorCode = true;
			ERROR("CUSTOM-W selected but CustomGear\CUSTOM-W.sqf not found");
		};
	};
	case "CUSTOM-E": {
		if (fileExists "CustomGear\CUSTOM-E.sqf") then {
			call compile preProcessFileLineNumbers "CustomGear\CUSTOM-E.sqf";
		} else {
			_errorCode = true;
			ERROR("CUSTOM-E selected but CustomGear\CUSTOM-E.sqf not found");
		};
	};
	case "CUSTOM-I": {
		if (fileExists "CustomGear\CUSTOM-I.sqf") then {
			call compile preProcessFileLineNumbers "CustomGear\CUSTOM-I.sqf";
		} else {
			_errorCode = true;
			ERROR("CUSTOM-I selected but CustomGear\CUSTOM-I.sqf not found");
		};
	};
	default {
		_errorCode = true;
		ERROR(FORMAT_1("Faction does not exist: %1", _side));
	};
};

