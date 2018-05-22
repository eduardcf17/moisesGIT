<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes" />
    <xsl:template match="/">
    		<cansons>
				<xsl:apply-templates />
			</cansons>
    	</xsl:template>
<xsl:template match="//canso">
	<canso>
		<xsl:apply-templates />
	</canso>
</xsl:template>

    <xsl:template match="//canso/*">
     	<xsl:copy-of select="." />   
    </xsl:template>

  <xsl:template match="text()"/>
 
</xsl:stylesheet>