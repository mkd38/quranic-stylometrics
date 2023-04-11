<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/2000/svg"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:variable name="barWidth" select="20" as="xs:integer"/>
    <xsl:variable name="interbarSpacing" select="$barWidth div 2" as="xs:double"/>
    <xsl:variable name="barInterval" select="$barWidth + $interbarSpacing" as="xs:double"/>
    <xsl:variable name="xAxisLength" as="xs:double"
        select="count(//surah) * $barInterval + $interbarSpacing"/>                 <!--x-axis length based on count of paper elements, bar interval and bar spacing-->
    <xsl:variable name="yScale" select="300" as="xs:integer"/>
    
    <!-- stylesheet variables -->
    
    <xsl:template match="/">                                                        <!-- document-level template -->
        
        <svg height="{1.5 * $yScale}" width="{$xAxisLength + 100}"  
            viewBox="-75 -{$yScale + 25} {$xAxisLength + 100} {1.5 * $yScale}">
            
            <!-- set graphic dimensions and viewbox dimensions -->
            
            <line x1="0" x2="{$xAxisLength}" y1="0" y2="0" stroke="black" stroke-width="1"
                stroke-linecap="square"/>
            <line x1="0" x2="0" y1="0" y2="-{$yScale}" stroke="black" stroke-width="1"
                stroke-linecap="square"/>
            <text x="{$xAxisLength div 2}" y="45" text-anchor="middle" font-size="x-large">Device</text>
            <text x="-50" y="-{$yScale div 2}" text-anchor="middle" writing-mode="tb"
                font-size="x-large">Raw Count</text>
            <text x="{$xAxisLength div 2}" y="90" text-anchor="middle" font-size="xx-large">Instances of Rhetorical Devices</text>
            
            <!-- x- and y-axes and graph title -->    
            
            <text x="-5" y="5" text-anchor="end">0</text>
            <text x="-5" y="-{$yScale div 4}" text-anchor="end">25</text>
            <line x1="0" x2="{$xAxisLength}" y1="-{$yScale div 4}" y2="-{$yScale div 4}" stroke="lightgray" stroke-width="1" stroke-dasharray="8 4"/>
            <text x="-5" y="-{$yScale div 2}" text-anchor="end">50</text>
            <line x1="0" x2="{$xAxisLength}" y1="-{$yScale div 2}" y2="-{$yScale div 2}" stroke="lightgray" stroke-width="1" stroke-dasharray="8 4"/>
            <text x="-5" y="-{$yScale - $yScale div 4}" text-anchor="end">75</text>
            <line x1="0" x2="{$xAxisLength}" y1="-{$yScale - $yScale div 4}" y2="-{$yScale - $yScale div 4}" stroke="lightgray" stroke-width="1" stroke-dasharray="8 4"/>
            <text x="-5" y="-{$yScale}" text-anchor="end">100</text>
            <line x1="0" x2="{$xAxisLength}" y1="-{$yScale}" y2="-{$yScale}" stroke="lightgray" stroke-width="1" stroke-dasharray="8 4"/>
            
            <!-- ruling lines -->
            
            <xsl:apply-templates select="//surah"/> 
            
        </svg>
        
    </xsl:template>
    
    
    <xsl:template match="surah">                                                    <!--paper-level template-->
        <xsl:variable name="paperPos" select="position() - 1" as="xs:integer"/>
        <xsl:variable name="xPosition" select="$paperPos * $barInterval + $interbarSpacing"
            as="xs:double"/>
        <xsl:variable name="midBarPostion" as="xs:double" select="$xPosition + $barWidth div 2"/>
        <xsl:variable name="barHeight_amplification" as="xs:double" select="count(./body/ayah/amplification)  * 3 "/> <!-- bar height based on raw count of nodes federalism * 3 to scale up to y-axis-->
        <xsl:for-each select=".">
            <rect x="{$xPosition}" y="-{$barHeight_amplification}" width="{$barWidth}" height="{$barHeight_amplification}" fill="blue"/>
            <text x="{$xPosition + 3}" y="-{$barHeight_amplification}"><xsl:apply-templates select="count(./body/ayah/amplification)"/></text> 
            <text x="{$xPosition}" y="{15}">
                <xsl:apply-templates select="count(./body/ayah/amplification)" mode="label"/></text>
        </xsl:for-each>
        
    </xsl:template>
    
</xsl:stylesheet>