# GW Framework Migration — Gear Module Handoff

## Goal

Move static faction gear data (loadout files, faction definitions, default kits) out of individual
mission folders and into the **GW addon** (`p:\x\GW\addons\gear`).

**Why**: Each mission currently carries its own full copy of ~70 faction files and 3 default-kit
scripts. When gear is updated you have to touch every mission. With the data in the addon, updating
one PBO updates every mission that references it.

**Constraint**: Every existing mission must continue to work without modification.  
Old missions must fall through to their own local files as-is.

---

## Design

The mission's `Modules/Gear/preInit.sqf` guards on the addon and then compiles the three
mission-side wrappers:

```sqf
if !(isClass (configFile >> "CfgPatches" >> "GW_Gear")) exitWith { diag_log "ERROR..." };
// compile DefaultCode, DefaultAICode, Handler_Addon wrappers
// all other functions auto-registered by addon XEH_PREP
```

The GW addon is a **hard requirement**. There is no fallback path and no legacy detection in the
template — old missions that were never updated simply keep their own unchanged `preInit.sqf` and
never receive this code at all.

### CUSTOM factions always stay local

`CUSTOM-W`, `CUSTOM-I`, `CUSTOM-E` are mission-specific overrides. The thin switcher
`Scripts\factions_addon.sqf` handles them locally before delegating everything else to the addon:

```sqf
switch (_side) do {
    case "CUSTOM-W": { #include "Classes\CUSTOM-W.sqf" };
    case "CUSTOM-I": { #include "Classes\CUSTOM-I.sqf" };
    case "CUSTOM-E": { #include "Classes\CUSTOM-E.sqf" };
    default          { #include "\x\gw\addons\gear\scripts\factions_standard.sqf" };
};
```

### CBA overrides for Default.sqf / Default_AI.sqf

Two CBA CHECKBOX settings (both default `false`, server-overwritable) let a mission opt out of the
addon's default kit files and use its own local copies instead:

| Setting key | Effect when `true` |
|---|---|
| `GW_Gear_UseLocalDefault` | Compiles `Modules\Gear\Functions\fnc_DefaultCode_Local.sqf` (wraps local `Scripts\Default.sqf`) |
| `GW_Gear_UseLocalDefaultAI` | Compiles `Modules\Gear\Functions\fnc_DefaultAICode_Local.sqf` (wraps local `Scripts\Default_AI.sqf`) |

When `false` (default) the addon's `\x\gw\addons\gear\scripts\Default.sqf` / `Default_AI.sqf` are
used.

---

## The Macro / Wrapper Pattern (critical — read this)

Arma's `compile preProcessFileLineNumbers` processes a file standalone. It does **not** inherit any
`#define` macros from the calling scope.

`Default.sqf` and `Default_AI.sqf` use two families of macros that must be defined before the file
is compiled:

1. **CBA macros** — `EFUNC`, `EGVAR`, `GVAR` etc. — from `\x\gw\addons\main\script_macros.hpp`
2. **Gear-specific macros** — `ISMAG`, `MAGCOUNT`, `ADD_MAG`, `COUNT_MAGS`, `COUNT_AG_MAGS`,
   `COUNT_AB_MAGS`, `COUNT_ATAB_MAGS`, `COUNT_AR_MAGS`, `COUNT_AMMG_MAGS`, `COUNT_MMG_MAGS`,
   `ISNILS`

**Solution**: Never compile a data file directly. Always compile a thin **wrapper** that
`#include`s the correct `script_component.hpp` first, which pulls in both macro families, then
`#include`s the data file.

### Wrapper files

| Wrapper | Where | Includes |
|---|---|---|
| `p:\x\GW\addons\gear\functions\fnc_DefaultCode.sqf` | Addon | `#include "..\script_component.hpp"` → `#include "..\scripts\Default.sqf"` |
| `p:\x\GW\addons\gear\functions\fnc_DefaultAICode.sqf` | Addon | `#include "..\script_component.hpp"` → `#include "..\scripts\Default_AI.sqf"` |
| `Modules\Gear\Functions\fnc_DefaultCode_Local.sqf` | Mission template | `#include "script_Component.hpp"` → `#include "..\Scripts\Default.sqf"` |
| `Modules\Gear\Functions\fnc_DefaultAICode_Local.sqf` | Mission template | `#include "script_Component.hpp"` → `#include "..\Scripts\Default_AI.sqf"` |

