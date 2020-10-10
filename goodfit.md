Title
===========================

__goodfit__ -- Takes the predicted results from a binary outcome model and displays goodness of fit measures.

Syntax
----------

__goodfit__ [*true_y*] [*y_pred*] [if] [,  cutoff(integer) max_cutoff n_quart(integer) mcc_graph roc_graph pr_graph]

---

Description
----------

This program is intended to be used with any binary outcome model such as but not limited to probit, logit, logistic, or lasso. It takes the predicted outcome and provides a summary table for the goodness of fit. The program took inspiration from __estat classification__ , but is not limited by model choice and provides an approximate estimate of the optimal positive cutoff threshold using the Matthews Correlation Coefficient (MCC). In the area machine learning with binary classification the Matthews Correlation Coefficient (MCC) is the preferred single metric, especially for imbalanced data (Chicco & Jurman 2020)(Boughorbel et al. 2017). The metric ranges $[-1,1]$ and takes on the value of zero if the prediction is the same as a random guess. A MCC value of one indicates perfect prediction of true positives (TP), true negatives (TN), false negatives (FN), and false positives (FP). MCC is defined as follows

MCC = (TP×TN-FP×FN) / sqrt((TP+FP)×(TP+FN)×(TN+FP)×(TN+FN))

It another metric is preferred use the __cutoff__ option and the return results to test another measure.

Variables
----------

__true_y__ the variable name of the original outcomes variable.

__y_pred__ the variable name of the predicted outcome variable. 

Options
---------- 

__cutoff__ the positive cutoff threshold if __max_cutoff__ is not used. The default number is set to 0.5.

__max_cutoff__ approximates the optimal positive cutoff threshold by a grid search using quartiles of the predicted outcome as estimation points. The default number of quartiles is 50.

__n_quart__ Allow the user to set the number of quartiles overriding the default 50.

__mcc_graph__ Graphs several goodness of fit measures including MCC over range of potential cutoffs points for the predicted outcome measure.

__roc_graph__ Graphs receiver operating characteristic curve (ROC) which places true positive rate on the y-axis and false positive rate on the x-axis. It also calculates the area under the curve to help in model comparison.

__pr_graph__ Graphs the precision-recall (PRC) curve and is considered a better measure than ROC with imbalanced data (Saito & Rehmsmeier 2015). It also calculates the area under the curve to help in model comparison.

__Note__ : If __cutoff__ is not used then __max_cutoff__ is required

Examples
----------

Stored results
----------

__goodfit__ stores the following in __r()__:

Scalars
----------
__r(MCC)__ estimated max MCC value  
__r(p_correct)__ percent correctly classified  
__r(f_cutoff)__ final cutoff value  
__r(p_neg_pred)__ negative predictive value  
__r(p_pos_pred)__ positive predictive value  
__r(p_t_pos_rate)__ true positive rate  
__r(p_t_neg_rate)__ true negative rate  
__r(p_f_pos_rate)__ false positive rate  
__r(p_f_neg_rate)__ false negative rate  

Matrices
----------

__e(Gph_results)__ Contains the results each quartile estimation  

Macros
----------

__r(y_pred_str)__ Contains the name of the predicted outcome variable.  
__r(y_outcome_str)__ Contains the name of the true outcome variable.  

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

References
----------

Boughorbel S, Jarray F, El-Anbari M. 2017. Optimal classifier for imbalanced data using matthews correlation coefficient metric. PloS one. 12(6):e0177678

Chicco D, Jurman G. 2020. The advantages of the matthews correlation coefficient (mcc) over f1 score and accuracy in binary classification evaluation. BMC genomics. 21(1):6

Saito T, Rehmsmeier M. 2015. The precision-recall plot is more informative than the roc plot when evaluating binary classifiers on imbalanced datasets. PloS one. 10(3):e0118432