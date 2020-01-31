.ml.loadfile`:util/init.q

/ import libraries
plt:.p.import`matplotlib.pyplot
.p.import[`mpl_toolkits.mplot3d]`:Axes3D;
itertools:.p.import`itertools
display:{x y;}.p.import[`kxpy.kx_backend_inline;`:display]

/ graphics functions

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
     plt[`:text][j;i;string cm[i;j];`horizontalalignment pykw`center;`color pykw $[thresh<cm[i;j];`white;`black]]
     }[cm;thresh;;]. 'cross[til shape 0;til shape 1];
    plt[`:xlabel]["Predicted Label";`fontsize pykw 12];
    plt[`:ylabel]["Actual label";`fontsize pykw 12];
    fig[`:tight_layout][];
    plt[`:show][];}


displayROC:{[y;yPredProb]

    rocval:`frp`tpr!.ml.roc[y;yPredProb];
    rocauc:.ml.rocaucscore[y;yPredProb];

    plt[`:plot][rocval`frp;rocval`tpr;`color pykw`darkorange;`lw pykw 2;`label pykw"ROC (Area = ",string[rocauc],")"];
    plt[`:plot][0 1;0 1;`color pykw`navy;`lw pykw 2;`linestyle pykw"--"];

    plt[`:xlim]0 1;
    plt[`:ylim]0 1.05;
    plt[`:xlabel]"False Positive Rate";
    plt[`:ylabel]"True Positive Rate";
    plt[`:title]"Reciever operating characteristic example";
    plt[`:legend][`loc pykw "lower right"];
    plt[`:show][];}


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


plotGridSequences:{[sequences;labels;text;title]
        
    subplots:plt[`:subplots][4;4];
    fig:subplots[`:__getitem__][0];
    axarr::subplots[`:__getitem__][1];
    fig[`:set_figheight;12];
    fig[`:set_figwidth;15];
    shp:shape sequences;
    
    {[sequences;labels;shp;text;x;y]
      rdlabel:rand shp[0];  
      box:axarr[`:__getitem__].p.eval","sv string x,y;
      box[`:plot][sequences[rdlabel]];
      box[`:set_title]$[text~();[string labels[rdlabel]];text[labels[rdlabel]]];
     }[sequences;labels;shp;text;;]. 'cross[til 4;til 4];

    fig[`:suptitle;title;`fontsize pykw 16];
    plt[`:tight_layout][];
    fig[`:subplots_adjust][`top pykw 0.92];
    plt[`:show][];

 }


plotAccXent:{[metrics]
    
    subplots:plt[`:subplots][1;2];
    fig:subplots[`:__getitem__][0];
    axarr:subplots[`:__getitem__][1];
    box0:axarr[`:__getitem__][0];
    box1:axarr[`:__getitem__][1];

    fig[`:set_figheight;8];
    fig[`:set_figwidth;15];

    box0[`:plot][metrics[`:get;<;`acc];"r--"];
    box0[`:plot][metrics[`:get;<;`val_acc];"b"];
    box0[`:set_title]["Accuracy"];
    box0[`:set_ylabel]["Accuracy %"];
    box0[`:set_ylabel]["Epoch"];

    box1[`:plot][metrics[`:get;`loss];"r--"];
    box1[`:plot][metrics[`:get;`val_loss];"b"];
    box1[`:set_title]["Cross Entropy"];
    box1[`:set_ylabel]["Cross Entropy"];
    box1[`:set_ylabel]["Epoch"];
        
    plt[`:legend][`train`test;`loc pykw "right"];
    plt[`:show][];
 }

plotprxpred:{
    plt[`:close][]`;
    plt[`:figure][`figsize pykw (15 5)]`;
    plt[`:title][`$"Next day close price prediction"];
    plt[`:plot][x;"r";`label pykw `$"real value"]`;
    plt[`:plot][y;"k--";`label pykw `$"predicted value"]`;
    plt[`:legend][]`;
    plt[`:xlim][200;300]`;
    plt[`:xlabel]["Random predicted date"];
    plt[`:ylabel]["Close Price"];
    plt[`:show][]`;
 }


/plotting function
/* x = algo e.g.`hc`ward`cure`dbscan
/* y = data
/* z = inputs for the cluster functions
plotcluster:{[x;y;z]$[x~`ward;plotw[x;y;z];plotcl[x;y;z]]}

/plot ward or dbscan
plotw:{
 s:.z.t;
 r:$[b:x~`ward;.ml.clust.hc;.ml.clust.dbscan][y;]. z;
 t:.z.t-s;
 $[2<count first y;[fig:plt[`:figure][];ax::fig[`:add_subplot][111;`projection pykw"3d"]];ax::plt];
 {ax[`:scatter]. flip x}each exec pts by clt from r;
 plt[`:title]"df/lf: e2dist/",string[x]," - ",string t;
 plt[`:show][];}

/plot hierarchical, kmeans or cure
plotcl:{[x;y;z]
 $[b::2<count first y;fig::plt[`:figure][];
  [subplots::plt[`:subplots]. ud[x;0];fig::subplots[@;0];axarr::subplots[@;1]]];
 $[x~`hc;fig[`:set_size_inches;18.5;13];fig[`:set_size_inches;18.5;8.5]];
 fig[`:subplots_adjust][`hspace pykw .5];
 {[a;d;f;i]
  if[b;ax:fig[`:add_subplot][;;i+1;`projection pykw"3d"]. ud[a]0];
  s:.z.t;r:ud[a;1][d]. f;t:.z.t-s;
  j:@[;i]cross[;]. til each ud[a]0;
  if[not b;ax:$[a in`kmeans`dbscan;axarr[@;i];axarr[@;j 0][@;j 1]]];
  {x[`:scatter]. flip y}[ax]each exec pts by clt from r;
  ax[`:set_title]ud[a;2;f]," - ",string t;
  }[x;y]'[z;til count z];
 plt[`:show][];}

/utils dictionary for plothkc
ud:`hc`cure`kmeans`dbscan!(enlist each(6 3;2 3;1 4;1 3)),'
 (.ml.clust.hc;.ml.clust.cure;.ml.clust.kmeans;.ml.clust.dbscan),'
 ({"df/lf: ",string[x 1],"/",string [x 2],$[x[2]in`complete`average;"";"/",string[x 3],"b"]};
  {"df/C: ",string[x[2;`df]],"/",string[x[2;`b]],"b"};{"df: ",string x 3};{"df: ",string x 0})

/plot clusters, dendrogram or both for hierarchical
/* d  = data points
/* k  = number of clusters
/* df = distance metric
/* lf = linkage function
/* f  = flag: `cluster`dgram or () to plot both
plot:{[d;k;df;lf;f]
 if[b:f~();f:`both];
 subplots:plt[`:subplots][;]. dgrami f;
 fig::subplots[@;0];axarr::subplots[@;1];
 fig[`:set_size_inches;18.5;8.5];
 if[b|f~`cluster;cl:.ml.clust.hc[d;k;df;lf;1b];
   {x[`:scatter]. flip y}[$[b;axarr[@;0];plt]]each exec pts by clt from cl];
 if[b|f~`dgram;dm:.ml.clust.dgram[d;df;lf];hc[`:dendrogram]flip value flip dm];
 plt[`:show][];}

/input dictionary for plot
dgrami:`cluster`dgram`both!(1 1;1 1;1 2)
/ scipy samples
hc:.p.import`scipy.cluster.hierarchy

/ final notebook
featurebarplot:{[d]
 sub:plt[`:subplots].(1;n:count cd:cols d),`gridspec_kw pykw enlist[`wspace]!enlist 0.1;
 fig:sub[@;0];axs:sub[@;1];
 ax:{x[@;y]}[axs]each tn:til n;
 fig[`:set_figheight;7];
 fig[`:set_figwidth;20];
 {[d;c;a]
  g:kg!g kg:asc key g:count each group d c;
  a[`:bar][i:til cg:count g;value g];
  a[`:set_xticks]i;
  a[`:set_xticklabels]$[15<cg;"";string key g];
  a[`:set_xlabel][c;`fontsize pykw 15];
  a[`:set_ylabel]["no. of entries";`fontsize pykw 15];
  a[`:label_outer][];}[d]'[cd;ax];
 plt[`:show][];}