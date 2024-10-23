#!/usr/bin/env -S awk -f

function criarSubscriber(tipo, telefone, primeiroNome, sobreNome,campanha) {
    switch (campanha){
        case "DIB" :                  api = "c7e572f0-c17b-4304-9478-b68641234d6c"
        break
        case "centralDeAtendimento" : api = "374ed645-c62f-4d21-8f18-d85448be68ac"
        break
        case "centralDeLeads" :       api = "d6a5598b-af5a-4a6f-9791-9b1b25b8445d"
        break
        default: print "Não encontrei a sua campanha"

    }
    if (tipo == "completo") {
        comando = "curl -X POST \"https://backend.botconversa.com.br/api/v1/webhook/subscriber/\" -H \"API-KEY: "api"\" -H \"Content-Type: application/json\" -d \"{ \\\"phone\\\": \\\"" telefone "\\\", \\\"first_name\\\": \\\"" tolower(primeiroNome) "\\\", \\\"last_name\\\": \\\"" tolower(sobreNome) "\\\"}\" | grep -iEo '\"id\":[0-9]+' | grep -iEo '[0-9]+'"
    } else {
        comando = "curl -X POST \"https://backend.botconversa.com.br/api/v1/webhook/subscriber/\" -H \"API-KEY: "api"\" -H \"Content-Type: application/json\" -d \"{ \\\"phone\\\": \\\"" telefone "\\\", \\\"first_name\\\": \\\"" tolower(primeiroNome) "\\\", \\\"last_name\\\": \\\"" tolower(sobreNome) "\\\"}\" | grep -iEo '\"id\":[0-9]+' | grep -iEo '[0-9]+'"
    }

    comando | getline idSubscriber
    print idSubscriber
    return idSubscriber

    system("sleep 2s")
}

