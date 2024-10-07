#!/usr/bin/env -S awk -f

BEGIN{
    FS=","
    print("Antes tive isso de ARGUMENTOS",ARGC)
    ARGC = 3 # Aqui estou aumentando essa variavel para usar um arquivo como ARGV[1]
    print("Agora tenho",ARGC)
    ARGV[1] = "laisLideranca.csv"
    #ARGV[2]="10"
    #print ARGV[2]

}
{
    sum += 1
    print
    #exit

}

END{
    # Maneiras de usar as variaveis do ambiente
    # semana='sengunda' ./script.awk
    # export semana='segunda'
    # Ambas sempre usando a variavel do awk ENVIRON
   print(toupper(ENVIRON["nome"]" " "total de linhas_")sum)

}
