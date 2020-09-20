/*
version 1.0 // inital version

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
	syntax , [true_y(string)] [y_pred(string)] [cutoff(numlist min=1 max=1)] [max_cutoff] [n_quart(numlist min=1 max=1)]
	capture drop P_model
	tempvar P_model 
	qui {

	if "`max_cutoff'"!="" {
		if "`n_quart'" == "" {
			local num_quarts = 50
		}
		else {
			local num_quarts = `n_quart'
		}
		tabstat `y_pred', statistics(min max)  save
		mat C = r(StatTotal)
		scalar C_min = C[1,1]
		scalar C_max = C[2,1]
		_pctile `y_pred', nq(`num_quarts')
		forvalues qi = 1/`num_quarts' {
			scalar q_`qi' = r(r`qi')
			di q_`qi'
		}
		forvalues qi = 1/`num_quarts' {
			di "quartile `qi' is " as result q_`qi'
			gen P_model = 0 
			replace P_model = 1 if `y_pred'>= q_`qi'
			replace P_model = . if `y_pred'== . //  not including missing values
			gen P_pos_true = 0
			replace P_pos_true = 1 if P_model ==1 & `true_y' ==1 
			gen P_neg_true = 0
			replace P_neg_true = 1 if P_model ==0 & `true_y' ==0 
			gen P_pos_false = 0
			replace P_pos_false = 1 if P_model ==1 & `true_y' ==0
			gen P_neg_false = 0
			replace P_neg_false = 1 if P_model ==0 & `true_y' ==1
			tabstat P_pos_true P_neg_true P_pos_false P_neg_false, statistics(sum) 			  varwidth(20) c(s) save
			mat A = r(StatTotal)
			scalar p_true = A[1,1] // a
			scalar n_true = A[1,2] // d
			scalar p_false = A[1,3] // b
			scalar n_false = A[1,4] // c
			scalar P_correct_`qi' = ((p_true+n_true)/(p_true+n_true+p_false+n_false))*			  100
			drop P_model P_pos_true P_neg_true P_pos_false P_neg_false
			if `qi' == 1 {
				local cutoff_temp = q_`qi'
				local max_Pcorr_temp = P_correct_`qi'
			}
			if `qi' != 1 & P_correct_`qi' > `max_Pcorr_temp' {
				local cutoff_temp = q_`qi'
				local max_Pcorr_temp = P_correct_`qi' 
			}
		}	
	}
	gen P_model = 0 
	if "`max_cutoff'"!="" {
		replace P_model = 1 if `y_pred'>=`cutoff_temp'
		local final_cut_off = `cutoff_temp'
	}
	else {
		replace P_model = 1 if `y_pred'>=`cutoff'
		local final_cut_off = `cutoff'
	}
	replace P_model = . if `y_pred'== . //  not including missing values
	gen P_pos_true = 0
	replace P_pos_true = 1 if P_model ==1 & `true_y' ==1 
	gen P_neg_true = 0
	replace P_neg_true = 1 if P_model ==0 & `true_y' ==0 
	gen P_pos_false = 0
	replace P_pos_false = 1 if P_model ==1 & `true_y' ==0
	gen P_neg_false = 0
	replace P_neg_false = 1 if P_model ==0 & `true_y' ==1
	tabstat P_pos_true P_neg_true P_pos_false P_neg_false, statistics(sum) varwidth(20) c(s) save
	mat A = r(StatTotal)
	scalar p_true = A[1,1] // a
	scalar n_true = A[1,2] // d
	scalar p_false = A[1,3] // b
	scalar n_false = A[1,4] // c
	scalar P_correct = ((p_true+n_true)/(p_true+n_true+p_false+n_false))*100
	scalar P_sens = ((p_true)/(p_true+n_false))*100
	scalar P_spec = ((n_true)/(p_false+n_true))*100
	scalar P_pos_pred = ((p_true)/(p_true+p_false))*100
	scalar P_neg_pred = ((n_true)/(n_true+n_false))*100
	scalar P_f_pos_rate = ((p_false)/(p_false+n_true))*100
	scalar P_f_neg_rate = ((n_false)/(n_false+p_true))*100
	drop P_model P_pos_true P_neg_true P_pos_false P_neg_false
	}
	di as text "Best cutoff was " as result `cutoff_temp'
	di as text "Correctly classified " as result `max_Pcorr_temp' as text "% at cutoff " as result `cutoff_temp'
	di as text ""
	di as text "{hline 11}{c TT}{hline 8}True Condition{hline 7}{c TT}{hline 15}"
	di as text "Predicted  {c |}          T           ~T     {c |}      Total"
	di as text "Condition  {c |}                             {c |}           "
	di as text "{hline 11}{c +}{hline 29}{c +}{hline 15}"
	di as text "     +     {c |}   " as result %10.0g p_true "  " %10.0g p_false as text "    {c |}  " as result %10.0g (p_true+p_false)
	di as text "     -     {c |}   " as result %10.0g n_false "  " %10.0g n_true as text "    {c |}  " as result %10.0g (n_false+n_true)
	di as text "{hline 11}{c +}{hline 29}{c +}{hline 15}"
	di as text "   Total   {c |}   " as result %10.0g (p_true+n_false) "  " %10.0g (p_false+n_true) as text "    {c |}  " as result %10.0g (n_false+n_true)
	di as text ""
	di as text "Classified + if predicted Pr(D) >= " as input `final_cut_off'
	di as text "True D defined as `true_y' != 0 "
	di as text ""
	di as text "{hline 42}{c TT}{hline 8}"
	di as text "True Positive Rate              Pr( +| T) {c |} "  as result %3.2f P_t_pos_rate as text "%"
	di as text "True Negative Rate              Pr( -|~T) {c |} "  as result %3.2f P_t_neg_rate as text "%"
	di as text "Positive predictive value       Pr( T| +) {c |} "  as result %3.2f P_pos_pred as text "%"
	di as text "Negative predictive value       Pr(~T| -) {c |} "  as result %3.2f P_neg_pred as text "%"
	di as text "{hline 42}{c +}{hline 8}"
	di as text "False positive rate             Pr( +|~T) {c |} "  as result %3.2f P_f_pos_rate as text "%"
	di as text "False negative rate             Pr( -| T) {c |} "  as result %3.2f P_f_neg_rate as text "%"
	di as text "{hline 42}{c +}{hline 8}"
	di as text "Correctly classified                      {c |} "  as result %3.2f P_correct as text "%"
	di as text "{hline 42}{c BT}{hline 8}"

	return scalar p_correct = P_correct
	return scalar f_cutoff = `final_cut_off'
	return scalar p_t_pos_rate = P_t_pos_rate
	return scalar p_t_neg_rate = P_t_neg_rate
	return scalar p_pos_pred = P_pos_pred
	return scalar p_neg_pred = P_neg_pred
	return scalar p_f_pos_rate = P_f_pos_rate
	return scalar p_f_neg_rate = P_f_neg_rate
end 

*************************************************************
