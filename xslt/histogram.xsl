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
        select="count(child::surah) * $barInterval + $interbarSpacing"/>
    <xsl:variable name="yScale" select="300" as="xs:integer"/>
    <xsl:variable name="surahs" as="document-node()+"
        select="collection('../analyzedsuwarXML?select=*.xml')"/>
    

    <!-- stylesheet variables -->
    
    <xsl:template match="/">
        <svg height="{1.5 * $yScale}" width="{$xAxisLength + 100}"
            viewBox="-75 -{$yScale + 25} {$xAxisLength + 100} {1.5 * $yScale}"> 
            
            <g>

                
                <line x1="0" x2="{$xAxisLength}" y1="-{$yScale div 2}"
                    y2="-{$yScale div 2}" stroke="lightgray" stroke-dasharray="8 4" stroke-width="1"/>
                
                <!-- ruling lines                                    -->

                <xsl:apply-templates select="//surah"/>
                
                <!-- bars for devices                                -->

                <line x1="0" x2="{$xAxisLength}" y1="0" y2="0" stroke="black" stroke-width="1"
                    stroke-linecap="square"/>
                <line x1="0" x2="0" y1="0" y2="-{$yScale}" stroke="black" stroke-width="1"
                    stroke-linecap="square"/>

                <!-- axes and labels  -->

                <text x="-5" y="0" text-anchor="end" dominant-baseline="middle">0</text>
                <text x="-5" y="-{$yScale div 2}" text-anchor="end" dominant-baseline="middle">50%</text>
                <text x="-5" y="-{$yScale}" text-anchor="end" dominant-baseline="middle">100%</text>
                
                <!-- Y axis interval labels (0%, 50%, 100%)         -->

                <text x="{$xAxisLength div 2}" y="50" text-anchor="middle" font-size="x-large">Device</text>
                <text x="-50" y="-{$yScale div 2}" text-anchor="middle" writing-mode="tb"
                    font-size="x-large">Count of Device</text>
                <text x="{$xAxisLength div 2}" y="90" text-anchor="middle" font-size="xx-large">Instances of Rhetorical Devices by Text</text>
                
                <!-- General labels (X, Y, graph)                   -->
                
            </g>
        </svg>
        
    </xsl:template>
    
    <xsl:template match="surah"> <!-- must be sorted by text -->
        
        <xsl:variable name="surahPos" select="position() - 1" as="xs:integer"/>
        <xsl:variable name="xPosition" select="$surahPos * $barInterval + $interbarSpacing"
            as="xs:double"/>
        <xsl:variable name="midBarPostion" as="xs:double" select="$xPosition + $barWidth div 2"/>
        
        <xsl:variable name="totalAmp" select="count(amplification)" as="xs:double"/>
        <xsl:variable name="totalEmph" select="count(emph)" as="xs:double"/>
        <xsl:variable name="totalComparison" select="count(comparison)" as="xs:double"/>
        <xsl:variable name="totalImagery" select="count(imagery)" as="xs:double"/>
        <xsl:variable name="totalRepetition" select="count(repetition)" as="xs:double"/>
        <xsl:variable name="totalAllusion" select="count(allusion)" as="xs:double"/>
        <xsl:variable name="totalIrony" select="count(irony)" as="xs:double"/>
        <xsl:variable name="totalRetoricalQ" select="count(rhetoricalQuestion)" as="xs:double"/>
        
        <xsl:variable name="barHeight_Amp" select="$totalAmp * $yScale" as="xs:double"/>
        <xsl:variable name="barHeight_Emph" select="$totalAmp * $yScale" as="xs:double"/>
        <xsl:variable name="barHeight_Comparison" select="$totalAmp * $yScale" as="xs:double"/>
        <xsl:variable name="barHeight_Imagery" select="$totalAmp * $yScale" as="xs:double"/>
        <xsl:variable name="barHeight_Repetition" select="$totalAmp * $yScale" as="xs:double"/>
        <xsl:variable name="barHeight_Allusion" select="$totalAmp * $yScale" as="xs:double"/>
        <xsl:variable name="barHeight_Irony" select="$totalAmp * $yScale" as="xs:double"/>
        <xsl:variable name="barHeight_RetoricalQ" select="$totalRetoricalQ * $yScale" as="xs:double"/>
        
        <xsl:variable name="device" select="." as="xs:string"/>
        
        <rect x="{$xPosition}" y="-{$barHeight_Amp}" stroke="black" stroke-width=".5" fill="blue"
            width="{$barWidth}" height="{$barHeight_Amp}"/>
        <text x="{$midBarPostion}" y="20" text-anchor="middle" fill="black" font-size="small">
            <xsl:value-of select="$device"/>
        </text>
        
        
    </xsl:template>
    
</xsl:stylesheet>
