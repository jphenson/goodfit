/*
beta version // inital version to graph several different graphs 

Author: James Patrick Henson ⚙
Email 📧: jphenson1218@Gmail.com 
Github 👨‍💻: https://github.com/jphenson
If you have any issues with the program please report on Github.  
*/
capture program drop goodfit_graph
program define goodfit_graph
	version 15.0
	syntax, [graph(numlist min=1 max=1)] [replay]

	if "`replay'" == "" {
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
	}
	if "`graph'" == "" | `graph' == 1 {
		twoway (connected p_cor y_pred, msymbol(none)) ///
		(connected p_t_pos_r y_pred, msymbol(none)) ///
		(connected p_t_neg_r y_pred, msymbol(none)) , ///
		title(Goodness of fit measures) xtitle("Predicted Outcome") ytitle("Percent") 
	}
	else if `graph' == 2 {
		twoway (connected p_cor y_pred, msymbol(none)) ///
		(connected p_f_pos_r y_pred, msymbol(none)) ///
		(connected p_f_neg_r y_pred, msymbol(none)), ///
		title(Goodness of fit measures) xtitle("Predicted Outcome") ytitle("Percent") 
	}
	else if `graph' == 3 {
		twoway (connected p_cor y_pred, msymbol(none)) ///
		(connected p_pos_p y_pred, msymbol(none)) ///
		(connected p_neg_p y_pred, msymbol(none)), ///
		title(Goodness of fit measures) xtitle("Predicted Outcome") ytitle("Percent")
	}
	else if `graph' == 4 {
		twoway (connected p_cor y_pred, msymbol(none)) ///
		(connected p_t_pos_r y_pred, msymbol(none)) ///
 		(connected p_pos_p y_pred, msymbol(none)) ///
 		(connected p_f_pos_r y_pred, msymbol(none)), ///
		title(Goodness of fit measures) xtitle("Predicted Outcome") ytitle("Percent")
	}
	else if `graph' == 5 {
		twoway (connected p_cor y_pred, msymbol(none)) ///
		(connected p_t_neg_r y_pred, msymbol(none)) ///
 		(connected p_neg_p y_pred, msymbol(none)) ///
 		(connected p_f_neg_r y_pred, msymbol(none)), ///
		title(Goodness of fit measures) xtitle("Predicted Outcome") ytitle("Percent")
	}
end 
