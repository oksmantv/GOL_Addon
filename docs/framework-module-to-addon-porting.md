# GW Framework — Module-to-Addon Porting Guide

## Purpose

This document is the canonical reference for migrating a GOL Framework mission module
(`Modules/<Name>/`) into a standalone GW addon component (`p:\x\GW\addons\<name>\`).

It covers the general pattern, a migration checklist, key decisions made per module, and common
pitfalls.

---

## Why Move Modules to the Addon?

| Problem (module in mission) | Solution (module in addon) |
|---|---|
| Every new mission needs the module folder copied in | Addon ships with every build; no copy needed |
| Bug fixes require updating every mission individually | Fix once in addon, all missions benefit |
| Updating `Modules/` during a mission refresh can overwrite customisations | Only `Core/` and `Modules/` are replaced on update; addon is separate |
| Module is not always loaded (depends on `Modules.cpp`) | Addon loads unconditionally via CBA XEH |

---

## Addon File Structure (Standard Template)

```
p:\x\GW\addons\<name>\
    $PBOPREFIX$            ← x\gw\addons\<Name>  (no trailing newline issues)
    $PBOPREFIX$.txt        ← x\gw\addons\<Name>\nversion=GuzzenVonLidl
    script_component.hpp   ← #define COMPONENT + macro chain
    config.cpp             ← CfgPatches + CfgEventHandlers + any config classes
    CfgEventHandlers.hpp   ← Extended_PreInit / Extended_PostInit registrations
    XEH_preInit.sqf        ← PREP calls + GVAR init + CBA settings registration
    XEH_PREP.sqf           ← One PREP(FunctionName) per function
    XEH_postInit.sqf       ← CBA event handlers, ACE actions, class EHs
    functions\
        script_component.hpp   ← redirects to addon root: #include "\x\gw\addons\<name>\script_component.hpp"
        fn_FunctionA.sqf
        fn_FunctionB.sqf
        ...
```

Additional optional folders:
- `Scripts\` — inline-included configuration files (e.g. `Init_TFAR.sqf`, `Init_ACRE.sqf`)
- `CfgXxx.hpp` — extracted config class definitions (e.g. `CfgBehaviour.hpp`, `CfgRscTitles.hpp`)

---

## Standard Boilerplate Files

### `script_component.hpp`

```cpp
#define COMPONENT <Name>
#include "\x\gw\addons\main\script_mod.hpp"

#ifdef DEBUG_ENABLED_<Name>
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_<Name>
    #define DEBUG_SETTINGS DEBUG_SETTINGS_<Name>
#endif

#include "\x\gw\addons\main\script_macros.hpp"
```

This gives access to `GVAR`, `QGVAR`, `FUNC`, `QFUNC`, `EFUNC`, `TRACE_*`, `ERROR`, `LOG` etc.
Macros expand with the component prefix: `FUNC(foo)` → `GW_<Name>_fnc_foo`.

### `config.cpp`

```cpp
#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "GuzzenVonLidl";
        name = "GW - <Name> Component";
        url = "https://github.com/GuzzenVonLidl/";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = { "GW_Core", "GW_Common" };
        version = VERSION;
        authors[] = {"GuzzenVonLidl"};
    };
};

#include "CfgEventHandlers.hpp"
// Add further class includes here (CfgRscTitles, GW_FRAMEWORK, etc.)
```

Add `"GW_Gear"` to `requiredAddons` when the module calls `EFUNC(Gear,Init)`.

### `CfgEventHandlers.hpp`

```cpp
class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};
```

### `functions\script_component.hpp`

```cpp
#include "\x\gw\addons\<name>\script_component.hpp"
```

This is required because `compile preprocessFileLineNumbers` compiles each file in isolation —
it does not inherit `#define` macros from the calling scope. Functions that use `GVAR`, `FUNC` etc.
must include this header explicitly.

---

## Migration Checklist

### Step 1 — Understand the module

- [ ] List all files in `Modules/<Name>/`
- [ ] Read `preInit.sqf` — what does it PREP? What GVARs does it initialise? What CBA settings does it register?
- [ ] Read `postInit.sqf` — what CBA event handlers, class event handlers, or ACE actions does it register?
- [ ] Read each function — do they reference `missionConfigFile`? Are there any hardcoded mission variable names?
- [ ] Check `Modules.cpp` — is the module actually included?
- [ ] Check `Description.ext` — does it include any module files directly (CfgFunctions, dialogs, etc.)?

