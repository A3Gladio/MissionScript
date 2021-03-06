//init.sqf
[ "Preload" ] call BIS_fnc_arsenal;
{
	if('vabox' in (vehicleVarName _x)) then {
		["AmmoboxInit",[_x,true]] call BIS_fnc_arsenal; 
		//[_x, true] call ace_arsenal_fnc_initBox; 
		_x addAction ["<t>Basic Loadout</t>", {player execVM "based_loadout.sqf";},nil,1,true,true,"","true",4]; 
		_x allowDamage false;
	};
	if('cabox' in (vehicleVarName _x)) then {
		call{
			[_x, GP_Base, ["Ground"], 10, "[_veh, 300, 150] execVM 'fn_autoDeleteVeh.sqf'"] call kbf_fnc_garageInit;
		};
	};
}foreach allMissionObjects "Thing";

_dontRemove = ["TFAR_anprc152","ASZ_Uniforme_Crew","ASZ_SOF_Uniform_CB60","ASZ_SOF_Uniform_CBT","ASZ_Uniforme_EI_CB60","ASZ_Uniforme_EI_CBT","ASZ_GhillieSuit_des","ASZ_GhillieSuit","ASZ_uniform_Pilot_AM","ASZ_uniform_Pilot_CC","ASZ_uniform_Pilot_MM","USAF_Overalls_Rpants_Ranger_2_w","gen3_cryes_B_altimetrico","gen3_cryes_B_CBT","gen3_cryes_l","gen3_cryes_B_rgroll2","gen3_cryes_B_vege","gen2p_crye_B","gen2p_crye_i","gen2p_cryes_n","gen2p_crye_A","uniform_crye_vans_A","gen3p_crye_pcuCBT","gen3p_crye_pcuHCS","gen3p_crye_pcu14_uni","gen3p_crye_pcuVegecam_uni","Ryker_G3CombatRolledKnee_PCU_Cargo_Brown_uni","Ryker_G3CombatRolledKnee_PCU_Cargo_CBT_uni","Ryker_G3CombatRolledKnee_PCU_Cargo_ICECAM_uni","Ryker_G3CombatRolledKnee_PCU_Cargo_terracam_uni","Ryker_G3CombatRolledKnee_PCU_Cargo_Vegecam_uni","Ryker_G3CombatRolledKnee_SOFTSHELL_Cargo_altimetrico","Ryker_G3CombatRolledKnee_SOFTSHELL_Cargo_cb62","Ryker_G3CombatRolledKnee_SOFTSHELL_Cargo_cbt","Ryker_G3CombatRolledKnee_SOFTSHELL_Cargo_Icecam","Ryker_G3CombatRolledKnee_SOFTSHELL_Cargo_vegecam","ACU_Coverall_Watch_Ranger_2_w","ACU_Ranger_BDU_Belt_4_w","ASZ_NC4_09_base","ASZ_NC4_09_GL","ASZ_NC4_09_MG","ASZ_NC4_09_MarkS","ASZ_NC4_09_Medic","ASZ_NC4_09","ASZ_NC4_09_TL","ASZ_NC4_09_naja","Viking_viking_avs_562","Viking_viking_avs_561","Viking_viking_avs_579","Viking_viking_avs_580","Viking_viking_avs_576","Viking_viking_avs_573","Viking_viking_avs_571","Viking_viking_avs_572","Viking_viking_avs_575","Viking_viking_avs_583","AVS_8","AVS_24","AVS_16","ex_milgp_v_jpc_assaulter_belt_mc","ex_milgp_v_jpc_Grenadier_belt_mc","ex_milgp_v_jpc_hgunner_belt_mc","ex_milgp_v_jpc_marksman_belt_mc","ex_milgp_v_jpc_medic_belt_mc","ex_milgp_v_jpc_teamleader_belt_mc","ex_milgp_v_mmac_assaulter_CBT","ex_milgp_v_mmac_assaulter_MC","ex_milgp_v_mmac_grenadier_belt_CBT","ex_milgp_v_mmac_grenadier_belt_MC","ex_milgp_v_mmac_hgunner_CBT","ex_milgp_v_mmac_hgunner_MC","milgp_v_mmac_marksman_belt_CBT","milgp_v_mmac_marksman_belt_MC","milgp_v_mmac_medic_CBT","milgp_v_mmac_medic_MC","ex_milgp_v_mmac_teamleader_CBT","ex_milgp_v_mmac_teamleader_MC","audx_hpc","audx_hpc_radio","vss_03_MC","mbav_mc_A","ASZ_Basco_CM","ASZ_Basco_EI","ASZ_BoonieHat_CB60","ASZ_BoonieHat_CB62","ASZ_BoonieHat_CBT","ASZ_BoonieHat_vegecam","ASZ_Mich_CB60","ASZ_Mich_CB60_alp","ASZ_Mich_CB60_bers","ASZ_Mich_CBT","ASZ_Mich_CBT_alp","ASZ_Mich_CBT_bers","ASZ_Mich_ARC_CB60","ASZ_Mich_ARC_CB60_alp","ASZ_Mich_ARC_CB60_bers","ASZ_Mich_ARC_CBT","ASZ_Mich_ARC_CBT_alp","ASZ_Mich_ARC_CBT_bers","ASZ_Mich_ESS_CB60","ASZ_Mich_ESS_CB60_alp","ASZ_Mich_ESS_CB60_bers","ASZ_Mich_ESS_CBT","ASZ_Mich_ESS_CBT_alp","ASZ_Mich_ESS_CBT_bers","ASZ_Mich_Net_CB60","ASZ_Mich_Net_CB60_alp","ASZ_Mich_Net_CB60_bers","ASZ_Mich_Net_CBT","ASZ_Mich_Net_CBT_alp","ASZ_Mich_Net_CBT_bers","ASZ_mach_2_CB60","ASZ_mach_2_CBT","ASZ_mach_2_vegecam","ASZ_mach_2_netting_CB60","ASZ_mach_2_netting_CBT","ASZ_mach_2_netting_vegecam","audx_c_booniehat_cb60","audx_c_booniehat_cb62","audx_c_booniehat_cbt","audx_c_booniehat_vegecam","audx_c_booniehat_wood","Mach2_cb62","Mach2_CBT","Mach2_vegecam","MICH2001_Spec_set_P_v10_e1","Mach3_vege","audx_h_helmet_gis","viking_helm6","viking_helmICE","viking_helm18","viking_helm13","viking_helm21","Maritime_Cover_ComtacIII_Arc1534","Maritime_Cover_ComtacIII30","Maritime_Cover_vegetata","Maritime_ComtacIII_Arc36","XP_ComtacIII_Arc25","XP_ComtacIII_Arc136","XP_ComtacIII_Vegecam","j03_exfil_coy","NVGoggles_OPFOR","NVGoggles","NVGoggles_INDEP","UK3CB_ANPVS7","audx_n_mum","Louetta_PVS31A_4","Louetta_PVS31A_6","rhsusf_ANPVS_14","rhsusf_ANPVS_15","rhsusf_Rhino","CUP_NVG_1PN138","CUP_NVG_PVS15_black","CUP_NVG_PVS15_green","CUP_NVG_PVS15_tan","CUP_NVG_PVS15_winter","CUP_NVG_PVS7","CUP_NVG_PVS14","CUP_NVG_GPNVG_black","CUP_NVG_GPNVG_green","CUP_NVG_GPNVG_Hide","CUP_NVG_GPNVG_tan","CUP_NVG_GPNVG_winter","CUP_NVG_HMNVS","ACE_NVG_Gen1","ACE_NVG_Gen1_Brown","ACE_NVG_Gen1_Green","ACE_NVG_Gen2_Black","ACE_NVG_Gen2_Brown","ACE_NVG_Gen2","ACE_NVG_Gen4_Black","ACE_NVG_Gen4","ACE_NVG_Gen4_Green","ACE_NVG_Wide_Black","ACE_NVG_Wide","ACE_NVG_Wide_Green","immersion_cigs_cigar0_nv","murshun_cigs_cig0_nv", "Pike_MiniMissileUGL", "Pike_MiniMissileATUGL"];
_pistols = ["hgun_ACPC2_F","hgun_Pistol_heavy_01_F","UK3CB_BHP","hgun_Pistol_heavy_01_green_F","rhsusf_weap_glock17g4","rhsusf_weap_m1911a1","rhsusf_weap_m9","rhs_weap_cz99","rhs_weap_cz99_etched","CUP_hgun_Browning_HP","CUP_hgun_CZ75","CUP_hgun_Phantom","CUP_hgun_Duty","CUP_hgun_Compact","CUP_hgun_Glock17","CUP_hgun_Glock17_blk","CUP_hgun_Glock17_tan","CUP_hgun_M17_Black","CUP_hgun_M17_Coyote","CUP_hgun_M17_Green","CUP_hgun_Colt1911","CUP_hgun_M9","CUP_hgun_M9A1","ACE_VMH3","ACE_VMM3"];
_primaryWeapons = ['ACWP_M4A5_145_ris_base','ACWP_M4A5_145_ris_AFG','ACWP_M4A5_145_ris_Tango','ACWP_M4A5_145_ris_ROE','rhs_weap_m4','rhs_weap_m4_mstock','rhs_weap_m4_carryhandle','rhs_weap_m4_carryhandle_mstock','rhs_weap_m4_m320','rhs_weap_m4_m203','rhs_weap_m4_m203S','rhs_weap_m4_carryhandle_m203','rhs_weap_m4_carryhandle_m203S','rhs_weap_m4a1','rhs_weap_m4a1_d','rhs_weap_m4a1_wd','rhs_weap_m4a1_mstock','rhs_weap_m4a1_d_mstock','rhs_weap_m4a1_wd_mstock','rhs_weap_m4a1_carryhandle','rhs_weap_m4a1_carryhandle_mstock','rhs_weap_m4a1_m203','rhs_weap_m4a1_m203s','rhs_weap_m4a1_m203s_wd','rhs_weap_m4a1_m203s_d','rhs_weap_m4a1_carryhandle_m203','rhs_weap_m4a1_carryhandle_m203S','rhs_weap_m4a1_m320','rhs_weap_m4a1_blockII','rhs_weap_m4a1_blockII_bk','rhs_weap_m4a1_blockII_wd','rhs_weap_m4a1_blockII_d','rhs_weap_m4a1_blockII_KAC','rhs_weap_m4a1_blockII_KAC_bk','rhs_weap_m4a1_blockII_KAC_wd','rhs_weap_m4a1_blockII_KAC_d','rhs_weap_m4a1_blockII_M203','rhs_weap_m4a1_blockII_M203_bk','rhs_weap_m4a1_blockII_M203_d','rhs_weap_m4a1_blockII_M203_wd','rhs_weap_mk18','rhs_weap_mk18_bk','rhs_weap_mk18_wd','rhs_weap_mk18_d','rhs_weap_mk18_KAC','rhs_weap_mk18_KAC_bk','rhs_weap_mk18_KAC_wd','rhs_weap_mk18_KAC_d','rhs_weap_mk18_m320','rhs_weap_m16a4','rhs_weap_m16a4_imod','rhs_weap_m16a4_carryhandle','rhs_weap_m16a4_carryhandle_M203','rhs_weap_m16a4_imod_M203','rhs_weap_hk416d10','rhs_weap_hk416d145','rhs_weap_hk416d10_LMT','rhs_weap_hk416d10_m320','rhs_weap_hk416d145_m320','rhs_weap_hk416d10_LMT_d','rhs_weap_hk416d10_LMT_wd','rhs_weap_hk416d145_d','rhs_weap_hk416d145_d_2','rhs_weap_hk416d145_wd','rhs_weap_hk416d145_wd_2','rhs_weap_m27iar','rhs_weap_m27iar_grip','rhs_weap_m32','UK3CB_M16A1','UK3CB_M16A1_LSW','UK3CB_M16_Carbine','UK3CB_M16A2','UK3CB_M16A3','UK3CB_M16A2_UGL','UK3CB_FAMAS_F1','UK3CB_FAMAS_F1_GLM203','UK3CB_HK33KA3','UK3CB_HK33KA2_RIS','UK3CB_HK33KA2_RIS_GL','UK3CB_G3KA4_GL','rhs_weap_m21a','rhs_weap_m21a_pr','rhs_weap_m21s','rhs_weap_m21s_pr','rhs_weap_vhsd2','rhs_weap_vhsd2_bg','rhs_weap_vhsd2_ct15x','rhs_weap_vhsd2_bg_ct15x','rhs_weap_vhsk2','rhs_weap_m21a_pr_pbg40','rhs_weap_m21a_pbg40','rhs_weap_g36c','rhs_weap_g36kv','rhs_weap_g36kv_ag36','UK3CB_HK33KA2','UK3CB_HK33KA1','CUP_arifle_ACR_blk_556','CUP_arifle_ACR_tan_556','CUP_arifle_ACR_wdl_556','CUP_arifle_ACR_snw_556','CUP_arifle_ACRC_blk_556','CUP_arifle_ACRC_tan_556','CUP_arifle_ACRC_wdl_556','CUP_arifle_ACRC_snw_556','CUP_arifle_ACR_EGLM_blk_556','CUP_arifle_ACR_EGLM_tan_556','CUP_arifle_ACR_EGLM_wdl_556','CUP_arifle_ACR_EGLM_snw_556','CUP_arifle_ACRC_EGLM_blk_556','CUP_arifle_ACRC_EGLM_tan_556','CUP_arifle_ACRC_EGLM_wdl_556','CUP_arifle_ACRC_EGLM_snw_556','CUP_arifle_ACR_EGLM_blk_68','CUP_arifle_ACR_EGLM_tan_68','CUP_arifle_ACR_EGLM_wdl_68','CUP_arifle_ACR_EGLM_snw_68','CUP_arifle_ACRC_EGLM_blk_68','CUP_arifle_ACRC_EGLM_tan_68','CUP_arifle_ACRC_EGLM_wdl_68','CUP_arifle_ACRC_EGLM_snw_68','CUP_CZ_BREN2_556_14','CUP_CZ_BREN2_556_14_GL','CUP_CZ_BREN2_556_11','CUP_CZ_BREN2_556_11_GL','CUP_CZ_BREN2_556_8','CUP_CZ_BREN2_762_14_GL','CUP_CZ_BREN2_556_14_Tan','CUP_CZ_BREN2_556_14_Grn','CUP_CZ_BREN2_556_14_GL_Tan','CUP_CZ_BREN2_556_14_GL_Grn','CUP_CZ_BREN2_556_11_Tan','CUP_CZ_BREN2_556_11_Grn','CUP_CZ_BREN2_556_11_GL_Tan','CUP_CZ_BREN2_556_11_GL_Grn','CUP_CZ_BREN2_556_8_Tan','CUP_CZ_BREN2_556_8_Grn','CUP_CZ_BREN2_762_14_GL_Tan','CUP_CZ_BREN2_762_14_GL_Grn','CUP_Famas_F1','CUP_Famas_F1_Rail','CUP_Famas_F1_Wood','CUP_Famas_F1_Arid','CUP_Famas_F1_Rail_Wood','CUP_Famas_F1_Rail_Arid','CUP_arifle_Galil_556_black','CUP_arifle_Galil_SAR_black','CUP_arifle_AUG_A1','CUP_arifle_X95','CUP_arifle_X95_Grippod','CUP_arifle_CZ805_A2','CUP_arifle_CZ805_A1','CUP_arifle_CZ805_GL','CUP_arifle_CZ805_A2_blk','CUP_arifle_CZ805_A2_coyote','CUP_arifle_CZ805_A1_blk','CUP_arifle_CZ805_A1_coyote','CUP_arifle_CZ805_GL_blk','CUP_arifle_CZ805_GL_coyote','CUP_arifle_G36A','CUP_arifle_G36A_camo','CUP_arifle_G36A_wdl','CUP_arifle_G36A_RIS','CUP_arifle_G36A_RIS_camo','CUP_arifle_G36A_RIS_wdl','CUP_arifle_AG36','CUP_arifle_AG36_camo','CUP_arifle_AG36_wdl','CUP_arifle_G36A_AG36_RIS','CUP_arifle_G36A_AG36_RIS_camo','CUP_arifle_G36A_AG36_RIS_wdl','CUP_arifle_G36A3','CUP_arifle_G36A3_camo','CUP_arifle_G36A3_wdl','CUP_arifle_G36A3_hex','CUP_arifle_G36A3_grip','CUP_arifle_G36A3_grip_camo','CUP_arifle_G36A3_grip_wdl','CUP_arifle_G36A3_grip_hex','CUP_arifle_G36A3_AG36','CUP_arifle_G36A3_AG36_camo','CUP_arifle_G36A3_AG36_wdl','CUP_arifle_G36A3_AG36_hex','CUP_arifle_G36E','CUP_arifle_G36E_camo','CUP_arifle_G36E_wdl','CUP_arifle_G36K','CUP_arifle_G36K_camo','CUP_arifle_G36K_wdl','CUP_arifle_G36K_VFG','CUP_arifle_G36K_VFG_camo','CUP_arifle_G36K_VFG_wdl','CUP_arifle_G36K_RIS','CUP_arifle_G36K_RIS_camo','CUP_arifle_G36K_RIS_wdl','CUP_arifle_G36K_RIS_hex','CUP_arifle_G36K_AG36','CUP_arifle_G36K_AG36_camo','CUP_arifle_G36K_AG36_wdl','CUP_arifle_G36K_RIS_AG36','CUP_arifle_G36K_RIS_AG36_camo','CUP_arifle_G36K_RIS_AG36_wdl','CUP_arifle_G36K_RIS_AG36_hex','CUP_arifle_G36K_KSK','CUP_arifle_G36K_KSK_camo','CUP_arifle_G36K_KSK_hex','CUP_arifle_G36K_KSK_VFG','CUP_arifle_G36K_KSK_VFG_camo','CUP_arifle_G36K_KSK_VFG_hex','CUP_arifle_G36K_KSK_AFG','CUP_arifle_G36K_KSK_AFG_camo','CUP_arifle_G36K_KSK_AFG_hex','CUP_arifle_G36KA3','CUP_arifle_G36KA3_camo','CUP_arifle_G36KA3_wdl','CUP_arifle_G36KA3_hex','CUP_arifle_G36KA3_grip','CUP_arifle_G36KA3_grip_camo','CUP_arifle_G36KA3_grip_wdl','CUP_arifle_G36KA3_grip_hex','CUP_arifle_G36KA3_afg','CUP_arifle_G36KA3_afg_camo','CUP_arifle_G36KA3_afg_wdl','CUP_arifle_G36KA3_afg_hex','CUP_arifle_G36C','CUP_arifle_G36C_camo','CUP_arifle_G36C_wdl','CUP_arifle_G36C_hex','CUP_arifle_G36C_VFG','CUP_arifle_G36C_VFG_camo','CUP_arifle_G36C_VFG_wdl','CUP_arifle_G36C_VFG_hex','CUP_arifle_G36C_VFG_Carry','CUP_arifle_G36CA3','CUP_arifle_G36CA3_camo','CUP_arifle_G36CA3_wdl','CUP_arifle_G36CA3_hex','CUP_arifle_G36CA3_grip','CUP_arifle_G36CA3_grip_camo','CUP_arifle_G36CA3_grip_wdl','CUP_arifle_G36CA3_grip_hex','CUP_arifle_G36CA3_afg','CUP_arifle_G36CA3_afg_camo','CUP_arifle_G36CA3_afg_wdl','CUP_arifle_G36CA3_afg_hex','CUP_arifle_MG36','CUP_arifle_MG36_camo','CUP_arifle_MG36_wdl','CUP_arifle_MG36_hex','CUP_arifle_HK416_CQB_Black','CUP_arifle_HK416_CQB_Desert','CUP_arifle_HK416_CQB_Wood','CUP_arifle_HK416_Black','CUP_arifle_HK416_Desert','CUP_arifle_HK416_Wood','CUP_arifle_HK416_M203_Black','CUP_arifle_HK416_M203_Desert','CUP_arifle_HK416_M203_Wood','CUP_arifle_HK416_CQB_M203_Black','CUP_arifle_HK416_CQB_M203_Desert','CUP_arifle_HK416_CQB_M203_Wood','CUP_arifle_HK416_AGL_Black','CUP_arifle_HK416_AGL_Desert','CUP_arifle_HK416_AGL_Wood','CUP_arifle_HK416_CQB_AG36','CUP_arifle_HK416_CQB_AG36_Desert','CUP_arifle_HK416_CQB_AG36_Wood','CUP_arifle_HK417_12_M203','CUP_arifle_HK417_12_M203_Wood','CUP_arifle_HK417_12_M203_Desert','CUP_arifle_HK417_12_AG36','CUP_arifle_HK417_12_AG36_Wood','CUP_arifle_HK417_12_AG36_Desert','CUP_arifle_M16A2','CUP_arifle_M16A2_GL','CUP_arifle_M16A4_Base','CUP_arifle_M16A4_Grip','CUP_arifle_M16A4_GL','CUP_arifle_XM16E1','CUP_arifle_M16A1','CUP_arifle_M16A1E1','CUP_arifle_M16A1GL','CUP_arifle_M16A1GL_USA','CUP_arifle_M16A1GL_FS','CUP_arifle_M16A1E1GL','CUP_arifle_Colt727','CUP_arifle_Colt727_M203','CUP_arifle_M4A1','CUP_arifle_M4A1_desert_carryhandle','CUP_arifle_M4A1_camo_carryhandle','CUP_arifle_M4A1_GL_carryhandle','CUP_arifle_M4A1_GL_carryhandle_camo','CUP_arifle_M4A1_GL_carryhandle_desert','CUP_arifle_M4A1_black','CUP_arifle_M4A1_camo','CUP_arifle_M4A1_desert','CUP_arifle_M4A1_BUIS_GL','CUP_arifle_M4A1_BUIS_camo_GL','CUP_arifle_M4A1_BUIS_desert_GL','CUP_arifle_M4A3_black','CUP_arifle_M4A3_desert','CUP_arifle_M4A3_camo','CUP_arifle_mk18_black','CUP_arifle_mk18_m203_black','CUP_arifle_SBR_black','CUP_arifle_SBR_od','CUP_arifle_M4A1_MOE_black','CUP_arifle_M4A1_MOE_wdl','CUP_arifle_M4A1_MOE_desert','CUP_arifle_M4A1_MOE_winter','CUP_arifle_M4A1_MOE_short_black','CUP_arifle_M4A1_MOE_short_wdl','CUP_arifle_M4A1_MOE_short_desert','CUP_arifle_M4A1_MOE_short_winter','CUP_arifle_M4A1_standard_black','CUP_arifle_M4A1_standard_wdl','CUP_arifle_M4A1_standard_dsrt','CUP_arifle_M4A1_standard_winter','CUP_arifle_M4A1_standard_short_black','CUP_arifle_M4A1_standard_short_wdl','CUP_arifle_M4A1_standard_short_dsrt','CUP_arifle_M4A1_standard_short_winter','CUP_arifle_M4A1_SOMMOD_black','CUP_arifle_M4A1_SOMMOD_tan','CUP_arifle_M4A1_SOMMOD_green','CUP_arifle_M4A1_SOMMOD_snow','CUP_arifle_M4A1_SOMMOD_hex','CUP_arifle_M4A1_SOMMOD_ctrg','CUP_arifle_M4A1_SOMMOD_ctrgt','CUP_arifle_M4A1_SOMMOD_Grip_black','CUP_arifle_M4A1_SOMMOD_Grip_tan','CUP_arifle_M4A1_SOMMOD_Grip_green','CUP_arifle_M4A1_SOMMOD_Grip_snow','CUP_arifle_M4A1_SOMMOD_Grip_hex','CUP_arifle_M4A1_SOMMOD_Grip_ctrg','CUP_arifle_M4A1_SOMMOD_Grip_ctrgt','CUP_arifle_Mk16_STD','CUP_arifle_Mk16_STD_FG','CUP_arifle_Mk16_STD_AFG','CUP_arifle_Mk16_STD_SFG','CUP_arifle_Mk16_STD_EGLM','CUP_arifle_Mk16_CQC','CUP_arifle_Mk16_CQC_FG','CUP_arifle_Mk16_CQC_AFG','CUP_arifle_Mk16_CQC_SFG','CUP_arifle_Mk16_CQC_EGLM','CUP_arifle_Mk16_CQC_black','CUP_arifle_Mk16_CQC_FG_black','CUP_arifle_Mk16_CQC_AFG_black','CUP_arifle_Mk16_CQC_SFG_black','CUP_arifle_Mk16_CQC_EGLM_black','CUP_arifle_Mk16_STD_black','CUP_arifle_Mk16_STD_FG_black','CUP_arifle_Mk16_STD_AFG_black','CUP_arifle_Mk16_STD_SFG_black','CUP_arifle_Mk16_STD_EGLM_black','CUP_arifle_Mk16_CQC_woodland','CUP_arifle_Mk16_CQC_FG_woodland','CUP_arifle_Mk16_CQC_AFG_woodland','CUP_arifle_Mk16_CQC_SFG_woodland','CUP_arifle_Mk16_CQC_EGLM_woodland','CUP_arifle_Mk16_STD_woodland','CUP_arifle_Mk16_STD_FG_woodland','CUP_arifle_Mk16_STD_AFG_woodland','CUP_arifle_Mk16_STD_SFG_woodland','CUP_arifle_Mk16_STD_EGLM_woodland','CUP_arifle_Mk17_CQC_EGLM','CUP_arifle_Mk17_STD_EGLM','CUP_arifle_Mk17_CQC_EGLM_black','CUP_arifle_Mk17_STD_EGLM_black','CUP_arifle_Mk17_CQC_EGLM_woodland','CUP_arifle_Mk17_STD_EGLM_woodland','CUP_arifle_XM8_Carbine','CUP_arifle_XM8_Carbine_FG','CUP_arifle_XM8_Carbine_GL','CUP_arifle_XM8_Compact','CUP_arifle_XM8_Compact_Rail','CUP_arifle_XM8_Railed'];
_launcher = ["launch_NLAW_F","twc_2inch_bag","rhs_weap_rpg75","rhs_weap_fgm148","rhs_weap_fim92","rhs_weap_M136","rhs_weap_M136_hedp","rhs_weap_M136_hp","rhs_weap_m72a7","rhs_weap_smaw","rhs_weap_smaw_green","rhs_weap_m80","CUP_launch_BF3","CUP_launch_M136","CUP_launch_M47","CUP_launch_HCPF3","CUP_launch_PzF3","launch_MRAWS_green_rail_F","launch_MRAWS_olive_rail_F","launch_MRAWS_sand_rail_F","launch_MRAWS_green_F","launch_MRAWS_olive_F","launch_MRAWS_sand_F"];
_marksman = ["rhs_weap_sr25","rhs_weap_sr25_d","rhs_weap_sr25_ec","rhs_weap_sr25_ec_d","rhs_weap_sr25_ec_wd","rhs_weap_sr25_wd","rhs_weap_M107","rhs_weap_M107_d","rhs_weap_M107_w","CUP_hgun_BallisticShield_Armed_M9","CUP_srifle_L129A1","CUP_srifle_L129A1_ctrg","CUP_srifle_L129A1_ctrgt","CUP_srifle_L129A1_d","CUP_srifle_L129A1_HG_ctrg","CUP_srifle_L129A1_HG_ctrgt","CUP_srifle_L129A1_HG_d","CUP_srifle_L129A1_HG_w","CUP_srifle_L129A1_w","CUP_srifle_L129A1_HG","CUP_srifle_M107_Base","CUP_srifle_M107_Pristine","CUP_srifle_M107_Desert","CUP_srifle_M107_Snow","CUP_srifle_M107_Woodland","CUP_srifle_m110_kac_black","CUP_srifle_M110_black","CUP_srifle_M110","CUP_srifle_M110_woodland","CUP_srifle_m110_kac","CUP_srifle_m110_kac_woodland","CUP_srifle_Mk12SPR","CUP_arifle_Mk20","CUP_arifle_Mk20_black","CUP_arifle_Mk20_woodland","CUP_arifle_HK417_20","CUP_arifle_HK417_20_Desert","CUP_arifle_HK417_20_Wood","CUP_srifle_Mk18_wdl","CUP_srifle_Mk18_des","CUP_srifle_Mk18_blk"];
_machineguns = ["rhs_weap_m240B","rhs_weap_m240G","CUP_lmg_M240_norail","CUP_lmg_M240_B","CUP_lmg_M240","CUP_lmg_FNMAG","CUP_lmg_FNMAG_RIS","CUP_lmg_FNMAG_RIS_modern","CUP_lmg_MG3","CUP_lmg_MG3_rail","CUP_lmg_Mk48","CUP_lmg_Mk48_des","CUP_lmg_Mk48_od","CUP_lmg_Mk48_tan","CUP_lmg_Mk48_nohg","CUP_lmg_Mk48_nohg_des","CUP_lmg_Mk48_nohg_od","CUP_lmg_Mk48_nohg_tan","CUP_lmg_Mk48_nohg_wdl","CUP_lmg_Mk48_wdl"];
_minimin = ["rhs_weap_m249","CUP_lmg_m249_SQuantoon","rhs_weap_m249_pip","rhs_weap_m249_light_L","rhs_weap_m249_pip_L_para","rhs_weap_m249_pip_L","rhs_weap_m249_pip_ris","CUP_lmg_m249_pip1","CUP_lmg_m249_pip3","rhs_weap_m249_light_S","rhs_weap_m249_pip_S_para","rhs_weap_m249_pip_S","CUP_lmg_m249_pip4","CUP_lmg_M249_E1","CUP_lmg_M249_E2","CUP_lmg_m249_pip2","CUP_lmg_m249_para","CUP_lmg_m249_para_gl"];
dontremove = _primaryWeapons+_pistols+_launcher+_marksman+_machineguns+_minimin+_dontremove;

