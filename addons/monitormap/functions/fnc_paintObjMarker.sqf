#include "script_component.hpp"

params ["_markers","_obj","_type","_color",["_size", DFT_MARKER_SIZE],["_alpha", 1]];

private _marker = createMarkerLocal[str(_obj), (getPos _obj)];
_marker setMarkerShapeLocal "ICON";
_marker setMarkerDirLocal (getDir _obj);
_marker setMarkerTypeLocal _type;
_marker setMarkerColorLocal _color;
_marker setMarkerAlphaLocal _alpha;
_marker setMarkerSizeLocal _size;
_markers set [(count _markers), [_obj, _marker, (alive _obj), (side _obj), (isPlayer _obj)]];
_marker
