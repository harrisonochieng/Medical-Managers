********START OF DO FILE ********

**Insert the path to the stored data file
use "C:\Users\ADMIN\Documents\hfa_endline.dta"

*Drop non-Public facilities 
drop if hcf_ownership=="Private Sector"
drop if hcf_ownership=="Non-Governmental Organization"
drop if hcf_ownership=="Faith Based Organization"


*ACTIVE MONITORING AND REVIEW

*Perceived ability of staff to carry out assingments

tabulate assignments
gen assignment_likert=0
. replace assignment_likert=0 if assignments=="Strongly Disagree"
. replace assignment_likert=0.25 if assignments=="Disagre"
. replace assignment_likert=0.5 if assignments=="Neutral"
. replace assignment_likert=0.75 if assignments=="Agree"
. replace assignment_likert=1 if assignments=="Strongly Agree"

*Staff encouraged to share new ideas
tabulate new_ideas
. gen ideas_likert=0
. replace ideas_likert=0 if new_ideas=="Strongly Disagree"
. replace ideas_likert=0.25 if new_ideas=="Disagre"
. replace ideas_likert=0.5 if new_ideas=="Neutral"
. replace ideas_likert=0.75 if new_ideas=="Strongly Agree"
. replace ideas_likert=1 if new_ideas=="Agree"

*Meetings to discuss routine service statistics 
. gen audit_meeting=0
. replace audit_meeting=0 if audit_meet=="No"
. replace audit_meeting=0 if audit_meet=="I don't know"
. replace audit_meeting=1 if audit_meet=="Yes"
tabulate audit_meeting

*Mechanism to report new disease outbreaks
. gen data_outbreak=0
. replace data_outbreak=0 if data_coll_method=="No"
. replace data_outbreak=0 if data_coll_method=="I don't know"
. replace data_outbreak=1 if data_coll_method=="Yes"
tabulate data_outbreak

*Data monitored and improving service delivery is valued
tabulate data_monitor
. gen data_monitoring=0
. replace data_monitoring=0 if data_monitor=="Strongly Disagree"
. replace data_monitoring=0.25 if data_monitor=="Disagre"
. replace data_monitoring=0.5 if data_monitor=="Neutral"
. replace data_monitoring=0.75 if data_monitor=="Agree"
. replace data_monitoring=1 if data_monitor=="Strongly Agree"

*Conducts formal case reviews for quality
tabulate case_reviews
tabulate case_reviews_freq
. gen case_quality=0
. replace case_quality=0 if case_reviews=="No"
. replace case_quality=0.25 if case_reviews_freq=="Never/less than quarterly"
. replace case_quality=0.5 if case_reviews_freq=="At least quarterly"
. replace case_quality=0.75 if case_reviews_freq=="Monthly"
. replace case_quality=1 if case_reviews_freq=="Weeky"

*Regularly receives reports tracking common conditions with results shared with staff
tabulate  res_shared
tabulate  res_shared_tools
. gen res_conditions=0
. replace res_conditions=0 if res_shared=="No"
. replace res_conditions=0.33 if res_shared_tools=="One tool used"
. replace res_conditions=0.66 if res_shared_tools=="Two tools used"
. replace res_conditions=1 if res_shared_tools=="All three tools used"

. egen domain_monitoring= rowtotal (assignment_likert ideas_likert audit_meeting data_outbreak data_monitoring case_quality res_conditions)

*Score of the domain
. gen domain_active_monitoring=domain_monitoring/7

. format domain_active_monitoring %9.2f


*CLIENT FEEDBACK AND IMPROVEMENT

*Conducts quality improvement activities
. gen qualy_improv=0
. replace qualy_improv=1 if case_reviews=="Yes"
. replace qualy_improv=0 if case_reviews=="No"
tabulate qualy_improv

*Reports client opinions using any available tool
. gen client_opinion=0
. replace client_opinion=1 if client_surveys=="Yes"
. replace client_opinion=0 if client_surveys=="No"
tabulate client_opinion

*Made changes based in client opinion
. gen client_changes=0
. replace client_changes=1 if opinion_changes=="Yes"
. replace client_changes=0 if opinion_changes=="No"
tabulate client_changes

. egen domain_client_feedback= rowtotal(client_change client_opinion  qualy_improv)

*Score for the domain
. gen domain_client_feed= domain_client_feedback/3
. format domain_client_feed %9.2f

*OPERATIONS AND FINANCING

*Has comprehensive annual budget for running costs
. gen facility_budget=0
. replace facility_budget=1 if fac_budget_avail=="Yes"
. replace facility_budget=0 if fac_budget_avail=="No"
tabulate facility_budget


*Proportion of time facility head spent on managerial activities the previous day
. destring tt_hours, replace ignore(",")
. destring tt_hours, replace force
. egen manag_time=rowtotal(treating_patients verify_drugs op_budget_time sup_med_staff)
. gen management_time=manag_time/tt_hours
. replace management_time=1 if management_time>1
summarize management_time

*Maintains books to track revenue and expenditure 
. gen revenue_reporting=0
. replace revenue_reporting=1 if revenue_report=="Yes"
. replace revenue_reporting=0 if revenue_report=="No"
tabulate revenue_reporting

