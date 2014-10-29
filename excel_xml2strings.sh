#! /bin/sh
SAXON_PATH=~/Development/saxon
java -cp $SAXON_PATH/saxon9he.jar net.sf.saxon.Transform -s:$1 -xsl:excel_xml2strings.xsl

