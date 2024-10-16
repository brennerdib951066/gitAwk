#!/usr/bin/env -S awk -f

@include "criarSubscriber.awk"
@include "enviarFluxos.awk"
@include "funcaoNotificarWhatsApp.awk"
#function criarSubscriber(tipo, telefone, primeiroNome, sobreNome) {
#    if (tipo == "completo") {
#        comando = "curl -X POST \"https://backend.botconversa.com.br/api/v1/webhook/subscriber/\" -H \"API-KEY: c7e572f0-c17b-4304-9478-b68641234d6c\" -H \"Content-Type: application/json\" -d \"{ \\\"phone\\\": \\\"" telefone "\\\", \\\"first_name\\\": \\\"" tolower(primeiroNome) "\\\", \\\"last_name\\\": \\\"" tolower(sobreNome) "\\\"}\" | grep -io id"
#    } else {
#        comando = "curl -X POST \"https://backend.botconversa.com.br/api/v1/webhook/subscriber/\" -H \"API-KEY: c7e572f0-c17b-4304-9478-b68641234d6c\" -H \"Content-Type: application/json\" -d \"{ \\\"phone\\\": \\\"" telefone "\\\", \\\"first_name\\\": \\\"" tolower(primeiroNome) "\\\", \\\"last_name\\\": \\\"" tolower(sobreNome) "\\\"}\" | grep -io id"
#    }
#    system(comando)

#    system("sleep 2s")
#}


BEGIN {
    FS=","
    OFS=","
    dataAtual = strftime("%d-%m-%Y")
    nomeArquivo = "elane-"
    areaDeTrabalho = ENVIRON["areaDeTrabalhoUsuario"]
    home = ENVIRON["HOME"]
    converterArquivo = "soffice --convert-to xlsx " home "/" "\""areaDeTrabalho"\"" "/" nomeArquivo dataAtual".csv " home "/" "\""areaDeTrabalho"\"" "/"
    print converterArquivo
    #system("sleep 10s")
    while (elaneNumero == ""){
        print "Elane numero:"
        getline elaneNumero < "-"
    }
}

{
    gsub(/\(|\)|-/,"",$2)
    gsub(/ /,"",$2)
    gsub(/\.|\||\^/,"",$1)
    if (NR == 1){
        print "nome","telefone","etiquetas" > home "/"areaDeTrabalho "/" nomeArquivo dataAtual".csv"
    }

    if (length($2) < 11){
        #dd =
        #$2 = "+55" $2
        dd = substr($2, 1, 2)
        numero = substr($2, 3)
        print (tolower($1),"55"dd"9"numero,"leadsElane"elaneNumero) > home "/"areaDeTrabalho "/" nomeArquivo dataAtual".csv"
        #comando = "curl -X POST \"https://backend.botconversa.com.br/api/v1/webhook/subscriber/\" -H \"API-KEY: c7e572f0-c17b-4304-9478-b68641234d6c\" -H \"Content-Type: application/json\" -d \"{ \\\"phone\\\": \\\"55" dd "9" numero"\\\", \\\"first_name\\\": \\\""tolower($1)"\\\", \\\"last_name\\\": \\\""tolower("api")"\\\"}\""
        #system(comando)
        print ""
        criarSubscriber("completo","55" dd "9" numero,tolower($1),"api")
        print "Aqui é o id do momento" idSubscriber
        enviarFluxo(idSubscriber,"5459783")
        textoNotificacao = "*Lead cadastrado com sucesso*" "\\n\\nNome: "toupper($1)"" "\\n\\nTelefone: 55 "dd"9"numero""
        notificarWhatsApp("DIB","193741501",textoNotificacao)
        system("sleep 5s")


    }
    else{
        print (tolower($1),"55"$2,"leadsElane"elaneNumero) > home "/"areaDeTrabalho "/" nomeArquivo dataAtual".csv"
        #comando = "curl -X POST \"https://backend.botconversa.com.br/api/v1/webhook/subscriber/\" -H \"API-KEY: c7e572f0-c17b-4304-9478-b68641234d6c\" -H \"Content-Type: application/json\" -d \"{ \\\"phone\\\": \\\"55" $2"\\\", \\\"first_name\\\": \\\""tolower($1)"\\\", \\\"last_name\\\": \\\""tolower("api")"\\\"}\""
        #system(comando)
        print ""
        criarSubscriber("basico","55" $2,tolower($1),"api")
        print "Aqui é o id do momento" idSubscriber
        enviarFluxo(idSubscriber,"5459783")
        textoNotificacao = "*Lead cadastrado com sucesso*" "\\n\\nNome: "toupper($1)"" "\\n\\nTelefone: 55"$2""
        notificarWhatsApp("DIB","193741501",textoNotificacao)
        #print "O id é",valor
        system("sleep 5s")


    }

}
ENDFILE{
    system(converterArquivo)
    system("mv "nomeArquivo dataAtual".xlsx ../")
    #print length(nomes)
}

END {
    print areaDeTrabalho
    #comando = "curl -X POST \"https://backend.botconversa.com.br/api/v1/webhook/subscriber/\" -H \"API-KEY: c7e572f0-c17b-4304-9478-b68641234d6c\" -H \"Content-Type: application/json\" -d \"{ \\\"phone\\\": \\\"5595991202325\\\", \\\"first_name\\\": \\\"4454545\\\", \\\"last_name\\\": \\\"l\\\"}\""
    #system(comando)

}
