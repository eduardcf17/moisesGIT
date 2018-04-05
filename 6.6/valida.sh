#! /bin/bash
# Aquest guió realitza comprovacions bàsiques de l'exercici
# IMPORTANT: No cal entendre aquest codi per poder realitzar correctament l'exercici
# La superació de les validacions bàsiques NO implica que l'exercici estigui bé. En canvi, la no
# superació implica que l'exercici presenta un o més problemes.
validfiles=acta_??_ok.xml
nonvalidfiles=acta_??_ko.xml
xsd=acta.xsd
error() { echo "Error: $1" 1>&2; exit 1; }

for f in $validfiles; do
  xmllint --schema $xsd $f &> /dev/null || error "$f no valida contra $xsd"
done

for f in $nonvalidfiles; do
  xmllint --schema $xsd $f &> /dev/null && error "$f valida contra $xsd"
done

[[ "`grep -c 'xmlns:\w.*=' $xsd`" == 0 ]] || error "No està permés definir espais de noms prefixats"
[[ "`xmllint --xpath 'count(/*[name()="schema"]/*) = 1' $xsd`" == "true" ]] || error "Només es permet definir globalment l'arrel" tar czvf "$paquet" *.x?? > /dev/null

echo "Validacions bàsiques superades. Considera lliurar el fitxer $xsd"
