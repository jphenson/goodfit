{smcl}

{title:Title}

{p 4 4 2}
{bf:goodfit} -- Takes the predicted results from a binary outcome model and displays goodness of fit measures.


{title:Syntax}

{p 4 4 2}
{bf:{ul:goodfit}} [, true_y(string) y_pred(string) cutoff(integer) max_cutoff n_quart(integer)]

{title:}


{title:Description}

{p 4 4 2}
This program is intended to be used with any binary outcome model such as but not limited to probit, logit, logistic, or lasso. It takes the predicted outcome and provides a summary table for the goodness of fit. The program took inspiration from {bf:estat classification} , but is not limited by model choice and provides an approximate estimate of the optimal positive cutoff threshold. The predicted outcomes of binary models are often between 0 or 1. The positive cutoff threshold is the point that maximizes the correct number of positive outcomes (outcome = 1).    {break}


{title:Options}

{p 4 4 2}
{bf:true_y} the variable name of the original outcomes variable.

{p 4 4 2}
{bf:y_pred} the variable name of the predicted outcome variable.    {break}

{p 4 4 2}
{bf:cutoff} the positive cutoff threshold if {bf:max_cutoff} is not used. The default number is set to 0.5.

{p 4 4 2}
{bf:max_cutoff} approximates the optimal positive cutoff threshold by a grid search using quartiles of the predicted outcome as estimation points. The default number of quartiles is 50.

{p 4 4 2}
{bf:n_quart} Allow the user to set the number of quartiles overriding the default 50.


{title:Examples}


{title:Stored results}

{p 4 4 2}
{bf:goodfit} stores the following in {bf:r()}:


{title:Scalars}

{p 4 4 2}
{bf:r(p_correct)} percent correctly classified    {break}
{bf:r(f_cutoff)} final cutoff value    {break}
{bf:r(p_neg_pred)} negative predictive value    {break}
{bf:r(p_pos_pred)} positive predictive value    {break}
{bf:r(p_t_pos_rate)} true positive rate    {break}
{bf:r(p_t_neg_rate)} true negative rate    {break}
{bf:r(p_f_pos_rate)} false positive rate    {break}
{bf:r(p_f_neg_rate)} false negative rate    {break}


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



