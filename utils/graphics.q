// Import needed libraries
plt:.p.import`matplotlib.pyplot
np:.p.import`numpy
itertools:.p.import`itertools
rocCurve:roc
display:{x y;}.p.import[`kxpy.kx_backend_inline;`:display]


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


displayROCcurve:{[y;yPredProb]

    // calculating the roc curve and appending it to a dictionary
    rocdict:`frp`tpr`x!rocCurve[y;yPredProb];
    // calculating the auc value
    rocAuc:auc[rocdict`frp; rocdict`tpr];


    lw:2;
    plt[`:plot][rocdict`frp;rocdict`tpr;`color pykw "darkorange";`lw pykw lw;`label pykw "ROC curve (Area = ",string[rocAuc]," )"];
    plt[`:plot][0 1;0 1;`color pykw "navy";`lw pykw lw;`linestyle pykw "--"];

    // customising the plot
    plt[`:xlim][0 1];
    plt[`:ylim][0 1.05];
    plt[`:xlabel]["False Positive Rate"];
    plt[`:ylabel]["True Positive Rate"];
    plt[`:title]["Reciever operating characteristic example"];
    plt[`:legend][`loc pykw "upper left"];
    plt[`:show][];
 }


displayCM:{[cm;classes;title;cmap]
    
    if[cmap~();cmap:plt`:cm.Blues];
    subplots:plt[`:subplots][`figsize pykw 10 10];
    fig:subplots[`:__getitem__][0];
    ax:subplots[`:__getitem__][1];

    ax[`:imshow][cm;`interpolation pykw `nearest;`cmap pykw cmap];
    ax[`:set_title][`label pykw title];
    tickMarks:til count classes;
    ax[`:xaxis.set_ticks][tickMarks];
    ax[`:set_xticklabels][classes];
    ax[`:yaxis.set_ticks][tickMarks];
    ax[`:set_yticklabels][classes];

    thresh:(max raze cm)%2;
    shp:shape cm;
    {[cm;thresh;i;j] plt[`:text][j;i;(string cm[i;j]);`horizontalalignment pykw `center;`color pykw $[thresh<cm[i;j];`white;`black]]}[cm;thresh;;]. 'cross[til shp[0];til shp[1]];
    plt[`:xlabel]["Predicted Label";`fontsize pykw 12];
    plt[`:ylabel]["Actual label";`fontsize pykw 12];
    fig[`:tight_layout][];
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
