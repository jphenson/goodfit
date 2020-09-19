/*
goodfit Example 1 

This example uses Stata's built in data auto.dta to produce some simple examples

Author: James Patrick Henson ⚙
Email: jphenson1218@Gmail.com 
Github: https://github.com/jphenson
Website: https://jphenson.me
If you have any issues with the program please report on Github.  
*/
clear all
sysuse auto

qui probit foreign price mpg length
predict probit_hat
// creating a goodfit table with a set cutoff point 0.5 
goodfit, true_y(foreign) y_pred(probit_hat) cutoff(0.5) 
// goodfit with the max_cutoff option finds the optimal cutoff point 
// to maximize % correct. 
goodfit, true_y(foreign) y_pred(probit_hat) max_cutoff

// The cutoff point can be input from as a local for special cases or 
// if you need to iterate to optimize another characteristic
// Here the mean of the predicted outcome is used as a cutoff point
sum probit_hat
local probit_hat_mu = r(mean)
goodfit, true_y(foreign) y_pred(probit_hat) cutoff(`probit_hat_mu')

goodfit, true_y(foreign) y_pred(probit_hat) max_cutoff
// In cases where more accuracy is a concern the number of quartile 
// can be set higher than the default = 50
goodfit, true_y(foreign) y_pred(probit_hat) max_cutoff n_quart(100)

// The results of goodfit can be stored to create comparisons across models. 
qui reg foreign price mpg length
predict ols_hat
goodfit, true_y(foreign) y_pred(probit_hat) max_cutoff
scalar prob_correct = r(p_correct)
goodfit, true_y(foreign) y_pred(ols_hat) max_cutoff
scalar ols_correct = r(p_correct)
di as text "probit % correct: " as result %3.2f prob_correct as text "%"
di as text "ols % correct: " as result %3.2f ols_correct as text "%"
