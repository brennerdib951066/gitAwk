#!/usr/bin/env -S awk -f

@include "retirarAspas.awk"



BEGIN{
    FS=","
    OFS=","
}
#NR == 1 {
#    $0 = toupper($0)
#}
#NR > 1 {

#}
{
    novoDado = semAspasDuplas($0)
    novoDado = semAspasSimples(novoDado)
    print novoDado
}
