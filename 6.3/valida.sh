#! /bin/bash
# Aquest guió realitza comprovacions bàsiques de l'exercici
# IMPORTANT: No cal entendre aquest codi per poder realitzar correctament l'exercici
# La superació de les validacions bàsiques NO implica que l'exercici estigui bé. En canvi, la no
# superació implica que l'exercici presenta un o més problemes.
paquet=quantitats.tar.gz

error() { echo "Error: $1" 1>&2; exit 1; }

for f in minims.xml maxims.xml quantitats.xsd validamaxims.xsd validaminims.xsd;
do
  [ -f $f ] || error "No es troba el fitxer $f"
done

for p in un-i-nomes-un hi-es-un-cop-o-no-hi-es tres-cops-exactament entre-un-i-dotze \
  hi-ha-com-a-molt-set obligatori-i-indefinit quants-vulguis;
do
  grep "$p" quantitats.xsd &> /dev/null
  [ "$?" -ne 0 ] && error "No es troba la paraula $p a quantitats.xsd"
done

for d in quantitats.xsd validamaxims.xsd;
do
  xmllint --schema $d maxims.xml &> /dev/null
  [[ "$?" != 0 ]] && error "$d no valida maxims.xml"
done

for d in quantitats.xsd validaminims.xsd;
do
  xmllint --schema $d minims.xml &> /dev/null || error "$d no valida minims.xml"
done

for d in quantitats.xsd validaminims.xsd validamaxims.xsd;
do
    [[ "`grep -c 'xmlns:\w.*=' $d`" == 0 ]] || error "No està permés definir espais de noms prefixats"
    [[ "`xmllint --xpath 'count(/*[name()="schema"]/*) = 1' $d`" == "true" ]] || error "Només es permet definir globalment l'arrel"
done

tar czvf "$paquet" *.x?? > /dev/null
echo "Validacions bàsiques superades. Considera lliurar el fitxer $paquet"