. egen domain_operations= rowtotal(facility_budget management_time revenue_reporting)
*Score of the domain
. gen domain_operations_financing=domain_operations/3

*SUPPORTIVE SUPERVISION AND TARGET SETTING

*Has formal improvement targets to achieve service delivery
. gen imprv_targets_num=0
. replace imprv_targets_num=1 if imprv_targets=="Yes"
. replace imprv_targets_num=0 if imprv_targets=="No"
tabulate imprv_targets_num

*Formal improvement targets for service delivery shared with staff
. gen imprv_targets_shared_num=0
. replace imprv_targets_shared_num=1 if imprv_targets_shared=="Yes"
. replace imprv_targets_shared_num=0 if imprv_targets_shared=="No"
tabulate imprv_targets_shared_num

*Facility head has received any formal management training 
. gen hfm_mngmnt_train_num=0
. replace hfm_mngmnt_train_num=1 if hfm_mngmnt_train=="Yes"
. replace hfm_mngmnt_train_num=0 if hfm_mngmnt_train=="No"
tabulate hfm_mngmnt_train_num

*Staff are offered training to improve their skills
. gen hf_staff_trained_num=0
. replace hf_staff_trained_num=1 if hf_staff_trained=="Yes"
. replace hf_staff_trained_num=0 if hf_staff_trained=="No"
tabulate hf_staff_trained_num

*Supervisors have held individual meetings to review staff performance
. gen hf_staff_appraisal_num=0
. replace hf_staff_appraisal_num=1 if hf_staff_appraisal=="Yes"
. replace hf_staff_appraisal_num=0 if hf_staff_appraisal=="No"
tabulate hf_staff_appraisal_num

*Has established criteria to evaluate staff performance 
. gen hf_apprais_criteria_num=0
. replace hf_apprais_criteria_num=1 if hf_apprais_criteria=="Yes"
. replace hf_apprais_criteria_num=0 if hf_apprais_criteria=="No"
tabulate hf_apprais_criteria_num

*Has formal, supportive and continuous supervision system
. gen sup_visit_num=0
. replace sup_visit_num=0.33 if sup_visit=="Yes"
. replace sup_visit_num=0 if sup_visit=="No"
tabulate sup_visit_num

. egen domain_support= rowtotal(imprv_targets_num imprv_targets_shared_num hfm_mngmnt_train_num hf_staff_trained_num hf_staff_appraisal_num hf_apprais_criteria_num sup_visit_num)

*Score of the domain
. gen domain_supportive=domain_support/7
. format domain_supportive %9.2f

*COMMUNITY ENGAGEMENT

*Shared information on performance within the community in the past 12 months 
. gen info_communication=0
. replace info_communication=0 if info_comm=="No"
. replace info_communication=0 if info_comm=="Don't Know"
. replace info_communication=1 if info_comm=="Yes"
tabulate info_communication

*Has a community advisory board that meets regularly and follows up
. gen cab_board=0
. replace cab_board=0 if board_present=="No"
. replace cab_board=0.5 if board_present=="Yes"
tabulate cab_board

*Has a community member regularly attending staff meetings
. gen community_staff=0
. replace community_staff=0 if comm_staff_meet=="No"
. replace community_staff=0 if comm_staff_meet=="Don't Know"
. replace community_staff=1 if comm_staff_meet=="Yes"
tabulate community_staff

. egen domain_community= rowtotal(info_communication cab_board community_staff)

*Score of the domain
. gen domain_community_engagement=domain_community/3
. format domain_community_engagement %9.2f

*TOTAL SCORE OF EACH FACILITY ACROSS THE DOMAINS
. egen facility_scores=rowtotal(domain_active_monitoring domain_client_feed domain_operations_financing domain_supportive domain_community_engagement)
. gen facility_score=facility_scores/5

*Median and Interquartile range for the different domains across different facility characteristics.

*facility type
table facility_type, c(median domain_active_monitoring iqr domain_active_monitoring median domain_client_feed iqr domain_client_feed) format (%9.2f)
table facility_type, c(median domain_operations_financing iqr domain_operations_financing median domain_supportive iqr domain_supportive) format (%9.2f)
table facility_type, c(median domain_community_engagement iqr domain_community_engagement) format (%9.2f)

*facility level 
table facility_level, c(median domain_active_monitoring iqr domain_active_monitoring median domain_client_feed iqr domain_client_feed) format (%9.2f)
table facility_level, c(median domain_operations_financing iqr domain_operations_financing median domain_supportive iqr domain_supportive) format (%9.2f)
table facility_level, c(median domain_community_engagement iqr domain_community_engagement) format (%9.2f)

*facility location
table facility_location, c(median domain_active_monitoring iqr domain_active_monitoring median domain_client_feed iqr domain_client_feed) format (%9.2f)
table facility_location, c(median domain_operations_financing iqr domain_operations_financing median domain_supportive iqr domain_supportive) format (%9.2f)
table facility_location, c(median domain_community_engagement iqr domain_community_engagement) format (%9.2f)

*facility ownership
table hcf_ownership, c(median domain_active_monitoring iqr domain_active_monitoring median domain_client_feed iqr domain_client_feed) format (%9.2f)
table hcf_ownership, c(median domain_operations_financing iqr domain_operations_financing median domain_supportive iqr domain_supportive) format (%9.2f)
table hcf_ownership, c(median domain_community_engagement iqr domain_community_engagement) format (%9.2f)

