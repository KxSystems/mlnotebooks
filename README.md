# Kx Machine Learning Notebooks

The example machine learning notebooks demonstrate the benefits of using kdb+/q alongside the Kx interfaces embedPy and JupyterQ, the Kx Natural Language Processing (NLP), Machine Learning Toolkit (ML-Toolkit) and Automated Machine Learning libraries. These notebooks showcase how to solve a range of machine learning problems, from feature engineering and neural network design to the model training and testing.

## embedPy

embedPy is part of the fusion for kdb+ initiative and allows the application of Python functions on kdb+ data within a q process. Python and kdb+/q developers can leverage the benefits of both technologies, pairing kdb+’s high-speed analytics with Python’s rich ecosystem of machine learning libraries including but not limited to scikit-learn, matplotlib and Tensorflow.

## JupyterQ

JupyterQ is also part of the fusion for kdb+ initiative and provides users with a kdb+ kernel for the Jupyter project. This kernel allows users to create Jupyter Notebooks and additionally to leverage JupyterHub and JupyterLab. These technologies are ubiquitous within the data science community.

## NLP

The Kx NLP library can be used to answer a variety of questions about unstructured text and can therefore be used to preprocess text data in preparation for model training. Input text data, in the form of emails, tweets, articles or novels, can be transformed to vectors, dictionaries and symbols which can be handled very effectively by q.

## ML-Toolkit

The toolkit contains libraries and scripts that provide kdb+/q users with general-use functions and procedures to perform machine-learning tasks on a wide variety of datasets. This includes utility functions, the FRESH (FeatuRe Extraction and Scalable Hypothesis testing) algorithm, cross validation and grid search procedures, clustering algorithms, time series forecasting models and feature engineering functions.

## AutoML

The Automated Machine Learning framework provides users with the ability to automate the process of applying machine learning techniques to real-world problems in kdb+/q. The pipeline comprises preprocessing, feature engineering, cross validation, model selection, hyperparameter tuning and report generation. As shown in the associated notebook, this framework is designed to be flexible to users with both novice and expert kdb+ or machine learning engineers alike.

## Notebooks
The contents of the notebooks are as follows:

1. **Decision Trees**: A decision tree is trained to detect if a patient has either benign or malignant cancer. The performance of the model is measured by computing a confusion matrix and ROC curve.

2. **Random Forests**: Random forest and XGBoost classifiers are trained to identify satisfied and unsatisfied financial clients. Different parameters are tuned and tested, with classifier performance evaluated using the ROC curve.

3. **Neural Networks**: A neural network is trained to identify samples of handwritten digits from the MNIST database. Performance is calculated for a test set of images, with a variety of plots used to show the results.

4. **Dimensionality Reduction**: Principal Component Analysis (PCA) and t-distributed Stochastic Neighbor Embedding (t-SNE) are used to reduce the dimensionality of the original dataset. Several plots are used to visualize reduced features and infer differences between the distinct groups present in the data.

5. **Feature Engineering**: Examples of data preprocessing that can highly affect the performance of a model are demonstrated. The first section of the notebook focuses on the robustness of different scalers against k-nearest neighbours, while the second section demonstrates the importance of one-hot encoding labels when training a neural network.

6. **Feature Extraction and Selection**: The three examples provided explain how to effectively use the FRESH (FeatuRe Extraction and Scalable Hypothesis testing) algorithm to extract features and determine how significant each feature is in predicting a target vector. The examples make use of both random forest and gradient boosting models.

7. **Cross Validation**: Cross validation procedures are demonstrated against a random forest classifier, with the aim of classifying breast cancer data. Results produced for the different cross validation methods available in the toolkit are compared.

8. **Natural Language Processing**: Parsing, clustering, sentiment analysis and outlier detection are demonstrated on a range of corpora, including the novel Moby Dick, the emails of the Enron CEOs and the 2014 IEEE Vast Challenge articles.

9. **K-Nearest Neighbours**: The notebook details the steps to follow in a machine learning problem, prior to model training. These include feature scaling, data splitting and parameter tuning - performed by measuring the accuracy of a k-nearest neighbours model for different values of parameter k.

10. **Automated Machine Learning**: The notebook looks at predicting how likely a telecommunications customer is to churn based on behaviour. The data and associated target is used throughout the notebook and is passed into the AutoML pipeline in both its default configuration and custom user-defined configuration, with the steps in the pipeline explained throughout.

11. **Clustering**: Examples of how to use the k-means, DBSCAN, affinity propagation, hierarchical and CURE algorithms available within the ML-Toolkit are provided. The notebook demonstrates how to effectively visualize results produced and make use of scoring functions contained within the toolkit. A real-world application is also included.

12. **Time Series Forecasting**: The notebook looks at a variety of time series forecasting models contained within the ML-Toolkit such as AR, ARIMA and SARIMA models along with time series specific feature engineering tools for passing time series data to supervised machine learning models.

## Requirements 

- kdb+>=? v3.5 64-bit
- Python 3.x
- [embedPy](https://github.com/KxSystems/embedPy)
- [JupyterQ](https://github.com/KxSystems/jupyterq)
- [NLP library](https://github.com/KxSystems/nlp) (v0.1.2)
- [ML-Toolkit](https://github.com/KxSystems/ml) (v0.3.x)
- [AutoML](https://github.com/KxSystems/automl) (v.0.1.0)

## Dependencies

Install the Python dependencies with

pip
```bash
pip install -r requirements.txt
```
or with conda
```bash
conda install --file requirements.txt
```

**N.B.** Additionally the following must be installed to ensure that all the notebooks can be run correctly.

1. [graphviz](http://www.graphviz.org/download/) must be installed on the system running the notebooks.
2. xgboost must be installed via either conda using the following command `conda install -c anaconda py-xgboost` or using the instructions provided here https://xgboost.readthedocs.io/en/latest/build.html

## Docker

A prebuilt docker image is available with all the dependencies installed. If you have [Docker installed](https://www.docker.com/community-edition) run it with:

	docker run -it -p 8888:8888 --name mymlnotebooks kxsys/mlnotebooks

Now point your browser at http://localhost:8888/tree/notebooks/

For subsequent runs, you will not be prompted to redo the license setup when calling:

	docker start -ai mymlnotebooks


**N.B.** [build instructions for the image are available](docker/README.md)
