# FW4 Port Audit - Kept vs Reverted

Date: 2026-06-08
Scope: Runtime wiring and parity fixes during FW4 migration debugging.

## Kept Changes (active in code)

### Core event pipeline
- Restored missionLoaded publish in core post-init event pipeline.
- Why: radios addon subscribes to missionLoaded; without publish, that logic never runs.
- File: addons/core/XEH_postInitEvents.sqf

### Common static AI bridge
- Restored disableAICommand event handling to call setAIStatic.
- Why: spawnHandler fired the event but there was no receiver in addon flow.
- Files:
  - addons/common/XEH_postInit.sqf
  - addons/common/functions/fnc_setAIStatic.sqf
  - addons/common/functions/fnc_spawnHandler.sqf

### Gear default function initialization safety
- Added fallback compile for DefaultCode and DefaultAICode when nil.
- Why: handler path reached calls while function pointers were unset in some startup orders.
- File: addons/gear/XEH_preInit.sqf

### Gear handler argument normalization fix
- Normalized _forceFaction optional argument to avoid undefined variable runtime errors from box actions.
- Why: action calls that passed only unit+role hit undefined _forceFaction path.
- File: addons/gear/functions/fnc_Handler.sqf

### Core diagnostics for startup path
- Added explicit entry diagnostics for core postInit and delayed switchable-unit pass diagnostics.
- Why: verify whether core branch executes and whether switchableUnits are available in local timing.
- File: addons/core/XEH_postInit.sqf

### Mission template diagnostics for gear source selection
- Added source-selection diagnostics in mission gear preInit.
- Why: prove whether runtime compiles local wrapper or addon wrapper.
- File: GOL_Framework_2021.VR/Gear/preInit.sqf (mission repo)

## Reverted Changes (removed after destabilizing tests)

### GameLoop experimental teammate AI lock logic
- Removed lock/unlock teammate AI behavior blocks added in setSafetyMode event.
- Removed related custom lockTeammateAI/unlockTeammateAI events.
- Why: kept changing behavior while runtime dependency state was not clean.
- File reverted to baseline+diagnostics shape: addons/gameLoop/XEH_postInit.sqf

### GameLoop experimental distance-limit setting
- Removed SafeMode_distanceLimit setting and related waitUntil release logic.
- Why: reintroduced old semantics during unstable runtime phase; reverted for controlled parity pass.
- File: addons/gameLoop/initSettings.sqf

### GameLoop experimental legacy class Fired hook
- Removed temporary legacy-style class Fired registration from playerReady path.
- Why: avoid layering behavior changes before dependency/runtime baseline is clean.
- File: addons/gameLoop/XEH_postInit.sqf

## Open Gaps to Validate Before Rollout

1. CBA/ACE/LAMBS/ZEN dependency stability in target runtime
- If cba_* globals are undefined, module parity validation is not trustworthy.

2. missionLoaded consumers
- Confirm radios missionLoaded handler executes after restored core publish.

3. SafeMode parity contract
- Decide explicitly whether FW4 should match legacy StartUp behavior exactly or keep gameLoop behavior.
- Do not mix both until runtime baseline is clean.

4. Local hosted startup timing
- Confirm delayed switchable-unit diagnostics show deterministic counts and expected branch execution.

## Recommended Signoff Sequence

1. Run clean local MP with required dependencies only and verify no undefined cba_* errors.
2. Verify core event chain: mapLoaded -> missionLoaded -> missionStarted -> serverReady -> playerReady.
3. Verify radios missionLoaded side effects.
4. Verify common static AI path from spawnHandler to setAIStatic.
5. Verify gear default function compile path and handler execution.
6. Re-introduce any desired legacy behavior only after the above passes.