*County
table county, c(median domain_active_monitoring iqr domain_active_monitoring median domain_client_feed iqr domain_client_feed) format (%9.2f)
table county, c(median domain_operations_financing iqr domain_operations_financing median domain_supportive iqr domain_supportive) format (%9.2f)
table county, c(median domain_community_engagement iqr domain_community_engagement) format (%9.2f)

*Mean and Median facility scores across different facility characteristics.
table facility_type, c(mean facility_score sd facility_score median facility_score) format (%9.2f)
table facility_level, c(mean facility_score sd facility_score median facility_score) format (%9.2f)
table facility_location, c(mean facility_score sd facility_score median facility_score) format (%9.2f)
table hcf_ownership, c(mean facility_score sd facility_score median facility_score) format (%9.2f)
table county, c(mean facility_score sd facility_score median facility_score) format (%9.2f)

*VISUALIZATION

*Tables
graph bar facility_score, over(facility_type) title("Facility Score across Facility Type") ylabel(0(0.1)1)
graph bar facility_score, over(facility_level) title("Facility Score across Facility Level") ylabel(0(0.1)1)
graph bar facility_score, over(facility_location) title("Facility Score across Facility Location") ylabel(0(0.1)1)
graph bar facility_score, over(hcf_ownership) title("Facility Score across Facility Ownership") ylabel(0(0.1)1)
graph bar facility_score, over(county) title("Facility Score across Counties") ylabel(0(0.1)1)

*Domain Averages
summarize domain_active_monitoring, detail
summarize domain_client_feed, detail
summarize domain_operations_financing, detail
summarize domain_supportive, detail
summarize domain_community_engagement, detail
summarize facility_score, detail

*Boxplots
graph box facility_score, over(facility_type)
graph box facility_score, over(facility_level)
graph box facility_score, over(facility_location)
graph box facility_score, over(hcf_ownership)
graph box facility_score, over(county)

*CONFIDENCE INTERVALS

*95% CI Median for facility scores and individual domain scores across different facility level and location

*95CIs for Level II
preserve
keep if facility_level=="Level II"
bootstrap r(p50),reps(1000):summarize domain_active_monitoring,detail
bootstrap r(p50),reps(1000):summarize domain_client_feed,detail
bootstrap r(p50),reps(1000):summarize domain_operations_financing,detail
bootstrap r(p50),reps(1000):summarize domain_supportive,detail
bootstrap r(p50),reps(1000):summarize domain_community_engagement,detail
bootstrap r(p50),reps(1000):summarize facility_score,detail
restore

*95% CI for Level III
preserve
keep if facility_level=="Level III"
bootstrap r(p50),reps(1000):summarize domain_active_monitoring,detail
bootstrap r(p50),reps(1000):summarize domain_client_feed,detail
bootstrap r(p50),reps(1000):summarize domain_operations_financing,detail
bootstrap r(p50),reps(1000):summarize domain_supportive,detail
bootstrap r(p50),reps(1000):summarize domain_community_engagement,detail
bootstrap r(p50),reps(1000):summarize facility_score,detail
restore

*95% CI for Level IV
preserve
keep if facility_level=="Level IV"
bootstrap r(p50),reps(1000):summarize domain_active_monitoring,detail
bootstrap r(p50),reps(1000):summarize domain_client_feed,detail
bootstrap r(p50),reps(1000):summarize domain_operations_financing,detail
bootstrap r(p50),reps(1000):summarize domain_supportive,detail
bootstrap r(p50),reps(1000):summarize domain_community_engagement,detail
bootstrap r(p50),reps(1000):summarize facility_score,detail
restore

*95% CI for Level V
preserve
keep if facility_level=="Level V"
bootstrap r(p50),reps(1000):summarize domain_active_monitoring,detail
bootstrap r(p50),reps(1000):summarize domain_client_feed,detail
bootstrap r(p50),reps(1000):summarize domain_operations_financing,detail
bootstrap r(p50),reps(1000):summarize domain_supportive,detail
bootstrap r(p50),reps(1000):summarize domain_community_engagement,detail
bootstrap r(p50),reps(1000):summarize facility_score,detail
restore

*95% CI for Rural Facilities
preserve
keep if facility_location=="Rural"
bootstrap r(p50),reps(1000):summarize domain_active_monitoring,detail
bootstrap r(p50),reps(1000):summarize domain_client_feed,detail
bootstrap r(p50),reps(1000):summarize domain_operations_financing,detail
bootstrap r(p50),reps(1000):summarize domain_supportive,detail
bootstrap r(p50),reps(1000):summarize domain_community_engagement,detail
bootstrap r(p50),reps(1000):summarize facility_score,detail
restore

*95% CI for Urban Facilities
preserve
keep if facility_location=="Urban"
bootstrap r(p50),reps(1000):summarize domain_active_monitoring,detail
bootstrap r(p50),reps(1000):summarize domain_client_feed,detail
bootstrap r(p50),reps(1000):summarize domain_operations_financing,detail
bootstrap r(p50),reps(1000):summarize domain_supportive,detail
bootstrap r(p50),reps(1000):summarize domain_community_engagement,detail
bootstrap r(p50),reps(1000):summarize facility_score,detail
restore


