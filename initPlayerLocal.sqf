//initPlayerLocal.sqf
sleep 1; 
missionNamespace setVariable ["BIS_fnc_garage_center", objNull, true]; //Fixes Loadout save not showing before garage init

[ missionNamespace, "arsenalClosed", { 
	if (isNull(missionNamespace getVariable "BIS_fnc_garage_center")) then {
	[player, [missionNamespace, "inventory_var"]] call BIS_fnc_saveInventory;
	systemChat "Loadout Saved"; 
	};
}] call BIS_fnc_addScriptedEventHandler;

["ace_arsenal_displayClosed", {
	if (isNull(missionNamespace getVariable "BIS_fnc_garage_center")) then {
    [player, [missionNamespace, "inventory_var"]] call BIS_fnc_saveInventory;
	systemChat "Loadout Saved";  
	};
}] call CBA_fnc_addEventHandler;

// Order: T.Maker; T.Wilders; F.Napalm; C.Edwards; J.Hart
_PermPlayers = ['76561198171611850','76561198076573165','76561198016586636','76561198172531177','76561197993479022'];
_playerID = getPlayerUID player;

if (_playerID in _PermPlayers) then {
//[_this select 0, SupportRequester, ArtilleryProvider] call BIS_fnc_addSupportLink;
//[_this select 0, SupportRequester, TransportProvider] call BIS_fnc_addSupportLink;
[player, SupportRequester, AmmoProvider] call BIS_fnc_addSupportLink;
	if (_playerID in ['76561198016586636','76561198076573165']) then{
		[player, SupportRequester1, ArtilleryProvider] call BIS_fnc_addSupportLink;
	}
};