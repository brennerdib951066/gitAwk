#!/usr/bin/env -S awk -f

# função criada para mandar notificacao via telegram
function notificarTelegram(idChat,texto){
    system("curl -s -F 'chat_id="idChat"' -F 'text= "texto"'  https://api.telegram.org/bot5919425665:AAFgtdzX6INh56NPu_fUqqQ_AOojoeQlDLc/sendMessage 1>-")
}