### Step 2 — Create the addon skeleton

- [ ] Create `$PBOPREFIX$` and `$PBOPREFIX$.txt`
- [ ] Create `script_component.hpp`
- [ ] Create `config.cpp`
- [ ] Create `CfgEventHandlers.hpp`

### Step 3 — Port logic

- [ ] Create `XEH_PREP.sqf` with one `PREP(Name)` per function
- [ ] Create `XEH_preInit.sqf` — move PREP call, GVAR initialisations, CBA settings registrations
- [ ] Create `XEH_postInit.sqf` — move all event handler registrations
- [ ] Create `functions\script_component.hpp` redirect
- [ ] Copy function files, renaming `fnc_Name.sqf` → `fn_Name.sqf`

### Step 4 — Migrate config classes (if any)

- [ ] Any config classes defined in `Module.hpp` (under `#ifdef LOAD_*`) move to `config.cpp` or a dedicated `CfgXxx.hpp`
- [ ] Change any `missionConfigFile >> "ClassName"` reads to `configFile >> "ClassName"` in ported functions

### Step 5 — Clean up the mission

- [ ] Remove the module's line from `Modules/Modules.cpp`
- [ ] Remove any direct includes from `Description.ext`:
  - CfgFunctions entries
  - Dialog/defines includes at root level
- [ ] Remove any `#define LOAD_<Feature>` / `#include Modules.cpp` / `#undef LOAD_<Feature>` blocks from `Description.ext` that are no longer needed
- [ ] Remove any CBA settings entries from `CurrentAddonOptionsImportSettings.txt` (they no longer exist as a setting once the module is gone)
- [ ] Delete the `Modules/<Name>/` folder

---

## Per-Module Migration Record

### HeadlessController

**Status:** Deleted (not migrated — replaced by ACEX).

**What was found:**
- Mission module was not in `Modules.cpp` — already dead code.
- GW addon also had a separate `addons/headlessController/` component.
- Both were disabled via `force GW_HeadlessController_Enable = false` in mission settings.
- ACEX headless (`acex_headless_*`) handles everything.

**Actions taken:**
- Deleted `GW/addons/headlessController/` entirely.
- Deleted mission `Modules/HeadlessController/` folder.
- In `addons/3den/Cfg3DEN.hpp`: `GW_DisableHC` attribute expression stripped of `GW_HeadlessController_BlackList` assignment; kept `acex_headless_blacklist` assignment.
- Removed `force GW_HeadlessController_Enable = false` from `CurrentAddonOptionsImportSettings.txt`.

---

### ServiceStation

**Status:** Deleted (not migrated — replaced by OKS_GOL_Misc).

**What was found:**
- Mission module was not in `Modules.cpp` — already dead code.
- GW addon had `addons/serviceStation/` (NEKY-based, old).
- OKS_GOL_Misc provides `OKS_fnc_SetupMobileServiceStation` as a full replacement.
- `Description.ext` had an orphaned `ShouldGiveServiceStationToVehicle` param (OKS uses `MHQ_ShouldBe_ServiceStation` via CBA settings instead).

**Actions taken:**
- Deleted `GW/addons/serviceStation/`.
- Deleted mission `Modules/ServiceStation/`.
- Removed `ShouldGiveServiceStationToVehicle` class from `Description.ext`.

---

### CustomGear (mission-local move, not an addon)

**Status:** Moved to mission root `CustomGear/` folder.

**Problem:** `CUSTOM-E/I/W.sqf`, `Default.sqf`, `Default_AI.sqf` lived inside `Modules/Gear/Scripts/`.
During a mission update, replacing the `Modules/` folder would overwrite mission-specific loadouts.

**Solution:** Move the five custom kit files to `GOL_Framework_2021.VR/CustomGear/` at the mission
root. Root-level folders are not replaced during `Core/` + `Modules/` updates.

