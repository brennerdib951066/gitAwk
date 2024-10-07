#!/usr/bin/env -S awk -f

# função criada para mandar notificacao via telegram
function notificarWhatsApp(idChat,texto){
    notificar = "curl -X POST https://backend.botconversa.com.br/api/v1/webhook/subscriber/" idChat "/send_message/ -H 'API-KEY: c7e572f0-c17b-4304-9478-b68641234d6c' -H 'Content-Type: application/json' -d '{ \"type\": \"text\", \"value\": \""texto"\" }'"
    system(notificar)
}


