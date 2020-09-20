# goodfit

__goodfit__ -- Takes the predicted results from a binary outcome model and displays goodness of fit measures.  

Syntax
----------

__**goodfit**__ [, true_y(string) y_pred(string) cutoff(integer) max_cutoff n_quart(integer)]  

Description
----------

This program is intended to be used with any binary outcome model such as but not limited to probit, logit, logistic, or lasso. It takes the predicted outcome and provides a summary table for the goodness of fit. The program took inspiration from __estat classification__ , but is not limited by model choice and provides an approximate estimate of the optimal positive cutoff threshold. The predicted outcomes of binary models are often between 0 or 1. The positive cutoff threshold is the point that maximizes the correct number of positive outcomes (outcome = 1).   

Example
---------
<img src="https://raw.githubusercontent.com/jphenson/goodfit/master/files/example_table.png" alt="Image 1" title="Example 1" width="50%" height="50%" />  



Options
----------

__true_y__  provides variable name of the the original outcomes variable.

__y_pred__ provides variable name of the the predicted outcome variable.  

__cutoff__ provides the positive cutoff threshold if __max_cutoff__ is not used. The default number is set to 0.5.

__max_cutoff__ approximates the optimal positive cutoff threshold by a grid search using quartiles of the predicted outcome as estimation points. The default number of quartiles is 50.

__n_quart__ Allow the user to set the number of quartiles overriding  the default 50.  

Stored results
----------

__goodfit__ stores the following in __r()__:  

Scalars
----------

__r(p_correct)__ percent correctly classified  
__r(f_cutoff)__ final cutoff value  
__r(p_neg_pred)__ negative predictive value  
__r(p_pos_pred)__ positive predictive value  
__r(p_t_pos_rate)__ true positive rate  
__r(p_t_neg_rate)__ true negative rate  
__r(p_f_pos_rate)__ false positive rate  
__r(p_f_neg_rate)__ false negative rate 