**Files moved:**
```
Modules/Gear/Scripts/Default.sqf        → CustomGear/Default.sqf
Modules/Gear/Scripts/Default_AI.sqf     → CustomGear/Default_AI.sqf
Modules/Gear/Scripts/Classes/CUSTOM-E.sqf → CustomGear/CUSTOM-E.sqf
Modules/Gear/Scripts/Classes/CUSTOM-I.sqf → CustomGear/CUSTOM-I.sqf
Modules/Gear/Scripts/Classes/CUSTOM-W.sqf → CustomGear/CUSTOM-W.sqf
```

**Include paths updated** (relative from functions subfolder to mission root = `..\..\..`):
- `fnc_DefaultCode_Local.sqf`: `#include "..\..\..\CustomGear\Default.sqf"`
- `fnc_DefaultAICode_Local.sqf`: `#include "..\..\..\CustomGear\Default_AI.sqf"`
- `factions.sqf`: `#include "..\..\..\CustomGear\CUSTOM-W.sqf"` (etc.)

---

### Callsigns

**Status:** Migrated to `GW/addons/callsigns/`.

**Key decisions:**

| Old (mission) | New (addon) |
|---|---|
| `Blu_fnc_showCallsigns` | `GW_Callsigns_fnc_showCallsigns` |
| `Blu_fnc_ElementSelected` | `GW_Callsigns_fnc_ElementSelected` |
| `Blu_fnc_SetCallsign` | `GW_Callsigns_fnc_SetCallsign` |
| Dialog button actions hardcoded in `dialogs.hpp` | Updated in `CfgRscTitles.hpp` |
| `"Modules\Callsigns\Logo.paa"` | `"\x\gw\addons\callsigns\Logo.paa"` |

**`ACE_Action.sqf` was dead code:** The file existed but was never executed (module not in
`Modules.cpp`, no preInit/postInit called it). Now properly wired in `XEH_postInit.sqf`.

**Dialog pattern:** `dialogs.hpp` content moved into `config.cpp` via:
```cpp
class CfgRscTitles {
    #include "CfgRscTitles.hpp"
};
```

**Mission cleanup:**
- Removed `#include "Modules\Callsigns\Functions\functions.hpp"` from `CfgFunctions` in `Description.ext`.
- Removed `#include "Modules\Callsigns\defines.hpp"` and `#include "Modules\Callsigns\dialogs.hpp"` from `Description.ext`.
- Also removed broken `#include "Modules\LARs\..."` CfgFunctions entry (LARs had already been deleted).

---

### MHQ

**Status:** Migrated to `GW/addons/mhq/`.

**OKS integration note:** OKS_GOL_Misc already calls `GW_MHQ_Fnc_Handler`. It guards with:
```sqf
waitUntil {
    !isNil "GW_MHQ_Fnc_Handler" && ...
};
```
Moving the function to the addon (which loads before the mission) means the wait resolves
immediately. No changes needed in OKS_GOL_Misc.

**Functions ported (6):**
`fn_Handler`, `fn_HandlerRespawn`, `fn_prefabCreate`, `fn_prefabCopy`, `fn_getFlag`, `fn_getDeployType`

**postInit content:** Three CBA event handlers (`GW_MHQ_Enabled`, `GW_MHQ_Assembled`,
`GW_MHQ_Actions`) plus a `CAManBase:Respawn` class event handler — all fully generic, no
mission-specific hardcoding. Moved verbatim to `XEH_postInit.sqf`.

---

### Radios

**Status:** Migrated to `GW/addons/radios/`.

**Init files:** `Init_TFAR.sqf` and `Init_ACRE.sqf` are kept under `Scripts/` and included at
preInit time via `#include` guards:
```sqf
if (false) then { #include "Scripts\Init_ACRE.sqf" };
if (true)  then { #include "Scripts\Init_TFAR.sqf" };
```
Toggle the guards to switch between ACRE and TFAR setups.

**`Init_TFAR.sqf` sets two things:**
1. TFAR CBA settings (via `CBA_settingsInitializedDelayed` event handler)
2. Global `TF_freq_*` and `TF_default*` variables used by `XEH_postInit.sqf`

**`fnc_Jammer.sqf` note:** This file existed but was not in the original `PREP` list. It has been
added to `XEH_PREP.sqf` as `PREP(Jammer)`. Verify whether it was intentionally omitted or an oversight.

---

### SetDifficulty

**Status:** Migrated to `GW/addons/setdifficulty/`.

