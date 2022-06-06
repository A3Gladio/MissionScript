#include "\A3\ui_f\hpp\defineDIKCodes.inc"
#include "\A3\Ui_f\hpp\defineResinclDesign.inc"
#define FADE_DELAY	0.15
_allowednames = ['ASZ','SwitchBlade','NDS','rhsusf'];
disableSerialization;
params["_point", "_types"];

fnc_Garage_load = {
	//If already the window open, close it by "Cancel"
	if !(isNull(uiNamespace getVariable [ "Garage_Display_Loadout", displayNull ])) then
	{
		_display = uiNamespace getVariable "Garage_Display_Loadout";
		_display closeDisplay 1;
	};

	_point = _this select 0;
	_pointName = vehicleVarName _point;
	_pos = (getPosASL _point) vectorAdd [0,0,0.5];
	_dir = getDir _point;

	_types = _this select 1;

	_existCount = 0;
	_allVehicles = nearestObjects [ ASLToAGL _pos, [ "AllVehicles" ], 20 ];
	{
	  if !(_x isKindOf "Man") then
	  {
	    _existCount = _existCount + 1;
	  };
	} forEach _allVehicles;

	if (_existCount > 0) exitwith
	{
	  ["Vehicles exist in Area"] call BIS_fnc_guiMessage;
	};

	//If someone open garage in same place, warn and exit.
	if (missionNamespace getVariable [format["Open_Garage_%1", _pointName], false]) exitwith
	{
		["Someone open the garage in Same place."] call BIS_fnc_guiMessage;
	};
	missionNamespace setVariable [format["Open_Garage_%1", _pointName], true, true];

	_helipad = createVehicle [ "Land_HelipadEmpty_F", _pos, [], 0, "CAN_COLLIDE" ];
	missionNamespace setVariable [ "BIS_fnc_arsenal_fullGarage", [ true, 0, false, [ false ] ] call bis_fnc_param ];
	with missionNamespace do { BIS_fnc_garage_center = [ true, 1, _helipad, [ objNull ] ] call bis_fnc_param; };
	missionNameSpace setVariable ["Garage_Vehicle", objNull];
	missionNameSpace setVariable ["Garage_Spawn_Flag", false];

	_display = (findDisplay 46) createDisplay "GarageLoadDisplay";
	uiNamespace setVariable ["Garage_Display_Loadout", _display];

	//Spawn type
	if(isNil "Garage_SpawnType") then {
		missionNamespace setVariable ["Garage_SpawnType", 0];
	};

	_ctrlMouseArea = _display displayctrl IDC_RSCDISPLAYARSENAL_MOUSEAREA;
	_ctrlMouseArea ctrladdeventhandler ["mousebuttonclick","
		call sel_toggleShown;
	"];
	_ctrlButtonInterface = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONINTERFACE;
	_ctrlButtonInterface ctrladdeventhandler ["buttonclick","
		call sel_toggleShown;
	"];

	//Wait until garage is ready.
	waitUntil {!isNull (missionnamespace getvariable ["BIS_fnc_arsenal_center", objNull])};
	waitUntil {(missionnamespace getvariable "BIS_fnc_arsenal_center") != _helipad};

	_centerVeh = missionnamespace getvariable "BIS_fnc_arsenal_center";

	//Convert types to corresponding number and check vehicle type.
	_fitNum = 0;
	_typeNums = [];
	{
		if (_x == "Car") then { _typeNums set [_forEachIndex, 0]; };
		if (_x == "Tank") then { _typeNums set [_forEachIndex, 1]; };
		if (_x == "Helicopter") then { _typeNums set [_forEachIndex, 2]; };
		if (_x == "Plane") then { _typeNums set [_forEachIndex, 3]; };
		if (_x == "Ship") then { _typeNums set [_forEachIndex, 4]; };
		if (_x == "StaticWeapon") then { _typeNums set [_forEachIndex, 5]; };
		if (_centerVeh isKindOf _x) then {
			_fitNum = _fitNum + 1;
		};
	} forEach _types;
	
	//Select vehicle random following types.
	if (_fitNum == 0) then {
		{
			if !("Logic" in (_x call BIS_fnc_objectType)) then {
				deleteVehicle _x;
			};
		} forEach (attachedObjects _centerVeh);
		[_typeNums] call sel_random;
	};

	_console = [_pos, _dir, _typeNums] spawn set_dlconsole;

	waitUntil {isNull _display || !alive player};

	{
		_x ctrlRemoveAllEventHandlers "LBSelChanged";
		_x ctrlRemoveAllEventHandlers "CheckedChanged";
		_x ctrlRemoveAllEventHandlers "ButtonClick";
		ctrlDelete _x;
	} forEach Garage_Loadout_Controls;

	terminate _console;

	deleteVehicle _helipad;

	_veh = missionNamespace getVariable "BIS_fnc_garage_center";

	//If pushed spawn button, call createVehicle. If not, delete it.
	if((missionNamespace getVariable "Garage_Spawn_Flag") && (alive player)) then {
		[_point] call fnc_Garage_CreateVehicle;
	} else {
		{
			_veh deleteVehicleCrew _x;
		} forEach (crew _veh);
		{
			deleteVehicle _x;
		} forEach (attachedObjects _veh);
		deleteVehicle _veh;
	};

	if(!alive player) then {
		_display = uiNamespace getVariable "Garage_Display_Loadout";
		_display closeDisplay 1;
	};

	missionNamespace setVariable [format["Open_Garage_%1", _pointName], false, true];
};

set_dlconsole = {
	params["_pos", "_dir", "_typeNums"];
	_display = uiNamespace getVariable "Garage_Display_Loadout";

	_attachedObj = [];

	while {true} do {
		sleep 0.1;

		//Don't show unneccessary ctrls.
		{
			(_display displayCtrl (930+_x)) ctrlShow false;
		} forEach ([0,1,2,3,4,5] - _typeNums);

		//If change vehicle selection, it will be executed.
		if ((missionnamespace getvariable "BIS_fnc_arsenal_center") != (missionNameSpace getVariable "Garage_Vehicle")) then
		{
			//Attached obj can't delete in changing garage selection, so delete them here.
			{
				if !("Logic" in (_x call BIS_fnc_objectType)) then {
					deleteVehicle _x;
				};
			} forEach _attachedObj;

			_veh = missionnamespace getvariable "BIS_fnc_arsenal_center";
			_typeVeh = typeOf _veh;
			_veh setPosASL _pos;
			_veh setDir _dir;
			missionNameSpace setVariable ["Garage_Vehicle", _veh];

			_attachedObj = attachedObjects _veh;

			if(isNil "Garage_Loadout_Controls") then {
				Garage_Loadout_Controls = [];
			};

			{
				_x ctrlRemoveAllEventHandlers "LBSelChanged";
				_x ctrlRemoveAllEventHandlers "CheckedChanged";
				_x ctrlRemoveAllEventHandlers "ButtonClick";
				ctrlDelete _x;
			} forEach Garage_Loadout_Controls;
			Garage_Loadout_Controls = [];

			_ctrls = [];

			//Setting stats ctrls
			_modPic = _display displayctrl 1869;
			_addons = configSourceAddonList (configFile >> "CfgVehicles" >> _typeVeh);
			_modPicText = "a3\ui_f\data\logos\arma3_white_ca.paa";
			if (count _addons > 0) then {
				_dlcs = configSourceModList (configfile >> "CfgPatches" >> _addons select 0);
				if (count _dlcs > 0) then {
					private _dlcName = _dlcs select 0;
					if (_dlcName != "") then {
						_modPicText = (modParams [_dlcName,["logo"]]) param [0,""];
					}else{
						_modPicText = getText ((configfile >> "cfgMods" >> getText (configFile >> "CfgVehicles" >> _typeVeh >> "dlc")) >> "logo");
					};
				};
			};
			_modPic ctrlSetText _modPicText;

			_statsExtremes = uinamespace getVariable "BIS_fnc_garage_stats";
			if !(isnil "_statsExtremes") then {
				_barMin = 0.01;
				_barMax = 1;

				_statsMin = _statsExtremes select 0;
				_statsMax = _statsExtremes select 1;

				_stats = [[configfile >> "cfgvehicles" >> _typeVeh],	["maxspeed","armor"], [false,true], _statsMin] call BIS_fnc_configExtremes;
				_stats = _stats select 1;
				_statMaxSpeed = linearConversion [_statsMin select 0,_statsMax select 0,_stats select 0,_barMin,_barMax];
				_statArmor = linearConversion [_statsMin select 1,_statsMax select 1,_stats select 1,_barMin,_barMax];

				_ctrlMaxspeed = _display displayctrl 1870;
				_ctrlMaxspeed progressSetPosition _statMaxSpeed;

				_ctrlArmor = _display displayctrl 1871;
				_ctrlArmor progressSetPosition _statArmor;
			};


			if (isText(configFile >> "CfgVehicles" >> _typeVeh >> "Components" >> "TransportPylonsComponent" >> "uiPicture")) then
			{
				_pylons = (configProperties [configFile >> "CfgVehicles" >> _typeVeh >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {configName _x};
				_countPylons = count _pylons;

				if (isNil (format ["Garage_Loadout_%1", _typeVeh])) then
				{
					missionNamespace setVariable [format ["Garage_Loadout_%1", _typeVeh], getPylonMagazines _veh];
				};
				_last_loadout = missionNamespace getVariable (format ["Garage_Loadout_%1", _typeVeh]);

				if (isNil (format ["Garage_Turret_%1", _typeVeh])) then
				{
					_magTurret = [];
					{
						_magTurret pushBack getArray(configfile >> "CfgVehicles" >> _typeVeh >> "Components" >> "TransportPylonsComponent" >> "Pylons" >> _x >> "turret");
					} forEach _pylons;
					missionNamespace setVariable [format ["Garage_Turret_%1", _typeVeh], _magTurret];
				};
				_last_turret = missionNamespace getVariable (format ["Garage_Turret_%1", _typeVeh]);

				_last_preset = missionNamespace getVariable [format ["Pylons_Preset_%1", _typeVeh], 0];

				//Pylon display group.
				_pylonGroup = _display ctrlCreate ["GaragePylonGroup", 1872];
				_ctrls pushBack _pylonGroup;

				_pylonGroupPos = ctrlPosition _pylonGroup;
				_pylonGroupSize_x = _pylonGroupPos select 2;
				_pylonGroupSize_y = _pylonGroupPos select 3;

				//Pylons setting ctrls
				_ctrlpic = _display displayctrl 1873;
				_textIMG = getText(configFile >> "CfgVehicles" >> _typeVeh >> "Components" >> "TransportPylonsComponent" >> "uiPicture");
				_ctrlpic ctrlSetText _textIMG;

				_height = ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)*0.9; //GUI_GRID_H*0.9

				_ctrl_preset = _display displayctrl 1875;
				_ctrl_mirror = _display displayctrl 1874;

				//Preset
				_presetsCFG = "true" configClasses (configfile >> "CfgVehicles" >> _typeVeh >> "Components" >> "TransportPylonsComponent" >> "presets");
				_preset = [];
				if(_last_preset > 0) then
				{
					_preset = getArray(configfile >> "CfgVehicles" >> _typeVeh >> "Components" >> "TransportPylonsComponent" >> "presets" >> configName (_presetsCFG select (_last_preset-1)) >> "attachment");
				};

				{
					_ctrl_preset lbAdd getText(configfile >> "CfgVehicles" >> _typeVeh >> "Components" >> "TransportPylonsComponent" >> "presets" >> configName _x >> "displayName");
				} forEach _presetsCFG;
				_ctrl_preset lbSetCurSel _last_preset;

				//If change preset, change pylon loadouts.
				_ctrl_preset ctrlAddEventHandler ["LBSelChanged",{
					[] call fnc_preset_change;
				}];

				//Mirror settings
				_ctrl_mirror cbSetChecked false;
				_ctrl_mirror ctrlAddEventHandler ["CheckedChanged", {
					[] call fnc_pylon_mirror;
				}];

				//Pylons' ctrls
				_i = 0;
				while{_i < _countPylons} do
				{
					_ctrl = _display ctrlCreate ["GaragePylons", 1876+_i, _pylonGroup];
					_ctrl ctrlSetTooltip (_pylons select _i);

					_offset = getArray (configfile >> "CfgVehicles" >> _typeVeh >> "Components" >> "TransportPylonsComponent" >> "pylons" >> (_pylons select _i) >> "UIposition");
					_offset_final = [0,0];
					_break = 0;
					{
						if(_x isEqualType "") then
						{
							_offset_final set [_forEachIndex, call (compile _x)];
						};
						if (_x isEqualType 0) then
						{
							_offset_final set [_forEachIndex, _x];
						};
						if(_offset_final select _forEachIndex > 1) then
						{
							_break = _break + 1;
						};
					} forEach _offset;

					//If inside of box, continue. If out of box, delete ctrl.
					if (_break == 0) then
					{
						_pos_offset = [0, _pylonGroupSize_y*0.07];

						_pos_x = _pylonGroupSize_x * (_offset_final select 0) / 0.87 + (_pos_offset select 0);
						_pos_y = _pylonGroupSize_y*0.93 * (_offset_final select 1) / 0.614 + (_pos_offset select 1);
						_ctrl ctrlSetPosition [_pos_x,_pos_y];
						_ctrl ctrlCommit 0;

						_ctrls pushBack _ctrl;

						if (count allTurrets [_veh, false] > 0) then
						{
							_turret = [];
							_ctrl_turret = _display ctrlCreate ["GaragePylonTurrets", 1976+_i, _pylonGroup];
							_ctrl_turret ctrlSetPosition [_pos_x-_height,_pos_y];
							_ctrl_turret ctrlCommit 0;

							if (count (_last_turret select _i) == 0) then
							{
								_ctrl_turret ctrlSetText "a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa";
								_ctrl_turret ctrlSetTooltip localize "str_driver";
							} else {
								_ctrl_turret ctrlSetText "a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa";
								_ctrl_turret ctrlSetTooltip localize "str_gunner";
								_turret = [0];
							};
							_ctrl_turret setVariable ["Owner", _turret];
							_ctrls pushBack _ctrl_turret;

							_ctrl_turret ctrlAddEventHandler ["ButtonClick", {
								[_this select 0] call fnc_toggle_turret;
							}];
						};

						_veh animateBay [_i, 1];

						//Set last loadout
						if(_last_preset == 0) then
						{
							if(!isNil "_last_loadout") then {
								_veh setPylonLoadOut [_i+1, _last_loadout select _i,true];
							};
						} else {
							if ((count _preset) != 0 && (count _preset) >= _i) then {
								_veh setPylonLoadOut [_i+1, _preset select _i,true];
							} else {
								_veh setPylonLoadOut [_i+1, "",true];
							};
						};

						//Insert weapon to the list, and select current weapon.
						_current_wep = (getPylonMagazines _veh) select _i;
						_magList = ["None"]; //empty pylon
						_magList append (_veh getCompatiblePylonMagazines (_pylons select _i));
						_selected = 0;
						{
							_magName = if (_forEachIndex == 0) then {
								"<empty>";
							} else {
								getText(configFile >> "CfgMagazines" >> _x >> "displayName");
							};
							_ctrl lbAdd _magName;
							_ctrl lbSetData [_forEachIndex, format["%1^%2", _x, _i]];

							_toolTip = getText(configFile >> "CfgMagazines" >> _x >> "descriptionShort");
							if (_toolTip != "") then
							{
								_ctrl lbSetTooltip [_forEachIndex, _toolTip];
							};

							if(_current_wep == _x) then {
								_selected = _forEachIndex;
							};
						} forEach _magList;
						_ctrl lbSetCurSel _selected;

						//When a pylon weapon change, model's pylon weapon change.
						_ctrl ctrlAddEventHandler ["LBSelChanged",{
							[_this select 0, _this select 1] call sel_weapon;
						}];
					} else {
						ctrlDelete _ctrl;
					};

					_i = _i + 1;
				};
			};
			Garage_Loadout_Controls = _ctrls;
		};
	};
};

sel_toggleShown = {
	_display = uiNamespace getVariable "Garage_Display_Loadout";

	_dummyBarGroup = _display displayctrl 1867;
	_statsGroup = _display displayctrl 1868;
	_pylonGroup = _display displayctrl 1872;

	_veh = missionNameSpace getVariable "Garage_Vehicle";
	_typeVeh = typeOf _veh;
	_pylons = (configProperties [configFile >> "CfgVehicles" >> _typeVeh >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {configName _x};
	_countPylons = count _pylons;

	_ctrls = [_statsGroup, _pylonGroup, _dummyBarGroup];
	_i = 0;
	while{_i < _countPylons} do
	{
		_ctrls append [_display displayctrl (1876+_i), _display displayctrl (1976+_i)];
		_i = _i + 1;
	};

	_shown = ctrlshown (_display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_CONTROLBAR);
	{
		_x ctrlsetfade ([1,0] select _shown);
		_x ctrlcommit FADE_DELAY;
		_x ctrlShow _shown;
	} forEach _ctrls;
};

sel_random = {
	_display = uiNamespace getVariable "Garage_Display_Loadout";
	_selNum = selectRandom (_this select 0);

	//--- Select random vehicle type
	for "_i" from 0 to 5 do {
		_ctrlList = _display displayctrl (960 + _i);
		_ctrlList lbSetCurSel -1;
	};

	//--- Select random item
	_ctrlLineicon = _display displayctrl 1803;
	waitUntil {!ctrlShown _ctrlLineicon}; //wait for loading lists.
	_ctrlList = _display displayctrl (960 + _selNum);
	_ctrlList lbSetCurSel (floor random ((lbSize _ctrlList) - 1));
};

sel_weapon = {
	//systemChat "Sel weapon";
	_ctrl = _this select 0;
	_index = lbCurSel _ctrl;
	_str = (_ctrl lbData _index) splitString "^";
	_pylon_index = parseNumber (_str select 1);

	[_pylon_index] call fnc_weapon_change;
};

fnc_toggle_turret = {
	_ctrl = _this select 0;
	_display = uiNamespace getVariable "Garage_Display_Loadout";
	_pylon_index = (ctrlIDC _ctrl) - 1976;

	_veh = missionNameSpace getVariable "Garage_Vehicle";
	_typeVeh = typeOf _veh;

	_last_turret = missionNamespace getVariable (format ["Garage_Turret_%1", _typeVeh]);

	_ctrls = [_ctrl];
	//If mirroring, change together.
	if (cbChecked (_display displayCtrl 1874)) then
	{
		_pylons = (configProperties [configFile >> "CfgVehicles" >> _typeVeh >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {configName _x};
		_countPylons = count _pylons;

		_mirrorPos = [];
		{
			_mirrorPos pushBack (getNumber (configfile >> "CfgVehicles" >> _typeVeh >> "Components" >> "TransportPylonsComponent" >> "Pylons">> _x >> "mirroredMissilePos"));
		} forEach _pylons;

		{
			_mirror_id = _x - 1;
			if (((_mirrorPos select _pylon_index) <= 0) && (_mirror_id == _pylon_index)) then {
				_ctrls pushBack (_display displayCtrl (1976+_forEachIndex));
			};
		} forEach _mirrorPos;
	};

	{
		//Toggle selection.
		_turret = [];
		if (count (_x getVariable "Owner") == 0) then
		{
			_x ctrlSetText "a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa";
			_x ctrlSetTooltip localize "str_gunner";
			_turret = [0];
		} else {
			_x ctrlSetText "a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa";
			_x ctrlSetTooltip localize "str_driver";
		};
		_x setVariable ["Owner", _turret];

		_index = (ctrlIDC _x) - 1976;
		_last_turret set [_index, _turret];
	} forEach _ctrls;

	missionNamespace setVariable [format ["Garage_Turret_%1", _typeVeh], _last_turret];
};

//0 : vehicle, 1 : pylon index (0~), 2 : weapon class
fnc_set_pylon = {
	_veh = _this select 0;
	_pylonIndex = _this select 1;
	_weaponClass = _this select 2;

	if (_weaponClass == "None") then
	{
		_veh setPylonLoadOut [_pylonIndex+1, "", true];
	} else {
		_veh setPylonLoadOut [_pylonIndex+1, _weaponClass, true];
		_veh setAmmoOnPylon [_pylonIndex+1,getNumber (configfile >> "CfgMagazines" >> _weaponClass >> "count")];
	};
};

fnc_preset_change = {
	_veh = missionNameSpace getVariable "Garage_Vehicle";
	_typeVeh = typeOf _veh;

	_display = uiNamespace getVariable "Garage_Display_Loadout";

	_ctrl_preset = _display displayCtrl (1875);
	_index = lbCurSel _ctrl_preset;

	_pylons = (configProperties [configFile >> "CfgVehicles" >> _typeVeh >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {configName _x};
	_countPylons = count _pylons;

	//Load selected preset's weapons.
	_preset = missionNamespace getVariable format ["Garage_Loadout_%1", _typeVeh];
	if (_index > 0) then
	{
		_presetsCFG = ("true" configClasses (configfile >> "CfgVehicles" >> _typeVeh >> "Components" >> "TransportPylonsComponent" >> "presets")) select (_index-1);
		_preset = getArray(configfile >> "CfgVehicles" >> _typeVeh >> "Components" >> "TransportPylonsComponent" >> "presets" >> configName _presetsCFG >> "attachment");
	};

	_i = 0;
	while{_i < _countPylons} do
	{
		_ctrl = _display displayCtrl (1876+_i);
		if (!isNull _ctrl) then {
			_ctrl ctrlRemoveAllEventHandlers "LBSelChanged";
			//Find id in select box.
			_selected = 0;
			_class = "";
			if ((count _preset) != 0 && (count _preset) > _i) then {
				_preset_mag = _preset select _i;
				_magList = [""]; //empty pylon
				_magList append (_veh getCompatiblePylonMagazines (format ["%1",_pylons select _i]));
				{
					if(_preset_mag == _x) then {
						_class = _x;
						_selected = _forEachIndex;
					};
				} forEach _magList;
			};

			//While change selection of weapon, remove selchange action.
			_ctrl lbSetCurSel _selected;
			[_veh, _i, _class] call fnc_set_pylon;
			waitUntil {(lbCurSel _ctrl) == _selected};
			_ctrl ctrlAddEventHandler ["LBSelChanged",{
				[_this select 0, _this select 1] call sel_weapon;
			}];
		};
		_i = _i + 1;
	};
	missionNamespace setVariable [format["Pylons_Preset_%1", _typeVeh], _index];

	//While change selection of mirroring, remove checkbox action.
	_ctrl_mirror = _display displayCtrl (1874);
	//_ctrl_mirror ctrlRemoveAllEventHandlers "CheckedChanged";
	if (cbChecked _ctrl_mirror) then
	{
		_ctrl_mirror cbSetChecked false;
		[] call fnc_pylon_mirror;
		waitUntil {!cbChecked _ctrl_mirror};
	};
	/*_ctrl_mirror ctrlAddEventHandler ["CheckedChanged",{
		[] call fnc_pylon_mirror;
	}];*/
};

fnc_pylon_mirror = {
	//systemChat "In pylon mirror";
	_veh = missionNameSpace getVariable "Garage_Vehicle";
	_typeVeh = typeOf _veh;

	_display = uiNamespace getVariable "Garage_Display_Loadout";

	_ctrl_mirror = _display displayCtrl 1874;

	_pylons = (configProperties [configFile >> "CfgVehicles" >> _typeVeh >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {configName _x};
	_countPylons = count _pylons;

	_mirrorPos = [];
	{
		_mirrorPos pushBack (getNumber (configfile >> "CfgVehicles" >> _typeVeh >> "Components" >> "TransportPylonsComponent" >> "Pylons">> _x >> "mirroredMissilePos"));
	} forEach _pylons;

	_last_turret = missionNamespace getVariable (format ["Garage_Turret_%1", _typeVeh]);

	_i = 0;
	_call_id = [];
	while {_i < _countPylons} do {
		_ctrl = _display displayCtrl (1876+_i);
		_ctrl_turret = _display displayCtrl (1976+_i);
		_mirror_id = _mirrorPos select _i;
		if (_mirror_id > 0) then
		{
			if (cbChecked _ctrl_mirror) then
			{
				_ctrl ctrlRemoveAllEventHandlers "LBSelChanged";
				_ctrl ctrlCommit 0;
				_ctrl ctrlEnable false;

				//systemChat str _mirror_id;
				if ((_call_id find _mirror_id) == -1) then {
					_call_id pushBack _mirror_id;
				};

				if (count allTurrets [_veh, false] > 0) then
				{
					_ctrl_turret ctrlRemoveAllEventHandlers "ButtonClick";
					_ctrl_turret ctrlCommit 0;
					_ctrl_turret ctrlEnable false;

					//If selection is different, toggle it.
					_ctrl_turret_mirror = _display displayCtrl (1976+(_mirror_id-1));
					_owner = _ctrl_turret getVariable "Owner";
					if (count (_ctrl_turret_mirror getVariable "Owner") != count _owner) then
					{
						_turret = [];
						if (count _owner == 0) then
						{
							_ctrl_turret ctrlSetText "a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa";
							_ctrl_turret ctrlSetTooltip localize "str_gunner";
							_turret = [0];
						} else {
							_ctrl_turret ctrlSetText "a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa";
							_ctrl_turret ctrlSetTooltip localize "str_driver";
						};
						_ctrl_turret setVariable ["Owner", _turret];

						_last_turret set [_i, _turret];
					};
				};
			} else {
				_ctrl ctrlAddEventHandler ["LBSelChanged",{
					[_this select 0, _this select 1] call sel_weapon;
				}];
				_ctrl ctrlEnable true;

				if (count allTurrets [_veh, false] > 0) then
				{
					_ctrl_turret ctrlAddEventHandler ["ButtonClick", {
						[_this select 0] call fnc_toggle_turret;
					}];
					_ctrl_turret ctrlEnable true;
				};
			};
		};
		_i = _i + 1;
	};

	missionNamespace setVariable [format ["Garage_Turret_%1", _typeVeh], _last_turret];

	{
		[_x - 1] spawn fnc_weapon_change;
	} forEach _call_id;
};

//0 : pylon index
fnc_weapon_change = {
	//systemChat "In weapon change";
	_veh = missionNameSpace getVariable "Garage_Vehicle";
	_typeVeh = typeOf _veh;
	_pylon_index = _this select 0;

	_display = uiNamespace getVariable "Garage_Display_Loadout";

	//While change selection of preset, remove selchange action.
	_ctrl_preset = _display displayCtrl 1875;
	_ctrl_preset ctrlRemoveAllEventHandlers "LBSelChanged";

	_ctrl = _display displayCtrl (1876+_pylon_index);
	_index = lbCurSel _ctrl;
	_str = (_ctrl lbData _index) splitString "^";
	_class = (_str select 0);

	_ctrl ctrlRemoveAllEventHandlers "LBSelChanged";

	//Change weapon
	[_veh, _pylon_index, _class] call fnc_set_pylon;

	//If mirroring, change together.
	if (cbChecked (_display displayCtrl 1874)) then
	{
		_pylons = (configProperties [configFile >> "CfgVehicles" >> _typeVeh >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {configName _x};
		_countPylons = count _pylons;

		_mirrorPos = [];
		{
			_mirrorPos pushBack (getNumber (configfile >> "CfgVehicles" >> _typeVeh >> "Components" >> "TransportPylonsComponent" >> "Pylons">> _x >> "mirroredMissilePos"));
		} forEach _pylons;

		{
			_mirror_id = _x - 1;
			if (((_mirrorPos select _pylon_index) <= 0) && (_mirror_id == _pylon_index)) then {
				_magList = ["None"]; //empty pylon
				_magList append (_veh getCompatiblePylonMagazines (format ["%1",_pylons select _forEachIndex]));

				_ctrl_mirrored = _display displayCtrl (1876+_forEachIndex);
				_selected = lbCurSel _ctrl_mirrored;
				_selFind = _magList find _class;
				if (_selFind != -1) then {
					_ctrl_mirrored lbSetCurSel _selFind;
					_str_mirrored = (_ctrl_mirrored lbData _selFind) splitString "^";
					_class_mirrored = _str_mirrored select 0;
					[_veh, _forEachIndex, _class_mirrored] call fnc_set_pylon;
				};
			};
		} forEach _mirrorPos;
	};

	missionNamespace setVariable [format ["Garage_Loadout_%1", _typeVeh], getPylonMagazines _veh];

	//While change selection of preset, remove selchange action.
	if ((lbCurSel _ctrl_preset) != 0) then
	{
		_ctrl_preset lbSetCurSel 0;
		missionNamespace setVariable [format["Pylons_Preset_%1", _typeVeh], 0];
		waitUntil {(lbCurSel _ctrl_preset) == 0};
	};

	_ctrl_preset ctrlAddEventHandler ["LBSelChanged",{
		[] call fnc_preset_change;
	}];

	_ctrl ctrlAddEventHandler ["LBSelChanged",{
		[_this select 0, _this select 1] call sel_weapon;
	}];
};

//hint "Create";
fnc_Garage_CreateVehicle = {
	_point = _this select 0;
	_veh = missionNamespace getVariable "BIS_fnc_garage_center";
	_typeVeh = typeOf _veh;

	_animationNames = animationNames _veh;
	_animationValues = [];
	{
		_animationValues pushBack (_veh animationPhase _x);
	} forEach _animationNames;

	_textures = getObjectTextures _veh;

	_magsNew = getPylonMagazines _veh;
	_turretNew = missionNamespace getVariable (format ["Garage_Turret_%1", _typeVeh]);

	_fullCrewParams = fullCrew _veh;

	_special = "CAN_COLLIDE";
	_movein = false;
	switch (missionNamespace getVariable "Garage_SpawnType") do {
		case 1 : {
			_movein = true;
		};
		case 2 : {
			_movein = true;
			if ((_veh isKindOf "plane") || (_veh isKindOf "helicopter")) then
			{
				_special = "FLY";
			};
		};
	};

	{
		_veh deleteVehicleCrew _x;
	} forEach (crew _veh);
	{
		deleteVehicle _x;
	} forEach (attachedObjects _veh);
	deleteVehicle _veh;
	waitUntil {!alive _veh};

	sleep 0.1;

	// VEH SPAWN CHECK
	// {
	// 	//systemChat (str _x);
	// 	if (_x in _typeVeh) then {
	// 		//systemChat 'True';
	// 		_veh = createVehicle [_typeVeh, _point, [], 0, _special];
	// 		if (_special != "FLY") then
	// 		{
	// 			_veh setPosASL ((getPosASL _point) vectorAdd [0,0,0.5]);
	// 		};
	// 		_veh setDir (getDir _point);

	// 		{
	// 			_veh animate [_x,_animationValues select _forEachIndex,true];
	// 		} forEach _animationNames;

	// 		{
	// 			_veh setObjectTextureGlobal [_forEachIndex,_x];
	// 		} forEach _textures;
	// 	};
	// } forEach _allowednames;

	_veh = createVehicle [_typeVeh, _point, [], 0, _special];
	if (_special != "FLY") then
	{
		_veh setPosASL ((getPosASL _point) vectorAdd [0,0,0.5]);
	};
	_veh setDir (getDir _point);

	{
		_veh animate [_x,_animationValues select _forEachIndex,true];
	} forEach _animationNames;

	{
		_veh setObjectTextureGlobal [_forEachIndex,_x];
	} forEach _textures;
	//Store non pylon weapons.
	_nonPylonWeapons = [];
	{
 		//_nonPylonWeapons append (getArray (_x >> "weapons"));
		{
			_nonPylonWeapons pushBack (toLower _x);
		} forEach (getArray (_x >> "weapons"));
	} forEach ([_veh, configNull] call BIS_fnc_getTurrets);

	//Delete pylon weapons.
	{
		_turretPath = _x;
		_allTurretWeapons = [];
		{
			_allTurretWeapons pushBack (toLower _x);
		} forEach (_veh weaponsTurret _turretPath);
		{
			//_veh removeWeaponGlobal _x;
			_veh removeWeaponTurret [_x, _turretPath];
		} forEach (_allTurretWeapons - _nonPylonWeapons);
	} forEach ([[-1]] + (allTurrets _veh));

	//Set weapons.
	{
		_veh setPylonLoadOut [_forEachIndex+1, _x, true, _turretNew select _forEachIndex];
		_veh setAmmoOnPylon [_forEachIndex+1, getNumber (configfile >> "CfgMagazines" >> _x >> "count")];
	} forEach _magsNew;

	if("VehicleAutonomous" in (_typeVeh call BIS_fnc_objectType)) then
	{
		createVehicleCrew _veh;
		_veh setAutonomous (player connectTerminalToUAV _veh);
		(crew _veh) joinSilent (createGroup [playerSide, true]);

		if(_moveIn) then
		{
			_ai = driver _veh;
			if(isNull _ai) then
			{
				_ai = gunner _veh;
			};

			if (player connectTerminalToUAV _veh) then
			{
				player action ["UAVTerminalOpen", player];
				player remoteControl _ai;
				_ai switchCamera "INTERNAL";
			};
		};
		/*
		//When player killed, diconnect UAV from player terminal.
		_eventID = player addEventHandler ["Killed", {
  		if (!isNull getConnectedUAV (_this select 0)) then {
    		(_this select 0) connectTerminalToUAV objNull;
		  };
			(_this select 0) removeEventHandler ["Killed", _thisEventHandler];
		}];
		_veh setVariable ["PlayerKilledEvent", [player, _eventID]];

		_veh addEventHandler ["Deleted", {
			params ["_veh"];
			_eventParam = _veh getVariable "PlayerKilledEvent";
			(_eventParam select 0) removeEventHandler ["Killed", _eventParam select 1];
		}];
		*/
	};

	//When the vehicle is plane, set initial speed.
	if (_veh isKindOf "plane" && _special == "FLY") then
	{
		_dir = getDir _veh;
		_speed = 80;
		_veh setVelocity [
			sin _dir * _speed,
			cos _dir * _speed,
			0
		];
		_veh setAirplaneThrottle 1;
	};

	//Execute additional script.
	_pointName = format["%1", _point];
	_script = missionNamespace getVariable format["Garage_Script_%1", _pointName];
	call (compile _script);
};

//call garage function
[_point, _types] call fnc_Garage_load;
