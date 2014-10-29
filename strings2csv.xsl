<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

  <xsl:output indent="no" method="text"/>
  <xsl:strip-space elements="*" />
  
  <xsl:template match="resources">
    <xsl:result-document href="strings.csv" method="text">
      <xsl:value-of select="'Element id,String&#10;'"/>
      <xsl:for-each select="string">
        <xsl:value-of select="concat(@name, ',', ., '&#10;')"/>
      </xsl:for-each>
    </xsl:result-document>
  </xsl:template>

</xsl:stylesheet>
