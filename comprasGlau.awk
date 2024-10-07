#!/usr/bin/env -S awk -Nf

#________________________________________________________
# Item      Preço   Qtd   Unidade Qtd_Total Custo_Total
# Banana     5,00     3       1kg
# Arroz     15,00     5       2kg
# Feijão    12,00    10       1kg
# Leite      4,00     4        1l

# Valor Total:
#_______________________________________________________

BEGIN{
        # Definir os arquivo 'compras.txt'
        ARGV[1] = "compras.txt"
        ARGC++
}

NR == 1{
        # Imprimir o cabeçalho e concatenar com o novo
        print $0,"  Qtd_Total","  Custo_Total"
}
NR > 1 {
        # Imprimir a parte existente da linha
        printf "%s",$0
        # Calcular subtotal
        subTotal = $2*$3
        # Remover a parte numérica da unidade no campo $4
        unidade = $4
        gsub(/[0-9]/,"",unidade)
        # imprimir a coluna da quantidade da quantidade total
        printf "%11s",($3*$4) unidade
        # Imprimir a coluna custo total
        printf "%13.2f\n", subTotal
        total += subTotal
}
END{
    print ""
    printf "%s" "%.2f\n", toupper("total a comprar: R$"),total
}
