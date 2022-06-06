//initPlayerLocal.sqf
sleep 1; 

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

if (str(player)in ['VN1','VN2','VN3','VN4']) then {
//[_this select 0, SupportRequester, ArtilleryProvider] call BIS_fnc_addSupportLink;
//[_this select 0, SupportRequester, TransportProvider] call BIS_fnc_addSupportLink;
[_this select 0, SupportRequester, AmmoProvider] call BIS_fnc_addSupportLink;
};
if (str(player)in ['VN1']) then {
[_this select 0, SupportRequester1, ArtilleryProvider] call BIS_fnc_addSupportLink;
};