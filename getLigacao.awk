#!/usr/bin/env -S awk -f
@include "cores.awk"

function verificarPrograma() {
    system("bash -c 'type -P gawk >/dev/null || { echo Por favor instale o gawk para usar esse codigo!; sleep 5;sudo apt install gawk;sleep 2s;clear;}'")
}

function aplicativo(banco) {

if (!banco) {
        print(cores("amarelo","Envie para mim no minimo o nome do banco como parametro! 1"))
        print(cores("branco destacado",nomeDoArquivo"."ARGV[0]" " "nomeDoBanco"))
        exit
}

print(cores("amarelo","Antes de começar escolha o sistema a qual o banco está relacionado para que se podessa fazer as filtragens corretamente\n"))
while (1) {
    printf "%s\n%s\n","1 - Sistema viver bem","2 - Viver bem app"
    getline app
    if (!app) {
        print(cores("branco destacado","Por favor escolha entre as opções"))
        continue
    }
    # Que seja numero e seja menor que 3
    if (match(app,/[^[:digit:]]/) || app >= 3) {
        print((cores("vermelho","Escolha um numero correspondente!")))
        continue
    }
    break
} # WHILE
#print("Seu valor de APP:",app)
switch (app) {
    case 1 : {
        #print("Parebéns escolheu a sistem viver bem")
        app = "www.sistemaviverbemseguros.com"
        return app
    }
    case 2 : {
        #print("Escolheu o app viver.app viver bem")
        app = "viverbem.app.br"
        return app
    }
} # SWITCH

}

function constraints(banco,interacao,sistema) {


#exit
# Valor inicial em 0
i = 0
tentativas = 0

# Arrays
constraint[0] = toupper("nome campo")
constraint[1] = toupper("valor do campo")
nomeConstraint[0] = "nomeCliente"
nomeConstraint[1] = "GNU Awk"

# banco = ARGV[1]

#delete ARGV[1]
#filtro[0] = ARGV[2]
#filtro[1] = ARGV[3]
#print("seu filtro1",filtro[0])
#print("seu filtro2",filtro[1])
#exit

#delete ARGV[2]
#delete ARGV[3]
# Textos
textoRequisicao = toupper("preciso do nome do banco para poder fazer a requisição corretamente")

# verificando se o argumento banco esta vazio
#if (!banco) { print(cores("vermelho",textoRequisicao)) ;print(cores("branco destacado","Exemplo: nomeDaFuncao(nomeBanco)"));exit}



# Verificando app para mandar corretamente a chave api
if (sistema ~ /app/) {
    chaveApi = "Bearer aeb0a18262e8df10973c3ba083735467"

} else {
    chaveApi = "Bearer 5b2a5efbc5fda2ffff948979031ac33a"

}

print("Vi que o seu sistema de filtro padra é:",cores("verde",sistema))



if (interacao=="sim") {
    #print("seu filtro1",filtro[0])
    #print("seu filtro2",filtro[1])
    #banco = ARGV[1]

    if (!filtro[0]) {
        print(cores("vermelho","Preciso do argumento 2"))
        return
    }

    if (!filtro[1]) {
        print(cores("vermelho","Preciso do argumento 3"))
        return
    }


    # Iniciando requisicao!
    print(cores("amarelo","⚫ Lembre-se que acentos também contam na pesquisa"))
    url = "https://"sistema"/api/1.1/obj/"banco""

    parametroUrl = "constraints=[{\"key\":\""filtro[0]"\",\"constraint_type\":\"text contains\",\"value\": \""filtro[1]"\"}]"
    requisicao = "curl -Ss -G -H \"Content-Type: Application/json\" -H \"Authorization: "chaveApi"\" "url" --data-urlencode '"parametroUrl"'"
    print(requisicao)
    system(""requisicao"")
    return

} # IF INTERACAO

if (!filtro[0] || !filtro[1]) {
    while (1) {
        print(cores("branco destacado",""constraint[i]" ("tentativas"/3) - ex: "nomeConstraint[i]""))
        printf "%s",": "
        getline filtro[i]

        if (match(filtro[i],/[^[:alpha:] ]+/)) { print cores("vermelho","Por favor o nome do "constraint[i]" deve ser em formato de texto!") ; continue } #IF # MACTH

        if (!filtro[i]) {
            #if (match(filtro[i],/[^A-Za-z]/)) { print "Por favor o nome do",constraint[i],"deve ser em formato de texto!" } # MACTH

            if (tentativas < 3) {
                tentativas++
                continue
            } # IF TENTATIVAS
            print(cores("vermelho","Atingiu todas as tentivas disponiveis!"))
            exit
        } # IF !FILTRO

        if (i==1) {
            break
        } # IF I==1
        i++
    } # WHILE
} # FILTRO
    # Iniciando requisicao!
    print(cores("amarelo","⚫ Lembre-se que acentos também contam na pesquisa"))
    url = "https://"sistema"/api/1.1/obj/"banco""
    parametroUrl = "constraints=[{\"key\":\""filtro[0]"\",\"constraint_type\":\"text contains\",\"value\": \""filtro[1]"\"}]"
    requisicao = "curl -Ss -G -H \"Content-Type: Application/json\" -H \"Authorization: "chaveApi"\" "url" --data-urlencode '"parametroUrl"'"
    print(requisicao)
    system(""requisicao"")

} # FUNCAO

BEGIN {
    nomeDoArquivo = "getLigacao"
    banco = ARGV[1] #ARGC =
    delete ARGV[1]
    filtro[0] = ARGV[2]
    filtro[1] = ARGV[3]

    delete ARGV[2]
    delete ARGV[3]

    sistema = aplicativo(banco)
    #print(sistema)
    constraints(banco,"nao",sistema)
}
