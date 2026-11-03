// GW default global mission settings.
// Included by the mission Description.ext so missions never carry a local copy.
// Mission specific values (briefingName, GW_FRAMEWORK) stay in Description.ext.
aiKills = 0;
allowFunctionsLog = 0;
allowFunctionsRecompile = 0;
disableChannels[]={{0,true,true},{1,false,true},{2,false,true},{5,false,true}};
disabledAi = 1;
ACE_maxWeightcarry = 3500;
ACE_maxWeightdrag = 4500;
enableDebugConsole = 1;
joinUnassigned = 1;
scriptedPlayer = 1;

corpseManagerMode = 3;
corpseLimit = 25; // Default: 15
corpseRemovalMinTime = 120; // seconds. Default: 10
corpseRemovalMaxTime = 3600; // seconds. Default: 3600
disposalCheckPeriod = 30; // seconds. Default: 10
minPlayerDistance[] = {400, 1200, 0}; // meters. Default: {0, 0, 0}
weaponholderManagerMode = 0; // Default: 0
wreckManagerMode = 1;
wreckLimit = 10; // seconds. Default: 15
wreckRemovalMinTime = 600; // seconds. Default: 10
wreckRemovalMaxTime = 3600; // seconds. Default: 36000 (10 hours)

respawn = "BASE";
respawnOnStart = 0;
respawnTemplates[] = {"Counter"};
respawnDelay = 20;
