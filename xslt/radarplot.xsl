<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no"
        indent="yes"/>
    <!-- ================================================================ -->
    <!-- Document Collection                                                    -->
    <!-- ================================================================ -->
    <xsl:variable name="surahs" 
        as="document-node()+"
        select="collection('../analyzedsuwarXML?select=*.xml')"/> 
    <!-- ================================================================ -->
    <!-- Whole Stylesheet Variables                                             -->
    <!-- ================================================================ -->
    <xsl:variable name="max_devices" as="xs:double" select="88"/>
    <xsl:variable name="max_height" as="xs:double" select="$max_devices * 2"/>
    <xsl:variable name="max_width" as="xs:double" select="$max_devices * 2"/>
    <!-- template match -->
    <xsl:template match="$surahs">
    <svg preserveAspectRatio="xMinYMin meet"
            viewBox="-800 -800 800 800"
            width="100%"
            height="100%">
    <!-- ==================================================== -->
    <!-- Graph Title and Axis Labels                          -->
    <!-- ==================================================== -->
    <text x="{$max_width div 2}" y="-{$max_height + 300}" text-anchor="middle"
        font-size="50" font-weight="bold">Instances of Rhetorical Device by Text</text>
    <xsl:for-each select="1 to 5">                                                                  
        <!-- Ruling Lines  -->
        <polygon points="469.282153,560.498447 130.717847,560.498447 26.0957233,238.504658 300,39.5015528 573.904277,238.504658"></polygon>
        <text x="-5" y="-{. * .25 * $max_height}" dominant-baseline="middle"
            text-anchor="end" font-size="10">
            <xsl:value-of select=". * 25"/>
        </text>
    </xsl:for-each>
    <!-- ==================================================== -->
    <!-- Axis Lines                                           -->
    <!-- ==================================================== -->
    
    <xsl:for-each select="1 to 11">
    <xsl:variable name="angle" as="xs:double" select="360 div 11"/>
    <line x1="0" y1="0" x2="$angle " y2=""/>
        <text x="-5" y="-{. * .25 * $max_height}" dominant-baseline="middle"
            text-anchor="end" font-size="10">
            <xsl:value-of select=". * 25"/>
        </text>
    </xsl:for-each>
    
    
    
    
    
    
    
    
</svg>    
        </xsl:template>
    
    
    
</xsl:stylesheet>