{
	_types = _x;
	{
		if !( _x in dontRemove ) then {
			
			_info = _x call BIS_fnc_itemType;
			_info params[ "_type", "_subType" ];
			//weapons
			switch ( _type ) do {
				case "Weapon":{
					_types set [ _forEachIndex, objNull ];
				};
			};
			//equipment
			switch ( _subType ) do {
				case "Vest";
				case "Headgear";
				case "Uniform": {
					_types set [ _forEachIndex, objNull ];
				};
			};
			//item
			switch ( _subType ) do {
				case "NVGoggles";
				case "Radio": {
					_types set [ _forEachIndex, objNull ];
				};
			};
		};
		
	}forEach +_types;
	_types = _types - [ objNull ];
	BIS_fnc_arsenal_data set [ _forEachIndex, _types ];
}forEach +BIS_fnc_arsenal_data;
// Supply Script
fnc_get3DENLoadout = { 
    _virtualCargo = [ 
        [ suppCrate call BIS_fnc_getVirtualWeaponCargo, [] ], 
        [ suppCrate call BIS_fnc_getVirtualMagazineCargo, [] ], 
        [ suppCrate call BIS_fnc_getVirtualItemCargo, [] ], 
        [ suppCrate call BIS_fnc_getVirtualBackpackCargo, [] ] 
    ]; 
 
    if ( _virtualCargo findIf{ count ( _x select 0 ) > 0 } > -1 ) then { 
		missionNamespace setVariable [ "loadout", [ _virtualCargo, true ], true ]; 
    }else{ 
        missionNamespace setVariable[ "loadout", 
            [ 
                [ 
                    getWeaponCargo suppCrate, 
                    getMagazineCargo suppCrate, 
                    getItemCargo suppCrate, 
                    getBackpackCargo suppCrate 
                ], 
                false 
            ],
			true
        ]; 
    }; 
}; 
suppCrate call fnc_get3DENLoadout;
suppCrate addAction ["Save ReSupply", {suppCrate call fnc_get3DENLoadout;},nil,1,true,true,"","true",4];

