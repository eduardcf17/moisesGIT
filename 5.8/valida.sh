#! /bin/bash
# Aquest guió realitza comprovacions bàsiques de l'exercici
# IMPORTANT: No cal entendre aquest codi per poder realitzar correctament l'exercici
# La superació de les validacions bàsiques NO implica que l'exercici estigui bé. En canvi, la no
# superació implica que l'exercici presenta un o més problemes.
validfiles=diari_ok_??.xml
nonvalidfiles=diari_ko_??.xml
dtd=diari.dtd
paquet=diari.tar.gz
error() { echo "Error: $1" 1>&2; rm -f $onefile; exit 1; }

for f in $validfiles; do
  xmllint --dtdvalid $dtd $f &> /dev/null || error "$f no valida contra $dtd"
done

for f in $nonvalidfiles; do
  xmllint --dtdvalid $dtd $f &> /dev/null && error "$f valida contra $dtd"
done

for p in diari article tipus cos nota titol subtitol paragraf font autor noticia opinio valoracio id data ref;
do
    grep "$p" $dtd &> /dev/null || error "No es troba la paraula $p a $dtd"
done

tar czvf "$paquet" diari.dtd diari_??_[01]?.xml > /dev/null
echo "Validacions bàsiques superades. Considera lliurar el fitxer $paquet"
