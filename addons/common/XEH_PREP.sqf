
PREP(addToCurators);
PREP(buildingPop);
PREP(findAverage);
PREP(findMatch);
PREP(getClassnameByRole);
PREP(getfullMoonDates);
PREP(getPosASL);
PREP(getPosATL);
PREP(getPylonsAvailable);
PREP(getRespawn);
PREP(getRespawnMarker);
PREP(getRespawnObjects);
PREP(getSide);
PREP(getSunAngle);
PREP(getGroupType);
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
PREP(setAttributes);
PREP(setAttributes3DEN);
PREP(setEditor);		// Legacy
PREP(setFramework);		// Legacy
PREP(setGroupAction);
PREP(setGroupColor);
PREP(setGroupId);
PREP(setHideTerrainObjects);
//PREP(setTimeBySunAngle);
PREP(setSettingsTFAR);
PREP(setName);			// Legacy
PREP(quickRepair);
PREP(simpleRoster);
PREP(spawn3DEN);
PREP(spawn3DENObjects);
PREP(spawnGroup);
PREP(spawnHandler);
PREP(spawnObjects);

if (is3DEN) then {
	PREP(setAttributes3DEN);
	PREP(spawn3DEN);
	PREP(spawn3DENObjects);
};
