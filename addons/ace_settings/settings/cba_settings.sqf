// ACE Advanced Ballistics ----------------------------------------------------------------------
force ace_advanced_ballistics_ammoTemperatureEnabled = true;
force ace_advanced_ballistics_barrelLengthInfluenceEnabled = true;
force ace_advanced_ballistics_bulletTraceEnabled = true;
force ace_advanced_ballistics_enabled = false;
force ace_advanced_ballistics_muzzleVelocityVariationEnabled = true;
force ace_advanced_ballistics_simulationInterval = 0.05;

// ACE Advanced Fatigue ----------------------------------------------------------------------
force ace_advanced_fatigue_enabled = true;
force ace_advanced_fatigue_enableStaminaBar = false;
force ace_advanced_fatigue_fadeStaminaBar = true;
force ace_advanced_fatigue_loadFactor = 0;
force ace_advanced_fatigue_performanceFactor = 1;
force ace_advanced_fatigue_recoveryFactor = 2;
force ace_advanced_fatigue_swayFactor = 1.2;
force ace_advanced_fatigue_terrainGradientFactor = 0.5;

// ACE Advanced Throwing ----------------------------------------------------------------------
force ace_advanced_throwing_enabled = true;
force ace_advanced_throwing_enablePickUp = true;
force ace_advanced_throwing_enablePickUpAttached = true;
force ace_advanced_throwing_showMouseControls = true;
force ace_advanced_throwing_showThrowArc = true;

// ACE Arsenal ----------------------------------------------------------------------
// force ace_arsenal_allowDefaultLoadouts = true;
force ace_arsenal_allowSharedLoadouts = false;
// force ace_arsenal_camInverted = false;
force ace_arsenal_enableIdentityTabs = false;
// force ace_arsenal_enableModIcons = true;
// force ace_arsenal_EnableRPTLog = false;
// force ace_arsenal_fontHeight = 4.5;

// ACE Artillery ----------------------------------------------------------------------
force ace_artillerytables_advancedCorrections = false;
force ace_artillerytables_disableArtilleryComputer = false;
force ace_mk6mortar_airResistanceEnabled = false;
force ace_mk6mortar_allowCompass = true;
force ace_mk6mortar_allowComputerRangefinder = false;
force ace_mk6mortar_useAmmoHandling = false;

// ACE Captives ----------------------------------------------------------------------
force ace_captives_allowHandcuffOwnSide = true;
force ace_captives_allowSurrender = true;
force ace_captives_requireSurrender = 1;
force ace_captives_requireSurrenderAi = false;

// ACE Common ----------------------------------------------------------------------
// force ace_common_allowFadeMusic = true;
force ace_common_checkPBOsAction = 0;
force ace_common_checkPBOsCheckAll = false;
force ace_common_checkPBOsWhitelist = "[""ace_tracers""]";
//force ace_common_settingFeedbackIcons = 1;
//force ace_common_settingProgressBarLocation = 0;
//force ace_noradio_enabled = true;
ace_parachute_hideAltimeter = true;

// ACE Cook off ----------------------------------------------------------------------
force ace_cookoff_ammoCookoffDuration = 2.3;
force ace_cookoff_enable = 1;
force ace_cookoff_enableAmmobox = true;
force ace_cookoff_enableAmmoCookoff = false;
force ace_cookoff_probabilityCoef = 0.7;

// ACE Crew Served Weapons ----------------------------------------------------------------------
force ace_csw_ammoHandling = 2;
force ace_csw_defaultAssemblyMode = false;
force ace_csw_dragAfterDeploy = true;
force ace_csw_handleExtraMagazines = true;
force ace_csw_progressBarTimeCoefficent = 1;

// ACE Explosives ----------------------------------------------------------------------
force ace_explosives_explodeOnDefuse = true;
force ace_explosives_punishNonSpecialists = false;
force ace_explosives_requireSpecialist = false;

// ACE Fragmentation Simulation ----------------------------------------------------------------------
force ace_frag_enabled = true;
force ace_frag_maxTrack = 25;
force ace_frag_maxTrackPerFrame = 15;
force ace_frag_reflectionsEnabled = true;
force ace_frag_spallEnabled = true;

// ACE Goggles ----------------------------------------------------------------------
force ace_goggles_effects = 2;
ace_goggles_showClearGlasses = true;
force ace_goggles_showInThirdPerson = false;

