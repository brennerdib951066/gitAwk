#!/usr/bin/env -S gawk -f

BEGIN {

    ARGC=2
    FS=ARGV[2]
    OFS=FS
    dataInicial = ARGV[3]
    dataFinal = ARGV[4]
    tipoFiltro = ARGV[5]
    if (ARGV[2] !~ /[;,:\t]/) {
        system("printf \"%b\n\" \"\\e[31;1mPreciso que mande o delimitador [;.,:\t]\\e[m\"")
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
    print $1,$2,$3,$4,$5,$6,$7,$campoAdicional
}

{
    $0 = tolower($0)
    $campoAdicional = "vital cross"
}
$3 ~ dataInicial || $3 ~ dataFinal {

    qtd++
    gsub(/ .*/,"",$3)

    # Base $4
    gsub(/ |^0/,"",$4)
    dd = substr($4,1,2)
    numeroBase = int(substr($4,3,1))
    numeroCompleto = substr($4,4)

    # Base $5
    gsub(/ /,"",$5)
    dd2 = substr($5,1,2)
    numeroBase2 = int(substr($5,3,1))
    numeroCompleto2 = substr($5,4)


    #length($4)
    #exit
    if (length($4)>0) {
#         if (length($5) <= 5) {
# #             print "MENOR OU IGUAL A 5",length($5)
#             $5 = substr($4,1,2)"9"substr($4,3)
#         }

        if(tipoFiltro ~ /fixo/) {

            if (numeroBase <= 7) {
                numeroFixo = dd numeroBase numeroCompleto
                $4 = numeroFixo



                if (numeroBase2 >= 6) {
                    numeroMovel = dd2 "9" numeroBase2 numeroCompleto2
                    $5 = numeroMovel
                }

                print
            } # IF NUMEROBASE
        } # TIPOFILTRO
        else {
            if (numeroBase >= 7) {
                             numeroMovel = dd "9" numeroBase numeroCompleto
                             $4 = numeroMovel
                             if (numeroBase2 >= 6) {
                                 numeroMovel = dd2 "9" numeroBase2 numeroCompleto2
#                                  print "MAIOR OU IGUAL A NUMERO BASE 2",length($5)
                                 $5 = numeroMovel
                             }

            }
            print $4,$5
        }
#         if (length($5)>0) {
#             if(tipoFiltro ~ /fixo/) {
#
#                 if (numeroBase <= 6) {
#                     numeroFixo = dd numeroBase numeroCompleto
#                     $4 = numeroFixo
#
#                     if (length($5) < 4) {
#                         $5 = $4
#                     }
#
#                     if (numeroBase2 >= 6) {
#                         numeroMovel = dd2 "9" numeroBase2 numeroCompleto2
#                         $5 = numeroMovel
#                     }
#
#                     #print $4
#                     #print $4,"FIXO"
#                     #print $4,$5
#                     print
#                 }
#             }

#         if (numeroBase >= 7) {
#             numeroMovel = dd "9" numeroBase numeroCompleto
#             $4 = numeroMovel
#
# #             print $4
#         }
#
#         # Verificando o campo 5
#         if (numeroBase2 <= 6) {
#             numeroFixo2 = dd2 numeroBase2 numeroCompleto2
#             $5 = numeroFixo2
#             if (length($5)<=3) {
#                 #print "MENOR",length($5)
#                 $5 = $4
#
#             }
#         }
#
#         if (numeroBase2 >= 7) {
#             numeroMovel2 = dd2 "9" numeroBase2 numeroCompleto2
#             $5 = numeroMovel2
#
#             #             print $4
#         }



    } # IF PRINCIPAL
}


# END {
#     print "TOTAL:",qtd
# }
#{
    #print NF
#}
#awk 'BEGIN {FS=";";OFS=";"};NR == 1 {print};$3 ~ /2022|2025/{$0 = tolower($0);gsub(/ .*/,"",$3);gsub(/ /,"",$4);$8 = "vital cross";if (substr($4,3,1) ~ /[6-9]/ || substr($5,3,1) ~ /[6-9]/){ qtd++; if (length($3) < 3) {$4 = "sem numero"}else {$4 = substr($4,1,2)"9"substr($4,3)} if(length($5) < 3){$5 = "sem numero"}else {$4 = substr($4,1,2)substr($4,3)} print $1,$2,$3,$4,substr($5,1,2)substr($5,3),$6,$7} }END {print qtd}' CNPJS_DF_CONSULTORIA_CNAE_7020400_8211300.csv
