#! /bin/sh
SAXON_PATH=~/Development/saxon
java -cp $SAXON_PATH/saxon9he.jar net.sf.saxon.Transform -s:$1 -xsl:strings2csv.xsl

