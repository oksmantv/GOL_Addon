
NEKY_ServiceStation_Actions = compile preprocessFileLineNumbers "\x\gw\addons\serviceStation\Functions\AddActions.sqf";
NEKY_ServiceStation_Available = compile preprocessFileLineNumbers "\x\gw\addons\serviceStation\Functions\Available.sqf";
NEKY_ServiceStation_Busy = compile preprocessFileLineNumbers "\x\gw\addons\serviceStation\Functions\Busy.sqf";
NEKY_ServiceStation_ExitLoop = compile preprocessFileLineNumbers "\x\gw\addons\serviceStation\Functions\ExitLoop.sqf";
NEKY_ServiceStation_FullService = compile preprocessFileLineNumbers "\x\gw\addons\serviceStation\Functions\FullService.sqf";
NEKY_ServiceStation_Hints = compile preprocessFileLineNumbers "\x\gw\addons\serviceStation\Functions\Hints.sqf";
NEKY_ServiceStation_Lights = compile preprocessFileLineNumbers "\x\gw\addons\serviceStation\Functions\Lights.sqf";
NEKY_ServiceStation_MobileSS = compile preprocessFileLineNumbers "\x\gw\addons\serviceStation\Functions\MobileSS.sqf";
NEKY_ServiceStation_Rearm = compile preprocessFileLineNumbers "\x\gw\addons\serviceStation\Functions\Rearm.sqf";
NEKY_ServiceStation_Refuel = compile preprocessFileLineNumbers "\x\gw\addons\serviceStation\Functions\Refuel.sqf";
NEKY_ServiceStation_Repair = compile preprocessFileLineNumbers "\x\gw\addons\serviceStation\Functions\Repair.sqf";
NEKY_ServiceStation_Init = compile preprocessFileLineNumbers "\x\gw\addons\serviceStation\Functions\ServiceStation.sqf";

GW_ServiceStation_fnc_Init = CompileFinal "_this spawn NEKY_ServiceStation_Init;";
GW_ServiceStation_fnc_InitMobile = CompileFinal "[_this select 0] spawn NEKY_ServiceStation_MobileSS;";
