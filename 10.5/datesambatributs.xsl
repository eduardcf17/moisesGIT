<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes" />
    
    <xsl:template match="//canso/data">
			<xsl:copy>	
				<xsl:copy-of select="@*"/>
				<xsl:attribute name="dia">
					<xsl:value-of select="dia"/>
				</xsl:attribute>
				<xsl:attribute name="mes">
					<xsl:value-of select="mes"/>
				</xsl:attribute>
				<xsl:attribute name="any">
					<xsl:value-of select="any"/>
				</xsl:attribute>
				<xsl:apply-templates select="*" />
			</xsl:copy>
   	</xsl:template>
 
 <xsl:template match="node()|@*">
			<xsl:copy>	
				<xsl:apply-templates select="node()|@*" />
			</xsl:copy>
   	</xsl:template>

<xsl:template match="//canso/data/dia"/>
<xsl:template match="//canso/data/mes"/>
<xsl:template match="//canso/data/any"/>
  
 
</xsl:stylesheet>