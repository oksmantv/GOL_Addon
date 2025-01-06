<div align="center">
    <h1 align="center">GW Addon
    <br/>
    <br/>
    <a href="https://gol-clan.com/home">
        <img src="https://github.com/oksmantv/GOL_Addon/blob/master/img/GWLogo_LM.png?raw=true#gh-dark-mode-only" alt="GOL Logo" height="300">
		<img src="https://github.com/oksmantv/GOL_Addon/blob/master/img/GWLogo_DK.png?raw=true#gh-light-mode-only" alt="GOL Logo" height="300">
    </a>
    </h1>
</div>

<div align="center">
<a><img src="https://img.shields.io/github/contributors/Oksmantv/GOL_Addon?color=yellow"></img></a>
<a><img src="https://img.shields.io/github/commit-activity/t/Oksmantv/GOL_Addon"></img></a>
<a href="https://github.com/Oksmantv/GOL_Addon/issues"><img src="https://img.shields.io/github/issues-raw/Oksmantv/GOL_Addon"></img></a>
<a href="https://gol-clan.com/home"><img src="https://img.shields.io/badge/Website-Click_Me-blue"></img></a>
<a href="https://discord.gg/k9BfvVjtYv"><img src="https://img.shields.io/discord/437979456196444161?label=Discord&color=%23BA55D3"></img></a>
</div>

## Introduction

The GuzzenWorks addon (GW) was made specifically for the Guerrillas Of Liberation (GOL) providing many QOL features and tweaks to the ArmA experience.
- Updated with new standards for performance and easy structure.
- This addon is modular and utilises CBA macros and scripts to achieve this.

## Contributers
The main author [GuzzenVonLidl](https://github.com/GuzzenVonLidl) is responsible for the majority of the addon's creation. After they discontinued maintainance of the addon, members from the GOL have taken over maintaining the addon.

- Oksman - Repo owner, Scripting
- Blu. - Maintainance, Scripting

## Overview 

Now each module includes a couple of feature
Note: these are the main things.

### 3den:
* New "tab" for easy copying
* Copy highlighted units/objects, No more scripting needed, just copy and paste!
	* "Group with waypoints" (saves formation, behaviour, combat mode),
	* NOTE: This only copies waypoints highlighted.
	* "Static units" will be copied and put in to the same group.
	* "Objects" will copy both objects and vehicles for building fortifications.
	* "Vehicles" same as "Objects" but only vehicles.
* New Composition found in (Composition(F2) > Props > Custom Composition).
* Ability to create your own compositions and them to the addon.

### Effects:
* Smoke: Bigger, longer lasting (extended with 15sec, total 45), slightly optimizeed performance.
* Smoke from launchers does NOT bounce, (shoot at a branch and it will not drop down).
* Revamped smoke color.
* Flares are the same as for before with GVL Enhancment, (lasting longer and increased brightness).
* Increased brightness and radius of chemlights.

### Enhancement:
* X2000 flash-light are still there for backwards compatibility.
* New X3000 flash-light, a combo of X2000s wide and point versions.
* AI will use RPG 7/42 against air and infantry.
* AK-12 now only uses 545x39 caliber.
* AKM replaced with AK-74 (545x39 caliber).

### Main:
* Added new GOL Difficulty and set is as standard, (should no longer need to pick difficulty).
* Hidden BIS standard mission.

### Menu:
* More or less same as GOL Menu however with new standard keybinds.
* Removed unused menus.

### UI:
* Removed all icons from the addAction menu..
* Map should have new contour lines.
* Removed "Statistics" from map screen.
* Added gol logo to Insignias.

## Packing Instructions:
The GW addon was previously compiled by Guzzen's own custom file. However, since losing that, the addon is now compiled using Mikero's PBOProject.

1. Download Mikero's pboProject
2. Mount the P: - Using ArmA III Tools
3. Place the **gw** folder into a path: (P:/x/**gw**)
4. Download a copy of [CBA](https://github.com/CBATeam/CBA_A3) from their Github
5. Extract the CBA.zip and place the contents into (P:/x/cba)
6. Make sure a copy of A3 unbinarized addons are located in the root directory of P:
   - This can be achieved using ArmA III Tools and executing the respective command.
7. Finally, due to TacOps still being encrypted by BI, remove the 'retexturing' module from packing and copy the pbo into the final upload once everything else is packed.
