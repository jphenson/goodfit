---
title: "goodfit"
date: \today
author: "James Patrick Henson"
bibliography: "goodfit.bib"
csl: "https://raw.githubusercontent.com/citation-style-language/styles/master/annual-reviews-author-date.csl"
link-citations: true
urlcolor: "blue"
---
# goodfit

__goodfit__ -- Takes the predicted results from a binary outcome model and displays goodness of fit measures.  

Syntax
----------

__goodfit__ [*true_y*] [*y_pred*] [if] [,  cutoff(integer) max_cutoff n_quart(integer) mcc_graph roc_graph pr_graph]  

Description
----------

This program is intended to be used with any binary outcome model such as but not limited to probit, logit, logistic, or lasso. It takes the predicted outcome and provides a summary table for the goodness of fit. The program took inspiration from __estat classification__ , but is not limited by model choice and provides an approximate estimate of the optimal positive cutoff threshold using the Matthews Correlation Coefficient (MCC). In the area machine learning with binary classification the Matthews Correlation Coefficient (MCC) is the preferred single metric, especially for imbalanced data [@chicco2020advantages][@boughorbel2017optimal]. The metric ranges $[-1,1]$ and takes on the value of zero if the prediction is the same as a random guess. A MCC value of one indicates perfect prediction of true positives (TP), true negatives (TN), false negatives (FN), and false positives (FP). MCC is defined as follows

$$ MCC = \frac{TP×TN-FP×FN}{\sqrt{(TP+FP)×(TP+FN)×(TN+FP)×(TN+FN)}} $$ 

It another metric is preferred use the __cutoff__ option and the return results to test another measure. 

Example Table
---------
<img src="https://raw.githubusercontent.com/jphenson/goodfit/master/files/example_table.png" alt="Image 1" title="Example 1" width="50%" height="50%" />  

Example Graphs
---------

### Goodness of Fit Measures with Optimal MCC Cutoff

<img src="https://raw.githubusercontent.com/jphenson/goodfit/master/files/mcc_graph.svg" alt="Graph 1" title="Example Graph" width="50%" height="50%" />  

### ROC Graph

<img src="https://raw.githubusercontent.com/jphenson/goodfit/master/files/roc_graph.svg" alt="Graph 1" title="Example Graph" width="50%" height="50%" />  

### PR Graph 

<img src="https://raw.githubusercontent.com/jphenson/goodfit/master/files/pr_graph.svg" alt="Graph 1" title="Example Graph" width="50%" height="50%" />  

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

__pr_graph__ Graphs the precision-recall (PRC) curve and is considered a better measure than ROC with imbalanced data [@saito2015precision]. It also calculates the area under the curve to help in model comparison. 

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

## References
