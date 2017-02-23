# Mahalanobis-Classification

~Defintions~
[Observations]: These observations are from sensor data collected from bill acceptors of Mexican currency. 
Each observation represents one accepted note. 
Sensor calibrations and formatting of data are preserved and processed before creation of the usable .csv files/data. 
[Variables]: Each raw observation is an array of 114 integers. These integers represent light (visible light or infrared) feedback from a specific sensor. I truncated the 114-integer arrays to 79ish in order to respect Mahalanobis parameter requirements (i.e. matrix transformations). This is why we see 96 observations, 79 variables. In order for Mahalanobis to be implement, there must be more obs than vars. 
[legit]: Legitimate bills collected. 
[cft]: Counterfeit bills collected. 

*Note*
I will think about adding these raw collected data.csv's for your pleasure. 
But for now to show Mahalanobis in action, this package will work. 
*ADDED... see below.*

~Datasets~
[Original_legit_set_for_Mahal.csv]: contains 96 observations with 79 variables each. 
[Original_cft_set_for_Mahal.csv]: contains 96 observations with 79 variables each. 
[Mahal_test_includes_variety_against_legit.csv]: contains 135 observations with 79 variables each. Includes the training in addition to counterfeit and other data collected from different sensors. 


~R language~
[L_matrix]: "Original_legit_set_for_Mahal" binded by columns. this basically means that R reads comma-separator's in the .csv as column entities per line(observation). This converts the .csv(consisting 96 observations of 79 variables) into a [96x79 matrix]. 
[C_matrix]: same as above, but for counterfeit instead of legit bills. 
[L_cov]: Covariance matrix of L_matrix. This returns a [79x79 square matrix].
[C_cov]: Covariance matrix of C_matrix. This returns a [79x79 square matrix].
[L_inv]: Inverse-Covariance. inv(matrix) of L_cov. Also returns a [79x79 square matrix].
[C_inv]: Inverse-Covariance. inv(matrix) of C_cov. Also returns a [79x79 square matrix].

*Mahalanobis stuff!*
[D2_Train]: ~Legits vs Legits~  This computes the Mahalanobis Distance for each entitity and returns a single dimensional array of the Square Distances. 
[D2_Train_cft]: ~Cft's vs Cft's~ 
[D2_Train_cft_vs_legit]: ~Cft's vs Legits~

*Analyse the D2 tables for each. You'll see how the legit D2's are calculated and what happens if we run counterfeits against the mean and cov(Legits). 

We can see how this does against our [Testing Set]
~Testing~
[test_raw]: #This includes training set + random bill information. Total of 135 observations, 79 variables. 
This basically simulates 135 new observations.
[Test_matrix]: "Mahal_test_includes_variety_against_legit". 135 observations, 79 variables.  
[Test_cov]: Covariance matrix of Test_matrix. This returns a [79x79 square matrix].
[Test_inv]: Inverse-Covariance. inv(matrix) of Test_cov. Also returns a [79x79 square matrix].

[D2_Test]: You'll notice here the last 39 entities stick out because they are very Mahalanobis-distant from the trained set (legits).

_______________________________________________________________________________________________
Raw data files for your pleasure.
Here I added .csv data consisting of scans of the same currency, same denomination. Different sensors (First Column: 1-8), Different directions (LD, LU, RD, RU). 

In order to create a training set for analysis (like for the Mahalanobis Classification), you need to note that each Sensor is unique to each Direction. 

[TACHS. csv]: Is simply a header for your own use. I use it just in case I have to open the files using Excel. It is automatically applied as the header, which makes locating/counting the variables (tachs) much easier. 

Creating target-columns
[C_string_appendor]: is a program that appends a new column of {C}'s to each entity. This helps for machine learning algorithms that require 'target values'. Counterfeit or Check data tagging. 
[L_string_appendor]: is a program that appends a new column of {L}'s to each entity. This helps for machine learning algorithms that require 'target values'.  Legit data tagging. 

HAVE FUN!
_______________________________________________________________________________________________
#Done

