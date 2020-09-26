/*
goodfit Example 1 

This example uses Stata's built in data auto.dta and simulation data
to produce some simple examples

Author: James Patrick Henson ⚙
Email: jphenson1218@Gmail.com 
Github: https://github.com/jphenson
Website: https://jphenson.me
If you have any issues with the program please report on Github.  
*/
clear all
sysuse auto
logit foreign rep78 weight turn gear_ratio
predict double logit_hat
sum logit_hat
// creating a goodfit table with a set cutoff point 0.2
goodfit foreign logit_hat, cutoff(0.2) 
// goodfit with the max_cutoff option finds the approximate optimal cutoff point 
// to maximize % correct. 
goodfit foreign logit_hat, max_cutoff
// The cutoff point can be input from another numeric variable for special cases or 
// if you need to iterate to optimize another characteristic such as false positive rate. 
// Here the mean of the predicted outcome is used as a cutoff point. 
sum logit_hat
local logit_hat_mu = r(mean)
goodfit foreign logit_hat, cutoff(`logit_hat_mu')

// In cases where more accuracy of the optimal cutoff is a concern  
// the number of quartile can be set higher than the default = 50
// Let setup a small dataset with enough observation to make a difference
clear all
set seed 1234 
local N = 1000
set obs `N'
gen x1 = rnormal()
gen x2 = rnormal()
gen u = rnormal()
gen c = 0 + 2*x1 + 3*x2 + u
gen pr_c = 1/ (1+exp(-c))
gen y= rbinomial(`N',pr_c)
logit y x1 x2 
predict y_hat
goodfit y y_hat, max_cutoff 
// The returned values can be used to compare to other model or specifications
scalar l1=r(p_correct)
goodfit y y_hat, max_cutoff n_quart(200)
scalar l2=r(p_correct)
reg y x1 x2 
predict ols_hat
goodfit y ols_hat, max_cutoff 
scalar ols1=r(p_correct)
goodfit y ols_hat, max_cutoff n_quart(200)
scalar ols2=r(p_correct)
// Comparing the two logit models against the ols models
// with different number of quartiles 
di "percent correct" _n "first logit model: " l1 _n "second logit model: " l2 _n ///
"first ols model: " ols1 _n "second ols model: " ols2 
