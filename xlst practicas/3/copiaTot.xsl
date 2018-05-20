<?xml version="1.0"?>
<!-- Demostració de còpia de continguts -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" />
    <xsl:template match="/">
        <xsl:copy-of select="." />
    </xsl:template>
</xsl:stylesheet>