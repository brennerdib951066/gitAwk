#!/usr/bin/env -S awk -f

function criarSubscriber(tipo, telefone, primeiroNome, sobreNome) {
    if (tipo == "completo") {
        comando = "curl -X POST \"https://backend.botconversa.com.br/api/v1/webhook/subscriber/\" -H \"API-KEY: c7e572f0-c17b-4304-9478-b68641234d6c\" -H \"Content-Type: application/json\" -d \"{ \\\"phone\\\": \\\"" telefone "\\\", \\\"first_name\\\": \\\"" tolower(primeiroNome) "\\\", \\\"last_name\\\": \\\"" tolower(sobreNome) "\\\"}\" | grep -iEo '\"id\":[0-9]+' | grep -iEo '[0-9]+'"
    } else {
        comando = "curl -X POST \"https://backend.botconversa.com.br/api/v1/webhook/subscriber/\" -H \"API-KEY: c7e572f0-c17b-4304-9478-b68641234d6c\" -H \"Content-Type: application/json\" -d \"{ \\\"phone\\\": \\\"" telefone "\\\", \\\"first_name\\\": \\\"" tolower(primeiroNome) "\\\", \\\"last_name\\\": \\\"" tolower(sobreNome) "\\\"}\" | grep -iEo '\"id\":[0-9]+' | grep -iEo '[0-9]+'"
    }

    comando | getline idSubscriber
    print idSubscriber
    return idSubscriber

    system("sleep 2s")
}

