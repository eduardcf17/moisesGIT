#! /bin/bash
# Aquest guió realitza comprovacions bàsiques de l'exercici
#
# IMPORTANT: No cal entendre aquest codi per poder realitzar correctament l'exercici
# La superació de les validacions bàsiques NO implica que l'exercici estigui bé. En canvi, la no
# superació implica que l'exercici presenta un o més problemes.
#
xsd=mesempleat.xsd
xmlok=empleat.xml
xmlko=malempleat.xml
error() { echo "Error: $1" 1>&2; rm -f $onefile; exit 1; }

[ -f $xsd ] || error "No es troba el fitxer $xsd"

for p in Contacte TipusContacte email mobil fax fix       \
    postal Empleat DenominacioEmpleat                     \
    TitolDenominacio "Sra." "Sr." "Dr." "Dra." Estimable  \
    CarrecEmpleat mindundi mandamenys mandames            \
    superboss Antiguitat contacte Nif;
do
    grep -F "$p" $xsd &> /dev/null || error "Comprova que aparegui \"$p\" a $xsd"
done

<<<<<<< HEAD
xmllint --noout --schema $xsd $xmlok &> /dev/null || error "$xmlok no valida contra $xsd"
xmllint --noout --schema $xsd $xmlko &> /dev/null && error "$xmlko valida contra $xsd però no ho hauria de fer"
=======
xmllint --noout --schema $xsd $xmlok || error "$xmlok no valida contra $xsd"
xmllint --noout --schema $xsd $xmlko && error "$xmlko valida contra $xsd però no ho hauria de fer"
>>>>>>> 01b79b440732576c233934e47a0ecf66d5af233f

echo "Validacions bàsiques superades. Considera lliurar el fitxer $xsd"
