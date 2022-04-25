# Anomaly-Detection-Log-Files

This project was completed as part of data 586 (Advanced Machine Learning) at UBC Okanagan. The goal of the project was to develop supervised machine learning models to perform anomaly detection in log files. We chose to work with the [HDFS_1](https://github.com/logpai/loghub/tree/master/HDFS) file.  To parse 
the file, we used the [Drain](https://github.com/logpai/logparser/tree/master/logparser/Drain) method which split the log messages into forty-eight different event 
types. We then made an event count matrix and used the frequency of the event types as predictors 
for whether an anomaly had occurred in a block. Because we were focused on predicting anomalies 
as well as possible, we tuned both a gradient boosting model and a random forest on 80% of the 
data using 5-fold cross-validation. Both models achieved high F1 scores on the test data, indicating 
that both performed well. However, the random forest was superior and achieved a recall score of 
1 on the test data, indicating that it classified all anomalies correctly.
