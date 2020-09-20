Title
===========================

__goodfit__ -- Takes the predicted results from a binary outcome model and displays goodness of fit measures.

Syntax
----------

__**goodfit**__ [, true_y(string) y_pred(string) cutoff(integer) max_cutoff n_quart(integer)]

---

Description
----------

This program is intended to be used with any binary outcome model such as but not limited to probit, logit, logistic, or lasso. It takes the predicted outcome and provides a summary table for the goodness of fit. The program took inspiration from __estat classification__ , but is not limited by model choice and provides an approximate estimate of the optimal positive cutoff threshold. The predicted outcomes of binary models are often between 0 or 1. The positive cutoff threshold is the point that maximizes the correct number of positive outcomes (outcome = 1).  

Options
----------

__true_y__ the variable name of the original outcomes variable.

__y_pred__ the variable name of the predicted outcome variable.  

__cutoff__ the positive cutoff threshold if __max_cutoff__ is not used. The default number is set to 0.5.

__max_cutoff__ approximates the optimal positive cutoff threshold by a grid search using quartiles of the predicted outcome as estimation points. The default number of quartiles is 50.

__n_quart__ Allow the user to set the number of quartiles overriding the default 50.

Examples
----------

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

Issues
----------

If there are any issues or suggestions with the program than please report the with the following steps:

If you have a Github account..   
1. Go to the __goodfit__ Github repository issue page [https://github.com/jphenson/goodfit/issues](https://github.com/jphenson/goodfit/issues)  
2. Click the green button labeled "New issue"  
3. Submit your issue or suggestion.

If you do not have a Github account please email me at [jphenson1218@gmail.com](mailto:jphenson1218@gmail.com).   

Authors
----------

James Patrick Henson  
Georgia State University  
Federal Reserve Bank of Atlanta  
Atlanta, GA USA  
[jphenson1218@gmail.com](mailto:jphenson1218@gmail.com)   
[Website](http://jphenson.me)  
[Github](https://github.com/jphenson)  

