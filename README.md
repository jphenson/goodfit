# goodfit  

![badge](https://img.shields.io/badge/goodfit-v1.3-green)
![badge](https://img.shields.io/badge/stata-v15.0-blue.svg?logo=data:image/png;base64,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)


__goodfit__ -- Takes the predicted results from a binary outcome model and displays goodness of fit measures.  

Syntax
----------

__goodfit__ [*true_y*] [*y_pred*] [if] [,  cutoff(integer) max_cutoff n_quart(integer) mcc_graph roc_graph pr_graph]  

Description
----------

This program is intended to be used with any binary outcome model such as but not limited to probit, logit, logistic, or lasso. It takes the predicted outcome and provides a summary table for the goodness of fit. The program took inspiration from __estat classification__ , but is not limited by model choice and provides an approximate estimate of the optimal positive cutoff threshold using the Matthews Correlation Coefficient (MCC). In the area machine learning with binary classification the Matthews Correlation Coefficient (MCC) is the preferred single metric, especially for imbalanced data (Chicco & Jurman 2020)(Boughorbel et al. 2017). The metric ranges $[-1,1]$ and takes on the value of zero if the prediction is the same as a random guess. A MCC value of one indicates perfect prediction of true positives (TP), true negatives (TN), false negatives (FN), and false positives (FP). MCC is defined as follows

<center><img src="http://latex.codecogs.com/svg.latex?&space;MCC&space;=&space;\frac{TP\times&space;TN-FP\times&space;FN}{\sqrt{(TP&plus;FP)\times&space;(TP&plus;FN)\times&space;(TN&plus;FP)\times&space;(TN&plus;FN)}}" title="http://latex.codecogs.com/svg.latex? MCC = \frac{TP\times TN-FP\times FN}{\sqrt{(TP+FP)\times (TP+FN)\times (TN+FP)\times (TN+FN)}}" /></center>

It another metric is preferred use the __cutoff__ option and the return results to test another measure. There are two example do files under the folder named examples to produce the tables and graphs below. 

Example Table
---------
<center><img src="https://raw.githubusercontent.com/jphenson/goodfit/master/files/example_table.png" alt="Image 1" title="Example 1" width="50%" height="50%" /></center>  

Example Graphs
---------

### Goodness of Fit Measures with Optimal MCC Cutoff

<center><img src="https://raw.githubusercontent.com/jphenson/goodfit/master/files/mcc_graph.svg" alt="Graph 1" title="Example Graph" width="60%" height="60%" /></center>  

### ROC Graph

<center><img src="https://raw.githubusercontent.com/jphenson/goodfit/master/files/roc_graph.svg" alt="Graph 1" title="Example Graph" width="60%" height="60%" /></center>

### PR Graph 

<center><img src="https://raw.githubusercontent.com/jphenson/goodfit/master/files/pr_graph.svg" alt="Graph 1" title="Example Graph" width="60%" height="60%" /></center>  

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

Boughorbel S, Jarray F, El-Anbari M. 2017. Optimal classifier for imbalanced data using matthews correlation coefficient metric. PloS one. 12(6):e0177678

Chicco D, Jurman G. 2020. The advantages of the matthews correlation coefficient (mcc) over f1 score and accuracy in binary classification evaluation. BMC genomics. 21(1):6

Saito T, Rehmsmeier M. 2015. The precision-recall plot is more informative than the roc plot when evaluating binary classifiers on imbalanced datasets. PloS one. 10(3):e0118432
