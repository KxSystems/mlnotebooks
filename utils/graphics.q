\d .util

// @kind function
// @category util
// @fileoverview Import Python functions
plt:.p.import`matplotlib.pyplot
.p.import[`mpl_toolkits.mplot3d]`:Axes3D;
itertools:.p.import`itertools
display:{x y;}.p.import[`kxpy.kx_backend_inline;`:display]

// @kind function
// @category util
// @fileoverview Plot a confusion matrix
// @param cm {num[][]} Values of a confusion matrix
// @param classes {sym} Classes of a confusion matrix
// @param title {str} Title of the plot
// @param cmap {<} Colour map
// @returns {<} A plotted confusion matrix
displayCM:{[cm;classes;title;cmap] 
  if[cmap~();cmap:plt`:cm.Blues];
  subplots:plt[`:subplots][`figsize pykw 5 5];
  fig:subplots[`:__getitem__][0];
  ax:subplots[`:__getitem__][1];
  ax[`:imshow][cm;`interpolation pykw`nearest;`cmap pykw cmap];
  ax[`:set_title][`label pykw title];
  tickMarks:til count classes;
  ax[`:xaxis.set_ticks]tickMarks;
  ax[`:set_xticklabels]classes;
  ax[`:yaxis.set_ticks]tickMarks;
  ax[`:set_yticklabels]classes;
  thresh:max[raze cm]%2;
  shape:.ml.shape cm;
  {[cm;thresh;i;j]
     plt[`:text][j;i;string cm[i;j];`horizontalalignment pykw`center;
       `color pykw $[thresh<cm[i;j];`white;`black]]
     }[cm;thresh;;]. 'cross[til shape 0;til shape 1];
  plt[`:xlabel]["Predicted Label";`fontsize pykw 12];
  plt[`:ylabel]["Actual label";`fontsize pykw 12];
  fig[`:tight_layout][];
  plt[`:show][];
  }

// @kind function
// @category util
// @fileoverview Plot an ROC curve
// @param y {num[];bool[]} Label associated with a prediction
// @param yPredProb {float[]} Probability that each prediction belongs to 
//   the positive class
// @returns {<} A plotted ROC curve
displayROC:{[y;yPredProb]
  rocval:`frp`tpr!.ml.roc[y;yPredProb];
  rocauc:.ml.rocAucScore[y;yPredProb];
  plt[`:plot][rocval`frp;rocval`tpr;`color pykw`darkorange;`lw pykw 2;
    `label pykw"ROC (Area = ",string[rocauc],")"];
  plt[`:plot][0 1;0 1;`color pykw`navy;`lw pykw 2;`linestyle pykw"--"];
  plt[`:xlim]0 1;
  plt[`:ylim]0 1.05;
  plt[`:xlabel]"False Positive Rate";
  plt[`:ylabel]"True Positive Rate";
  plt[`:title]"Reciever operating characteristic example";
  plt[`:legend][`loc pykw "lower right"];
  plt[`:show][];
  }

// @kind function
// @category util
// @fileoverview Plot an accuracy and MSE plot
// @param accuracy {} The accuracy score
// @param valAccuracy {} The validation accuracy score
// @param loss {} The loss score
// @param valLoss {} The validation loss score
// @returns {<} A plotted accuracy and MSE plot
plotAccMSE:{[accuracy;valAccuracy;loss;valLoss]
  subplots:plt[`:subplots][1;2];
  fig:subplots[`:__getitem__]0;
  axarr:subplots[`:__getitem__]1;
  box0:axarr[`:__getitem__]0;
  box1:axarr[`:__getitem__]1;
  fig[`:set_figheight;8];
  fig[`:set_figwidth;15];
  box0[`:plot][accuracy;"r--"];
  box0[`:plot][valAccuracy;"b"];
  box0[`:set_title]`Accuracy;
  box0[`:set_ylabel]"Accuracy %";
  box0[`:set_xlabel]`Epoch;
  box1[`:plot][loss;"r--"];
  box1[`:plot][valLoss;"b"];
  box1[`:set_title]["Mean-Squared Error"];
  box1[`:set_ylabel]["MSE"];
  box1[`:set_xlabel]["Epoch"];    
  plt[`:legend][`train`test;`loc pykw "right"];
  plt[`:show][];
  }

// @kind function
// @category util
// @fileoverview Plot the price predictions
// @param true {num[]} True values
// @param pred {num[]} Predicted values
// @returns {<} The prices predictions plotted
plotPrxPred:{[true;pred]
  plt[`:close][]`;
  plt[`:figure][`figsize pykw (15 5)]`;
  plt[`:title][`$"Next day close price prediction"];
  plt[`:plot][true;"r";`label pykw `$"real value"]`;
  plt[`:plot][pred;"k--";`label pykw `$"predicted value"]`;
  plt[`:legend][]`;
  plt[`:xlim][200;300]`;
  plt[`:xlabel]["Random predicted date"];
  plt[`:ylabel]["Close Price"];
  plt[`:show][]`;
  }

// @kind function
// @category misc
// @fileoverview Plot a time series
// @param dt     {num[]} The timeframe of the timeseries
// @param series {num[]} The values of the timeseries
// @param label  {string} Plot label
// @return {<} The time series plotted
plotTimeSeries:{[dt;series;label]
  plt[`:plot][q2pydts dt;series];
  plt[`:xlabel]["Date"];
  plt[`:ylabel][label];
  plt[`:title][label," vs Date"];
  plt[`:xticks][q2pydts dt .ml.arange[0;count dt;50]];
  plt[`:show][];
  }

// @kind function
// @category util
// @fileoverview Plot the predicted and true values of a forecasting series
// @param pred {num[]} Predicted values
// @param true {num[]} True values
// @return {<} The predicted vs true values plotted
plotPredTrue :{[pred;true]
  {plt[`:plot][x];}each(pred;true);
  plt[`:legend][`preds`true];
  plt[`:xlabel]["Time in hours"];
  plt[`:ylabel]["Bike Shares"];
  plt[`:title][" Bike Shares vs Time in hours"];
  plt[`:show][];
  }

// @kind function
// @category util
// @fileoverview Plot the residual errors as a function of forecasting series
// @param true {num[]} True values
// @param pred {num[]} Predicted values
// @param idx {long} The indices to plot
// @return {<} The residuals plotted 
plotResiduals:{[true;pred;idx]
  plt[`:plot][idx;true-pred];
  plt[`:legend][enlist`residuals];
  plt[`:xlabel]["Time in hours"];
  plt[`:ylabel]["Residuals"];
  plt[`:title]["Residuals vs Time in hours"];
  plt[`:show][];
  }

// @kind function
// @category util
// @fileoverview Plot results in scatter plot
// @param trn {float[][]} Data points in value flip format
// @param tst {float[][]} Data points in value flip format
// @param ttl {string}    Plot title
// @param clt {long[]}    List of cluster labels
// @param s {boolean}   Indicates whether to show plot or not
// @return {<} The scatter plot
plotResults:{[trn;tst;ttl;clt;s]
  $[clt~(::);
    plt[`:scatter]. trn;
    plt[`:scatter][;;`c pykw clt]. trn];
  if[not tst~();
    plt[`:scatter][;;`c pykw`r;`label pykw"Testing data"]. tst;
    plt[`:legend][`bbox_to_anchor pykw 1.05 1;`loc pykw"upper left"]
    ];
  plt[`:title]ttl;
  plt[`:xlabel]"X";
  plt[`:ylabel]"Y";
  if[s;plt[`:show][];
    ];
  }

// @kind function
// @category util
// @fileoverview Plot new dataset
// @param trn {float[][]} Data points in value flip format
// @param ttl {string}    Plot title
// @return {<} The scatter plot
plotDataset:plotResults[;();;::;1b]

// @kind function
// @category util
// @fileoverview Plot clusters from single dataset
// @param trn {float[][]} Data points in value flip format
// @param ttl {string} Plot title
// @param clt {long[]} List of cluster labels
// @return {<} The scatter plot
plotCluster:plotResults[;();;;1b]

// @kind function
// @category util
// @fileoverview Plot clusters for training and testing data
// @param trn {float[][]} Data points in value flip format
// @param tst {float[][]} Data points in value flip format
// @param ttl {string}    Plot title
// @param clt {long[]}    List of cluster labels
// @return  {<} The scatter plot
plotTrainTest:plotResults[;;;;1b]

// @kind function
// @category util
// @fileoverview Plot kmeans and add cluster centres
// @param trn {float[][]} Data points in value flip format
// @param r1 {dict} kmeans fitted cluster
// @param r2 {dict} kmeans fitted cluster
// @param ttl {string} Plot title
// @return {<} The kmeans values and centres plotted
plotKMeans:{[trn;r1;r2;ttl]
  r1:r1`modelInfo;
  r2:r2`modelInfo;
  plotResults[trn;();ttl;;0b]$[(::)~r2;r1`clust;r2`clust];
  plt[`:scatter][;;`c pykw"#ff028d";`marker pykw"*";`s pykw 500;
    `label pykw"Original centres"]. flip r1`repPts;
  if[not(::)~r2;
    plt[`:scatter][;;`c pykw"#21fc0d";`marker pykw"*";`s pykw 500;
      `label pykw"Updated centres"]. flip r2`repPts];
  plt[`:legend][`bbox_to_anchor pykw 1.05 1;`loc pykw"upper left"];
  plt[`:show][];
  }

// Plot clusters and dendrogram
// @param d {float[][]} Data points
// @param lf {sym} Linkage function
// @param dend {dict} Results of HC algo
// @param clust{long[]} Clusters - results of HC cut function
// @return {<} The HC results plotted
plotHCResults:{[d;lf;dend;clust]
  dend:dend`modelInfo;
  // initialize subplots
  subplots:plt[`:subplots][1;2];
  fig::subplots[@;0];axarr::subplots[@;1];
  fig[`:set_size_inches;18.5;8.5];
  // set plot title
  ttl:@[string lf;0;upper];
  // plot clusters
  a0:axarr[@;0];
  a0[`:scatter][;;`c pykw clust`clust]. d;
  a0[`:set_title]ttl," Clustered Data";
  a0[`:set_xlabel]"X";
  a0[`:set_ylabel]"Y";
  // plot dendrogram using scipy functionality
  .p.import[`scipy.cluster;`:hierarchy;`:dendrogram]flip value flip dend`dgram;
  plt[`:title]ttl," Dendrogram";
  plt[`:xlabel]"Point Index";
  plt[`:ylabel]"Distance";
  plt[`:show][];
  }
