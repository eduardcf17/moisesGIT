<?xml version="1.0"?>
<!-- Demostració de còpia de part dels continguts -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes" />

    <!-- <xsl:strip-space elements="*" />         elimina espais innecessaris -->

    <xsl:template match="assistents">       <!-- regla per només els assistents -->
        <xsl:copy-of select="." />
    </xsl:template>
    <xsl:template match="noassistents">       <!-- regla per només els assistents -->
        <xsl:copy-of select="." />
    </xsl:template>

    <xsl:template match="text()"/>          <!-- regla per evitar el text de la resta -->

</xsl:stylesheet>