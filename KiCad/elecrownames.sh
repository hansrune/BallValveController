#!/bin/bash
P=$( basename $PWD )
G=gerber

function mvfile {
    if [ "$3" = "drl" ]
    then
        E="txt"
    else
        E="$3"
    fi
    if [ -f "${G}/$1$2.$3" ]
    then
        #echo Move "${G}/$1$2.$3" to "${G}/$1.$E"
        mv -vf "${G}/$1$2.$3" "${G}/$1.$E"
    elif [ -f "${G}/$1.$E" ]
    then
        echo "${G}/$1.$E already there"
    else
        echo "Need to check $1 $2 $3"
    fi
}

mkdir -p $G
mvfile "$P" "-B_Cu"         "gbl"
mvfile "$P" "-B_Mask"       "gbs"
mvfile "$P" "-B_Silkscreen" "gbo"
mvfile "$P" "-Edge_Cuts"    "gm1"
mvfile "$P" "-F_Cu"         "gtl"
mvfile "$P" "-F_Mask"       "gts"
mvfile "$P" "-F_Silkscreen" "gto"
mvfile "$P" ""              "drl"

cd "$G" 
rm -f "../$P.zip"
zip "../$P" * 
