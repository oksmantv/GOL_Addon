# Phase 1 Pretest Checklist (Before Behavior Validation)

Purpose: ensure runtime dependency baseline is valid before testing FW4 module behavior.

## Required startup RPT lines

Search for these exact strings:

- [GW][Phase1] preflight env
- [GW][Phase1] BLOCKER: CBA_Main missing
- [GW][Modules] PostInit count:
- [GW_Gear] dependency check GW_Main=
- [GW][SafeMode] XEH_postInit loaded useType=

## Pass / Fail criteria

1. Fail immediately if this line exists:
- [GW][Phase1] BLOCKER: CBA_Main missing

2. Fail immediately if any of these appear:
- Undefined variable in expression: cba_
- Undefined variable in expression: ace_
- Undefined variable in expression: lambs_
- Undefined variable in expression: zen_

3. Continue to Phase 2 only when:
- [GW][Phase1] preflight env appears once per runtime
- No cba_* undefined variable errors
- Core module chain reaches [GW][Modules] PostInit count:

## Notes

- If cba_* errors exist, do not evaluate SafeMode, AI static, Gear, or radio behavior in that run.
- Use local MP host for validation runs, not SP.
