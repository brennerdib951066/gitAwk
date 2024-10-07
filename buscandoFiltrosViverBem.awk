#!/usr/bin/env -S awk -f

BEGIN{
    FS=","
    ARGC=2
    ARGV[1]="outroDadosViverBem.csv"
    #print("Gerente:")
    #getline pesquisar < "-"
}
$2 ~ /[Tt]hales/ {
    if($1 ~ /sim/){
        vendaDeletada+=1

    }else{vendaCerta += 1

    }
    gsub(/"/,"",$2)
    gerente = $2

}END{
    print(gerente,"DELETOU:",vendaDeletada+=1)
    print(gerente,"VENDAS CERTAS:",vendaCerta)
    print("TOTAL:",vendaDeletada+vendaCerta)

}

