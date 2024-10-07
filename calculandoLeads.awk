#!/usr/bin/env bash


awk '
    # Criando função para calcular a quantidade de linhas mediante filtros
    function qtdLinhas(){
        totalLinhas++
        return totalLinhas
    }

    # Iniciando a configuração ante de ler o arquivo
    BEGIN{
        FS=","
        ARGV[1] = "statusLeads.csv"
        ARGC++
    }
    NR == 1{
        # Transformando o cabeçalho em upper case
        print toupper($0)
    }
    NR > 1{
        if(tolower($0) ~ tolower("'"${1}"'")){
            print tolower($0)
            # Calculando quantidade de linhas
            linhas = qtdLinhas()
        }
    }
    ENDFILE{
        exit
    }
    END{
        print "LINHA " linhas
    }
'