*PROPORTION OF FEMALES 

*Proportion of females in the health management team
destring hmt_num_fem, replace ignore(",")
destring hmt_num_fem, replace force
destring hmt_num, replace ignore(",")
destring hmt_num, replace force
gen females_proportion_hmt=hmt_num_fem/hmt_num
replace females_proportion_hmt=0 if missing(females_proportion_hmt)
replace females_proportion_hmt =1 if females_proportion_hmt>1
summarize females_proportion_hmt

*Proportion of females in the facility board
destring fboard_comm, replace ignore(",")
destring fboard_comm, replace force
destring fboard_comm_f, replace ignore(",")
destring fboard_comm_f, replace force
gen females_proportion_fboard=fboard_comm_f/fboard_comm
replace females_proportion_fboard=0 if missing(females_proportion_fboard)
replace females_proportion_fboard =1 if females_proportion_fboard>1
summarize females_proportion_fboard 

*Proportion of females in the expenditure committee
destring exp_members, replace ignore(",")
destring exp_members, replace force
destring exp_members_f, replace ignore(",")
destring exp_members_f, replace force
gen females_proportion_exp=exp_members_f/exp_members
replace females_proportion_exp=0 if missing(females_proportion_exp)
replace females_proportion_exp =1 if females_proportion_exp>1
summarize females_proportion_exp

*Female Chair to the facility board
gen fboard_chair_female=.
replace fboard_chair_female=1 if fboard_chair_gender=="Female"
replace fboard_chair_female=0 if fboard_chair_gender=="Male"

*Drop other unused variables 
*keep facility_type facility_level facility_location hcf_ownership county pop_served nhif_contract assignment_likert assignments new_ideas ideas_likert audit_meeting audit_meet data_outbreak data_coll_method data_monitoring data_monitor case_quality case_reviews res_conditions res_shared res_shared_tools domain_monitoring domain_active_monitoring qualy_improv case_reviews client_opinion client_surveys client_changes opinion_changes domain_client_feedback domain_client_feed facility_budget fac_budget_avail treating_patients verify_drugs op_budget_time sup_med_staff tt_hours manag_time management_time revenue_reporting revenue_report domain_operations domain_operations_financing imprv_targets_num imprv_targets imprv_targets_shared_num imprv_targets_shared hfm_mngmnt_train_num hfm_mngmnt_train hf_staff_trained_num hf_staff_trained hf_staff_appraisal_num hf_staff_appraisal hf_apprais_criteria_num hf_apprais_criteria sup_visit_num sup_visit domain_support domain_supportive info_communication info_comm cab_board board_present community_staff comm_staff_meet domain_community domain_community_engagement facility_scores facility_score inpatient_beds hcf_manager_sex fboard_chair_gender fboard_chair_female hmt_num hmt_num_fem females_proportion_hmt fboard_comm fboard_comm_f females_proportion_fboard exp_members exp_members_f females_proportion_exp

*Code for de_identifying counties
replace county="county 1" if county=="Busia"
replace county="county 2" if county=="Embu"
replace county="county 3" if county=="Garissa"
replace county="county 4" if county=="Homa Bay"
replace county="county 5" if county=="Kajiado"
replace county="county 6" if county=="Kakamega"
replace county="county 7" if county=="Kirinyaga"
replace county="county 8" if county=="Kisumu"
replace county="county 9" if county=="Kwale"
replace county="county 10" if county=="Lamu"
replace county="county 11" if county=="Makueni"
replace county="county 12" if county=="Migori"
replace county="county 13" if county=="Nakuru"
replace county="county 14" if county=="Nyandarua"
replace county="county 15" if county=="Tana River"

*Cleaning the variable inpatient beds
 replace inpatient_beds =. if inpatient_beds ==99
 replace inpatient_beds =. if inpatient_beds ==999
 replace inpatient_beds =. if inpatient_beds ==9999
 replace inpatient_beds =. if inpatient_beds ==99999
 replace inpatient_beds =. if inpatient_beds ==999999
 replace inpatient_beds =. if inpatient_beds ==9999999
 replace inpatient_beds =. if inpatient_beds ==99999999
 replace inpatient_beds =. if inpatient_beds ==999999999
 replace inpatient_beds =. if inpatient_beds ==9999999999
 
 
 ********SERVICE READINESS**************
				****(i) Availability of basic amenities 

gen elec_main_src_num = .
replace elec_main_src_num = 0 if elec_main_src == "No power supply"
replace elec_main_src_num = 1 if elec_main_src != "No power supply" & elec_main_src != ""

gen elec_intr_num = .
replace elec_intr_num = 0 if elec_intr == "No"
replace elec_intr_num = 1 if elec_intr == "Yes"

gen elec_backup_avail_num = .
replace elec_backup_avail_num = 0 if elec_backup_avail == "No"
replace elec_backup_avail_num =1 if elec_backup_avail == "Yes"

gen water_main_src_num = .
replace water_main_src_num = 0 if water_main_src == "No water"
replace water_main_src_num = 1 if water_main_src != "No water" & water_main_src != ""

