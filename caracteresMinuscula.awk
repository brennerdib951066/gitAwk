#!/usr/bin/env -S awk -f

#{ print tolower($0) > "KARGO.TXT" }

# FUNÇÕES#########################################################
function verCabecalho(){
        print("Você me chamou")
        print(toupper("qual é a a linha que está o cabeçalho?"))
        getline cabecalho < "-"

        if (NR == cabecalho){
                print(tolower($0"\n"))
                print("no cabeçalho contém",NF,"de colunas")
        }
        exit
}

function todasAsLinhas(arquivo,valor){
        print(tolower($0)"\n",NR)
}

#################################################################

BEGIN{
    FS=","
    linhas = NR
    arquivo = ARGV[1]
    #print("QUAL LINHA ESTÁ AS COLUNAS")
    #getline coluna < "-"
    #print(coluna)
    # Craindo uma lista para o menu
    pergunta[0]="ver somente cabeçalho"
    pergunta[1]="ver certa quantidade de linhas"
    pergunta[2]="ver todas as linhas"
    print("Escolha o modo de leitura")
    for (i in pergunta){
        print(i")",toupper(pergunta[i]))
    }
    print("OPÇÃO")
    getline resposta < "-"

}

{
        if (resposta == 0){
                verCabecalho()
        }

        if (resposta == 2){
                todasAsLinhas(arquivo,valor)
        }


}
