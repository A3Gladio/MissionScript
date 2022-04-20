//based_loadout.sqf
comment "Exported from Arsenal by T.Maker";


comment "Remove existing items";
removeAllWeapons _this;
removeAllItems _this;
removeAllAssignedItems _this;
removeUniform _this;
removeVest _this;
removeBackpack _this;
removeHeadgear _this;
removeGoggles _this;

comment "Add weapons";
_this addWeapon "CUP_arifle_ACRC_blk_556";
_this addPrimaryWeaponItem "ACE_30Rnd_556x45_Stanag_Mk318_mag";
_this addWeapon "CUP_hgun_Glock17";
_this addHandgunItem "CUP_17Rnd_9x19_glock17";

comment "Add containers";
_this forceAddUniform "ASZ_Uniforme_EI_CBT";
_this addVest "ASZ_NC4_09";
_this addBackpack "ASZ_BackPack_30lt_CBT";

comment "Add binoculars";
_this addWeapon "Binocular";

comment "Add items to containers";
for "_i" from 1 to 2 do {_this addItemToUniform "ACE_EarPlugs";};
_this addItemToUniform "ACE_EntrenchingTool";
_this addItemToUniform "ACE_MapTools";
_this addItemToUniform "ACE_Flashlight_XL50";
for "_i" from 1 to 4 do {_this addItemToVest "ACE_tourniquet";};
for "_i" from 1 to 4 do {_this addItemToVest "ACE_CableTie";};
_this addItemToVest "ItemcTabHCam";
for "_i" from 1 to 2 do {_this addItemToVest "ACE_IR_Strobe_Item";};
_this addItemToVest "ACRE_PRC343";
for "_i" from 1 to 9 do {_this addItemToVest "ACE_30Rnd_556x45_Stanag_Mk318_mag";};
_this addItemToVest "CUP_17Rnd_9x19_glock17";
for "_i" from 1 to 16 do {_this addItemToBackpack "ACE_elasticBandage";};
for "_i" from 1 to 4 do {_this addItemToBackpack "ACE_splint";};
for "_i" from 1 to 4 do {_this addItemToBackpack "ACE_morphine";};
for "_i" from 1 to 7 do {_this addItemToBackpack "ACE_epinephrine";};
for "_i" from 1 to 2 do {_this addItemToBackpack "CUP_HandGrenade_M67";};
for "_i" from 1 to 2 do {_this addItemToBackpack "SmokeShell";};
_this addItemToBackpack "SmokeShellRed";
_this addItemToBackpack "SmokeShellBlue";
_this addHeadgear "ASZ_Mich_ARC_CBT";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadioAcreFlagged";
_this linkItem "ItemGPS";
_this linkItem "rhsusf_ANPVS_15";
