<?xml version="1.0"?>
<!-- Demostració de còpia de part dels continguts -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes" />
    	<xsl:template match="assistents">
			<pisos-assistents>
				<xsl:apply-templates />
			</pisos-assistents>
    	</xsl:template>
		<xsl:template match="assistents/assistent/pis">
        		<xsl:copy-of select="." />
    </xsl:template>

    <xsl:template match="text()"/>

</xsl:stylesheet>