/imports
.p.import[`warnings;`:filterwarnings]"ignore";
npa:.p.import[`numpy]`:array
pylist:.p.import[`builtins]`:list

/ funcs
getunicode:pylist[<]
imax:{x?max x}
mattab:{flip value flip x}
round:{y*"j"$x%y}