/*
goodfit Example 2

This example uses goodfit to produce some results graphs and compare models
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
predict L_hat
reg ins retire hstatusg hhincome educyear married white hisp chronic adl
predict lpm_hat
cloglog ins retire hstatusg hhincome educyear married white hisp chronic adl
predict cll_hat
** Getting the goodfit measure to compare across models
goodfit ins L_hat, max_cutoff
scalar log_pc=r(p_correct)
scalar log_mcc=r(MCC)
goodfit ins lpm_hat, max_cutoff 
scalar lpm_pc=r(p_correct)
scalar lpm_mcc=r(MCC)
goodfit ins cll_hat, max_cutoff 
scalar cll_pc=r(p_correct)
scalar cll_mcc=r(MCC)

// Comparing the different models
di "[percent correct, MCC] logit model: [" log_pc " , " log_mcc " ]" _n ///
"[percent correct, MCC] linear probability model: [" lpm_pc " , " lpm_mcc " ]" _n ///
"[percent correct, MCC] cloglog model: [" cll_pc " , " cll_mcc " ]" _n 
// Interesting cloglog had the highest percent correct, while the linear probability model had the highest MCC value.

// Lets graph the lpm and cloglog to see the differences. 

** increasing the number of quartiles to improve precision of the graphs 
qui goodfit ins lpm_hat, max_cutoff  n_quart(100) mcc_graph
qui goodfit ins cll_hat, max_cutoff  n_quart(100) mcc_graph

// Looking at the ROC curve as another measure of comparison 
qui goodfit ins lpm_hat, max_cutoff  n_quart(100) roc_graph

qui goodfit ins cll_hat, max_cutoff  n_quart(100) roc_graph


// Looking at the PRcurve as another measure of comparison 
qui goodfit ins lpm_hat, max_cutoff  n_quart(100) pr_graph

qui goodfit ins cll_hat, max_cutoff  n_quart(100) pr_graph


// If a custom graph is desired it can be created from the returned results 
preserve
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
	 
restore 
