/imports
.p.import[`warnings;`:filterwarnings]"ignore";
npa:.p.import[`numpy]`:array

/ funcs
round:{y*"j"$x%y}
imax:{x?max x}
mattab:{flip value flip x}
print_runid:{-1"Run date: ",string[x],". Run time: ",string[y],"."}
