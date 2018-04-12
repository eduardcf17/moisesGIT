#! /bin/bash
# Aquest guió realitza comprovacions bàsiques de l'exercici
# IMPORTANT: No cal entendre aquest codi per poder realitzar correctament l'exercici
# La superació de les validacions bàsiques NO implica que l'exercici estigui bé. En canvi, la no
# superació implica que l'exercici presenta un o més problemes.
xsd=totselssimpsons.xsd
xml_docs="elssimpsons.xml lessimpsons.xml"
paquet=totselssimpsons.tar.gz
error() { echo "Error: $1" 1>&2; exit 1; }

for f in $xml_docs $xsd;
do
  [ -f $f ] || error "No es troba el fitxer $f"
done

xmllint --schema $xsd $xml_docs &> /dev/null || error "No validen $xml_docs contra $xsd"

[[ "`grep -c 'xmlns:\w.*=' $xsd`" == 0 ]] || error "No està permés definir espais de noms prefixats"
[[ "`xmllint --xpath 'count(/*[name()="schema"]/*) = 1' $xsd`" == "true" ]] || error "Només es permet definir globalment l'arrel" tar czvf "$paquet" *.x?? > /dev/null

tar czvf $paquet $xml_docs $xsd > /dev/null
echo "Validacions bàsiques superades. Considera lliurar el fitxer $paquet"
