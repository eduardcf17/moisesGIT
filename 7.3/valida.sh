#! /bin/bash
# Aquest guió realitza comprovacions bàsiques de l'exercici
#
# IMPORTANT: No cal entendre aquest codi per poder realitzar correctament l'exercici
# La superació de les validacions bàsiques NO implica que l'exercici estigui bé. En canvi, la no
# superació implica que l'exercici presenta un o més problemes.
#

package=comprador.tar.gz
xsd=comprador.xsd
xmls=( comprador_01.xml comprador_02.xml )
definedns=http://agapesa.com/empleat
files="$xsd producte.xsd empleat.xsd ${xmls[@]}"

error() { echo "Error: $1" 1>&2; exit 1; }

for f in $files; do
    [ -f $f ] || error "No s'ha trobat el fitxer $f"
    xmllint $f &> /dev/null || error "El document $f no està ben format"
done

for p in import schemaLocation 'xmlns:'; do
  [[ "`grep -o $p $xsd | wc -l`" == 2 ]] || error "Revisa $p a $xsd"
done

for xml in ${xmls[@]}; do
    xmllint --schema $xsd $xml &> /dev/null || error "El document $xml no valida contra $xsd"
done
[[ "`grep -c denominacio $xsd`" == 0 ]] || error "Revisa si realment fas servir les definicions de producte i empleat a $xsd"
[[ "`xmllint --xpath 'count(//*[local-name()="producte"])=1' ${xmls[0]}`" == true ]] || error "Revisa el nombre de productes a ${xmls[0]}"
[[ "`xmllint --xpath 'count(//*[local-name()="producte"])>2' ${xmls[1]}`" == true ]] || error "Revisa el nombre de productes a ${xmls[1]}"

tar czvf $package $files > /dev/null
echo "Validacions bàsiques superades. Considera lliurar el fitxer $package"
