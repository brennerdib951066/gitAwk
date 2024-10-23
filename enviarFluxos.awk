#!/usr/bin/env -S awk -f


function enviarFluxo(idSubscriber,idFluxo,campanha){
    print "gostoso"
    switch (campanha){
        case "DIB" :                  api = "c7e572f0-c17b-4304-9478-b68641234d6c"
        break
        case "centralDeAtendimento" : api = "374ed645-c62f-4d21-8f18-d85448be68ac"; idFluxo = "5515896"
        break
        case "centralDeLeads" :       api = "d6a5598b-af5a-4a6f-9791-9b1b25b8445d"; idFluxo = "5515582"
        break
        default: print "Não encontrei a sua campanha"

    }
    comando = "curl -X POST \"https://backend.botconversa.com.br/api/v1/webhook/subscriber/"idSubscriber"/send_flow/\" -H \"accept: application/json\" -H \"API-KEY: "api"\" -H \"Content-Type: application/json\" -d \"{ \\\"flow\\\": \\\""idFluxo"\\\"}\""
    system(comando)
}

