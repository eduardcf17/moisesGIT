#! /bin/bash
# Aquest guió realitza comprovacions bàsiques de l'exercici
# IMPORTANT: No cal entendre aquest codi per poder realitzar correctament l'exercici
# La superació de les validacions bàsiques NO implica que l'exercici estigui bé. En canvi, la no
# superació implica que l'exercici presenta un o més problemes.
paquet=tipus.tar.gz
xsd=tipus.xsd
files="$xsd tipus.xml"
error() { echo "Error: $1" 1>&2; exit 1; }

for f in $files;
do
    [ -f $f ] || error "No es troba el fitxer $f"
    for p in arrel es_text es_token es_enter es_decimal es_boolean es_data es_hora es_data_i_hora es_duration;
    do
        [[ "`grep -c $p $f`" == 0 ]] && error "No es troba la paraula $p a $f"
    done
done

xmllint --schema $files &> /dev/null || error "No valida tipus.xml respecte tipus.xsd"

[[ "`grep -c 'xmlns:\w.*=' $xsd`" == 0 ]] || error "No està permés definir espais de noms prefixats"
[[ "`xmllint --xpath 'count(/*[name()="schema"]/*) = 1' $xsd`" == "true" ]] || error "Només es permet definir globalment l'arrel" tar czvf "$paquet" *.x?? > /dev/null

tar czvf "$paquet" $files > /dev/null
echo "Validacions bàsiques superades. Considera lliurar el fitxer $paquet"