gen water_shortage_num = .
replace water_shortage_num = 0 if water_shortage == "No"
replace water_shortage_num = 1 if water_shortage == "Yes"

gen water_rel_bup_num = .
replace water_rel_bup_num = 0 if water_rel_bup == "No"
replace water_rel_bup_num = 1 if water_rel_bup == "Yes"

gen landline_tel_num = .
replace landline_tel_num = 0 if landline_tel == "Not available today"
replace landline_tel_num = 0 if landline_tel == "Available today but not functional"
replace landline_tel_num = 1 if landline_tel == "Available today and functional"

gen cellphone_fc_num = .
replace cellphone_fc_num = 0 if cellphone_fc == "Not available today"
replace cellphone_fc_num = 0 if cellphone_fc == "Available today but not functional"
replace cellphone_fc_num = 1 if cellphone_fc == "Available today and functional"

gen cellphone_staff_num = .
replace cellphone_staff_num = 0 if cellphone_staff == "Not available today"
replace cellphone_staff_num = 0 if cellphone_staff == "Available today but not functional"
replace cellphone_staff_num = 1 if cellphone_staff == "Available today and functional"

gen public_tel_num = .
replace public_tel_num = 0 if public_tel == "Not available today"
replace public_tel_num = 0 if public_tel == "Available today but not functional"
replace public_tel_num = 1 if public_tel == "Available today and functional"

gen radio_num = .
replace radio_num = 0 if radio == "Not available today"
replace radio_num = 0 if radio == "Available today but not functional"
replace radio_num = 1 if radio == "Available today and functional"

gen internet_num = .
replace internet_num = 0 if internet == "Not available today"
replace internet_num = 0 if internet == "Available today but not functional"
replace internet_num = 1 if internet == "Available today and functional"

gen func_comp_num = .
replace func_comp_num = 0 if func_comp == "No"
replace func_comp_num = 0 if func_comp == "Yes, but not observed"
replace func_comp_num = 1 if func_comp == "Yes, computer & tablet (Both)"
replace func_comp_num = 1 if func_comp == "Yes, computer only"
replace func_comp_num = 1 if func_comp == "Yes, tablet only"



gen comp_internet_num = .
replace comp_internet_num  = 0 if comp_internet == "No"
replace comp_internet_num  = 1 if comp_internet == "Yes"

gen it_support_num = .
replace it_support_num = 0 if it_support == "No"
replace it_support_num = 1 if it_support == "Yes, from HF"
replace it_support_num = 1 if it_support == "Yes, from county"

gen opd_num = .
replace opd_num = 0 if opd == "No"
replace opd_num =1 if opd == "Yes"

gen opd_consult_room_num = .
replace opd_consult_room_num = 0 if opd_consult_room == "No"
replace opd_consult_room_num = 1 if opd_consult_room == "Yes"

gen ip_dept_num = .
replace ip_dept_num = 0 if ip_dept == "No"
replace ip_dept_num =1 if ip_dept == "Yes"

gen toilet_sep_num = .
replace toilet_sep_num = 1 if toilet_sep == "Available today and functional in all wards"
replace toilet_sep_num = 1 if toilet_sep == "Available today and functional in some wards"
replace toilet_sep_num = 1 if toilet_sep == "Available today but not functional"
replace toilet_sep_num = 0 if toilet_sep == "Not available today"

gen staff_toilet_num = .
replace staff_toilet_num = 0 if staff_toilet == "Not available today"
replace staff_toilet_num = 0 if staff_toilet == "Available today but not functional"
replace staff_toilet_num = 1 if staff_toilet == "Available today and functional"

gen patient_toilet_num = .
replace patient_toilet_num = 0 if patient_toilet == "Not available today"
replace patient_toilet_num = 0 if patient_toilet == "Available today but not functional"
replace patient_toilet_num = 1 if patient_toilet == "Available today and functional"

gen patient_toilet_num = .
replace patient_toilet_num = 0 if patient_toilet == "Not available today"
replace patient_toilet_num = 0 if patient_toilet == "Available today but not functional"
replace patient_toilet_num = 1 if patient_toilet == "Available today and functional"

gen hwash_toilet_num = .
replace hwash_toilet_num  = 0 if patient_toilet == "Not available today"
replace hwash_toilet_num  = 1 if patient_toilet == "Available today and functional next to some toilets"
replace hwash_toilet_num  = 1 if patient_toilet == "Available today and functional next to all toilets"

gen refer_where_num = .
replace refer_where_num = 0 if refer_where == "No"
replace refer_where_num = 1 if refer_where != "No" & refer_where != ""

gen amb_emmergency_num = .
replace amb_emmergency_num = 0 if amb_emmergency == "No"
replace amb_emmergency_num = 1 if amb_emmergency == "Yes, ambulance"
replace amb_emmergency_num = 1 if amb_emmergency == "Yes, other type of vehicle"

*Noting that this a follow up from the previous variable (Ambulance, Yes, Does it have fuel?)
gen fuel_num = . 
replace fuel_num = 0 if fuel == "No"
replace fuel_num = 0 if fuel == "Don't know"
replace fuel_num = 1 if fuel == "Yes"


				****(ii) Availability of functional basic equipment 

