#! /bin/bash
# Aquest guió realitza comprovacions bàsiques de l'exercici
#
# IMPORTANT: No cal entendre aquest codi per poder realitzar correctament l'exercici
# La superació de les validacions bàsiques NO implica que l'exercici estigui bé. En canvi, la no
# superació implica que l'exercici presenta un o més problemes.
#
xml=cançons.xml
xslt=cançonsclassificades.xsl
expected=cançonsperunavida.html
tmp=`mktemp`
error() { echo -e "Error: $1" 1>&2; rm -f $tmp; exit 1; }

for f in $xml $xslt $expected; do
    [ -f $f ] || error "No es troba el fitxer $f"
done

java net.sf.saxon.Transform $xml -xsl:$xslt -o:$tmp &> /dev/null || error "No s'ha pogut realitzar la transformació"

diff -BbwZ $tmp $expected &> /dev/null || error "La sortida obtinguda no és l'esperada"

rm -f $tmp
echo "Validacions bàsiques superades. Considera lliurar el fitxer $xslt"
