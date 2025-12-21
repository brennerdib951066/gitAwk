#!/usr/bin/env -S gawk -f

BEGIN {

    ARGC=2
    FS=ARGV[2]
    OFS=FS
    dataInicial = int(ARGV[3])
    dataFinal = int(ARGV[4])


    tipoFiltro = ARGV[5]
    nomeArquivo = "novo_" ARGV[3] "_" ARGV[4] "_"  tolower(gensub(/\..*/, "", 1, ARGV[1])) ".csv"
    #exit

    # Verificações
    if (ARGV[2] !~ /[;,:\t]/) {
        system("printf \"%b\n\" \"\\e[31;1mPreciso que mande o delimitador [;.,:\t]\\e[m\"")
        exit
    }

    if (!dataInicial) {
       system("printf \"%b\n\" \"\\e[33;2mEscolha um ano inicial para prosseguir\\e[m\"")
       exit
    }

    if (!dataFinal) {
        system("printf \"%b\n\" \"\\e[35;2mEscolha um ano final para prosseguir\\e[m\"")
        exit
    }

    if (!tipoFiltro){
        system("printf \"%b\n\" \"\\e[31;1mMande sempre se filtro sera MOVÉL ou FIXO\\e[m\"")
        exit
    }
    tipoFiltro = tolower(tipoFiltro)
    switch (tipoFiltro) {
        case "movel" :
            print "parabéns movel"
            break
        case "fixo":
            print "parabéns fixo"
            break
        default :
            print "Escolha entre MOVEL ou FIXO"
            exit
    }

#     print dataInicial,dataFinal
#     exit
}

NR == 1 {
    campoAdicional = NF+1
    $campoAdicional = "responsavel dado"
    print $1,$2,$3,$4,$5,$6,$7,$campoAdicional > nomeArquivo
}

{
    $0 = tolower($0)
    $campoAdicional = "vital cross"
    dataParametro = gensub(/-.*/,"","g",$3)
    #print "data" dataParametro
}
dataParametro >= dataInicial &&  dataParametro <= dataFinal {

    gsub(/ .*/,"",$3)
    gsub(/ /,"",$4)

    ddd = int(substr($4,1,2))
    nonoDigito = "9"

    numeroCompleto = int(substr($4,3))
    numeroPre = int(substr(numeroCompleto,1,2))
    numeroCorrigido = ddd nonoDigito numeroCompleto

    numeroCompleto2 = int(substr($5,3))
    numeroPre2 = int(substr(numeroCompleto2,1,2))
    numeroCorrigido2 = ddd nonoDigito numeroCompleto2


    if (tipoFiltro ~ /movel/) {
        if (numeroPre >= 50 && numeroPre <= 99) {
            if (length($5)<=3) {
                numeroCorrigido2 = numeroCorrigido
                #print numeroCorrigido2
            }
            #print $1,$2,$3,"55" numeroCorrigido,"55" numeroCorrigido2,$6,$7
            print $1,$2,$3,numeroCorrigido,numeroCorrigido2,$6,$7 > nomeArquivo
        }
    }

    if (tipoFiltro ~ /fixo/) {
        sub("9","",numeroCorrigido)
        sub("9","",numeroCorrigido2)
        if (numeroPre >= 30 && numeroPre <= 39) {
            if (length($5)<=3) {
                numeroCorrigido2 = numeroCorrigido
                #print numeroCorrigido2
            }
            if (length($4)<=7) {
                numeroCorrigido = "Numero invalido"
                #print numeroCorrigido2
            }
            if (length($5)<=7) {
                 numeroCorrigido2 = numeroCorrigido
                 #print numeroCorrigido2
             }
             #print $1,$2,$3,"55" numeroCorrigido,"55" numeroCorrigido2,$6,$7
            print $1,$2,$3,numeroCorrigido,numeroCorrigido2,$6,$7 > nomeArquivo
        }
    }

    #print ddd nonoDigito numeroCompleto,$5

    #print

}


  END {

        comando = "curl -sX POST -w \"%{http_code}\" \"https://3c.fluxoti.com/api/v1/campaigns?api_token=0ThoHgXPfj3rFp6EZdVc1811q8u7ujL4QcCdvJYOpi1AYe77dC2qIh1jQlbS\" -H \"accept: application/json\" -H \"Content-Type: application/x-www-form-urlencoded\" -d \"name="nomeArquivo"&extension_number=731295&start_time=09%3A00&qualification_list=24542&end_time=18%3A00\""
        #FS=":"
        system(comando)
        print
        system("printf \"%b\n\" \"\\e[31;1mAbrindo seu arquivo\\e[m\"; sleep 2s")
        system("soffice "nomeArquivo"")

}
#{
    #print NF
#}
#awk 'BEGIN {FS=";";OFS=";"};NR == 1 {print};$3 ~ /2022|2025/{$0 = tolower($0);gsub(/ .*/,"",$3);gsub(/ /,"",$4);$8 = "vital cross";if (substr($4,3,1) ~ /[6-9]/ || substr($5,3,1) ~ /[6-9]/){ qtd++; if (length($3) < 3) {$4 = "sem numero"}else {$4 = substr($4,1,2)"9"substr($4,3)} if(length($5) < 3){$5 = "sem numero"}else {$4 = substr($4,1,2)substr($4,3)} print $1,$2,$3,$4,substr($5,1,2)substr($5,3),$6,$7} }END {print qtd}' CNPJS_DF_CONSULTORIA_CNAE_7020400_8211300.csv
