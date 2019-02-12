#!/usr/bin/bash
#Script permettant la conversion de chiffres en chiffres romain
convertir_vers_romain(){
    local nombre_a_convertir=$1
    local valeurs_en_romain=""
    #Nous définissons un tableau de conversion 
    declare -a tableau_conversion=([1000]="M" [900]="CM" [500]="D" [100]="C" [90]="XC" [50]="L" [40]="XL" [10]="X" [9]="IX" [5]="V" [4]="IV" [1]="I" [400]="CD")
    #et un tableau d'équivalence permettant de réaliser les conversions
    declare -a valeurs_a_substituer=(1000 900 500 400 100 90 50 40 10 9 5 4 1)                       

    #On lance la boucle de filtrage tant qu'on a pas retiré tous les chiffres
    while [ "${nombre_a_convertir}" -ne 0 ]; do
        val=0
	#On restitue les valeurs en chiffre(s) romain et on l'affiche (en décalant vers la gauche)
        for val_test in ${valeurs_a_substituer[*]}; do
	    #on test la valeure dès qu'on est en dessous on peut commencer à sortir les valeurs (break, ici fait office de ceinture de sécurité pour ne pas tester les valeurs plus faibles dès le début)
            (( "${val_test}" <= "${nombre_a_convertir}" )) && { val=${val_test} ; break ; }
        done
	#ici s'opère la conversion de valeure en romain, on va chercher dans notre tableau la correspondance
        valeurs_en_romain+=${tableau_conversion[$val]}
	#une fois la partie élevée du tableau inférieure, on la soustraie
        ((nombre_a_convertir-=val))
    done
    echo "${valeurs_en_romain}"
}

main(){
    #On fixe un nombre maximal que l'on ne peut pas dépasser 
    local nb_max=3999
    #On teste la valeure pour s'assurer qu'elle corresponde bien à l'interval proposé.
    if [ "$#" -ne 1 ] || [[ "${1}" -lt 1 || "${1}" -gt "$nb_max" ]]
    then
        echo "Le script doit s'exécuer de la façon suivante: conv_vers_romain.sh <chiffre à convertir> cette valeur doit etre comptise entre 1 and $nb_max."
        exit 0
    else
	#dès lors, on peut commencer la conversion
        convertir_vers_romain "${1}"
    fi
}

main "$@"
