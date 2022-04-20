//init.sqf
{
	if('vabox' in (vehicleVarName _x)) then {
		["AmmoboxInit",[_x,true]] call BIS_fnc_arsenal; 
		[_x, true] call ace_arsenal_fnc_initBox; 
		_x addAction ["<t>Basic Loadout</t>", {player execVM "based_loadout.sqf";},nil,1,true,true,"","true",4]; 
		_x allowDamage false;
	};
}foreach allMissionObjects "Thing";
