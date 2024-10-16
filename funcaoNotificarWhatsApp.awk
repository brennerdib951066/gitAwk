#!/usr/bin/env -S awk -f

# função criada para mandar notificacao via telegram
function notificarWhatsApp(campanha,idChat,texto){
    switch (campanha){
        case "DIB" :                  api = "c7e572f0-c17b-4304-9478-b68641234d6c"
        break
        case "centralDeAtendimento" : api = "374ed645-c62f-4d21-8f18-d85448be68ac"
        break
        case "centralDeLeads" :       api = "d6a5598b-af5a-4a6f-9791-9b1b25b8445d"
        break
        default: print "Não encontrei a sua campanha"
        
    }
    print "Você é", campanha
    system("sleep 5s")
    notificar = "curl -X POST \"https://backend.botconversa.com.br/api/v1/webhook/subscriber/"idChat"/send_message/\" -H \"API-KEY: "api"\" -H \"Content-Type: application/json\" -d \"{ \\\"type\\\": \\\"text\\\", \\\"value\\\": \\\""texto"\\\" }\""
    system(notificar)
}

#BEGIN{
#    notificarWhatsApp("DIB","385910829","olá")
#}