// ACE Hearing ----------------------------------------------------------------------
force ace_hearing_autoAddEarplugsToUnits = false;
force ace_hearing_disableEarRinging = false;
force ace_hearing_earplugsVolume = 0.5;
force ace_hearing_enableCombatDeafness = false;
force ace_hearing_enabledForZeusUnits = false;
force ace_hearing_unconsciousnessVolume = 0.4;

// ACE Interaction ----------------------------------------------------------------------
force ace_interaction_disableNegativeRating = false;
force ace_interaction_enableMagazinePassing = true;
force ace_interaction_enableTeamManagement = true;

// ACE Logistics ----------------------------------------------------------------------
force ace_cargo_enable = true;
force ace_cargo_loadTimeCoefficient = 5;
force ace_cargo_paradropTimeCoefficent = 2.5;
force ace_rearm_distance = 20;
force ace_rearm_level = 0;
force ace_rearm_supply = 0;
force ace_refuel_hoseLength = 12;
force ace_refuel_rate = 1;
force ace_repair_addSpareParts = true;
force ace_repair_autoShutOffEngineWhenStartingRepair = true;
force ace_repair_consumeItem_toolKit = 0;
force ace_repair_displayTextOnRepair = true;
force ace_repair_engineerSetting_fullRepair = 0;
force ace_repair_engineerSetting_repair = 0;
force ace_repair_engineerSetting_wheel = 0;
force ace_repair_fullRepairLocation = 0;
force ace_repair_fullRepairRequiredItems = ["ToolKit"];
force ace_repair_miscRepairRequiredItems = ["ToolKit"];
force ace_repair_repairDamageThreshold = 0.6;
force ace_repair_repairDamageThreshold_engineer = 0.4;
force ace_repair_wheelRepairRequiredItems = [];

// ACE Magazine Repack ----------------------------------------------------------------------
force ace_magazinerepack_timePerAmmo = 1.5;
force ace_magazinerepack_timePerBeltLink = 8;
force ace_magazinerepack_timePerMagazine = 2;

// ACE Map ----------------------------------------------------------------------
force ace_map_BFT_Enabled = false;
force ace_map_BFT_HideAiGroups = false;
force ace_map_BFT_Interval = 15;
force ace_map_BFT_ShowPlayerNames = false;
force ace_map_DefaultChannel = 1;
force ace_map_mapGlow = true;
force ace_map_mapIllumination = true;
force ace_map_mapLimitZoom = false;
force ace_map_mapShake = true;
force ace_map_mapShowCursorCoordinates = false;
force ace_markers_moveRestriction = 0;

// ACE Map Gestures ----------------------------------------------------------------------
force ace_map_gestures_defaultColor = [1,0.88,0,0.7];
force ace_map_gestures_defaultLeadColor = [1,0.88,0,0.95];
force ace_map_gestures_enabled = true;
force ace_map_gestures_interval = 0.05;
force ace_map_gestures_maxRange = 10;
force ace_map_gestures_nameTextColor = [0.2,0.2,0.2,0.3];

// ACE Map Tools ----------------------------------------------------------------------
force ace_maptools_drawStraightLines = true;
force ace_maptools_rotateModifierKey = 1;

// ACE Name Tags ----------------------------------------------------------------------
force ace_nametags_defaultNametagColor = [0.77,0.51,0.08,1];
force ace_nametags_nametagColorBlue = [0.67,0.67,1,1];
force ace_nametags_nametagColorGreen = [0.67,1,0.67,1];
force ace_nametags_nametagColorMain = [1,1,1,1];
force ace_nametags_nametagColorRed = [1,0.67,0.67,1];
force ace_nametags_nametagColorYellow = [1,1,0.67,1];
force ace_nametags_playerNamesMaxAlpha = 0.8;
force ace_nametags_playerNamesViewDistance = 25;
force ace_nametags_showCursorTagForVehicles = false;
force ace_nametags_showNamesForAI = false;
ace_nametags_showPlayerNames = 1;
force ace_nametags_showPlayerRanks = false;
force ace_nametags_showSoundWaves = 0;
force ace_nametags_showVehicleCrewInfo = true;
force ace_nametags_tagSize = 2;

