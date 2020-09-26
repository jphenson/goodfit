/*
goodfit Example 2

This example uses goodfit to produce some results graphs
The data comes from the website for "Microeconometrics using Stata" by Cameron and Trivedi
http://cameron.econ.ucdavis.edu/musbook/mus.html
Author: James Patrick Henson ⚙
Email: jphenson1218@Gmail.com 
Github: https://github.com/jphenson
Website: https://jphenson.me
If you have any issues with the program please report on Github.  
*/
clear all
use http://cameron.econ.ucdavis.edu/musbook/mus14data.dta, clear
logit ins retire hstatusg hhincome educyear married white hisp chronic adl
predict double L_hat
sum L_hat
goodfit ins L_hat, max_cutoff n_quart(100)
mat R = r(Gph_results)
clear
svmat R, names(col) 
label var p_cor "% correct"
label var p_t_pos_r "True Positive Rate"
label var p_t_neg_r "True Negative Rate"
label var p_pos_p "Positive predictive value"
label var p_neg_p "Negative predictive value"
label var p_f_pos_r "False positive rate" 
label var p_f_neg_r "False negative rate"

twoway (connected p_cor y_pred, msymbol(none)) ///
	 (connected p_t_pos_r y_pred, msymbol(none)) ///
	 (connected p_t_neg_r y_pred, msymbol(none)) , ///
	 title(Goodness of fit measures) xtitle("Predicted Outcome") ytitle("Percent") 
	 
twoway (connected p_cor y_pred, msymbol(none)) ///
	(connected p_f_pos_r y_pred, msymbol(none)) ///
	(connected p_f_neg_r y_pred, msymbol(none)), ///
	title(Goodness of fit measures) xtitle("Predicted Outcome") ytitle("Percent") 

twoway (connected p_cor y_pred, msymbol(none)) ///
	(connected p_pos_p y_pred, msymbol(none)) ///
	(connected p_neg_p y_pred, msymbol(none)), ///
	title(Goodness of fit measures) xtitle("Predicted Outcome") ytitle("Percent")

twoway (connected p_cor y_pred, msymbol(none)) ///
	(connected p_t_pos_r y_pred, msymbol(none)) ///
 	(connected p_pos_p y_pred, msymbol(none)) ///
 	(connected p_f_pos_r y_pred, msymbol(none)), ///
	title(Goodness of fit measures) xtitle("Predicted Outcome") ytitle("Percent")

twoway (connected p_cor y_pred, msymbol(none)) ///
	(connected p_t_neg_r y_pred, msymbol(none)) ///
 	(connected p_neg_p y_pred, msymbol(none)) ///
 	(connected p_f_neg_r y_pred, msymbol(none)), ///
	title(Goodness of fit measures) xtitle("Predicted Outcome") ytitle("Percent")
