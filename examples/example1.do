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
// to maximize MCC. 
goodfit foreign logit_hat, max_cutoff
// The cutoff point can be input from another numeric variable for special cases or 
// if you need to iterate to optimize another characteristic such as false positive rate. 
// Here the mean of the predicted outcome is used as a cutoff point. 
sum logit_hat
local logit_hat_mu = r(mean)
goodfit foreign logit_hat, cutoff(`logit_hat_mu')

