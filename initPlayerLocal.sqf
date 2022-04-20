//initPlayerLocal.sqf
sleep 1; 

[ missionNamespace, "arsenalClosed", { 
	[player, [missionNamespace, "inventory_var"]] call BIS_fnc_saveInventory;
	systemChat "Loadout Saved"; 
}] call BIS_fnc_addScriptedEventHandler;

["ace_arsenal_displayClosed", {
    [player, [missionNamespace, "inventory_var"]] call BIS_fnc_saveInventory;
	systemChat "Loadout Saved";  
}] call CBA_fnc_addEventHandler;