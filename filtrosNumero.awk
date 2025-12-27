#!/usr/bin/env -S gawk -f

function exibir(cor,aviso) {
    if (!cor) {
        printf "Por favor envie sempre a cor correspondente ao seu aviso!"
        #exit
    }
    cor = tolower(cor)
    switch (cor) {
        case "vermelho":
            # VERDE
            escape = "1"
            break
        case "verde":
            # VERDE
            escape = "2"
        case "amarelo":
            # VERDE
            escape = "3"

    } # switch

    return system("printf \"%b\n\" \"\\e[3"escape";1m"aviso"\\e[m\"")
}

BEGIN {

    ARGC=2
    FS=ARGV[2]
    OFS=FS
    dataInicial = int(ARGV[3])
    dataFinal = int(ARGV[4])


    tipoFiltro = ARGV[5]
    deggub = ARGV[6]

    nomeArquivo = "novo_" ARGV[3] "_" ARGV[4] "_"  tolower(gensub(/\..*/, "", 1, ARGV[1])) ".csv"

    # Bubble
    token = "aeb0a18262e8df10973c3ba083735467"
    url = "https://app.vitalcross.com.br/version-test/api/1.1/obj/bancoLigacao"
    chaveBubble = "no"
    #exit

    # Verificações
    if (ARGV[2] !~ /[;,:\t]/) {
        exibir("amarelo","Help: ./filtrosNumero.awk arquivo.csv delimitador anoInicial anoFinal movel|fixo")
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
            #print "parabéns movel"
            break
        case "fixo":
            #print "parabéns fixo"
            break
        default :
            print "Escolha entre MOVEL ou FIXO"
            exit
    }

    while (1) {
        print "Deseja mandar os dados para o bubble? [s/n]"
        getline resposta < "-"
        # Verifiacando se a entrada esta vazia
        if (match(/[^A-Za-z0-9]/,resposta)) {
            print "É vazio"
        }

        if (length(resposta)>=2) {
            print "Sua resposta deve conter apenas S ou N"
        }
        resposta = tolower(resposta)
        switch (resposta) {
            case "s" :
                print "Parabens escolheu sim"
                break
            case "n" :
                print "Parabens escolheu não"
        } # switch
        break
    } # WHLE

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
    #print  > nomeArquivo
    #print "data" dataParametro
}
dataParametro >= dataInicial &&  dataParametro <= dataFinal {

    gsub(/ .*/,"",$3)
    gsub(/ /,"",$4)
    gsub(/&/,"e")

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
            qtd++
            if (length($5)<=3) {
                numeroCorrigido2 = numeroCorrigido
                #print numeroCorrigido2
            }
            if (deggub ~ /-d|debug/) {
                print $1,$2,$3,"55" numeroCorrigido,"55" numeroCorrigido2,$6,$7,$campoAdicional
                next
            }
            print $1,$2,$3,"55" numeroCorrigido,"55" numeroCorrigido2,$6,$7,$campoAdicional > nomeArquivo

            if (resposta !~ /s/) {
                next
            }
            comandoCriarBubble = "curl -sX POST -H \"Content-Type: application/x-www-form-urlencoded\" -H \"Autorization: "token"\" "url" -H \"accept: application/json\"  -d \"nomeFantasia="$2"&dataAtivacao="$3"&telefoneCliente=55"numeroCorrigido"&email="$6"&razaoSocial="$7"&responsavelDoDado="$campoAdicional"\"; sleep 0.5s"
            #FS=":"
            system(comandoCriarBubble)
            #print $1,$2,$3,"55" numeroCorrigido, "55" numeroCorrigido2,$6,$7 > nomeArquivo
        }
    }

    if (tipoFiltro ~ /fixo/) {
        sub("9","",numeroCorrigido)
        sub("9","",numeroCorrigido2)

        if (numeroPre >= 30 && numeroPre <= 39) {
            qtd++
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
            if (deggub ~ /-d|debug/) {
                print $1,$2,$3,"55" numeroCorrigido,"55" numeroCorrigido2,$6,$7,$campoAdicional
                next
            }
            print $1,$2,$3,"55" numeroCorrigido,"55" numeroCorrigido2,$6,$7,$campoAdicional > nomeArquivo

            if (resposta !~ /s/) {
                next
            }
            comandoCriarBubble = "curl -sX POST -H \"Content-Type: application/x-www-form-urlencoded\" -H \"Autorization: "token"\" "url" -H \"accept: application/json\"  -d \"nomeFantasia="$2"&dataAtivacao="$3"&telefoneCliente=55"numeroCorrigido"&email="$6"&razaoSocial="$7"&responsavelDoDado="$campoAdicional"\"; sleep 0.5s"
            #FS=":"
            system(comandoCriarBubble)

            #print $1,$2,$3, "55" numeroCorrigido, "55" numeroCorrigido2,$6,$7 > nomeArquivo
        }
    }

    #print ddd nonoDigito numeroCompleto,$5

    #print

}


END {

    comando = "curl -sX POST -w \"%{http_code}\" \"https://3c.fluxoti.com/api/v1/campaigns?api_token=0ThoHgXPfj3rFp6EZdVc1811q8u7ujL4QcCdvJYOpi1AYe77dC2qIh1jQlbS\" -H \"accept: application/json\" -H \"Content-Type: application/x-www-form-urlencoded\" -d \"name="nomeArquivo"&extension_number=731295&start_time=09%3A00&qualification_list=24542&end_time=18%3A00\""


    print
    #print qtd,"QUANTIDADE"

    if (deggub ~ /-d|debug/ || ! qtd) {
        exit
    }
    #system("echo -e \"\\E[31;1mAbrindo o arquivo "nomeArquivo"\\E[m\"; sleep 2")
    system("printf \"%b\n\" \"\\e[31;1mAbrindo seu arquivo "nomeArquivo"\\e[m\"; sleep 2s")
    system("soffice "nomeArquivo" >/dev/null 2>/dev/null &")
    #break
    #system("printf \"%b\n\" \"\\e[31;1mAbrindo seu arquivo\\e[m\"; sleep 2s")


}
#{
#print NF
#}
#awk 'BEGIN {FS=";";OFS=";"};NR == 1 {print};$3 ~ /2022|2025/{$0 = tolower($0);gsub(/ .*/,"",$3);gsub(/ /,"",$4);$8 = "vital cross";if (substr($4,3,1) ~ /[6-9]/ || substr($5,3,1) ~ /[6-9]/){ qtd++; if (length($3) < 3) {$4 = "sem numero"}else {$4 = substr($4,1,2)"9"substr($4,3)} if(length($5) < 3){$5 = "sem numero"}else {$4 = substr($4,1,2)substr($4,3)} print $1,$2,$3,$4,substr($5,1,2)substr($5,3),$6,$7} }END {print qtd}' CNPJS_DF_CONSULTORIA_CNAE_7020400_8211300.csv