**Important**: Mission-local wrappers must include `"script_Component.hpp"` (same folder, the
functions-level header that has the gear macros), NOT `"..\script_Component.hpp"` (module level,
which lacks them).

---

## File Inventory

### Addon — `p:\x\GW\addons\gear\`

```
config.cpp                      CfgPatches: GW_Gear (requires GW_Core, GW_Common)
script_component.hpp            COMPONENT=Gear + CBA macro chain + all gear-specific macros
CfgEventHandlers.hpp            Registers XEH_preStart, XEH_preInit
XEH_preStart.sqf                (empty / future use)
XEH_preInit.sqf                 Includes XEH_PREP.sqf then initSettings.sqf
XEH_PREP.sqf                    PREP(getLoadoutClass, getAttachments, getClassnameByRole, replaceAttachments, Init)
initSettings.sqf                Registers GW_Gear_UseLocalDefault + GW_Gear_UseLocalDefaultAI CBA settings

functions/
    fnc_DefaultCode.sqf         Wrapper → scripts\Default.sqf     (compiled by mission preInit)
    fnc_DefaultAICode.sqf       Wrapper → scripts\Default_AI.sqf  (compiled by mission preInit)
    fnc_getLoadoutClass.sqf     Maps unit display name → role string (Phase 2)
    fnc_getAttachments.sqf      Returns compatible attachment arrays for a weapon (Phase 2)
    fnc_getClassnameByRole.sqf  Maps role + side → vanilla unit classname (Phase 2)
    fnc_replaceAttachments.sqf  CBA flexiMenu UI for swapping weapon attachments (Phase 2)
    fnc_Init.sqf                Auto-gear orchestrator: detects role, calls fnc_Handler (Phase 2)

scripts/
    Common.sqf                  Shared gear variables / helpers (included inline by fnc_Handler_Addon)
    Default.sqf                 Authoritative player default kits (all roles)
    Default_AI.sqf              Authoritative AI default kits
    factions_standard.sqf       switch/case for all 64 standard factions; each case #includes Factions\FACTION.sqf
    Factions/                   67 individual faction files (AAF-W.sqf … USMC-W.sqf)
```

### Mission Template — `GOL_Framework_2021.VR\Modules\Gear\`

```
preInit.sqf                     Three-way detection; addon path skips local PREP for migrated functions
script_Component.hpp            Module-level component header (no gear macros)
Module.hpp                      Unchanged

functions/
    script_Component.hpp        Functions-level header: COMPONENT=Gear + gear macros (ISMAG, COUNT_*_MAGS etc.)
    fnc_Handler.sqf             UNTOUCHED legacy handler (used by all old/legacy missions)
    fnc_Handler_Addon.sqf       NEW — copy of fnc_Handler with 6 edits (see below)
    fnc_DefaultCode_Local.sqf   Wrapper — for CBA UseLocalDefault=true path
    fnc_DefaultAICode_Local.sqf Wrapper — for CBA UseLocalDefaultAI=true path
    fnc_actions.sqf             Stays local — mission-specific ACE action behaviour
    fnc_getLoadoutClass.sqf     Kept for fallback (no addon) — authoritative copy now in addon
    fnc_getAttachments.sqf      Kept for fallback — authoritative copy now in addon
    fnc_getClassnameByRole.sqf  Kept for fallback — authoritative copy now in addon
    fnc_replaceAttachments.sqf  Kept for fallback — authoritative copy now in addon
    fnc_Init.sqf                Kept for fallback — authoritative copy now in addon
    functions.sqf               Shared handler helper code (_addEquipment etc.) — unchanged

Scripts/
    Common.sqf                  UNTOUCHED (used by legacy fnc_Handler)
    Default.sqf                 UNTOUCHED (used by legacy fnc_Handler + local-override wrappers)
    Default_AI.sqf              UNTOUCHED (used by legacy fnc_Handler + local-override wrappers)
    factions.sqf                UNTOUCHED (used by legacy fnc_Handler)
    factions_addon.sqf          NEW — thin switcher: CUSTOM-* local, else → addon factions_standard.sqf

    Classes/
        CUSTOM-W.sqf            Mission-specific override (never moved to addon)
        CUSTOM-I.sqf            Mission-specific override (never moved to addon)
        CUSTOM-E.sqf            Mission-specific override (never moved to addon)
        Reference/              67 non-CUSTOM faction files moved here as read-only reference
                                (never loaded; exist so you can diff against addon versions)
```

