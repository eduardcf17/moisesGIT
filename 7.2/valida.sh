#! /bin/bash
# Aquest guió realitza comprovacions bàsiques de l'exercici
#
# IMPORTANT: No cal entendre aquest codi per poder realitzar correctament l'exercici
# La superació de les validacions bàsiques NO implica que l'exercici estigui bé. En canvi, la no
# superació implica que l'exercici presenta un o més problemes.
#

package=empleats.tar.gz
xsd=empleats.xsd
xsd2=empleat.xsd
xml=empleats.xml
definedns=http://agapesa.com/empleat

error() { echo "Error: $1" 1>&2; exit 1; }

for f in $xsd $xsd2 $xml; do
    [ -f $f ] || error "No s'ha trobat el fitxer $f"
    xmllint $f &> /dev/null || error "El document $f no està ben format"
done

for p in import schemaLocation; do
  [[ "`grep -c $p $xsd`" == 1 ]] || error "Revisa $p a $xsd"
done

xmllint --schema $xsd $xml &> /dev/null || error "El document $xml no valida contra $xsd"

[[ "`xmllint --xpath 'count(//*[local-name()="nom"])>2' $xml`" == true ]] || error "Revisa nr empleats a $xml"

tar czvf $package $xsd $xsd2 $xml > /dev/null
echo "Validacions bàsiques superades. Considera lliurar el fitxer $package"
