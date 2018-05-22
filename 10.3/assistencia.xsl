<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes" />
    	<xsl:template match="/">
    		<resum-acta>
				<xsl:apply-templates />
			</resum-acta>
    	</xsl:template>

    	<xsl:template match="comunitat">
    		<xsl:copy-of select="." />
    	</xsl:template>

    	<xsl:template match="noassistents">
    		<xsl:copy-of select="." />
    		<assistents>
    		 <xsl:for-each select="/acta/assistents/assistent/pis">
    		 	   <xsl:copy-of select="."/>

    		 </xsl:for-each>
    		</assistents>
    	</xsl:template>



     <xsl:template match="text()"/>
</xsl:stylesheet>