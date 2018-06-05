<?xml version="1.0"?>
<!-- Demostració de creació de taules HTML -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes" />

    <xsl:template match="/">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
            	<title>Cançons per una vida</title>
            </head>
            <body>
                <h1>Cançons per una vida</h1>
                <table border="1">
                    <tr>
                        <th>Any</th>
                        <th>Títol</th>
                        <th>Artista</th>
                    </tr>
                     <xsl:for-each select="//canso" >
                        <tr>
                            <td><xsl:value-of select="@any"/></td>
                            <td><xsl:value-of select="titol"/></td>
                            <td><xsl:value-of select="artista"/></td>

                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>