**Key change — Behaviour presets:** The AI skill presets (`Testing`, `Specialforces`, `Military`,
`Insurgents`, `Dummy`) previously lived in `Module.hpp` under `#ifdef LOAD_Behaviour` and were
injected into `missionConfigFile >> "GW_FRAMEWORK" >> "Behaviour"` via `Description.ext`.

They now live in `config.cpp` → `CfgBehaviour.hpp`:
```cpp
class GW_FRAMEWORK {
    class Behaviour {
        #include "CfgBehaviour.hpp"
    };
};
```

All code reading behaviour presets updated from `missionConfigFile` to `configFile`:
- `XEH_preInit.sqf`: `#define BEHAVIOURS (configFile >> "GW_FRAMEWORK" >> "Behaviour")`
- `fn_setSkill.sqf`: same `#define`
- `fn_setDetectionCoef.sqf`: direct `configFile >>` reference
- `fn_setActiveSkillTree.sqf`: two `configFile >>` references

**Mission cleanup:**
- `LOAD_Behaviour` block removed from `Description.ext` (no longer needed).
- `SetDifficulty` removed from `Modules.cpp`.

---

## Common Pitfalls

### `missionConfigFile` vs `configFile`

When a module reads its own config from `missionConfigFile`, it must be moved to `configFile` after
migration. Check all `#define` macros and direct `>>` expressions in every function.

### Macro scope

`compile preprocessFileLineNumbers` gives each file a blank macro scope. Functions that use
`GVAR`, `FUNC`, `QGVAR` etc. **must** include `script_component.hpp` (directly or via the
`functions\script_component.hpp` redirect). Without it the macros expand to nothing or error.

### Dead includes in `Description.ext`

After removing a module, search `Description.ext` for:
- `CfgFunctions` entries pointing at the removed module's `functions.hpp`
- Root-level `#include` of removed module's `defines.hpp` / `dialogs.hpp`
- `#define LOAD_<Feature>` blocks that would now include an empty `Modules.cpp` entry

### `$PBOPREFIX$` vs `$PBOPREFIX$.txt`

Both files must exist. Mikero's tools use `.txt`; some other tools read the extension-less file.
Content of `.txt` includes `version=GuzzenVonLidl` on line 2; the plain file has only the prefix.

### CBA settings in `CurrentAddonOptionsImportSettings.txt`

When a module that registered CBA settings is removed, any `force GW_<Name>_<Setting> = ...` line
in `CurrentAddonOptionsImportSettings.txt` becomes a harmless orphan but should be cleaned up to
avoid confusion.

### Function naming convention

Mission modules use `fnc_Name.sqf`; GW addons use `fn_Name.sqf`. Rename on copy.

### PREP list vs actual functions

Always cross-check that every `.sqf` file in `functions/` has a matching `PREP(Name)` entry.
Arma silently ignores unregistered functions — they simply won't be callable by name.

---

### MiscSettings

**Status:** Migrated to `GW/addons/miscSettings/`.

**Key decisions:**

| Old (mission) | New (addon) |
|---|---|
| `GW_MiscSettings_fnc_addToFlexiMenu` | `GW_miscSettings_fnc_addToFlexiMenu` |
| `GW_MiscSettings_fnc_customMenu_Example` | `GW_miscSettings_fnc_customMenu_Example` |
| `GW_MiscSettings_flexiMenu` | `GW_miscSettings_FlexiMenu` |

**Component name is lowercase `miscSettings`** (not `MiscSettings`) — to match the variable name
`GW_miscSettings_FlexiMenu` that `menu/functions/fnc_flexi_InteractSelf.sqf` already referenced via
`QEGVAR(miscSettings,FlexiMenu)`. Using a different casing would produce a different global variable.

**`STUI` and `STHud` variables:** The menu addon sets `STHud_NoSquadBarMode = true` in its
`XEH_preInit`. MiscSettings overrides this to `false` in `XEH_postInit` — correct order is
preserved since PostInit always fires after PreInit.

**Mission cleanup:**
- Removed `Modules/MiscSettings/` folder.
- Removed `#include "MiscSettings\Module.hpp"` from `Modules.cpp`.

---

### StartUp

**Status:** Migrated — functionality was already in `GW/addons/gameLoop/`.

