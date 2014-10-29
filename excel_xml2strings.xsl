<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:this="https://github.com/fourier/xmltools/excel2strings"
                xmlns:o="urn:schemas-microsoft-com:office:office"
                xmlns:x="urn:schemas-microsoft-com:office:excel"
                xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
                xmlns:html="http://www.w3.org/TR/REC-html40">


  <xsl:output indent="no" method="text"/>
  <xsl:strip-space elements="*" />

  <xsl:template match="ss:Row" mode="this:extract-nth-value">
    <xsl:param name="index"/>
    <xsl:value-of select="ss:Cell[$index]"/>
  </xsl:template>

  <xsl:template match="ss:Table" mode="this:print-column-to-file">
    <xsl:param name="index"/>
    <xsl:variable name="column-name">
      <xsl:apply-templates select="ss:Row[1]" mode="this:extract-nth-value">
        <xsl:with-param name="index" select="$index"/>
      </xsl:apply-templates>
    </xsl:variable>
    <xsl:variable name="filename" select="concat($column-name, '.xml')"/>
    <xsl:message><xsl:value-of select="concat('Writing to ', $column-name, ' column ', $index)"/></xsl:message>
    <xsl:result-document href="$filename" method="xml">
      
    </xsl:result-document>
  </xsl:template>
  
  <xsl:template match="ss:Table">
    <xsl:param name="sheet"/>
    <xsl:if test="count(ss:Row) > 0">
      <xsl:for-each select="ss:Column[position() > 1]">
        <xsl:apply-templates select=".." mode="this:print-column-to-file">
          <!-- skipping 1st position, so the index is 2-based -->
          <xsl:with-param name="index" select="position()+1"/>
        </xsl:apply-templates>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="ss:Worksheet">
    <xsl:variable name="name" select="@ss:Name"/>
    <xsl:message><xsl:value-of select="concat('Processing Worksheet ', $name)"/></xsl:message>
    <xsl:apply-templates select="ss:Table">
      <xsl:with-param name="sheet" select="$name"/>
    </xsl:apply-templates>
  </xsl:template>
  
  <!-- process worksheets -->
  <xsl:template match="ss:Workbook">
    <xsl:message>Processing Workbook</xsl:message>
    <xsl:apply-templates select="ss:Worksheet"/>
    <!--xsl:variable name="file-name" select="'strings.csv'"/>
    <xsl:result-document href="{$file-name}" method="text">
      <xsl:value-of select="'Element id,String&#10;'"/>
      <xsl:for-each select="string">
        <xsl:value-of select="concat(@name, ',', ., '&#10;')"/>
      </xsl:for-each>
    </xsl:result-document-->
  </xsl:template>

  
</xsl:stylesheet>
