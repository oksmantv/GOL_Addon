# Copilot Instructions — Commit Messages (GW)

When generating commit messages, use this exact template:

Title (Example: Updated Gear and Roles)
+ (Added something new)
~ (Changed something existing)
- (Removed something)

Rules:
- Title is a short, human-readable summary of the functional intent (no trailing period).
- Use `+` only for newly introduced functionality/content.
- Use `~` for modifications to existing functionality/content.
- Use `-` for removals/deprecations.
- Include **all functional changes** in the message (anything that changes gameplay/behavior): addons logic, UI/menus, event handlers, admin tools, headless/AI logic, respawn rules, server performance behavior, settings defaults.
- Do not add extra sections or alternative bullet styles. Omit unused prefixes if there were no changes of that type.
- Prefer one change per line; include the addon/system in parentheses when helpful (e.g., `(respawnLimit)`, `(ui)`, `(headlessController)`).

Example:

Improved Respawn Flow
+ Added spectator hint for locked respawns (respawnLimit)
~ Changed admin teleport permission checks (admin)
- Removed deprecated debug console toggle (common)
