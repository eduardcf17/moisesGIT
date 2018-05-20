#! /bin/bash
# Aquest guió realitza comprovacions bàsiques de l'exercici
#
# IMPORTANT: No cal entendre aquest codi per poder realitzar correctament l'exercici
# La superació de les validacions bàsiques NO implica que l'exercici estigui bé. En canvi, la no
# superació implica que l'exercici presenta un o més problemes.
#
xml=expressions.xml
xsd=expressions.xsd
basexml=cançons.xml
total=34
tmp=`mktemp`
error() { echo "Error: $1" 1>&2; rm -f $tmp; exit 1; }
interpretaxsd() {
    grep -F "$xml validates" $tmp &> /dev/null && return
    grep -F "attribute 'nr' is required" $tmp &> /dev/null && error "Hi ha expressions sense l'atribut 'nr'"
    grep -F "The value has a length of '0'" $tmp &> /dev/null && error "Hi ha expressions buides"
    error "$xml no valida contra $xsd"
}
checkexpressio(){
    givenexpr=$2
    givenexpr=${givenexpr//&lt;/<}
    givenexpr=${givenexpr//&gt;/>}
    xmllint --xpath "$givenexpr" $basexml > $tmp
    expectedfilename="expressio_nr$1.out"
    diff $tmp $expectedfilename &> /dev/null || error "L'expressió $1 no genera el resultat esperat"
}

for f in $xml $xsd $basexml; do
    [ -f $f ] || error "No es troba el fitxer $f"
done

xmllint --schema $xsd $xml &> $tmp
interpretaxsd

for nr in $(seq 1 $total); do
    expressio="//expressio[@nr=\"$nr\"]/text()"
    exprcount="count($expressio)"
    quants=`xmllint --xpath $exprcount $xml`
    [[ "$quants" = "0" ]] && continue
    [[ "$quants" > "1" ]] && error "Més d'una expressió amb el nr $nr"
    givenexpr="`xmllint --xpath $expressio $xml`"
    checkexpressio $nr "$givenexpr"
done
delivered=`xmllint --xpath 'count(//expressio)' $xml`
[[ "$delivered" != "$total" ]] && echo "Atenció: has lliurat $delivered de $total"
rm -f $tmp
echo "Validacions bàsiques superades. Considera lliurar el fitxer $xml"