gen a_wscale_num = .
replace a_wscale_num = 0 if a_wscale == "Not available today"
replace a_wscale_num = 1 if a_wscale == "Available today"

gen c_wscale_num = .
replace c_wscale_num = 0 if c_wscale == "Not available today"
replace c_wscale_num = 1 if c_wscale == "Available today"

gen i_wscale_num = .
replace i_wscale_num = 0 if i_wscale == "Not available today"
replace i_wscale_num = 1 if i_wscale == "Available today"

gen mtape_num = .
replace mtape_num = 0 if mtape == "Not available today"
replace mtape_num = 1 if mtape == "Available today"

gen thermometer_num = .
replace thermometer_num = 0 if thermometer == "Not available today"
replace thermometer_num = 1 if thermometer == "Available today"

gen stethoscope_num = .
replace stethoscope_num = 0 if stethoscope == "Not available today"
replace stethoscope_num = 1 if stethoscope == "Available today"

gen bp_apparatus_num = .
replace bp_apparatus_num = 0 if bp_apparatus == "Not available today"
replace bp_apparatus_num = 1 if bp_apparatus == "Available today"

gen light_src_num = .
replace light_src_num = 0 if light_src == "Not available today"
replace light_src_num = 1 if light_src == "Available today"

gen intravenous_kits_num = .
replace intravenous_kits_num = 0 if intravenous_kits == "Not available today"
replace intravenous_kits_num = 1 if intravenous_kits == "Available today"

gen oxy_cylinders_num = .
replace oxy_cylinders_num = 0 if oxy_cylinders == "Not available today"
replace oxy_cylinders_num = 1 if oxy_cylinders == "Available today"

gen oxy_central_num = .
replace oxy_central_num = 0 if oxy_central == "Not available today"
replace oxy_central_num = 1 if oxy_central == "Available today"

gen oxy_flow_meter_num = .
replace oxy_flow_meter_num = 0 if oxy_flow_meter == "Not available today"
replace oxy_flow_meter_num = 1 if oxy_flow_meter == "Available today"

gen oxy_del_apparatus_num = .
replace oxy_del_apparatus_num = 0 if oxy_del_apparatus == "Not available today"
replace oxy_del_apparatus_num = 1 if oxy_del_apparatus == "Available today"

gen oxy_unavail_3m_num = .
replace oxy_unavail_3m_num = 0 if oxy_unavail_3m == "Not available today"
replace oxy_unavail_3m_num = 1 if oxy_unavail_3m == "Available today"

gen cold_storage_num = .
replace cold_storage_num = 0 if cold_storage == "Not available today"
replace cold_storage_num = 1 if cold_storage == "Available today"

gen blood_trans_serv_num = .
replace blood_trans_serv_num = 0 if blood_trans_serv == "Not available today"
replace blood_trans_serv_num = 1 if blood_trans_serv == "Available today"




**************** (iii) Availability of diagnostic services

gen malaria_kit_num = .
replace malaria_kit_num = 0 if malaria_kit == "No"
replace malaria_kit_num = 1 if malaria_kit == "Yes"

gen malaria_bs_num = .
replace malaria_bs_num = 0 if malaria_bs == "No"
replace malaria_bs_num = 1 if malaria_bs == "Yes"

gen syphilis_rapid_num = .
replace syphilis_rapid_num = 0 if syphilis_rapid == "No"
replace syphilis_rapid_num = 1 if syphilis_rapid == "Yes"

gen hiv_rapid_num = .
replace hiv_rapid_num = 0 if hiv_rapid == "No"
replace hiv_rapid_num = 1 if hiv_rapid == "Yes"

gen urine_preg_kit_num = .
replace urine_preg_kit = 0 if urine_preg == "No"
replace urine_preg_kit = 1 if urine_preg == "Yes"

gen dipstick_urine_pr_num = .
replace dipstick_urine_pr_num = 0 if dipstick_urine_pr == "No"
replace dipstick_urine_pr_num = 1 if dipstick_urine_pr == "Yes"

gen dipstick_urine_gl_num = .
replace dipstick_urine_gl_num = 0 if dipstick_urine_gl == "No"
replace dipstick_urine_gl_num = 1 if dipstick_urine_gl == "Yes"

gen dipstick_urine_ket_num = .
replace dipstick_urine_ket_num = 0 if dipstick_urine_ket == "No"
replace dipstick_urine_ket_num = 1 if dipstick_urine_ket == "Yes"

gen filt_pp_dbs_num = .
replace filt_pp_dbs_num = 0 if filt_pp_dbs == "No"
replace filt_pp_dbs_num = 1 if filt_pp_dbs == "Yes"

gen hb_num = .
replace hb_num = 0 if hb == "No"
replace hb_num = 1 if hb == "Yes"

gen gen_microscp_num = .
replace gen_microscp_num = 0 if gen_microscp == "No"
replace gen_microscp_num = 1 if gen_microscp == "Yes"

gen culture_num = .
replace culture_num = 0 if culture == "No"
replace culture_num = 1 if culture == "Yes"

gen tb_num = .
replace tb_num = 0 if tb == "No"
replace tb_num = 1 if tb == "Yes"