// ACE Nightvision ----------------------------------------------------------------------
force ace_nightvision_aimDownSightsBlur = 0.75;
force ace_nightvision_disableNVGsWithSights = false;
force ace_nightvision_effectScaling = 0.5;
force ace_nightvision_fogScaling = 0;
force ace_nightvision_noiseScaling = 0.1;
force ace_nightvision_shutterEffects = true;

// ACE Overheating ----------------------------------------------------------------------
ace_overheating_displayTextOnJam = true;
force ace_overheating_enabled = true;
force ace_overheating_overheatingDispersion = true;
ace_overheating_showParticleEffects = true;
force ace_overheating_showParticleEffectsForEveryone = false;
force ace_overheating_unJamFailChance = 0.2;
force ace_overheating_unJamOnreload = true;

// ACE Pointing ----------------------------------------------------------------------
force ace_finger_enabled = true;
//force ace_finger_indicatorColor = [0.83,0.68,0.21,0.75];
//force ace_finger_indicatorForSelf = true;
force ace_finger_maxRange = 10;

// ACE Pylons ----------------------------------------------------------------------
force ace_pylons_enabledForZeus = true;
force ace_pylons_enabledFromAmmoTrucks = true;
force ace_pylons_rearmNewPylons = true;
force ace_pylons_requireEngineer = false;
force ace_pylons_requireToolkit = false;
force ace_pylons_searchDistance = 20;
force ace_pylons_timePerPylon = 5;

// ACE Quick Mount ----------------------------------------------------------------------
force ace_quickmount_distance = 7;
ace_quickmount_enabled = true;
force ace_quickmount_enableMenu = 3;
force ace_quickmount_priority = 3;
force ace_quickmount_speed = 10;

// ACE Respawn ----------------------------------------------------------------------
force ace_respawn_removeDeadBodiesDisconnected = false;
force ace_respawn_savePreDeathGear = false;

// ACE Scopes ----------------------------------------------------------------------
force ace_scopes_correctZeroing = true;
force ace_scopes_deduceBarometricPressureFromTerrainAltitude = false;
force ace_scopes_defaultZeroRange = 100;
force ace_scopes_enabled = true;
force ace_scopes_forceUseOfAdjustmentTurrets = false;
force ace_scopes_overwriteZeroRange = false;
force ace_scopes_simplifiedZeroing = false;
force ace_scopes_useLegacyUI = false;
force ace_scopes_zeroReferenceBarometricPressure = 1013.25;
force ace_scopes_zeroReferenceHumidity = 0;
force ace_scopes_zeroReferenceTemperature = 15;

// ACE Spectator ----------------------------------------------------------------------
force ace_spectator_enableAI = false;
force ace_spectator_maxFollowDistance = 5;
force ace_spectator_restrictModes = 0;
force ace_spectator_restrictVisions = 0;

// ACE Switch Units ----------------------------------------------------------------------
force ace_switchunits_enableSafeZone = true;
force ace_switchunits_enableSwitchUnits = false;
force ace_switchunits_safeZoneRadius = 100;
force ace_switchunits_switchToCivilian = false;
force ace_switchunits_switchToEast = false;
force ace_switchunits_switchToIndependent = false;
force ace_switchunits_switchToWest = false;

// ACE Uncategorized ----------------------------------------------------------------------
force ace_fastroping_requireRopeItems = true;
force ace_gforces_enabledFor = 1;
force ace_hitreactions_minDamageToTrigger = 0.1;
//force ace_inventory_inventoryDisplaySize = 0;
//force ace_laser_dispersionCount = 2;
//force ace_microdagr_mapDataAvailable = 2;
//force ace_microdagr_waypointPrecision = 3;
force ace_optionsmenu_showNewsOnMainMenu = false;
force ace_overpressure_distanceCoefficient = 2;
force ace_tagging_quickTag = 1;

// ACE Vehicle Lock ----------------------------------------------------------------------
force ace_vehiclelock_defaultLockpickStrength = 10;
force ace_vehiclelock_lockVehicleInventory = false;
force ace_vehiclelock_vehicleStartingLockState = -1;

// ACE Vehicles ----------------------------------------------------------------------
//force ace_vehicles_hideEjectAction = true;
force ace_vehicles_keepEngineRunning = true;
force ace_vehicles_speedLimiterStep = 1;

// ACE View Distance Limiter ----------------------------------------------------------------------
force ace_viewdistance_enabled = false;
force ace_viewdistance_limitViewDistance = 10000;
force ace_viewdistance_objectViewDistanceCoeff = 0;
force ace_viewdistance_viewDistanceAirVehicle = 0;
force ace_viewdistance_viewDistanceLandVehicle = 0;
force ace_viewdistance_viewDistanceOnFoot = 0;

