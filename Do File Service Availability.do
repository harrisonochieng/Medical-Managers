use "C:\Users\ADMIN\Documents\hfa_endline.dta"

******* Service Readiness and Availability***************

*List 
*1.	Availability of basic amenities
*2.	Availability of basic services
*3.	Availability of basic equipment
*4.	Availability of basic diagnostics  
*5.	Availability of essential medicines 
*6.	Availability of KEPI vaccines in stock 
*7.	Availability of family planning commodities 
*8.	Availability of malaria drugs
*9.	Availability of Anti TBs
*10. Availability of antiretroviral drugs
*11. Health workforce




*******Availability of basic equipment 
foreach x in a_wscale c_wscale i_wscale mtape thermometer stethoscope bp_apparatus light_src intravenous_kits oxy_cylinders oxy_central oxy_flow_meter oxy_del_apparatus oxy_unavail_3m cold_storage blood_trans_serv {
	gen `x'_num = .
	replace `x'_num = 0 if `x' == "Not available today"
	replace `x'_num = 1 if `x' == "Available today"
	}
egen basic_equipment = rowmean (a_wscale_num c_wscale_num i_wscale_num mtape_num thermometer_num stethoscope_num bp_apparatus_num light_src_num intravenous_kits_num oxy_cylinders_num oxy_central_num oxy_flow_meter_num oxy_del_apparatus_num oxy_unavail_3m_num cold_storage_num blood_trans_serv_num)
gen basic_equipment_avg = basic_equipment *100
summarize basic_equipment_avg, detail

**********Availability of diagnostic services***********
foreach x in malaria_kit malaria_bs syphilis_rapid hiv_rapid urine_preg_kit dipstick_urine_pr dipstick_urine_gl dipstick_urine_ket filt_pp_dbs bgt_glucometer hb gen_microscp culture tb blood_creat liver_func renal_func blood_typing blood_grouping {
    gen `x'_num = .
    replace `x'_num = 0 if `x' == "No"
    replace `x'_num = 1 if `x' == "Yes"
	}
egen basic_diagnostics = rowmean (malaria_kit_num malaria_bs_num syphilis_rapid_num hiv_rapid_num urine_preg_kit_num dipstick_urine_pr_num dipstick_urine_gl_num dipstick_urine_ket_num filt_pp_dbs_num bgt_glucometer_num hb_num gen_microscp_num culture_num tb_num blood_creat_num liver_func_num renal_func_num blood_typing_num blood_grouping_num)
gen basic_diagnostics_avg = basic_diagnostics * 100 
summarize basic_diagnostics_avg, detail

**********Availability of essential medicines*****************
foreach x in amlodipine amox_syr_disp amox_tab ampicillin_powd asp_tab bec_inhaler beta_blocker carbamazepine ceftriaxone diazepam enalapril fluoxetine genta_inject glibenclamide_tab haloperidol_tab insulin_inject mag_sul_inj metformin_tab omeprazole_alt ors oxytocin_inj salbut_inhaler simvastatin_tab thiazide zinc_sul_tab {
    gen `x'_num = .
    replace `x'_num = 0 if `x' == "Not available today"
	replace `x'_num = 0 if `x' == "Available but expired"
    replace `x'_num = 1 if `x' == "At least one dose not expired"
	}
egen essential_medicines = rowmean (amlodipine_num amox_syr_disp_num amox_tab_num ampicillin_powd_num asp_tab_num bec_inhaler_num beta_blocker_num carbamazepine_num ceftriaxone_num diazepam_num enalapril_num fluoxetine_num genta_inject_num glibenclamide_tab_num haloperidol_tab_num insulin_inject_num mag_sul_inj_num metformin_tab_num omeprazole_alt_num ors_num oxytocin_inj_num salbut_inhaler_num simvastatin_tab_num thiazide_num zinc_sul_tab_num)
gen essential_medicines_avg = essential_medicines * 100
summarize essential_medicines_avg, detail

