# AI Skill Presets

The lobby parameter and the SetDifficulty CBA settings use the same preset indices.
Changing a display name does not change the preset values or existing saved CBA selections.

| Index | Display name | Internal config class |
| ---: | --- | --- |
| 0 | Special Forces | `Testing` |
| 1 | Commando | `Specialforces` |
| 2 | Regulars | `Military` |
| 3 | Insurgents | `Insurgents` |
| 4 | Farmer | `Dummy` |

## Default Skill Comparison

The bars show the default applied when **Use Skill Variation** is disabled. Each full bar is 100% (`██████████`).

The progression is **Farmer → Insurgents → Regulars → Commando → Special Forces**. Each preset is consistently stronger than the previous one for every skill. For inverse traits, the progression is also consistent: stronger AI flee less often and receive a lower player camouflage coefficient.

### Marksmanship and Reaction

| Property | Special Forces | Commando | Regulars | Insurgents | Farmer |
| --- | --- | --- | --- | --- | --- |
| Aiming accuracy | 60% `██████░░░░` | 55% `█████▌░░░░` | 50% `█████░░░░░` | 45% `████▌░░░░░` | 25% `██▌░░░░░░` |
| Aiming shake | 100% `██████████` | 95% `█████████▌` | 90% `█████████░` | 85% `████████▌░` | 75% `███████▌░░` |
| Aiming speed | 100% `██████████` | 95% `█████████▌` | 90% `█████████░` | 85% `████████▌░` | 75% `███████▌░░` |
| Reload speed | 100% `██████████` | 95% `█████████▌` | 90% `█████████░` | 85% `████████▌░` | 45% `████▌░░░░░` |

### Command, Morale, and General Skill

| Property | Special Forces | Commando | Regulars | Insurgents | Farmer |
| --- | --- | --- | --- | --- | --- |
| Commanding | 90% `█████████░` | 85% `████████▌░` | 80% `████████░░` | 75% `███████▌░░` | 45% `████▌░░░░░` |
| Courage | 90% `█████████░` | 85% `████████▌░` | 80% `████████░░` | 75% `███████▌░░` | 20% `██░░░░░░░░` |
| Endurance | 90% `█████████░` | 85% `████████▌░` | 80% `████████░░` | 75% `███████▌░░` | 45% `████▌░░░░░` |
| General | 100% `██████████` | 95% `█████████▌` | 90% `█████████░` | 85% `████████▌░` | 45% `████▌░░░░░` |

### Fleeing and Player Visibility

| Property | Special Forces | Commando | Regulars | Insurgents | Farmer |
| --- | --- | --- | --- | --- | --- |
| Fleeing | 70% `███████░░░` | 75% `███████▌░░` | 80% `████████░░` | 85% `████████▌░` | 90% `█████████░` |
| Player camouflage coefficient | 75% `███████▌░░` | 80% `████████░░` | 85% `████████▌░` | 90% `█████████░` | 125% `██████████ +25%` |

### Detection

| Property | Special Forces | Commando | Regulars | Insurgents | Farmer |
| --- | --- | --- | --- | --- | --- |
| Spot distance | 100% `██████████` | 95% `█████████▌` | 90% `█████████░` | 85% `████████▌░` | 75% `███████▌░░` |
| Spot time | 100% `██████████` | 95% `█████████▌` | 90% `█████████░` | 85% `████████▌░` | 75% `███████▌░░` |

The camouflage coefficient is a multiplier: 100% is the baseline. A lower value makes a player more visible to AI; a higher value makes the player harder to spot.

## Skill Variation Ranges

When **Use Skill Variation** is enabled, a random value between the shown percentage bounds replaces the default. Properties not listed below are fixed at their default shown above.

| Preset | Variable properties |
| --- | --- |
| Special Forces | Aiming accuracy 55–65%; commanding and courage 80–100%. |
| Commando | Aiming accuracy 50–60%; commanding and courage 75–95%. |
| Regulars | Aiming accuracy 45–55%; commanding and courage 70–90%. |
| Insurgents | Aiming accuracy 40–50%; commanding and courage 65–85%. |
| Farmer | Aiming accuracy 20–30%; aiming shake and aiming speed 55–95%; commanding, endurance, general, and reload speed 35–55%; courage 10–25%; fleeing 85–95%; player camouflage coefficient 115–145%. |

## Long-Range Optic Penalty

AI equipped with a primary-weapon optic that has a magnified mode receive a 20% weapon-handling penalty. The check uses the optic mode's field of view: any `opticsZoomMin` below the standard 0.75 non-magnified FOV counts as a long-range optic.

| Affected raw skill | Result with a long-range optic |
| --- | --- |
| Aiming accuracy | Base value × 80% |
| Aiming shake | Base value × 80% |
| Aiming speed | Base value × 80% |

The penalty is applied after Gear equips the unit's final primary-weapon optic and before Arma's difficulty scaling. It affects only the AI's primary-weapon optic; iron sights, non-magnified sights, launchers, and secondary weapons do not receive it.