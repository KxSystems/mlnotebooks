# Example notebooks

Throughout the machine learning notebooks we showcase the benefits of using Embedpy and JupyterQ to solve a range of machine learning problems, from feature engineering to the training and testing models.

EmbedPy allows users to access the rich eco-system of machine learning and visual libraries available in Python, while JupyterQ allows users to display results in a range of ways, giving a better undertanding of the data and results produced using kdb+/q.

The contents of the notebooks are as follows:

1. **Decision Trees**: A decision tree is trained to detect if a patient has either benign or malignant cancer. The performance of the model is measured by computing a confusion matrix and ROC curve.

2. **Random Forests**: Random forest and XGBoost classifiers are trained to identify satisfied and unsatisfied bank clients. Different parameters are tuned and tested and the classifier performance is evaluated using the ROC curve.

3. **Neural Networks**: A neural network is trained to identify handwritten digits in a set of training images. Once the neural network has been trained, the performance is measured on the test dataset and different plots are used to show the results.

4. **Dimensionality Reduction**: Principal Component Analysis (PCA) and t-distributed Stochastic Neighbor Embedding (t-SNE) are used to try and reduce the dimensionality of the original dataset. Several plots are also employed to visualize the obtained reduced features and infer whether they are able to catch differences between the distict groups present in the data.

5. **Feature Engineering**: Examples of data preprocessing, such as feature scaling and one-hot categorical encoding, that can highly affect the performance of a model are demonstrated. The robustness of different scalers against KNN are demonstrated in the first part of the notebook while in a second part, the importance of one-hot encoding labels when training a neural network is shown.

6. **Feature Extraction and Selection**: 3 examples are provided explaining how to effectively use the FRESH (FeatuRe Extraction and Scalable Hypothesis testing) algorithm to extract features and determine how significant each feature is in predicting a target vector. Random forest are train in the first and third examples, which a gradient boosting model is used in the second.

7. **Cross Validation**: Different cross validation methods are used with a random forest classifer to see how results compare across the methods when classifying breast cancer data.

8. **Natural Language Processing**: Parsing, clustering, sentiment analysis and outlier detection are demonstated on a range of corpora, including the novel *Moby Dick*, the emails of the Enron CEOs, and the 2014 IEEE Vast Challenge articles.

9. **K Nearest Neighbours**: The basic steps to follow in a standard machine learning problem previous to final model training are performed: features are scaled, data is split into training and test datasets and parameter tuning is done by measuring accuracy of a K-Nearest Neighbours model for different values of parameter K.

## Requirements 

- kdb+>=? v3.5 64-bit
- Python 3.x
- [embedPy](https://github.com/KxSystems/embedPy)
- [JupyterQ](https://github.com/KxSystems/jupyterq)
- [NLP library](https://github.com/KxSystems/nlp) (v0.1.2)
- [ML-Toolkit](https://github.com/KxSystems/ml) (v0.3.x)

### Dependencies

Install the Python dependencies with

pip
```bash
pip install -r requirements.txt
```
or with conda
```bash
conda install --file requirements.txt
```
**N.B.** Additionally, [graphviz](http://www.graphviz.org/download/) must be installed on the system running the notebooks.

## Docker

A prebuilt docker image is available with all the dependencies installed. If you have [Docker installed](https://www.docker.com/community-edition) run it with:

	docker run -it -p 8888:8888 --name mymlnotebooks kxsys/mlnotebooks

Now point your browser at http://localhost:8888/tree/notebooks/

For subsequent runs, you will not be prompted to redo the license setup when calling:

	docker start -ai mymlnotebooks


**N.B.** [build instructions for the image are available](docker/README.md)