*************Availability of KEPI Vaccines in stock*****************
foreach x in measles_vacc_dil measles_rub measles_mumps_rub penta polio bcg rota pcv_10 ipv hpv tt_td rabies flu typhoid yellow_fev meningo anti_venom anti_rabies chick_pox {
	gen `x'_num = .
	replace `x'_num = 0 if `x' == "Not available today"
	replace `x'_num = 0 if `x' == "Available but expired"
	replace `x'_num = 1 if `x' == "At least one not expired"	
	}
egen kepi_vaccines = rowmean (measles_vacc_dil_num measles_rub_num measles_mumps_rub_num penta_num polio_num bcg_num rota_num pcv_10_num ipv_num hpv_num tt_td_num rabies_num flu_num typhoid_num yellow_fev_num meningo_num anti_venom_num anti_rabies_num chick_pox_num)
gen kepi_vaccines_avg = kepi_vaccines * 100
summarize kepi_vaccines_avg, detail 

***************Availability of family planning commodities*************************
foreach x in coc progestin_pill comb_estrogen progestin_contra male_condom female_condom implant emmerg_contraceptive intrauterine_dev cycle_beads {
	gen `x'_num = .
	replace `x'_num = 0 if `x' == "Not available today"
	replace `x'_num = 0 if `x' == "Available but expired"
	replace `x'_num = 1 if `x' == "At least one non-expired commodity"
	}
egen family_planning = rowmean (measles_vacc_dil_num measles_rub_num measles_mumps_rub_num penta_num polio_num bcg_num rota_num pcv_10_num ipv_num hpv_num tt_td_num rabies_num flu_num typhoid_num yellow_fev_num meningo_num anti_venom_num anti_rabies_num chick_pox_num)
gen family_planning_avg = family_planning * 100
summarize family_planning_avg, detail
	
*****************Availability of malaria drugs**********************

foreach x in al_tab_6 al_tab_12 al_tab_18 al_tab_24 coartem_6 coartem_12 artesunate_inj sp_tab {
	gen `x'_num = .
	replace `x'_num = 0 if `x' == "Not available today"
	replace `x'_num = 0 if `x' == "Available but expired"
	replace `x'_num = 1 if `x' == "At least one dose not expired"
	}
egen malaria_drugs = rowmean (al_tab_6_num al_tab_12_num al_tab_18_num al_tab_24_num coartem_6_num coartem_12_num artesunate_inj_num sp_tab_num)
gen malaria_drugs_avg = malaria_drugs * 100
summarize malaria_drugs_avg, detail

***************Availability of Anti TBs*******************************
foreach x in ethambutol isoniazid pyrazinamide rifampicin iso_rif iso_etham rzh rhe fdc_4 inh paed_rif paed_etham streptomycin mdr {
	gen `x'_num = .
	replace `x'_num = 0 if `x' == "Not available today"
	replace `x'_num = 0 if `x' == "Available but expired"
	replace `x'_num = 1 if `x' == "At least one dose not expired"
	}
egen anti_tb = rowmean (ethambutol_num isoniazid_num pyrazinamide_num rifampicin_num iso_rif_num iso_etham_num rzh_num rhe_num fdc_4_num inh_num paed_rif_num paed_etham_num streptomycin_num mdr_num)
gen anti_tb_avg = anti_tb * 100
summarize anti_tb_avg, detail 

*********************Availability of Antiretroviral drugs********************

foreach x in zidovudine_tab zidovudine_syr abacavir lamivudine_3tc_2 tenofovir_df nevirapine_tab nevirapine_syr efav_600mg efav_400mg emtricitabine lam_3tc_abc zidovu_azt azt_3tc_nvp tdc_ftc tdf_3tc tdf_3tc_efv tdf_ftc_efv lam_3tc_syr efv0_syrup paed_lam_3tc_syr paed_dolute dtg_3tc_tdf {
	gen `x'_num = .
	replace `x'_num = 0 if `x' == "Not available today"
	replace `x'_num = 0 if `x' == "Available but expired"
	replace `x'_num = 1 if `x' == "At least one dose not expired"
	}
