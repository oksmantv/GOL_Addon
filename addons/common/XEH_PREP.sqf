
PREP(addToCurators);
PREP(findAverage);
PREP(findMatch);
PREP(getfullMoonDates);
PREP(getPosASL);
PREP(getPosATL);
PREP(getPylonsAvailable);
PREP(getRespawn);
PREP(getRespawnMarker);
PREP(getRespawnObjects);
PREP(getSide);
PREP(getSunAngle);
PREP(getVersionAddon);
PREP(getVersionFramework);
PREP(hint);
//PREP(isDebugConsoleAllowed); // CfgFunction
PREP(isDevBuild);
PREP(isNight);
PREP(isNightSoon);
PREP(lowerWeapon);
PREP(loadSettingsFile);
PREP(setAIStatic);
PREP(setEditor);		// Legacy
PREP(setFramework);		// Legacy
PREP(setHideTerrainObjects);
//PREP(setTimeBySunAngle);
PREP(setSettingsTFAR);
PREP(setName);			// Legacy
PREP(quickRepair);

if ((getNumber(missionConfigFile >> "GW_Modules" >> "Common" >> "version")) >= 2.0) then {
	PREP(getGroupType);
	PREP(simpleRoster);
};
