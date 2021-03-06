#! /bin/bash
# Aquest guió realitza comprovacions bàsiques de l'exercici
#
# IMPORTANT: No cal entendre aquest codi per poder realitzar correctament l'exercici
# La superació de les validacions bàsiques NO implica que l'exercici estigui bé. En canvi, la no
# superació implica que l'exercici presenta un o més problemes.
#
xsd=carta.xsd
xmls=carta_??.xml
onefile=`mktemp`

error() { echo "Error: $1" 1>&2; rm -f $onefile; exit 1; }

[[ "`grep -c '<[^/]*choice' carta.xsd`" == "1" ]] || error "S'espera només un <choice>"
for f in $xmls;
do
    expected=${f/xml/exp}
    xmllint --noout --schema $xsd $f &> $onefile
    df=`diff $onefile $expected`
    [[ "$df" == "" ]] && continue 
    echo "S'ha trobat un error mentre es validava el document $f"
    echo
    echo "Aquesta és la sortida que ha generat el teu document"
    echo "----------------------------------------------------"
    cat $onefile
    echo
    echo "Y aquesta és la sortida que s'esperava"
    echo "--------------------------------------"
    cat $expected
    echo
    error "Revisa l'error"
done
rm -f $onefile

echo "Validacions bàsiques superades. Considera lliurar el fitxer $xsd"