gen blood_creat_num = .
replace blood_creat_num = 0 if blood_creat == "No"
replace blood_creat_num = 1 if blood_creat == "Yes"

gen liver_func_num = .
replace liver_func_num = 0 if liver_func == "No"
replace liver_func_num = 1 if liver_func == "Yes"

gen renal_func_num = .
replace renal_func_num = 0 if renal_func == "No"
replace renal_func_num = 1 if renal_func == "Yes"

gen blood_typing_num = .
replace blood_typing_num = 0 if blood_typing == "No"
replace blood_typing_num = 1 if blood_typing == "Yes"

gen blood_grouping_num = .
replace blood_grouping_num = 0 if blood_grouping == "No"
replace blood_grouping_num = 1 if blood_grouping == "Yes"


**********Availability of essential medicines**************
gen amlodipine_num = .
replace amlodipine_num = 0 if amlodipine == "Not available today"
replace amlodipine_num = 1 if amlodipine == "At least one dose not expired"

gen amox_syr_disp_num = .
replace amox_syr_disp_num = 0 if amox_syr_disp == "Not available today"
replace amox_syr_disp_num = 1 if amox_syr_disp == "At least one dose not expired"

gen ampicillin_powd_num = .
replace ampicillin_powd_num = 0 if ampicillin_powd == "Not available today"
replace ampicillin_powd_num = 1 if ampicillin_powd == "At least one dose not expired"

gen asp_tab_num = .
replace asp_tab_num = 0 if asp_tab == "Not available today"
replace asp_tab_num = 1 if asp_tab == "At least one dose not expired"

gen bec_inhaler_num = .
replace bec_inhaler_num = 0 if bec_inhaler == "Not available today"
replace bec_inhaler_num = 1 if bec_inhaler == "At least one dose not expired"

gen beta_blocker_num = .
replace beta_blocker_num = 0 if beta_blocker == "Not available today"
replace beta_blocker_num = 1 if beta_blocker == "At least one dose not expired"

gen carbamazepine_num = .
replace carbamazepine_num = 0 if carbamazepine == "Not available today"
replace carbamazepine_num = 1 if carbamazepine == "At least one dose not expired"

gen ceftriaxone_num = .
replace ceftriaxone_num = 0 if ceftriaxone == "Not available today"
replace ceftriaxone_num = 1 if ceftriaxone == "At least one dose not expired"

gen diazepam_num = .
replace diazepam_num = 0 if diazepam == "Not available today"
replace diazepam_num = 1 if diazepam == "At least one dose not expired"

gen enalapril_num = .
replace enalapril_num = 0 if enalapril == "Not available today"
replace enalapril_num = 1 if enalapril == "At least one dose not expired"

gen fluoxetine_num = .
replace fluoxetine_num = 0 if fluoxetine == "Not available today"
replace fluoxetine_num = 1 if fluoxetine == "At least one dose not expired"

gen genta_inject_num = .
replace genta_inject_num = 0 if genta_inject == "Not available today"
replace genta_inject_num = 1 if genta_inject == "At least one dose not expired"

gen glibenclamide_tab_num = .
replace glibenclamide_tab_num = 0 if glibenclamide_tab == "Not available today"
replace glibenclamide_tab_num = 1 if glibenclamide_tab == "At least one dose not expired"

gen haloperidol_tab_num = .
replace haloperidol_tab_num = 0 if haloperidol_tab == "Not available today"
replace haloperidol_tab_num = 1 if haloperidol_tab == "At least one dose not expired"

gen insulin_inject_num = .
replace insulin_inject_num = 0 if insulin_inject == "Not available today"
replace insulin_inject_num = 1 if insulin_inject == "At least one dose not expired"

gen mag_sul_inj_num = .
replace mag_sul_inj_num = 0 if mag_sul_inj == "Not available today"
replace mag_sul_inj_num = 1 if mag_sul_inj == "At least one dose not expired"

gen metformin_tab_num = .
replace metformin_tab_num = 0 if metformin_tab == "Not available today"
replace metformin_tab_num = 1 if metformin_tab == "At least one dose not expired"

gen omeprazole_alt_num = .
replace omeprazole_alt_num = 0 if omeprazole_alt == "Not available today"
replace omeprazole_alt_num = 1 if omeprazole_alt == "At least one dose not expired"

gen ors_num = .
replace ors_num = 0 if ors == "Not available today"
replace ors_num = 1 if ors == "At least one dose not expired"

gen ors_num = .
replace ors_num = 0 if ors == "Not available today"
replace ors_num = 1 if ors == "At least one dose not expired"

gen salbut_inhaler_num = .
replace salbut_inhaler_num = 0 if salbut_inhaler == "Not available today"
replace salbut_inhaler_num = 1 if salbut_inhaler == "At least one dose not expired"

gen simvastatin_tab_num = .
replace simvastatin_tab_num = 0 if simvastatin_tab == "Not available today"
replace simvastatin_tab_num = 1 if simvastatin_tab == "At least one dose not expired"

gen thiazide_num = .
replace thiazide_num = 0 if thiazide == "Not available today"
replace thiazide_num = 1 if thiazide == "At least one dose not expired"

