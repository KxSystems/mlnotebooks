# Example notebooks

Embedpy and jupyterq can be used to solve all kind of machine learning problems, from feature engineering to the training and testing of models. They also allow users to display results in a range of ways, giving a better undertanding of the data and results.

The following notebooks provide examples that bring together these concepts and show what can be achieved:

* **ML01 Neural Networks**: A neural network is trained to identify handwritten digits in a set of training images. Once the neural network has been trained, the performance is measured on the test dataset and different plots are used to show the results.
* **ML02 Dimensionality Reduction**: Principal Component Analysis (PCA) and t-distributed Stochastic Neighbor Embedding (t-SNE) are used to try and reduce the dimensionality of the original dataset. Several plots are also employed to visualize the obtained reduced features and infer whether they are able to catch differences between the distict groups present in the data.
* **ML03 K-Nearest Neighbours**: The basic steps to follow in a standard machine learning problem previous to final model training are performed: features are scaled, data is split into training and test datasets and parameter tuning is done by measuring accuracy of a K-Nearest Neighbours model for different values of parameter K.
* **ML04 Feature Engineering**: Details of data preprocessing that can highly affect the performance of a model like selecting the best scaler and one-hot encoding categorical variables. The robustness of different scalers against KNN is demonstrated in the first part of the notebook while in a second part, the importance of one-hot encoding labels when training a neural network is shown.
* **ML05 Decision Trees**: A decision tree is trained to detect if a patient has either benign or malignant cancer. The performance of the model is measured by computing the confusion matrix and the ROC curve.
* **ML06 Random Forests**: Random Forest and XGBoost classifiers are trained to identify satisfied and unsatisfied bank clients. Different parameters are tuned and tested and the classifier performance is evaluated using the ROC curve.
* **ML07 Natural Language Processing**: Parsing, clustering, sentiment analysis and outlier detection are demonstated on a range of corpora, including the novel *Moby Dick*, the emails of the Enron CEOs, and the 2014 IEEE Vast Challenge articles.

## Requirements 
- kdb+>=? v3.5 64-bit
- Anaconda Python 3.x
- [embedPy](https://github.com/KxSystems/embedPy)
- [jupyterq](https://github.com/KxSystems/jupyterq)
- [nlp library](https://github.com/KxSystems/nlp)

#### Dependencies
Install the Python dependencies with

pip
```bash
pip install -r requirements.txt
```
or with conda
```bash
conda install --file requirements.txt
```
**N.B.** Graphviz requires to be installed with conda and pip. Please check this [notebook](https://github.com/KxSystems/mlnotebooks/blob/master/notebooks/ML05%20Decision%20Trees.ipynb) for further details. 

## Docker
A prebuilt docker image is available with all the dependencies installed. If you have [Docker installed](https://www.docker.com/community-edition) run it with:

	docker run -it -p 8888:8888 --name mymlnotebooks kxsys/mlnotebooks

Now point your browser at http://localhost:8888/tree/notebooks/

For subsequent runs, you will not be prompted to redo the license setup when calling:

	docker start -ai mymlnotebooks


**N.B.** [build instructions for the image are available](docker/README.md)