**What was found:**
- `gameLoop` addon already contained `fn_startText.sqf`, `fn_weaponLock.sqf`, the SafeMode
  countdown logic, and `XEH_postInitPlayer.sqf` (identical to the mission module's).
- A guard `if (isClass(missionConfigFile >> "GW_Modules" >> "StartUp")) exitWith {false};` at the
  top of `gameLoop/XEH_postInit.sqf` deferred to the mission module when it was present.
- `gameLoop/initSettings.sqf` defaulted SafeMode to "Disabled" when the StartUp module was loaded
  (since the module managed its own settings), and "Countdown" when it was not.
- `admin/fnc_flexi_InteractSelf.sqf` had a legacy "Weapon Lock (Legacy)" entry visible only
  when the StartUp module was present, plus a new "Toggle Weapon Lock" entry for the GameLoop path.

**Actions taken:**
- Removed the `exitWith` guard from `gameLoop/XEH_postInit.sqf`.
- Simplified `gameLoop/initSettings.sqf`: removed the StartUp module check; SafeMode now always
  defaults to "Countdown" (index 1).
- Removed the legacy "Weapon Lock (Legacy)" block and its condition from
  `admin/fnc_flexi_InteractSelf.sqf`; "Toggle Weapon Lock" now unconditionally visible.
- Removed `Modules/StartUp/` folder from the mission.
- Removed `#include "StartUp\Module.hpp"` from `Modules.cpp`.

---

### Common

**Status:** Migrated into the existing `GW/addons/common/` component.

**What was found:**
- The `common` addon already existed with utility functions, CBA settings, and event handlers.
- Version guards `(getNumber(missionConfigFile >> "GW_Modules" >> "Common" >> "version")) >= 2.0 / > 2.0`
  prevented double-execution when the mission module was loaded alongside the addon.
- The `simpleRoster` PREP was behind a `>= 2.0` guard; the `setGroupColor/setGroupId/InventoryOpened`
  block was behind a `> 2.0` guard (version in Module.hpp was exactly 2.0, so that block never ran
  from the addon — it came from the mission module instead).

**Functions added to addon (13 new files):**
`fn_buildingPop`, `fn_getClassnameByRole`, `fn_getGroupType`, `fn_setAttributes`,
`fn_setAttributes3DEN`, `fn_setGroupAction`, `fn_setGroupColor`, `fn_setGroupId`,
`fn_spawnGroup`, `fn_spawnHandler`, `fn_spawnObjects`, `fn_spawn3DEN`, `fn_spawn3DENObjects`

**`fn_getGroupType` — `missionConfigFile` → `configFile`:** The function read faction rosters from
`missionConfigFile >> "GW_FRAMEWORK" >> "SpawnUnits"`. These classes now live in `configFile` via
`CfgSpawnUnits.hpp` included in `config.cpp`:
```cpp
class GW_FRAMEWORK {
    class SpawnUnits {
        #include "CfgSpawnUnits.hpp"
    };
};
```

**CBA settings added to `initSettings.sqf`:** `Faction` (spawn side), `AutoLock`, `autoDelete`,
`autoQueue` — under `[QUOTE(ADDON), "Spawning"]` category.

**`XEH_preInit.sqf`:** Added `GVAR(spawnActive) = false` and `GVAR(spawnQueue) = []`.

**`XEH_postInit.sqf` changes:**
- Removed both version guards; all event handlers now unconditional.
- Added `GOL_SpawnMultiplier` initialisation from mission params (was in module postInit).
- Added `setGroupColor`, `setGroupId`, `setVariable isPlayer`, team colour assignment at the top
  of the `playerReady` handler.
- Added `autoDelete` class event handler inside the `serverReady` block.

**`Description.ext` cleanup:**
- Removed the `LOAD_SpawnUnits` block (3 lines) — `SpawnUnits` class now in `configFile`.

**Mission cleanup:**
- Removed `Modules/Common/` folder.
- Removed `#include "Common\Module.hpp"` from `Modules.cpp`.

---

## Remaining Mission Modules (candidates for future porting)

As of June 2026, the following modules remain in the mission:

| Module | Notes |
|---|---|
| `Gear` | Partially migrated (Phase 1-2); standard factions in addon, custom kits in `CustomGear/` |