// CHAT INTERCEPT

[] call compile preProcessFilelineNumbers "module_chatIntercept\config.sqf";
[] call compile preProcessFilelineNumbers "module_chatIntercept\commands.sqf";

pvpfw_chatIntercept_executeCommand = compile preProcessFilelineNumbers "module_chatIntercept\executeCommand.sqf";

// Reset and old EH IDs and scripthandles
if (!isNil "pvpfw_chatIntercept_handle")then{
	terminate pvpfw_chatIntercept_handle
};
if (!isNil "pvpfw_chatIntercept_EHID")then{
	(findDisplay 24) displayRemoveEventHandler ["KeyDown",pvpfw_chatIntercept_EHID];
	pvpfw_chatIntercept_EHID = nil;
};

pvpfw_chatIntercept_handle = [] spawn {
	private["_equal","_chatArr"];
	
	while{true}do{
		pvpfw_chatString = "";
		
		waitUntil{sleep 0.22;!isNull (finddisplay 24 displayctrl 101)};
		
		pvpfw_chatIntercept_EHID = (findDisplay 24) displayAddEventHandler["KeyDown",{
			if ((_this select 1) != 28) exitWith{false};
			
			_equal = false;
			
			_chatArr = toArray pvpfw_chatString;
			//_chatArr resize 1;
			if ((_chatArr select 0) isEqualTo ((toArray pvpfw_chatIntercept_commandMarker) select 0))then{
				if (pvpfw_chatIntercept_debug)then{
					systemChat format["Intercepted: %1",pvpfw_chatString];
				};
				_equal = true;
				closeDialog 0;
				(findDisplay 24) closeDisplay 1;
				
				[_chatArr] call pvpfw_chatIntercept_executeCommand;
			};
			
			_equal
		}];
		
		waitUntil{
			if (isNull (finddisplay 24 displayctrl 101))exitWith{
				if (!isNil "pvpfw_chatIntercept_EHID")then{
					(findDisplay 24) displayRemoveEventHandler ["KeyDown",pvpfw_chatIntercept_EHID];
				};
				pvpfw_chatIntercept_EHID = nil;
				true
			};
			pvpfw_chatString = (ctrlText (finddisplay 24 displayctrl 101));
			false
		};
	};
};

// AUTHED Users
missionNamespace setVariable["authplayers", [],true];
// User authed?
missionNamespace setVariable["loggedin", false];
// spectator enabled?
missionNamespace setVariable["spectatorcheck", false,true];