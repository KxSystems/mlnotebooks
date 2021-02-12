\d .util

/imports
.p.import[`warnings;`:filterwarnings]"ignore";
npa:.p.import[`numpy]`:array

/ funcs
round:{y*"j"$x%y}
imax:{x?max x}
mattab:{flip value flip x}
printDateTimeId:{-1"Model date: ",string[x`startDate],". Model time: ",string[x`startTime],"."}
printSavedModelId:{-1"Model Name: ",string[x`savedModelName],"."}

// @kind function
// @category util
// @fileoverview Include any missing datetimes in the table
// @param dt  {sym} Datetime column name
// @param tab {tab}  table
// @param tm  {timespan} frequency of time in datetime col
// @return {tab} tequispaced time series table
dateFill:{[dt;tab;tm]
         (flip enlist[dt]!enlist {x<max y}[;tab[dt]]{y+x}[tm]\min tab[dt])lj dt xkey tab}

// @kind function
// @category util
// @fileoverview Train test split for time series (non shuffle)
// @param tab {tab} input table
// @param tar {list} target values
// @param sz  {float} train test split
// @return {dict} the input data split up into train and test sets
ttsTimeSeries:{[tab;tar;sz]`xtrain`ytrain`xtest`ytest!raze(tab;tar)@\:/:(0,floor n*1-sz)_til n:count tab}

rmsle:{
  "The RMSLE is: ",string .ml.rmsle[x;y]
  }
