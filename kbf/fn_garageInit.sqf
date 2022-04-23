disableserialization;
params[["_obj", objNull], ["_point", objNull], ["_types", ["Auto"]], ["_range", 10], ["_script", ""]];

_pointName = format["%1", _point];
missionNamespace setVariable [format["Garage_Script_%1", _pointName], _script];

//Check surface
_surfaceWater = surfaceIsWater (getPos _point);

_arrayGround = ["Car", "Tank", "Helicopter", "Plane", "StaticWeapon"];

//If Auto, set array depending on the point's surface.
if ((_types select 0) == "Auto") then {
  _types = if (_surfaceWater) then {
    ["Ship"];
  } else {
    _arrayGround;
  };
};
if ((_types select 0) == "Ground") then {
  _types = _arrayGround;
};
if ((_types select 0) == "All") then {
  _types = ["Car", "Tank", "Helicopter", "Plane", "Ship", "StaticWeapon"];
};

//Change icon
_markerDesign = "respawn_unknown";
if (count _types == 1) then {
  _markerDesign = switch (_types select 0) do {
    case "Car": {
      "respawn_motor";
    };
    case "Tank": {
      "respawn_armor";
    };
    case "Helicopter": {
      "respawn_air";
    };
    case "Plane": {
      "respawn_plane";
    };
    case "Ship": {
      "respawn_naval";
    };
    default {
      "respawn_unknown";
    };
  };
};

//Set markers
_markerRange = createMarker [format["Marker_%1_Range", _pointName], _point];
_markerRange setMarkerShape "ELLIPSE";
_markerRange setMarkerSize [20,20];

_markerPointName = ((_pointName splitString "_")-["GP"]) joinString " ";
_markerName = createMarker [format["Marker_%1_Name", _pointName], _point];
_markerName setMarkerText _markerPointName;
_markerName setMarkerType _markerDesign;

_obj addaction [format["<t color='#FFFF00'>Open Garage(%1)</t>", _markerPointName], {
    _params = _this select 3;
    [_params select 0, _params select 1] call kbf_fnc_garageLoad;
  },
  [_point, _types],
  1.5,
  true,
  true,
  "",
  "true",
  _range
];

_obj addAction[format["<t color='#00ffff'>Delete Vehicles(%1)</t>", _markerPointName],{
    _vehicles = ((_this select 3) nearObjects ["AllVehicles", 20]) + ((_this select 3) nearObjects ["#particlesource", 20]);

    {
      _nowvehicle = _x;
      _vehVarName = vehicleVarName _nowvehicle;
      _defaultVeh = "DFV" in (_vehVarName splitString "_");
      if (!(_x isKindOf "Man") && !_defaultVeh) then
      {
        {_nowvehicle deleteVehicleCrew _x} forEach crew _nowvehicle;
        deleteVehicle _x;
      };
    } forEach _vehicles;

  },
  _point,
  1.5,
  true,
  true,
  "",
  "true",
  _range
];

_obj addAction["<t color='#ff0000'>Reset Garage Flag</t>",{
    _marker = vehicleVarName (_this select 3);
    missionNamespace setVariable [format["Open_Garage_%1", _marker], false, true];
  },
  _point,
  1.5,
  true,
  true,
  "",
  "true",
  _range
];