pvpfw_chatIntercept_allCommands = [
	[
		"help",
		{
			_commands = "";
			if ((getPlayerUID player) in (missionNamespace getVariable "authplayers")) then{
				{
					_commands = _commands + (pvpfw_chatIntercept_commandMarker + (_x select 0)) + ", ";
				}forEach pvpfw_chatIntercept_allCommands;
			}else{
				_commands = "!help, !login, !echo";
			};
			systemChat format["Available Commands: %1",_commands];
		}
	],
	[
		"echo",
		{
			_argument = _this select 0;
			systemChat format["Echo: %1",_argument];
		}
	],
	[
		"login",
		{
			_argument = _this select 0;
			if (_argument == 'password') then {
				if ((getPlayerUID player) in (missionNamespace getVariable "authplayers")) then{
					systemChat format["Game Admin: Already Logged In"];
				}else{
					_temp = missionNamespace getVariable "authplayers";
					_temp pushBack (getPlayerUID player);
					missionNamespace setVariable["authplayers", _temp,true];
					missionNamespace setVariable["loggedin", true];
					systemChat format["Game Admin: Logged In"];
				};
			};
		}
	],
	[
		"logout",
		{
			if (missionNamespace getVariable "loggedin") then{
				_temp = missionNamespace getVariable "authplayers";
				_temp deleteAt(_temp find (getPlayerUID player));
				missionNamespace setVariable["authplayers", _temp,true];
				missionNamespace setVariable["loggedin", false];
				private _curVarName = _myName+"Cur";
				if (!isNil _curVarName) then {
					//remove zeus
					deleteVehicle (missionNamespace getVariable [_curVarName, objNull]);
					missionNamespace setVariable [_curVarName, nil, true];
				};
				systemChat format["Game Admin: Logged Out"];
			};
		}
	],
	[
		"zeus",
		{
			if (missionNamespace getVariable "loggedin") then{
				["makeCreator"]  call {
					missionNamespace setVariable [_this select 0,player, true];
					[0, {
						params ["_myName"];
						private _curVarName = _myName+"Cur";
						
						if (!isNil _curVarName) then {
							//remove zeus
							deleteVehicle (missionNamespace getVariable [_curVarName, objNull]);
							missionNamespace setVariable [_curVarName, nil, true];
						};


						if (isNil _curVarName) then {
							//begin creation

							if (isNil "Cur_group") then {Cur_group = creategroup sideLogic;};
							private _myCurObject = Cur_group createunit["ModuleCurator_F", [0, 90, 90], [], 0.5, "NONE"];	//Logic Server
							_myCurObject setVariable ["showNotification",false];
							
							missionNamespace setVariable [_curVarName, _myCurObject, true];
							publicVariable "Cur_group";
							unassignCurator _myCurObject;
							_cfg = (configFile >> "CfgPatches");
							_newAddons = [];
							for "_i" from 0 to((count _cfg) - 1) do {
								_name = configName(_cfg select _i);
								_newAddons pushBack _name;
							};
							if (count _newAddons > 0) then {_myCurObject addCuratorAddons _newAddons};

							_myCurObject setcuratorcoef["place", 0];
							_myCurObject setcuratorcoef["delete", 0];
							private _enableSyncVar = _myName+"_enableSync";
							private _val = random 500;
							missionNamespace setVariable [_enableSyncVar, random 500];
							[_enableSyncVar,_val] spawn {
								while  {(missionNamespace getVariable [_this select 0, 0]) == (_this select 1)} do {
								sleep 2;
							};};
							

						};
						private _myCurObject = missionNamespace getVariable [_curVarName, objNull];
						//finished
						unassignCurator _myCurObject;
						sleep 0.4;
						makeCreator assignCurator _myCurObject;
					}, _this] call CBA_fnc_globalExecute;
				};
				systemChat format["Game Admin: Created Zeus"];
			};
		}
	],
	[
		"spectator",
		{
			_argument = _this select 0;
			if (count _argument > 1) then{
				if (missionNamespace getVariable "loggedin") then{
					if (toLower _argument == 'true')then{
						missionNamespace setVariable["spectatorcheck", true,true];
						systemChat format["Game Admin: Spectator enabled for all players"];
					};
					if (toLower _argument == 'false')then{
						missionNamespace setVariable["spectatorcheck", false,true];
						systemChat format["Game Admin: Spectator disabled for all players"];
					}
				};
			}else{
				if ((missionNamespace getVariable "loggedin")||(missionNamespace getVariable "spectatorcheck")) then{
					["Initialize", [player]] call BIS_fnc_EGSpectator;
					[] spawn {
						while{true}do{
							waitUntil {!isNull findDisplay 49};
							["Terminate"] call BIS_fnc_EGSpectator;
							uisleep 3;
						};
					};
				}else{
					systemChat format["Game Admin: This is not available right now"];
				};
			};
		}
	],
	[
        "kick",
        {
            _argument = _this select 0;
            _argumentLowercase = (toLower _argument);
            _kickedflag = false;
            _reason = "Unknown";
            private _headlessClients = entities "HeadlessClient_F";
            private _humanPlayers = allPlayers - _headlessClients;
            {
                _playername = name _x;
                _playernameLowercase = (toLower _playername);
                _playerid = getPlayerUID _x;
                if (_argumentLowercase in _playernameLowercase) then{
                    if !(_playerid in (missionNamespace getVariable "authplayers")) then{
                        systemChat format["Kicking: %1",_playername];
                        _kickedflag = true;
                    }else{
                        _reason = "User is Authenticated";
                    };
                }else{
                    _reason = "Unable to find player";
                };
            } forEach _humanPlayers;
            if !(_kickedflag) then{
                systemChat format["Game Admin: Failed to kick: %1. %2.",_argument,_reason];
            };
        }
    ]
];