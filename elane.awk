#!/usr/bin/env -S awk -f

function criarData(data){
    return data

}

BEGIN{
    FS="("
    OFS=","
    dataAtual = strftime("%d-%m-%Y")
    nomeArquivo = "elane-"

}

{
    gsub(/\(|\)|-/,"",$2)
    gsub(/ /,"",$2)
    if (NR == 1){
        print "Nome","Telefone" >> nomeArquivo dataAtual".csv"
    }
    if (length($2) < 11){
        #dd =
        #$2 = "+55" $2
        dd = substr($2, 1, 2)
        numero = substr($2, 3)
        print (tolower($1),"+55"dd"9"numero) >> nomeArquivo dataAtual".csv"
    }
    else{
        print (tolower($1),"+55"$2) >> nomeArquivo dataAtual".csv"
    }

}


