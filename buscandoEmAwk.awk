#!/usr/bin/env -S awk -f

BEGIN{
    FS="|"
    ARVC=3
    ARGV[2] = tolower(ARGV[2])
    #delete ARGV[2]
}
tolower($0) ~ ARGV[2]{
    print NR"   -",$0
}
ENDFILE{
    exit
}
