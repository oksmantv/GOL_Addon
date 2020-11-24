
if !(hasInterface) exitWith {false};

if (isNull (objectParent player) && ((getPosASL player) select 2 > 0)) then {
	_stance = (stance player);
	_anim = (toLower (animationState player));	// stance is broken for some animations.
	if (_anim find "ppne" == 4) then {_stance = "PRONE"};
	if (_anim find "pknl" == 4) then {_stance = "CROUCH"};
	if (_anim find "perc" == 4) then {_stance = "STAND"};

	_anim = switch (_stance) do {
		case 'STAND': {'amovpercmstpslowwrfldnon'};
		case 'CROUCH': {'amovpknlmstpslowwrfldnon'};
		case 'PRONE': {'amovppnemstpsraswrfldnon'};
	};
	player playMoveNow _anim;
	true
} else {
	false
};