### fnc_Handler_Addon.sqf — the 6 edits from fnc_Handler.sqf

The addon handler is identical to the legacy handler except for these lines:

| Original | Replaced with |
|---|---|
| `#include "..\Scripts\Common.sqf"` (×2, lines ~189 & ~331) | `#include "\x\gw\addons\gear\scripts\Common.sqf"` |
| `#include "..\Scripts\factions.sqf"` (×2) | `#include "..\Scripts\factions_addon.sqf"` |
| `#include "..\Scripts\Default_AI.sqf"` | `call GW_Gear_fnc_DefaultAICode;` |
| `#include "..\Scripts\Default.sqf"` | `call GW_Gear_fnc_DefaultCode;` |

The last two replace direct `#include` with a `call` to the pre-compiled wrapper function, which is
what ensures Default.sqf is compiled with the correct macro context.

---

## What Is NOT Yet Migrated (Phase 3+)

These Gear functions were migrated in Phase 2 and are now in the addon:
`fnc_getLoadoutClass`, `fnc_getAttachments`, `fnc_getClassnameByRole`, `fnc_replaceAttachments`, `fnc_Init`.

Remaining mission functions (phase 3 candidates):

| Function | Notes |
|---|---|
| `fnc_actions` | Has mission-specific radio/cargo behaviour — leave local |

Other framework modules not yet touched (each is a separate migration unit):

- `Modules/Callsigns/`
- `Modules/Common/`
- `Modules/LARs/`
- `Modules/MHQ/`
- `Modules/Radios/`
- `Modules/ServiceStation/`
- and others under `Modules/`

---

## Key Rules — Never Break These

1. **Never touch `fnc_Handler.sqf`** (legacy). It must remain byte-for-byte identical to what old
   missions rely on.
2. **Never move `CUSTOM-*.sqf`** to the addon. They are mission-specific.
3. **Wrapper pattern is mandatory** for any data file that uses CBA or gear macros. Always
   `#include script_component.hpp` before `#include` of the data file.
4. **Detect legacy by file path, not by mission name**. The check
   `fileExists "Modules\Gear\Scripts\Classes\AAF-W.sqf"` is the canonical gate.
5. **CBA settings are server-overwritable**. Defaults must be `false` (use addon data) so
   missions work out of the box without any per-mission configuration.

---

## Suggested Workflow for Each New Module

1. Read the module's `preInit.sqf` and all functions — identify what is static data vs.
   mission-specific behaviour.
2. Copy static data files to the addon under `addons/<module>/scripts/`.
3. If any data file uses macros, create wrapper functions in `addons/<module>/functions/`.
4. Add a `script_component.hpp` to the addon component that defines any module-specific macros.
5. Write a thin `factions_<module>_addon.sqf` in the mission that handles CUSTOM cases locally and
   delegates everything else to the addon.
6. Edit (copy) the module's handler into `fnc_Handler_Addon.sqf` with the same 6-edit pattern used
   for Gear.
7. Update the mission's `preInit.sqf` with the three-way legacy/addon/fallback detection.
8. Leave all original mission files completely untouched.

---

## Recommended Approach for Continuing

**Start a new chat.** Paste this document at the top as context. The current chat window has grown
very large and the compression summary, while accurate, is not as reliable as a clean document for
a fresh implementation task.

Useful files to share at the start of the next session:
- This document
- `p:\x\GW\addons\gear\script_component.hpp` (for the macro pattern to copy)
- `p:\x\GW\addons\gear\config.cpp` (for the CfgPatches/requires pattern to copy)
- The target module's `preInit.sqf` and function list
