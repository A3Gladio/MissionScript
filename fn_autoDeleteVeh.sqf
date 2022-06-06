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
_desertedFlag = false;
_alarm = false;
_time = 0;
_timeStart = 0;
_uav = "VehicleAutonomous" in (typeOf _veh call BIS_fnc_objectType);
_uavGroup = if (_uav) then {
	group ((crew _veh) select 0);
} else {
	grpNull;
};

{
  [_x, _deserted_time, _deserted_dist] spawn kbf_fnc_autoDeleteVeh;
} forEach (attachedObjects _veh);

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

		_getIn = if ({alive _x && isPlayer _x} count (crew _veh) == 0) then { false; } else { true; };
		if(_uav) then {
			if (!isNull ((UAVControl _veh) select 0)) then {
				_getIn = true;
				_desertedFlag = false;
				_alarm = false;
			} else {
				_getIn = false;
			};
		};

		if (_leave && !_getIn) then
		{
			_manCount = 0;
			{
				if (_x isKindOf "Man") then {
					if (alive _x && isPlayer _x) then {
						_manCount = _manCount + 1;
					};
				} else {
					_manCount = _manCount + ({alive _x && isPlayer _x} count (crew _x));
				};
			} forEach (_veh nearEntities [["Man", "Plane", "Helicopter", "Car", "Tank", "Ship", "StaticWeapon"], _deserted_dist]);

			if (_manCount > 0) then {
				_desertedFlag = false;
				_alarm = false;
			};

			//Deserted
			if (_manCount == 0 && !_desertedFlag) then
			{
				_desertedFlag = true;
				_timeStart = _time;
				[format["Warning: %1 is deserted.", _vehName]] remoteExec ["systemChat"];
				sleep 0.1;
			};

			if ((_time - _timeStart) > (_deserted_time - 60) && _desertedFlag && !_alarm) then
			{
				_alarm = true;
				[format["Warning: %1 will be destroyed within 1 min.", _vehName]] remoteExec ["systemChat"];
			};

			//If over time, destroy vehicle.
			if ((_time - _timeStart) > _deserted_time && _desertedFlag) then
			{
				[format["Warning:Time up (%1).", _vehName]] remoteExec ["systemChat"];
				while {alive _veh} do {
					_veh setDamage ((damage _veh) + 0.2);
					sleep 1;
				};
			};
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
