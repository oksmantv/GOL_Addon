
[QGVAR(allowSpectator), "CHECKBOX", ["Allow Spectator in base", "Allow Spectator Mode in the base while waiting for reinserting, Viewing limited to: only players, 1P & 3P Options"], [QUOTE(DOUBLES(PREFIX,GameLoop)), "General"], false, CBA_SERVEROVERWRITE] call CBA_settings_fnc_init;

[QGVAR(nameTags), "LIST", ["Enable","How it will be activated"], [QUOTE(ADDON), "Name Tags"], [[0, 1, 2], ["Disabled","Enabled","Keypress"], 0], CBA_CANOVERWRITE, {
	call FUNC(initNameTags);
}] call cba_settings_fnc_init;

[QGVAR(showActionPrompts), "CHECKBOX", ["Show vanilla action prompts", "Show the standard Arma interaction menu, including vehicle, door, and hold-action prompts. Disabling it hides every action prompt."], [QUOTE(ADDON), "Action Prompts"], false, CBA_CANOVERWRITE, {
	params ["_showActionPrompts"];
	GVAR(showActionPrompts) = _showActionPrompts;

	if (hasInterface && {!isNull player}) then {
		[_showActionPrompts] call FUNC(setActionMenuVisible);
	};
}] call CBA_settings_fnc_init;

[QGVAR(nameSize), "SLIDER", ["Name Size", "How large name tags should be"], [QUOTE(ADDON), "Name Tags"], [0.5, 3.0, 1.3, 1], CBA_CANOVERWRITE] call cba_settings_fnc_init;
[QGVAR(nameShadow), "LIST", ["Shadow","How the text will be displayed"], [QUOTE(ADDON), "Name Tags"], [[0, 1, 2], ["None","Shadow","Outline"], 2], CBA_CANOVERWRITE] call cba_settings_fnc_init;
