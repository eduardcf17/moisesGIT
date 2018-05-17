#! /bin/bash
# Aquest guió realitza comprovacions bàsiques de l'exercici
#
# IMPORTANT: No cal entendre aquest codi per poder realitzar correctament l'exercici
# La superació de les validacions bàsiques NO implica que l'exercici estigui bé. En canvi, la no
# superació implica que l'exercici presenta un o més problemes.
#
xml=reptes.xml
xsd=reptes.xsd
basexml=cançons.xml
total=5
tmp1=`mktemp`
tmp2=`mktemp`
error() { echo -e "Error: $1" 1>&2; rm -f $tmp1 $tmp2; exit 1; }
interpretaxsd() {
    grep -F "$xml validates" $tmp1 &> /dev/null && return
    grep -F "attribute 'nr' is required" $tmp1 &> /dev/null && error "Hi ha elements sense l'atribut 'nr'"
    grep -F "The value has a length of '0'" $tmp1 &> /dev/null && error "Hi ha elements buits"
    error "$xml no valida contra $xsd"
}
checkexpressio(){
    solucio=$2
    solucio=${solucio//&lt;/<}
    solucio=${solucio//&gt;/>}
    xmllint --xpath "$solucio" $basexml &> $tmp1; echo >> $tmp1
    diff -wB $tmp1 $tmp2 || error "El resultat de l'expressió nr $1 no és l'esperat.  L'esperat és:\n`cat $tmp2`"
}

for f in $xml $xsd $basexml; do
    [ -f $f ] || error "No es troba el fitxer $f"
done

xmllint --schema $xsd $xml &> $tmp1
interpretaxsd

delivered=`xmllint --xpath 'count(//repte)' $xml`
for nr in $(seq 1 $delivered); do
    echo > $tmp1; echo > $tmp2
    xpath="//repte[@nr=\"$nr\"]"
    xpath_count="count($xpath)"
    quants=`xmllint --xpath $xpath_count $xml`
    [[ "$quants" = "0" ]] && error "No es troba el repte $nr. T'has saltat algún número?"
    [[ "$quants" > "1" ]] && error "Més d'un repte amb el nr $nr"
    xpath_solucio="//repte[@nr=\"$nr\"]/solucio/text()"
    xpath_sortida="//repte[@nr=\"$nr\"]/sortida/text()"
    solucio="`xmllint --xpath $xpath_solucio $xml`"
    xmllint --xpath $xpath_sortida $xml > $tmp2; echo >> $tmp2
    sed -i 's/<!\[CDATA\[//' $tmp2; sed -i 's/]]>//' $tmp2
    checkexpressio $nr "$solucio" 
done
[[ "$delivered" < "$total" ]] && echo "Atenció: has lliurat només $delivered de $total"
rm -f $tmp1 $tmp2
echo "Validacions bàsiques superades. Considera lliurar el fitxer $xml"
