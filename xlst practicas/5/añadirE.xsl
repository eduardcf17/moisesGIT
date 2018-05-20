<?xml version="1.0"?>
<!-- Demostració de còpia de part dels continguts -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes" />

    <xsl:strip-space elements="*" />

    <xsl:template match="assistents">
        <participació>
  <!-- com no pertany a l'espai de noms xsl, es copia directament -->
            <xsl:apply-templates />     <!-- continua aplicant altres regles -->
        </participació>>
    </xsl:template>

    <xsl:template match="veí">
        <participant>
            <xsl:value-of select="." />
        </participant>
    </xsl:template>

    <xsl:template match="text()" />

</xsl:stylesheet>