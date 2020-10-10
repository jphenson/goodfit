{smcl}

{title:Title}

{p 4 4 2}
{bf:goodfit} -- Takes the predicted results from a binary outcome model and displays goodness of fit measures.


{title:Syntax}

{p 4 4 2}
{bf:goodfit} [*true_y*] [*y_pred*] [if] [,  cutoff(integer) max_cutoff n_quart(integer) mcc_graph roc_graph pr_graph]

{title:}


{title:Description}

{p 4 4 2}
This program is intended to be used with any binary outcome model such as but not limited to probit, logit, logistic, or lasso. It takes the predicted outcome and provides a summary table for the goodness of fit. The program took inspiration from {bf:estat classification} , but is not limited by model choice and provides an approximate estimate of the optimal positive cutoff threshold using the Matthews Correlation Coefficient (MCC). In the area machine learning with binary classification the Matthews Correlation Coefficient (MCC) is the preferred single metric, especially for imbalanced data (Chicco & Jurman 2020)(Boughorbel et al. 2017). The metric ranges $[-1,1]$ and takes on the value of zero if the prediction is the same as a random guess. A MCC value of one indicates perfect prediction of true positives (TP), true negatives (TN), false negatives (FN), and false positives (FP). MCC is defined as follows

{p 4 4 2}
MCC = (TP×TN-FP×FN) / sqrt((TP+FP)×(TP+FN)×(TN+FP)×(TN

{p 4 4 2}
It another metric is preferred use the {bf:cutoff} option and the return results to test another measure.


{title:Variables}

{p 4 4 2}
{bf:true_y} the variable name of the original outcomes variable.

{p 4 4 2}
{bf:y_pred} the variable name of the predicted outcome variable. 


{title:Options}

{p 4 4 2}
{bf:cutoff} the positive cutoff threshold if {bf:max_cutoff} is not used. The default number is set to 0.5.

{p 4 4 2}
{bf:max_cutoff} approximates the optimal positive cutoff threshold by a grid search using quartiles of the predicted outcome as estimation points. The default number of quartiles is 50.

{p 4 4 2}
{bf:n_quart} Allow the user to set the number of quartiles overriding the default 50.

{p 4 4 2}
{bf:mcc_graph} Graphs several goodness of fit measures including MCC over range of potential cutoffs points for the predicted outcome measure.

{p 4 4 2}
{bf:roc_graph} Graphs receiver operating characteristic curve (ROC) which places true positive rate on the y-axis and false positive rate on the x-axis. It also calculates the area under the curve to help in model comparison.

{p 4 4 2}
{bf:pr_graph} Graphs the precision-recall (PRC) curve and is considered a better measure than ROC with imbalanced data (Saito & Rehmsmeier 2015). It also calculates the area under the curve to help in model comparison.

{p 4 4 2}
{bf:Note} : If {bf:cutoff} is not used then {bf:max_cutoff} is required


{title:Examples}


{title:Stored results}

{p 4 4 2}
{bf:goodfit} stores the following in {bf:r()}:


{title:Scalars}
{bf:r(MCC)} estimated max MCC value    {break}
{bf:r(p_correct)} percent correctly classified    {break}
{bf:r(f_cutoff)} final cutoff value    {break}
{bf:r(p_neg_pred)} negative predictive value    {break}
{bf:r(p_pos_pred)} positive predictive value    {break}
{bf:r(p_t_pos_rate)} true positive rate    {break}
{bf:r(p_t_neg_rate)} true negative rate    {break}
{bf:r(p_f_pos_rate)} false positive rate    {break}
{bf:r(p_f_neg_rate)} false negative rate    {break}


{title:Matrices}

{p 4 4 2}
{bf:e(Gph_results)} Contains the results each quartile estimation    {break}


{title:Macros}

{p 4 4 2}
{bf:r(y_pred_str)} Contains the name of the predicted outcome variable.    {break}
{bf:r(y_outcome_str)} Contains the name of the true outcome variable.    {break}


{title:Issues}

{p 4 4 2}
If there are any issues or suggestions with the program than please report the with the following steps:

{p 4 4 2}
If you have a Github account..     {break}
{break}    1. Go to the {bf:goodfit} Github repository issue page  {browse "https://github.com/jphenson/goodfit/issues":https://github.com/jphenson/goodfit/issues}    {break}
{break}    2. Click the green button labeled "New issue"    {break}
{break}    3. Submit your issue or suggestion.

{p 4 4 2}
If you do not have a Github account please email me at  {browse "mailto:jphenson1218@gmail.com":jphenson1218@gmail.com}.     {break}


{title:Authors}

{p 4 4 2}
James Patrick Henson    {break}
Georgia State University    {break}
Federal Reserve Bank of Atlanta    {break}
Atlanta, GA USA    {break}
{browse "mailto:jphenson1218@gmail.com":jphenson1218@gmail.com}     {break}
{browse "http://jphenson.me":Website}    {break}
{browse "https://github.com/jphenson":Github}    {break}


{title:References}

{p 4 4 2}
Boughorbel S, Jarray F, El-Anbari M. 2017. Optimal classifier for imbalanced data using matthews correlation coefficient metric. PloS one. 12(6):e0177678

{p 4 4 2}
Chicco D, Jurman G. 2020. The advantages of the matthews correlation coefficient (mcc) over f1 score and accuracy in binary classification evaluation. BMC genomics. 21(1):6

{p 4 4 2}
Saito T, Rehmsmeier M. 2015. The precision-recall plot is more informative than the roc plot when evaluating binary classifiers on imbalanced datasets. PloS one. 10(3):e0118432


