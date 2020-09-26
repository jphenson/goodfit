/*
version 1.0 // inital version
version 1.1 // added [if] statement
			// Changed the to have true outcome and predicted outcome in the varlist not the options section
			// Added the varnames of the true outcome and predicted outcome to the return list
			// Changed output to include matrix at each cutoff step to making graphing the results simple
			// Changed several scalar variable to locals to prevent conflicts with variable names. 
Author: James Patrick Henson ⚙
Email 📧: jphenson1218@Gmail.com 
Github 👨‍💻: https://github.com/jphenson
If you have any issues with the program please report on Github.  
*/
capture program drop goodfit
program define goodfit, rclass
	// This program creates the same type of goodness of fit infomation as estat classification
	// but works for any binary prediction not just logistic, logit, probit, ivprobit.
	version 15.0
	syntax varlist(numeric min=2 max=2) [if] , [cutoff(numlist min=1 max=1)] [max_cutoff] [n_quart(numlist min=1 max=1)] 
	return clear
	tempvar P_model y_outcome y_pred P_pos_true P_neg_true P_pos_false P_neg_false P_correct A_min A_max
	tempname A B C temp1 Gph minmax_check
	marksample touse
	tokenize `varlist'
	return local y_outcome_str = "`1'"
	gen `y_outcome' = `1' if `touse'
	return local y_pred_str = "`2'"
	gen `y_pred' = `2' if `touse'
	if "`max_cutoff'"==""&"`cutoff'"=="" {
		di as error "Error: Option cutoff or max_cutoff required"
	}
	qui tabstat `y_pred', statistics(min max)  save
	qui mat `minmax_check' = r(StatTotal)
	qui scalar `A_min' = `minmax_check'[1,1]
	qui scalar `A_max' = `minmax_check'[2,1]
	if "`cutoff'"!="" {
		if `cutoff' < `A_min' {
			di as error "Warning: cutoff was set below the minimum of the predicted outcome."
			di as error "Minimum of the predicted outcome was: " as error `A_min'
		}
		if `cutoff' > `A_max' {
			di as error "Warning: cutoff was set above the maximum of the predicted outcome."
			di as error "Maximum of the predicted outcome was: " as error `A_max'
		}
	}
	 qui {

	di as result "`max_cutoff'"
	if "`max_cutoff'"!="" {
		if "`n_quart'" == "" {
			local num_quarts = 50
		}
		else {
			local num_quarts = `n_quart'
		}
		tabstat `y_pred', statistics(min max)  save
		mat `A' = r(StatTotal)
		scalar `A_min' = `A'[1,1]
		scalar `A_max' = `A'[2,1]
		_pctile `y_pred' , nq(`num_quarts')
		forvalues qi = 1/`num_quarts' {
			local q_`qi' = r(r`qi')
		}
		forvalues qi = 1/`num_quarts' {
			di as text "`qi'"
		    di as text `q_`qi'' 
			if `q_`qi'' != . {

				gen `P_model' = 0 
				replace `P_model' = 1 if `y_pred'>= `q_`qi'' 
				replace `P_model' = . if `y_pred'== .  //  not including missing values
				gen `P_pos_true' = 0
				replace `P_pos_true' = 1 if `P_model' ==1 & `y_outcome' ==1 
				gen `P_neg_true' = 0
				replace `P_neg_true' = 1 if `P_model' ==0 & `y_outcome' ==0 
				gen `P_pos_false' = 0
				replace `P_pos_false' = 1 if `P_model' ==1 & `y_outcome' ==0 
				gen `P_neg_false' = 0
				replace `P_neg_false' = 1 if `P_model' ==0 & `y_outcome' ==1 
				tabstat `P_pos_true' `P_neg_true' `P_pos_false' `P_neg_false', statistics(sum) varwidth(20) c(s) save
				mat `B' = r(StatTotal)
				// adding new values 
				local p_true = `B'[1,1] // a
				local n_true = `B'[1,2] // d
				local p_false = `B'[1,3] // b
				local n_false = `B'[1,4] // c
				local P_correct_`qi' = ((`p_true'+`n_true')/(`p_true'+`n_true'+`p_false'+`n_false'))*100
				local P_t_pos_rate = ((`p_true')/(`p_true'+`n_false'))*100
				local P_t_neg_rate = ((`n_true')/(`p_false'+`n_true'))*100
				local P_pos_pred = ((`p_true')/(`p_true'+`p_false'))*100
				local P_neg_pred = ((`n_true')/(`n_true'+`n_false'))*100
				local P_f_pos_rate = ((`p_false')/(`p_false'+`n_true'))*100
				local P_f_neg_rate = ((`n_false')/(`n_false'+`p_true'))*100
				if `qi' == 1{
					matrix `Gph' = [`qi', `q_`qi'', `P_correct_`qi'', `P_t_pos_rate', `P_t_neg_rate', `P_pos_pred', `P_neg_pred', `P_f_pos_rate', `P_f_neg_rate']
				}
				else if `q_`qi''!=. {
					mat `temp1' = [`qi', `q_`qi'', `P_correct_`qi'', `P_t_pos_rate', `P_t_neg_rate', `P_pos_pred', `P_neg_pred', `P_f_pos_rate', `P_f_neg_rate'] 
					matrix `Gph' = [ `Gph' \ `temp1' ]
				}
				drop `P_model' `P_pos_true' `P_neg_true' `P_pos_false' `P_neg_false' 
				}
			else { 

			}
			if `qi' == 1 {
				local cutoff_temp = `q_`qi''
				local max_Pcorr_temp = `P_correct_`qi''
				di as result "1if"  
				di as result `cutoff_temp' 
				di as result `max_Pcorr_temp'
			}
			else if `q_`qi'' != . {
				if `qi' != 1 & `P_correct_`qi'' > `max_Pcorr_temp' {
					local cutoff_temp = `q_`qi''
					local max_Pcorr_temp = `P_correct_`qi'' 
					di as result "2if" 
					di as result `cutoff_temp' 
					di as result `max_Pcorr_temp'
				}
			}
		}	
	}
	gen `P_model' = 0 
	di as result "`max_cutoff'"
	if "`max_cutoff'"!="" {
		replace `P_model' = 1 if `y_pred' >=`cutoff_temp'
		local final_cut_off = `cutoff_temp'
		di as result "3if" 
		di as result `cutoff_temp' 
		di as result `final_cut_off'
	}
	else {
		replace `P_model' = 1 if `y_pred' >=`cutoff'
		local final_cut_off = `cutoff'
		di as result "4if" 
		di as result `cutoff_temp' 
		di as result `final_cut_off'
	}
	replace `P_model' = . if `y_pred'== . //  not including missing values
	gen `P_pos_true' = 0
	replace `P_pos_true' = 1 if `P_model' ==1 & `y_outcome' ==1 
	gen `P_neg_true' = 0
	replace `P_neg_true' = 1 if `P_model' ==0 & `y_outcome' ==0 
	gen `P_pos_false' = 0
	replace `P_pos_false' = 1 if `P_model' ==1 & `y_outcome' ==0
	gen `P_neg_false' = 0
	replace `P_neg_false' = 1 if `P_model' ==0 & `y_outcome' ==1
	tabstat `P_pos_true' `P_neg_true' `P_pos_false' `P_neg_false', statistics(sum) varwidth(20) c(s) save
	mat `C' = r(StatTotal)
	local p_true = `C'[1,1] // a
	local n_true = `C'[1,2] // d
	local p_false = `C'[1,3] // b
	local n_false = `C'[1,4] // c
	local P_correct = ((`p_true'+`n_true')/(`p_true'+`n_true'+`p_false'+`n_false'))*100
	local P_t_pos_rate = ((`p_true')/(`p_true'+`n_false'))*100
	local P_t_neg_rate = ((`n_true')/(`p_false'+`n_true'))*100
	local P_pos_pred = ((`p_true')/(`p_true'+`p_false'))*100
	local P_neg_pred = ((`n_true')/(`n_true'+`n_false'))*100
	local P_f_pos_rate = ((`p_false')/(`p_false'+`n_true'))*100
	local P_f_neg_rate = ((`n_false')/(`n_false'+`p_true'))*100
	drop `P_model' `P_pos_true' `P_neg_true' `P_pos_false' `P_neg_false'
	}
	di as text "Best cutoff was " as result `cutoff_temp'
	di as text "Correctly classified " as result `max_Pcorr_temp' as text "% at cutoff " as result `cutoff_temp'
	di as text ""
	di as text "{c TLC}{hline 11}{c TT}{hline 29}{c TT}{hline 15}{c TRC}"
	di as text "{c |}           {c |}        True Condition       {c |}               {c |}"
	di as text "{c LT}{hline 11}{c +}{hline 29}{c +}{hline 15}{c RT}"
	di as text "{c |}Predicted  {c |}          T           ~T     {c |}      Total    {c |}"
	di as text "{c |}Condition  {c |}                             {c |}               {c |}"
	di as text "{c LT}{hline 11}{c +}{hline 29}{c +}{hline 15}{c RT}"
	di as text "{c |}     +     {c |}   " as result %10.0g `p_true' "  " %10.0g `p_false' as text "    {c |}  " as result %10.0g (`p_true'+`p_false') as text "   {c |}"
	di as text "{c |}     -     {c |}   " as result %10.0g `n_false' "  " %10.0g `n_true' as text "    {c |}  " as result %10.0g (`n_false'+`n_true') as text "   {c |}"
	di as text "{c LT}{hline 11}{c +}{hline 29}{c +}{hline 15}{c RT}"
	di as text "{c |}   Total   {c |}   " as result %10.0g (`p_true'+`n_false') "  " %10.0g (`p_false'+`n_true') as text "    {c |}  " as result %10.0g (`n_false'+`n_true') as text "   {c |}"
	di as text "{c BLC}{hline 11}{c BT}{hline 29}{c BT}{hline 15}{c BRC}"
	di as text "Classified + if predicted Pr(D) >= " as result `final_cut_off'
	di as text "True D defined as " as text "`1'" as text " != 0 "
	di as text ""
	di as text "{hline 42}{c TT}{hline 8}"
	di as text "True Positive Rate              Pr( +| T) {c |} "  as result %3.2f `P_t_pos_rate' as text "%"
	di as text "True Negative Rate              Pr( -|~T) {c |} "  as result %3.2f `P_t_neg_rate' as text "%"
	di as text "Positive predictive value       Pr( T| +) {c |} "  as result %3.2f `P_pos_pred' as text "%"
	di as text "Negative predictive value       Pr(~T| -) {c |} "  as result %3.2f `P_neg_pred' as text "%"
	di as text "{hline 42}{c +}{hline 8}"
	di as text "False positive rate             Pr( +|~T) {c |} "  as result %3.2f `P_f_pos_rate' as text "%"
	di as text "False negative rate             Pr( -| T) {c |} "  as result %3.2f `P_f_neg_rate' as text "%"
	di as text "{hline 42}{c +}{hline 8}"
	di as text "Correctly classified                      {c |} "  as result %3.2f `P_correct' as text "%"
	di as text "{hline 42}{c BT}{hline 8}"


	return scalar p_correct = `P_correct'
	return scalar f_cutoff = `final_cut_off'
	return scalar p_t_pos_rate = `P_t_pos_rate'
	return scalar p_t_neg_rate = `P_t_neg_rate'
	return scalar p_pos_pred = `P_pos_pred'
	return scalar p_neg_pred = `P_neg_pred'
	return scalar p_f_pos_rate = `P_f_pos_rate'
	return scalar p_f_neg_rate = `P_f_neg_rate' 
	if "`max_cutoff'"!="" {
	matrix colnames `Gph' = qtile_n y_pred p_correct p_t_pos_rate p_t_neg_rate p_pos_pred p_neg_pred p_f_pos_rate p_f_neg_rate
	return matrix Gph_results = `Gph'
	}
end 

*************************************************************
