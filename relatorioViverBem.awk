#!/usr/bin/env bash

awk '
    BEGIN{
        # Iniciando as configurações iniciais
        FS=","
        ARGV[1] = "/home/brenner/Área de Trabalho/csv/outrosDadosCompletos.csv"
        ARGV[2] = "'${1,,}'"
        ARGV[3] = "'${2,,}'"
        ARGC = 5
        print "ARGUMENTO 1: "ARGV[2],"\n""ARGUMENTO 2: ",ARGV[3]

    }
    NR > 1{
        switch(ARGV[2]){
            case 1:
                print "Voce escolheu",$$ARGV[2]
                exit
            case 2:
                print "Voce escolheu 2"
                exit
            default :
                print "Escolha numeros por favor"
                exit
        }
        #if($0 ~ ARGV[2]){
        #    print tolower($0),"\n"
        #}
    }
    ENDFILE{
        exit
    }
'