// ACE Weapons ----------------------------------------------------------------------
force ace_common_persistentLaserEnabled = false;
force ace_laserpointer_enabled = true;
force ace_reload_displayText = true;
force ace_reload_showCheckAmmoSelf = true;
force ace_weaponselect_displayText = true;

// ACE Weather ----------------------------------------------------------------------
force ace_weather_enabled = true;
force ace_weather_showCheckAirTemperature = true;
force ace_weather_updateInterval = 60;
force ace_weather_windSimulation = false;

// ACE Wind Deflection ----------------------------------------------------------------------
force ace_winddeflection_enabled = false;
force ace_winddeflection_simulationInterval = 0.05;
force ace_winddeflection_vehicleEnabled = false;

// ACE Zeus ----------------------------------------------------------------------
force ace_zeus_autoAddObjects = false;
force ace_zeus_canCreateZeus = -1;
force ace_zeus_radioOrdnance = false;
force ace_zeus_remoteWind = false;
force ace_zeus_revealMines = 0;
force ace_zeus_zeusAscension = false;
force ace_zeus_zeusBird = false;

// Task Force Radio - Global Settings

force TFAR_AICanHearPlayer = true;
force TFAR_AICanHearSpeaker = false;
force TFAR_allowDebugging = true;
TFAR_curatorCamEars = true;
force TFAR_defaultIntercomSlot = 0;
force TFAR_enableIntercom = true;
force TFAR_experimentalVehicleIsolation = true;
force TFAR_fullDuplex = true;
force TFAR_giveLongRangeRadioToGroupLeaders = false;
force TFAR_giveMicroDagrToSoldier = false;
force TFAR_givePersonalRadioToRegularSoldier = true;
force TFAR_globalRadioRangeCoef = 1;
force TFAR_instantiate_instantiateAtBriefing = false;
TFAR_noAutomoveSpectator = false;
force TFAR_objectInterceptionEnabled = true;
force TFAR_objectInterceptionStrength = 400;
force tfar_radiocode_east = "_opfor";
force tfar_radiocode_independent = "_independent";
force tfar_radiocode_west = "_bluefor";
force tfar_radioCodesDisabled = false;
force TFAR_SameLRFrequenciesForSide = false;
force TFAR_SameSRFrequenciesForSide = false;
TFAR_setting_defaultFrequencies_lr_east = "";
TFAR_setting_defaultFrequencies_lr_independent = "";
TFAR_setting_defaultFrequencies_lr_west = "";
TFAR_setting_defaultFrequencies_sr_east = "";
TFAR_setting_defaultFrequencies_sr_independent = "";
TFAR_setting_defaultFrequencies_sr_west = "";
TFAR_setting_DefaultRadio_Airborne_east = "TFAR_mr6000l";
TFAR_setting_DefaultRadio_Airborne_Independent = "TFAR_anarc164";
TFAR_setting_DefaultRadio_Airborne_West = "TFAR_anarc210";
TFAR_setting_DefaultRadio_Backpack_east = "TFAR_mr3000";
TFAR_setting_DefaultRadio_Backpack_Independent = "TFAR_anprc155";
TFAR_setting_DefaultRadio_Backpack_west = "TFAR_rt1523g";
TFAR_setting_DefaultRadio_Personal_east = "TFAR_fadak";
TFAR_setting_DefaultRadio_Personal_Independent = "TFAR_anprc148jem";
TFAR_setting_DefaultRadio_Personal_West = "TFAR_anprc152";
TFAR_setting_DefaultRadio_Rifleman_East = "TFAR_pnr1000a";
TFAR_setting_DefaultRadio_Rifleman_Independent = "TFAR_anprc154";
TFAR_setting_DefaultRadio_Rifleman_West = "TFAR_rf7800str";
force TFAR_spectatorCanHearEnemyUnits = true;
force TFAR_spectatorCanHearFriendlies = true;
force TFAR_takingRadio = 2;
force TFAR_Teamspeak_Channel_Name = "TaskForceRadio";
force TFAR_Teamspeak_Channel_Password = "123";
force tfar_terrain_interception_coefficient = 7;
force TFAR_voiceCone = true;
