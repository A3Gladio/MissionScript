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