#! /bin/bash
# Aquest guió realitza comprovacions bàsiques de l'exercici
#
# IMPORTANT: No cal entendre aquest codi per poder realitzar correctament l'exercici
# La superació de les validacions bàsiques NO implica que l'exercici estigui bé. En canvi, la no
# superació implica que l'exercici presenta un o més problemes.
#

package=empleat.tar.gz
xsd=empleat.xsd 
xml1=empleat1.xml
xml2=empleat2.xml
definedns=http://agapesa.com/empleat

error() { echo "Error: $1" 1>&2; exit 1; }

for f in $xsd $xml1 $xml2; do
    [ -f $f ] || error "No s'ha trobat el fitxer $f"
    xmllint $f &> /dev/null || error "El document $f no està ben format"
done

[[ "`grep -c 'xs:string' $xsd`" == 6 ]] || error "Prefix no declarat per espai de noms de $xsd"
[[ "`grep -c $definedns $xsd`" == 1 ]] || error "No es declara l'espai de noms $definedns a $xsd"

for f in $xml1 $xml2; do
    xmllint --schema $xsd $f &> /dev/null || error "El document $f no valida contra $xsd"
    [[ "`grep -c $definedns $f`" == 1 ]] || error "No s'especifica l'espai de noms $definedns a $f"
done

[[ "`grep -c '<nom>' $xml1`" == 1 ]] || error "No declarat l'espai de noms a $xml1 segons requeriments"
[[ "`grep -c '<emp:nom>' $xml2`" == 1 ]] || error "No declarat l'espai de noms a $xml2 segons requeriments"

tar czvf $package $xsd $xml1 $xml2 > /dev/null
echo "Validacions bàsiques superades. Considera lliurar el fitxer $package"
