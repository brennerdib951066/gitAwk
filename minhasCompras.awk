#!/usr/bin/env -S awk -Nf

#__________________________________________________________
# nomeDoProduto   tipoDeProduto valorUnitário   unidade
# Arroz           Alimento        R$ 10,00      5KG
# Leite           Bebida          R$ 5,00       4KG
# Sabão em pó     LimpezaR$       8,00          2KG
# Maçã            Fruta           R$3,00       10KG
#__________________________________________________________

# Dica se for calucar colunas e a primeira coluna contiver letras o caluclo não irá funcionar, entao sempre o subtitua com gsub()

BEGIN {
    # Chamar o arquivo de 'compraGPT.txt'
    #ARGV[1] = "compraGPT.txt"
    ARGC = 3
    FS="|"


}
NR == 1 {
    # Printar o cabeçalho antigo com o cabeçalho novo
    print $0,"| valorTotal"
}

NR > 1{
    gsub(/[A-Za-z$]/,"",$3)
    valorPorUnidade = $3*$4
    printf "%10s%10s%.4f\n", $0,"",valorPorUnidade
    valorTotal += valorPorUnidade
    delete ARGV[2]
}
END{
    printf "%s\n",""
    printf "%s%.2f\n", toupper("O valor total de compras: R$"),valorTotal
}