gen zinc_sul_tab_num = .
replace zinc_sul_tab_num = 0 if zinc_sul_tab == "Not available today"
replace zinc_sul_tab_num = 1 if zinc_sul_tab == "At least one dose not expired"

 ****************Availability of KEPI vaccines in stock*********************


gen measles_vacc_dil_num = .
replace measles_vacc_dil_num = 0 if measles_vacc_dil == "Not available today"
replace measles_vacc_dil_num = 0 if measles_vacc_dil == "Available but expired"
replace measles_vacc_dil_num = 1 if measles_vacc_dil == "At least one not expired"

gen measles_rub_num = .
replace measles_rub_num = 0 if measles_rub == "Not available today"
replace measles_rub_num = 0 if measles_rub == "Available but expired"
replace measles_rub_num = 1 if measles_rub == "At least one not expired"

gen measles_mumps_rub_num = .
replace measles_mumps_rub_num = 0 if measles_mumps_rub == "Not available today"
replace measles_mumps_rub_num = 0 if measles_mumps_rub == "Available but expired"
replace measles_mumps_rub_num = 1 if measles_mumps_rub == "At least one not expired"

gen penta_num = .
replace penta_num = 0 if penta == "Not available today"
replace penta_num = 0 if penta == "Available but expired"
replace penta_num = 1 if penta == "At least one not expired"

gen polio_num = .
replace polio_num = 0 if polio == "Not available today"
replace polio_num = 0 if polio == "Available but expired"
replace polio_num = 1 if polio == "At least one not expired"

gen bcg_num = .
replace bcg_num = 0 if bcg == "Not available today"
replace bcg_num = 0 if bcg == "Available but expired"
replace bcg_num = 1 if bcg == "At least one not expired"

gen rota_num = .
replace rota_num = 0 if rota == "Not available today"
replace rota_num = 0 if rota == "Available but expired"
replace rota_num = 1 if rota == "At least one not expired"

gen rota_num = .
replace rota_num = 0 if rota == "Not available today"
replace rota_num = 0 if rota == "Available but expired"
replace rota_num = 1 if rota == "At least one not expired"

gen pcv_10_num = .
replace pcv_10_num = 0 if rota == "Not available today"
replace pcv_10_num = 0 if rota == "Available but expired"
replace pcv_10_num = 1 if rota == "At least one not expired"

				*****Availability of family planning cyree

gen coc_num = .
replace coc_num = 0 if coc == "Not available today"
replace coc_num = 0 if coc == "Available but expired "
replace coc_num = 1 if coc == "At least one non-expired commodity"

gen progestin_pill_num = .
replace progestin_pill_num = 0 if progestin_pill == "Not available today"
replace progestin_pill_num = 0 if progestin_pill == "Available but expired "
replace progestin_pill_num = 1 if progestin_pill == "At least one non-expired commodity"

gen comb_estrogen_num = .
replace comb_estrogen_num = 0 if comb_estrogen == "Not available today"
replace comb_estrogen_num = 0 if comb_estrogen == "Available but expired "
replace comb_estrogen_num = 1 if comb_estrogen == "At least one non-expired commodity"

gen progestin_contra_num = .
replace progestin_contra_num = 0 if progestin_contra == "Not available today"
replace progestin_contra_num = 0 if progestin_contra == "Available but expired "
replace progestin_contra_num = 1 if progestin_contra == "At least one non-expired commodity"

gen male_condom_num = .
replace male_condom_num = 0 if male_condom == "Not available today"
replace male_condom_num = 0 if male_condom == "Available but expired "
replace male_condom_num = 1 if male_condom == "At least one non-expired commodity"

gen female_condom_num = .
replace female_condom_num = 0 if female_condom == "Not available today"
replace female_condom_num = 0 if female_condom == "Available but expired "
replace female_condom_num = 1 if female_condom == "At least one non-expired commodity"

gen implant_num = .
replace implant_num = 0 if implant == "Not available today"
replace implant_num = 0 if implant == "Available but expired "
replace implant_num = 1 if implant == "At least one non-expired commodity"

gen emmerg_contraceptive_num = .
replace emmerg_contraceptive_num = 0 if emmerg_contraceptive == "Not available today"
replace emmerg_contraceptive_num = 0 if emmerg_contraceptive == "Available but expired "
replace emmerg_contraceptive_num = 1 if emmerg_contraceptive == "At least one non-expired commodity"

gen intrauterine_dev_num = .
replace intrauterine_dev_num = 0 if intrauterine_dev_num == "Not available today"
replace intrauterine_dev_num = 0 if intrauterine_dev_num == "Available but expired "
replace intrauterine_dev_num = 1 if intrauterine_dev_num == "At least one non-expired commodity"

gen cycle_beads_num = .
replace cycle_beads_num = 0 if cycle_beads == "Not available today"
replace cycle_beads_num = 0 if cycle_beads == "Available but expired "
replace cycle_beads_num = 1 if cycle_beads == "At least one non-expired commodity"


******************************Availability of malaria drugs*************************8
gen al_tab_6_num = .
replace al_tab_6_num = 0 if al_tab_6 == "Not available today"
replace al_tab_6_num = 0 if al_tab_6 == "Available but expired"
replace al_tab_6_num = 0 if al_tab_6 == "At least one dose not expired"
















































































































********END OF DO FILE ********

