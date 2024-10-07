#!/usr/bin/env -S awk -Nf

@include "funcaoNotificarTelegram.awk"


BEGIN{
    DEBUG = 1
    FS="\t"
    menu[0] = "Todos os dados"
    menu[1] = "Delete NÃO"
    menu[2] = "Delete SIM"

    print "ESCOLHA O TIPO DE FILTRO"
    for (v in menu){
        menu[v] = toupper(menu[v])
        print v+1")",menu[v]
    }
    print ""
    while (opcao == ""){
        getline opcao < "-"
    }

}
NR == 1 {
    #print tolower($0)

}
NR > 1{
    # O valor da adesão corresponde a coluna $25
    # O valor do plano corresponde a coluna $26
    #sub(/\./,",",$25)
    if (opcao == 1){
        #print "VOcÊ escolheu 1"
        filtroSolicitado = toupper(menu[0])
        #dado["filtro"] = filtroSolicitado
        #notificarTelegram("-1001831122226",filtroSolicitado)
        valorTotalDaAdesao += $25
        valorTotalDoPlano  += $26
    }else if (opcao == 2) {
        #print "ESCOLHEU 2"
        # $44 é o campo delete
        if($44 ~ /não|null/){
            filtroSolicitado = toupper(menu[1])
            #dado["filtro"] = filtroSolicitado
            #notificarTelegram("-1001831122226",filtroSolicitado)
            valorTotalDaAdesao += $25
            valorTotalDoPlano  += $26
        }

    }else if (opcao == 3) {
        if($44 ~ /sim/){
            filtroSolicitado = toupper(menu[2])
            #dado["filtro"] = filtroSolicitado
            #notificarTelegram("-1001831122226",filtroSolicitado)
            valorTotalDaAdesao += $25
            valorTotalDoPlano  += $26
        }
    }
}
END{
    nomeTotal[0] = "adesao"
    nomeTotal[1] = "plano"
    valorTotal[0] = valorTotalDaAdesao
    valorTotal[1] = valorTotalDoPlano

    #notificarTelegram("-1001831122226","Filtro atual: "filtroSolicitado)
    for (valor in valorTotal){
        #for (coluna in nomeTotal){
            nomeTotal[valor] = toupper(nomeTotal[valor])
            mensagem = sprintf("%8s %s %.2f\n",nomeTotal[valor],"=",valorTotal[valor])
            notificarTelegram("-1001831122226",mensagem)
        #}

    }
    #print NR
}
