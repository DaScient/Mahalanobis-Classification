################################################
#MahalanobisSnackPack.R
#Don Tadaya
#February 2017
#Arizona State University
#Applied Mathematics in Life & Social Sciences
################################################
#Let's get started...

#setwd 
setwd("/Users/don/Desktop/Mahalanobis")

#getwd
getwd()

############################
#NOTES:
#
#
#
#
############################


#############
#read in data
#############
#For training set
legit_raw <- read.csv("Original_legit_set_for_Mahal.csv", header = TRUE) #tach0-tach78 are the variables, 96 observations
#Each of the 96 observations here come from the same specific dataset of the Mexican 100P currency, in the same direction, from the same sensor. VERY SPECIFIC to it's class. 

cft_raw <- read.csv("Original_cft_set_for_Mahal.csv", header = TRUE) #I won't really be using this much, but its good to see a set of ONLY counterfeits

#######################################
#completed reading in data
#######################################

#Convert each file.csv into a column-matrix
L_matrix <- cbind(legit_raw)    #training matrix
C_matrix <- cbind(cft_raw)      #just to have it...


#Covariances
L_cov <- cov(L_matrix)
C_cov <- cov(C_matrix)

#Inverse
L_inv <- solve(L_cov)
C_inv <- solve(C_cov)


##########################
#Mahalanobis-ness
##########################
#D2 <- mahalanobis(a, b, c)
#a = matrix of observations
#b = colMeans of observations(training)
#c = covariance of observations(training)
##########################
#Calculating Square Distances
##########################
#For training set
D2_Train <- mahalanobis(L_matrix, colMeans(L_matrix), L_cov)  
D2_Train_cft <- mahalanobis(C_matrix, colMeans(C_matrix), C_cov) 
D2_Train_cft_vs_legit <- mahalanobis(C_matrix, colMeans(L_matrix), L_cov) 
##########################
#SET: 1-D array of mahalanobis square distances for each observation.
#D2_Train: This is the target set... legits againsts legits. Think of this as your training vector. It's what we KNOW to be true for this specific class of Mexican 100P's.
#D2_Train_cft: #Counterfeits against itself. 
#D2_Train_cft_vs_legit: #Counterfeits against legits.
##########################

#PLOTTING Train data
plot(density(D2_Train, bw = 0.5),
     main="Squared Mahalanobis Distances (Training), Observations=96, Variables=79") ; rug(D2_Train)
plot(density(D2_Train_cft, bw = 0.5),
     main="Squared Mahalanobis Distances (Counterfeits), Observations=96, Variables=79") ; rug(D2_Train_cft)
plot(density(D2_Train_cft_vs_legit, bw = 0.5),
     main="Squared Mahalanobis Distances (Counterfeits vs Training), Observations=96, Variables=79") ; rug(D2_Train_cft_vs_legit)



################
#Q-Q Plots (Training)
D2_Train_Plot <- qqplot(qchisq(ppoints(100), df = 3), D2_Train,
       main = expression("Q-Q plot of Mahalanobis" * ~D^2 *
                           " vs. quantiles of" * ~ chi[3]^2))


D2_Train_cft_Plot <- qqplot(qchisq(ppoints(100), df = 3), D2_Train_cft,
       main = expression("Q-Q plot of Mahalanobis" * ~D^2 *
                           " vs. quantiles of" * ~ chi[3]^2))


D2_Train_cft_vs_legit_Plot <- qqplot(qchisq(ppoints(100), df = 3), D2_Train_cft_vs_legit,
       main = expression("Q-Q plot of Mahalanobis" * ~D^2 *
                           " vs. quantiles of" * ~ chi[3]^2))

abline(0,1,col='gray')  #I don't get why this is here...

#write D2's into csv.files for quick observations
write.table(D2_Train, file = "D2_Train.csv",row.names=FALSE, na="",col.names=FALSE, sep=",")
write.table(D2_Train_cft, file = "D2_Train_cft.csv",row.names=FALSE, na="",col.names=FALSE, sep=",")
write.table(D2_Train_cft_vs_legit, file = "D2_Train_cft_vs_legit.csv",row.names=FALSE, na="",col.names=FALSE, sep=",")




########TESTING#################TESTING#################TESTING#########
########TESTING#################TESTING#################TESTING#########
########TESTING#################TESTING#################TESTING#########
#Read in Data
test_raw <- read.csv("Mahal_test_includes_variety_against_legit.csv", header = TRUE) #See comment line24.
##########what is test_raw?###########
#This includes training set + random bill information. 
#Total of 135 observations, 75 variables. 
#This basically simulates 135 new observations.
#######################################
#Matrix
Test_matrix <- cbind(test_raw)  #testing matrix

#Covariance
Test_cov <- cov(Test_matrix)

#Inverse Covariance
Test_inv <- solve(Test_cov)

#For test set
D2_Test <- mahalanobis(Test_matrix, colMeans(L_matrix), L_cov)
##########################
#SET: 1-D array of mahalanobis square distances for each observation.
#D2_Test: 135 "new" observations against training-mahalanobis-distance.
##########################

#PLOT THE TEST
plot(density(D2_Test, bw = 0.5),
     main="Squared Mahalanobis Distances ((Test vs Training), Observations=135, Variables=79") ; rug(D2_Test)
################
#This probably didn't graph right because the windows aren't big enough.
#If you set your windows right, you'll see how far off the 
#"Counterfeits + New" data is when their mahalanobis distances 
#are compared to the legitimate bills from the training data.
################################
#Q-Q Plots (Testing)
D2_Test_Plot <- qqplot(qchisq(ppoints(100), df = 3), D2_Test,
                       main = expression("Q-Q plot of Mahalanobis" * ~D^2 *
                                           " vs. quantiles of" * ~ chi[3]^2))
abline(0,1,col='gray')

write.table(D2_Test, file = "D2_Test.csv",row.names=FALSE, na="",col.names=FALSE, sep=",")

