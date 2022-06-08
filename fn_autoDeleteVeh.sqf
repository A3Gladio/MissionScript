params[["_veh", objNull], ["_deserted_time", 120], ["_deserted_dist", 150]];

if (_deserted_time < 0) then {_deserted_time = 0};

_position = getPosASL _veh;
_vehName = getText (configFile >> "CfgVehicles" >> typeOf _veh >> "displayName");

_crew = [];
_i = 0;
{
	if (!isPlayer _x) then {
		_crew set [_i, _x];
		_i = _i + 1;
	};
} forEach (crew _veh);

_leave = false;
_time = 0;
_timeStart = 0;
_uav = "VehicleAutonomous" in (typeOf _veh call BIS_fnc_objectType);
_uavGroup = if (_uav) then {
	group ((crew _veh) select 0);
} else {
	grpNull;
};

// Start monitoring the vehicle
_run = true;
while {_run} do
{
	sleep 10;

	if (isMultiplayer) then
	{
		_time = serverTime;
	} else {
		_time = time;
	};

	if (!isNull _veh) then {
		if ((getPosASL _veh) distance _position > 20 && !_leave) then {
			_leave = true;
		};
		//Delete destroyed vehicle
	  	if !(alive _veh) then
		{
			[format["System : %1 is destroyed.", _vehName]] remoteExec ["systemChat"];
			sleep 30;
			{
				if (typeOf _x == "#particlesource") then
				{
					[_x] remoteExec ["deleteVehicle"];
				};
			} forEach (_veh nearObjects 15);

			{_veh deleteVehicleCrew _x} forEach (crew _veh);
			{
				deleteVehicle _x;
			} forEach (attachedObjects _veh);
			deleteVehicle _veh;

			if (_uav) then {
				deleteGroup _uavGroup;
			};

			{
				if (!isNull _x) then {
					deleteVehicle _x;
				};
			} forEach _crew;

			[format["System : %1 is deleted.", _vehName]] remoteExec ["systemChat"];
			_run = false;
		};
	} else {
		if (_uav) then {
			deleteGroup _uavGroup;
		};
		{
			if (!isNull _x) then {
				deleteVehicle _x;
			};
		} forEach _crew;
		[format["System : %1 is deleted.", _vehName]] remoteExec ["systemChat"];
		_run = false;
	};
};
