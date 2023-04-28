<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/2000/svg"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

    <xsl:variable name="surahs" as="document-node()+"
        select="collection('../analyzedsuwarXML?select=*.xml')"/> <!--collect surahs -->
 
    <xsl:variable name="surahVersionIdentifiers" as="xs:string+"
        select="$surahs ! concat(descendant::body/@xml:lang, descendant::translator) => distinct-values()"/> <!--create unique ID for each surah -->
    
    <xsl:variable name="distinctDevices" as="xs:string+"
        select="$surahs//ayah/descendant::* ! name() => distinct-values()"/> <!-- collect list of distinct devices -->

    <xsl:variable name="barWidth" select="20" as="xs:integer"/>
    <xsl:variable name="interbarSpacing" select="$barWidth" as="xs:double"/>
    <xsl:variable name="barInterval"
        
        select="$barWidth * count($surahVersionIdentifiers) + $interbarSpacing" as="xs:double"/>
    <xsl:variable name="xAxisLength" as="xs:double"
        select="3 * count($surahVersionIdentifiers) * $barInterval + $interbarSpacing"/>
    <xsl:variable name="maxHeight" select="300" as="xs:integer"/>
    <xsl:variable name="yScale" as="xs:integer" select="3"/>
    <xsl:variable name="colors" as="xs:string+" select="'#03AC13', '#5DBB63', '#466D1D'"/>


    <!-- stylesheet variables -->

    <xsl:template name="xsl:initial-template">
        <svg height="{1.5 * $maxHeight}" width="{$xAxisLength + 100}"
            viewBox="-75 -{$maxHeight + 25} {$xAxisLength + 100} {1.5 * $maxHeight}">
                
            <xsl:for-each select="1 to 4">                                                                  <!-- ruling lines  -->
                <line x1="0" x2="{$xAxisLength}" y1="-{. * .25 * $maxHeight}"
                    y2="-{. * .25 * $maxHeight}" stroke="gray" stroke-dasharray="3"/>
                <text x="-5" y="-{. * .25 * $maxHeight}" dominant-baseline="middle"
                    text-anchor="end" font-size="10">
                    <xsl:value-of select=". * 25"/>
                </text>
            </xsl:for-each>

            <!-- collect all of devices and group by device types, and within these group versions, all descendants of ayah elements,
                    if we use for each group we cannot reserve space for things no there, we want zero height bar,  division of devices
            michael kay, pg 334, look what he says, grouping key and concating, to do: clean up graph, shorten x, remove percent, make emph and questions full words
            excl-->
            
            <xsl:for-each select="$distinctDevices[not(. = ('name' , 'place'))]">                           <!-- exclude name and place from visualization -->
                <xsl:sort/>
                <xsl:variable name="currentDevice" as="xs:string" select="."/>
                <xsl:variable name="xPos" as="xs:double"
                    select="(count($surahVersionIdentifiers) * $barWidth + $interbarSpacing) * (position() - 1)"/>
                <text x="{$xPos + (count($surahVersionIdentifiers) * $barWidth div 2)}" y="13"
                    text-anchor="middle" font-size="smaller" >
                    <xsl:value-of select="$currentDevice"/>                                                 <!-- device labels on x-axis -->
                </text>
                <xsl:for-each-group select="$surahs" 
                    group-by="concat(descendant::body/@xml:lang, descendant::translator)">                  <!-- divide 9 total surahs into 3 text groups using lang attribute and translator -->
                    <xsl:sort select="current-grouping-key()"/>
                    <xsl:variable name="barOffset" as="xs:integer" select="position()"/>
                    <xsl:variable name="barXPos" as="xs:double"
                        select="$xPos + (position() - 1) * $barWidth"/>
                    <xsl:variable name="versionDevices" as="element()*"
                        select="current-group()/descendant::*[local-name() eq $currentDevice]"/>
                    <xsl:variable name="barHeight" as="xs:double"
                        select="count($versionDevices) * $yScale"/>                                         <!-- create bars -->
                    <rect x="{$barXPos}" y="-{$barHeight}" width="{$barWidth}" height="{$barHeight}" 
                        fill="{$colors[$barOffset]}"/>
                    <text x="{$barXPos + 10}" y="-{$barHeight + 3}" font-size="smaller" text-anchor="middle"> <xsl:value-of select="count($versionDevices)"/></text>
                </xsl:for-each-group>
            </xsl:for-each>
            


            <line x1="0" x2="{$xAxisLength}" y1="0" y2="0" stroke="black" stroke-width="1"
                stroke-linecap="square"/>
            <line x1="0" x2="0" y1="0" y2="-{$maxHeight}" stroke="black" stroke-width="1"
                stroke-linecap="square"/>
            <text x="{$xAxisLength div 2}" y="50" text-anchor="middle" font-size="x-large"
                >Device</text>
            <text x="-50" y="-{$maxHeight div 2}" text-anchor="middle" writing-mode="tb"
                font-size="x-large">Count of Device</text>
            <text x="{$xAxisLength div 2}" y="90" text-anchor="middle" font-size="xx-large"
                >Instances of Rhetorical Devices by Text</text>                                             <!-- axes and labels  -->
            
            
            
            <circle cx="{$xAxisLength - 80}" cy="-{$maxHeight * (2 div 3)}" r="10" fill="#03AC13"/>
            <text x="{$xAxisLength - 70}" y="-{$maxHeight * (2 div 3)-5}" font-size="12"
                dominant-baseline="middle">Original</text>
            <circle cx="{$xAxisLength - 80}" cy="-{$maxHeight * (2 div 3) - 20}" r="10" fill="#5DBB63"/>
            <text x="{$xAxisLength - 70}" y="-{$maxHeight * (2 div 3) - 25}" font-size="12"
                dominant-baseline="middle">Ali translation</text>
            <circle cx="{$xAxisLength -80}" cy="-{$maxHeight * (2 div 3)-40}" r="10" fill="#466D1D"/>
            <text x="{$xAxisLength - 70}" y="-{$maxHeight * (2 div 3)-43}" font-size="12"
                dominant-baseline="middle">Pickthall translation</text>
            
            
        </svg>

    </xsl:template>


</xsl:stylesheet>
