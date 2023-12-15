if [ "$#" -ne 1 ]; then
     echo "Usage: $0 [fichier_objet]"
     exit 1
 fi
 
 # Nom du fichier objet
 fichier_objet=$1
 
 objdump -d $fichier_objet | grep "^ " | awk '{ for (i = 2; i <= NF; i++) if ($i ~ /^[0-9a-fA-F]+$/) print $i; }' | tr -d '\n' | sed 's/.\{2\}/\\x&/g'
