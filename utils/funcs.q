shape:{-1_count each first scan x} 
traintestsplit:{[x;y;sz]`xtrain`ytrain`xtest`ytest!raze(x;y)@\:/:(0,floor n*1-sz)_neg[n]?n:count x};
/ one hot encode
eye:{neg[til x]rotate'x#enlist 1,(x-1)#0};
onehot:{("f"$eye[count d])(d:asc distinct x)?x}
accuracy:{[actual;pred]sum[pred=actual]%count pred}
cfm:{[preds;labels]
 classes:asc distinct labels;
 :exec 0^(count each group pred)classes by label 
  from([]pred:preds;label:labels);
 }
round:{y*"j"$x%y}
range:{max[x]-min x}
minmaxscaler:{{(z-x)%y}[mnx;max[x]-mnx:min x]each x} 
np:.p.import`numpy
nparray:np`:array
pylist:.p.import[`builtins]`:list
getunicode:pylist[<]
EPS:1e-15 / TODO what should this be?
/ special case for binary classification, x(actual class) should be 0 or 1; y should be the probability of belonging to class 0 or 1 for each instance
logloss:{sum[neg u+x*log[y[;1]]-u:log(y:EPS|y)[;0]]%count x}
/ any number of labels; x should be the indices of the list of unique class labels (0 if it belongs to 1st class, 1 if belongs to 2nd class, etc); y should be the probability of belonging to each class
crossentropy:{sum[sum neg eye[count y 0][x]*log y|EPS]%count x}
/ TODO, none of these support the full options in sklearn, also need to be unit tested fully
/ receiver operating characteristic curve for y's and corresponding positive scores
bc:{[y;score]
 fps:1+ti-tps:sums[y@:si]ti:-1+1_where differ score,1+last score@:si:idesc score;
 :(fps;tps;score ti);
 }
roc:{[y;score]u@\:curveinds .(u:@[bc[y;score];0 1;{x%last x}])0 1}
/ area under 'curve' with x and y values
auc:{[x;y]sum 1_(w*y)-.5*deltas[y]*w:deltas x}
rocaucscore:{[y;score]auc . 2#roc[y;score]}
/ given x's and y's, return indices of points defining curve excluding colinear points but always including first and last ind
curveinds:{[x;y]where(-1_differ gradients[x;y]),1b}
/ gradient of previous line segment at each point defined by x y, value at first index is junk
gradients:{[x;y]deltas[y]%deltas x}
 

 
