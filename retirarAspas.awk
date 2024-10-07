#!/usr/bin/env -S awk -f

function semAspasDuplas(dado){
    #print dado
    retirei = gensub(/"/, "", "g", dado)
    return retirei
}

function semAspasSimples(dado){
    #print dado
    retireiSimples = gensub(/'/, "", "g", dado)
    return retireiSimples
}
