#!/usr/bin/env -S awk -f

# FUNÇÔES

function eliminarApas(opcao){
    if(opcao == 1){
        gsub(/'/,"",$0)

    }else{
        gsub(/"/,"",$0)
        sub(/^ /,"",$1)
        sub(/ $/,"",$1)
    }

}


BEGIN{
    FS=","
    ARGC=3
    pergunta[0]="aspas simples"
    pergunta[1]="aspas duplas"

    print(toupper("escolha uma das opções:"))
    for(i in pergunta){
        print(i+1")",toupper(pergunta[i]))

    }
    print("_________________________")
    while(opcao==""){
        print(toupper("opcao:"))
        getline opcao < "-"
    }

}


{
    gsub(/.csv/,".txt",ARGV[1])
    eliminarApas(opcao)
    print $1","$2","$3","$4 > ARGV[1]

    #exit
}

