#!/usr/bin/env -S awk -f

#@include "criarSubscriber.awk"
#@include "enviarFluxos.awk"
@include "funcaoNotificarWhatsApp.awk"

# Aqui começa as funções
function menuCampanha(){
	opcao[0] = "DIB"
	opcao[1] = "centralDeAtendimento"
	opcao[2] = "centralDeLeads"

	while (1){
		for (i in opcao){
			print i")",opcao[i]
		} # FOR

			print "OPÇÃO:"
			getline escolha < "-"

			if (escolha != ""){
				if (escolha !~ /^[[:xdigit:]]*$/){
					print "Por favor escolha numeros de 0-2"
					continue
				} # IF
				else if (escolha <= 2) {
					break
				} # ELSE IF
				else {
					print "resposta deve ser numero de 0-2"
				} # ELSE

			} # If escolha
	} # WHILE 1

	switch (escolha){
		case "0": campanhaEscolhida = "DIB"; break
		case "1": campanhaEscolhida = "centralDeAtendimento"; break
		case "2": campanhaEscolhida = "centralDeLeads"; break
	} # SWITCH CASE

	#system("sleep 10")
	return campanhaEscolhida
	#system("sleep 10")
} # FUNÇÂO PARA RETORNAR O VALOR DA ESCOLHA DAS OPÇÔES DO MENU

BEGIN{
	FS=","
	campanha = menuCampanha()
}
NR > 1{
	print "Sua campanha é:",campanha
	#system("sleep 10")

	if (length($4) == 11 && $4 !~ /^55/) {
		qtdsNaoContinha += 1
		#campanha = "DIB"
		idChat = "385910829"
		#system("sleep 2")
		$4 = "55" $4 # acionando o 55 na inicial da coluna $4
		textoNome = "Nome: *"$3"*\\n\\n"
		textoTelefone = "Telefone: *"$4"*"
		print $4,"Modificando no IF"
		notificarWhatsApp(campanha,idChat,""textoNome" "textoTelefone"")
	} # IF PARA VERIFICAR SE A COLUNA $4 que é de telefone é = 11 e não comece com 55
	else if (length($4) == 13 && $4 ~ /^55/){
		qtdsContinha += 1
		#campanha = "DIB"
		idChat = "385910829"
		#system("sleep 2")
		textoNome = "Nome: *"$3"*\\n\\n"
		textoTelefone = "Telefone: *"$4"*"
		print $4, "tem todos os numeros"
		notificarWhatsApp(campanha,idChat,""textoNome" "textoTelefone"")
	} # ELSE IF
	else {
		qtdNormal += 1
		idChat = "385910829"
		textoNome = "Nome: *"$3"*\\n\\n"
		quatroDigito = substr($4,1,4)"9"
		quintoEmDiante = substr($4,5)
		$4 = ""quatroDigito""quintoEmDiante""
		textoTelefone = "Telefone: *"$4"*"
		print $4, "CAIU NO ELSE",NR
		notificarWhatsApp(campanha,idChat,""textoNome" "textoTelefone"")
	}
}
END{
	texto = toupper("*Total de registros*")
	totalDeRegistros = qtdsNaoContinha + qtdsContinha + qtdNormal
	print "Continha =",qtdsContinha"\nNão continha",qtdsNaoContinha
	notificarWhatsApp(campanha,idChat,texto" :"totalDeRegistros)
}

