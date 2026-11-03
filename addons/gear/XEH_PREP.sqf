#include "script_component.hpp"

PREP(actions);
PREP(getLoadoutClass);
PREP(getClassnameByRole);
// Handler is intentionally NOT PREP'd: CBA compiles PREP functions final, which blocks the
// mission's local CustomGear\Handler.sqf override. It is compiled in XEH_preInit instead.
PREP(Init);
PREP(removeUnsupportedGearCandidates);
PREP(validateDlcCandidates);
PREP(validateFactionDlc);