egen arv = rowmean (zidovudine_tab_num zidovudine_syr_num abacavir_num lamivudine_3tc_2_num tenofovir_df_num nevirapine_tab_num nevirapine_syr_num efav_600mg_num efav_400mg_num emtricitabine_num lam_3tc_abc_num zidovu_azt_num azt_3tc_nvp_num tdc_ftc_num tdf_3tc_num tdf_3tc_efv_num tdf_ftc_efv_num lam_3tc_syr_num efv0_syrup_num paed_lam_3tc_syr_num paed_dolute_num dtg_3tc_tdf_num)
gen arv_avg = arv * 100 
summarize arv_avg, detail
	
	

********************************************Availability of basic amenities *************************************
* --- Electricity & Water ---
gen elec_main_src_num    = (elec_main_src != "No power supply" & elec_main_src != "") if elec_main_src != ""
gen elec_intr_num        = (elec_intr == "Yes") if elec_intr != ""
gen elec_backup_avail_num = (elec_backup_avail == "Yes") if elec_backup_avail != ""

gen water_main_src_num   = (water_main_src != "No water" & water_main_src != "") if water_main_src != ""
gen water_shortage_num   = (water_shortage == "Yes") if water_shortage != ""
gen water_rel_bup_num    = (water_rel_bup == "Yes") if water_rel_bup != ""

* --- Communication Devices (Standard 3-option responses) ---
foreach v in landline_tel cellphone_fc cellphone_staff public_tel radio internet staff_toilet patient_toilet {
    gen `v'_num = (`v' == "Available today and functional") if `v' != ""
}

* --- Computers & IT ---
gen func_comp_num     = inlist(func_comp, "Yes, computer & tablet (Both)", "Yes, computer only", "Yes, tablet only") if func_comp != ""
gen comp_internet_num = (comp_internet == "Yes") if comp_internet != ""
gen it_support_num    = inlist(it_support, "Yes, from HF", "Yes, from county") if it_support != ""

* --- Departments & Toilets ---
gen opd_num               = (opd == "Yes") if opd != ""
gen opd_consult_room_num  = (opd_consult_room == "Yes") if opd_consult_room != ""
gen ip_dept_num           = (ip_dept == "Yes") if ip_dept != ""
gen toilet_sep_num        = (toilet_sep != "Not available today") if toilet_sep != ""
gen hwash_toilet_num      = inlist(hwash_toilet, "Available today and functional next to some toilets", "Available today and functional next to all toilets") if hwash_toilet != ""

* --- Referrals & Transport ---
gen refer_where_num     = (refer_where != "No" & refer_where != "") if refer_where != ""
gen amb_emmergency_num  = inlist(amb_emmergency, "Yes, ambulance", "Yes, other type of vehicle") if amb_emmergency != ""

* Follow-up conditional: Ambulance fuel status
gen fuel_num            = (fuel == "Yes") if fuel != "" & fuel != "Don't know"
replace fuel_num        = 0 if fuel == "Don't know"

***Average availability of basic amenities

* Calculate average 
egen basic_amenities = rowmean(elec_main_src_num elec_intr_num elec_backup_avail_num water_main_src_num water_shortage_num water_rel_bup_num landline_tel_num cellphone_fc_num cellphone_staff_num public_tel_num radio_num internet_num func_comp_num comp_internet_num it_support_num opd_num opd_consult_room_num ip_dept_num toilet_sep_num staff_toilet_num patient_toilet_num hwash_toilet_num refer_where_num amb_emmergency_num fuel_num)
gen basic_amenities_avg = basic_amenities * 100
summarize basic_amenities_avg	
	
****************OVERALL SERVICE AVAILABILITY AND READINESS SCORE*************************
service_readiness_score = rowmean (basic_equipment_avg basic_diagnostics_avg essential_medicines_avg kepi_vaccines_avg family_planning_avg malaria_drugs_avg anti_tb_avg arv_avg basic_amenities_avg)
summarize service_readiness_score, detail
	
	
	
	
	
	
	
	