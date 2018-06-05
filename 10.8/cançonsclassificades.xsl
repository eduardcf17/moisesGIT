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
                <p>Aquestes són les cançons per una vida</p>
            <ul>
         <li><a href="#seglepassat">Cançons del segle passat</a></li>
         <li><a href="#decadapassada">Cançons de la dècada passada</a></li>
         <li><a href="#actuals">Cançons actuals</a></li>
      </ul>
      <h2 id="seglepassat">Cançons del segle passat</h2>
                <table border="1">
                    <tr>
                        <th>Any</th>
                        <th>Títol</th>
                        <th>Artista</th>
                    </tr>
                    <xsl:apply-templates select="//canso[@any &lt; 2000]">
                        <xsl:sort select="@any" order="ascending"/>
                    </xsl:apply-templates>
                </table>
                <h2 id="decadapassada">Cançons de la dècada passada</h2>
                 <table border="1">
                    <tr>
                        <th>Any</th>
                        <th>Títol</th>
                        <th>Artista</th>
                    </tr>
                    <xsl:apply-templates select="//canso[@any &gt;= 2000 and @any &lt; 2010 ]">
                        <xsl:sort select="@any" order="ascending"/>
                    </xsl:apply-templates>
                </table>
                <h2 id="actuals">Cançons actuals</h2>
                <table border="1">
                    <tr>
                        <th>Any</th>
                        <th>Títol</th>
                        <th>Artista</th>
                    </tr>
                    <xsl:apply-templates select="//canso[@any &gt;= 2010 ]">
                        <xsl:sort select="@any" order="ascending"/>
                    </xsl:apply-templates>
                </table>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="//canso">
        <tr>
            <td><xsl:value-of select="@any"/></td>
            <td><xsl:value-of select="titol"/></td>
            <td><xsl:value-of select="artista"/></td>
        </tr>
    </xsl:template>
</xsl:stylesheet>