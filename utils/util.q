\d .util

// @kind function
// @category util
// @fileoverview Import Python functions
.p.import[`warnings;`:filterwarnings]"ignore";
npa:.p.import[`numpy]`:array

/ funcs
// @kind function
// @category util
// @fileoverview Round a value
// @param val {num} The value to be rounded
// @param round {num} The decimal places to round the val to
// @returns {num} The value rounded to the appropriate decimal
round:{[val;round]
  round*"j"$val%round
  }

// @kind function
// @category util
// @fileoverview Convert a table to a matrix
// @param tab {tab} A simple table
// @returns {num[][]} The table converted to a matrix
mattab:{[tab]
  flip value flip tab
  }

// @kind function
// @category util
// @fileoverview Print the model ID date/time
// @param mdl {dict} The model ID information
// @returns {str} The model ID date/time joined together
printDateTimeId:{[mdl]
  -1"Model date: ",string[mdl`startDate],". Model time: ",string[mdl`startTime],"."
  }

// @kind function
// @category util
// @fileoverview Print the model ID date/time
// @param mdl {dict} The model ID information
// @returns {str} The model ID date/time joined together
printSavedModelId:{[mdl]
  -1"Model Name: ",string[mdl`savedModelName],"."
  }

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
ttsTimeSeries:{[tab;tar;sz]
  `xtrain`ytrain`xtest`ytest!raze(tab;tar)@\:/:(0,floor n*1-sz)_til n:count tab
  }

// @kind function
// @category util
// @fileoverview Print the RMSLE
// @param pred {float[]} A vector of predicted labels 
// @param true {float[]} A vector of true labels
// @returns {str} The root mean squared log error between predicted values
//   and the true values
rmsle:{[pred;true]
  "The RMSLE is: ",string .ml.rmsle[pred;true]
  }

// @kind function
// @category util
// @fileoverview Convert q dates to python dates
// @param dates {datetime} Date values
// @returns {<} q date values converted to python dates
q2pydts:{[dates]
  .p.import[`numpy;`:array;"j"$dates-("pmd"t)$1970.01m;
    `dtype pykw "datetime64[",@[("ns";"M";"D");t:type[dates]-12],"]"]
  }