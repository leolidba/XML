<xsl:stylesheet version="1.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output omit-xml-declaration="yes" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:variable name="apos">'</xsl:variable>

    <xsl:template match="*[@* or not(*)]">
      <xsl:if test="not(*)">
         <xsl:value-of select="concat (', l.value( ', $apos, '(')"/>
         <xsl:apply-templates select="ancestor-or-self::*" mode="path"/>
         <xsl:value-of select="concat (')[1]', $apos, ', ', $apos, 'VARCHAR(50)', $apos, ' ) AS [')"/>
         <xsl:apply-templates select="ancestor-or-self::*" mode="columnName"/>
         <xsl:value-of select="concat ('', ']')"/>

         <xsl:text>&#xA;</xsl:text>
      </xsl:if>
      <xsl:apply-templates select="*|*"/>
    </xsl:template>

    <xsl:template match="*" mode="path">
        <xsl:value-of select="concat('/',name())"/>
        <xsl:variable name="vnumPrecSiblings" select=
         "count(preceding-sibling::*[name()=name(current())])"/>
        <xsl:if test="$vnumPrecSiblings">
            <xsl:value-of select="concat('[', $vnumPrecSiblings +1, ']')"/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="*" mode="columnName">
        <xsl:value-of select="concat('_',name())"/>
        <xsl:variable name="vnumPrecSiblings" select=
         "count(preceding-sibling::*[name()=name(current())])"/>
        <xsl:if test="$vnumPrecSiblings">
            <xsl:value-of select="concat('[', $vnumPrecSiblings +1, ']')"/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="@*">
        <xsl:apply-templates select="../ancestor-or-self::*" mode="path"/>
        <xsl:value-of select="concat('[@',name(), '=',$apos,.,$apos,']')"/>
        <xsl:text>&#xA;</xsl:text>
    </xsl:template>
</xsl:stylesheet>
