#! /bin/bash
# Aquest guió realitza comprovacions bàsiques de l'exercici
# IMPORTANT: No cal entendre aquest codi per poder realitzar correctament l'exercici
# La superació de les validacions bàsiques NO implica que l'exercici estigui bé. En canvi, la no
# superació implica que l'exercici presenta un o més problemes.
lliurament=/tmp/lliurament.tar.gz
validfiles=ranquing_??_ok.xml
nonvalidfiles=ranquing_??_ko.xml
dtd=ranquing.dtd
hi_ha_error=0

for f in *.ok.xml; do
  xmllint --dtdvalid ranquing.dtd $f &> /dev/null
  if [[ "$?" != 0 ]]; 
  then
    hi_ha_error=1
    echo "hi_ha_error=$hi_ha_error amb $f"
    break
  fi
  echo "Validat $f"
done
echo "En passar els valids hi_ha_error=$hi_ha_error";
for f in *.ko.xml; do
  xmllint --dtdvalid ranquing.dtd $f &> /dev/null
  if [[ "$?" == 0 ]]; then hi_ha_error=1; echo "hi_ha_error=2"; break; fi
  echo "No Validat $f"
done

if [[ ! -f companys.xml ]]; then hi_ha_error=1; echo "hi_ha_error=3"; fi

if [[ "$hi_ha_error" == 0 ]];
then
  tar czvf "$lliurament" ranquing.dtd companys.xml > /dev/null
  echo "Validacions bàsiques superades. Considera lliurar el fitxer $lliurament"
else
  echo "Aquest lliurament no passa una o més comprovacions. Revisa els requeriments."
fi
