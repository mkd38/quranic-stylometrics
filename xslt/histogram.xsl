<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/2000/svg"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

    <xsl:variable name="surahs" as="document-node()+"
        select="collection('../analyzedsuwarXML?select=*.xml')"/>
    <xsl:variable name="surahVersionIdentifiers" as="xs:string+"
        select="$surahs ! concat(descendant::body/@xml:lang, descendant::translator) => distinct-values()"/>
    <xsl:variable name="distinctDevices" as="xs:string+"
        select="$surahs//ayah/descendant::* ! name() => distinct-values()"/>

    <xsl:variable name="barWidth" select="20" as="xs:integer"/>
    <xsl:variable name="interbarSpacing" select="$barWidth" as="xs:double"/>
    <xsl:variable name="barInterval"
        select="$barWidth * count($surahVersionIdentifiers) + $interbarSpacing" as="xs:double"/>
    <xsl:variable name="xAxisLength" as="xs:double"
        select="count($distinctDevices) * count($surahVersionIdentifiers) * $barInterval + $interbarSpacing"/>
    <xsl:variable name="maxHeight" select="300" as="xs:integer"/>
    <xsl:variable name="yScale" as="xs:integer" select="3"/>
    <xsl:variable name="colors" as="xs:string+" select="'purple', 'red', 'blue'"/>


    <!-- stylesheet variables -->

    <xsl:template name="xsl:initial-template">
        <svg height="{1.5 * $maxHeight}" width="{$xAxisLength + 100}"
            viewBox="-75 -{$maxHeight + 25} {$xAxisLength + 100} {1.5 * $maxHeight}">

            <!-- collect all of devices and group by device types, and within these group versions, all descendants of ayah elements,
                    if we use for each group we cannot reserve space for things no there, we want zero height bar,  division of devices
            michael kay, pg 334, look what he says, grouping key and concating, to do: clean up graph, shorten x, remove percent, make emph and questions full words
            excl-->
            <xsl:for-each select="$distinctDevices[not(. = ('name' , 'place'))]">
                <xsl:sort/>
                <xsl:variable name="currentDevice" as="xs:string" select="."/>
                <xsl:variable name="xPos" as="xs:double"
                    select="(count($surahVersionIdentifiers) * $barWidth + $interbarSpacing) * (position() - 1)"/>
                <text x="{$xPos + (count($surahVersionIdentifiers) * $barWidth div 2)}" y="13"
                    text-anchor="middle" font-size="smaller">
                    <xsl:value-of select="$currentDevice"/>
                </text>
                <xsl:for-each-group select="$surahs"
                    group-by="concat(descendant::body/@xml:lang, descendant::translator)">
                    <xsl:sort select="current-grouping-key()"/>
                    <xsl:variable name="barOffset" as="xs:integer" select="position()"/>
                    <xsl:variable name="barXPos" as="xs:double"
                        select="$xPos + (position() - 1) * $barWidth"/>
                    <xsl:variable name="versionDevices" as="element()*"
                        select="current-group()/descendant::*[local-name() eq $currentDevice]"/>
                    <xsl:variable name="barHeight" as="xs:double"
                        select="count($versionDevices) * $yScale"/>
                    <rect x="{$barXPos}" y="-{$barHeight}" width="{$barWidth}" height="{$barHeight}"
                        fill="{$colors[$barOffset]}"/>
                </xsl:for-each-group>
            </xsl:for-each>
            <line x1="0" x2="{$xAxisLength}" y1="-{$maxHeight div 2}" y2="-{$maxHeight div 2}"
                stroke="lightgray" stroke-dasharray="8 4" stroke-width="1"/>

            <!-- ruling lines                                    -->

            <!-- bars for devices                                -->

            <line x1="0" x2="{$xAxisLength}" y1="0" y2="0" stroke="black" stroke-width="1"
                stroke-linecap="square"/>
            <line x1="0" x2="0" y1="0" y2="-{$maxHeight}" stroke="black" stroke-width="1"
                stroke-linecap="square"/>

            <!-- axes and labels  -->

            <text x="-5" y="0" text-anchor="end" dominant-baseline="middle">0</text>
            <text x="-5" y="-{$maxHeight div 2}" text-anchor="end" dominant-baseline="middle"
                >50%</text>
            <text x="-5" y="-{$maxHeight}" text-anchor="end" dominant-baseline="middle">100%</text>

            <!-- Y axis interval labels (0%, 50%, 100%)         -->

            <text x="{$xAxisLength div 2}" y="50" text-anchor="middle" font-size="x-large"
                >Device</text>
            <text x="-50" y="-{$maxHeight div 2}" text-anchor="middle" writing-mode="tb"
                font-size="x-large">Count of Device</text>
            <text x="{$xAxisLength div 2}" y="90" text-anchor="middle" font-size="xx-large"
                >Instances of Rhetorical Devices by Text</text>

            <!-- General labels (X, Y, graph)                   -->
        </svg>

    </xsl:template>

    <xsl:template match="$surahs">
        <!-- must be sorted by text -->
        <xsl:for-each select="$surahs">
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

            <xsl:variable name="barHeight_Amp" select="$totalAmp * $maxHeight" as="xs:double"/>
            <xsl:variable name="barHeight_Emph" select="$totalAmp * $maxHeight" as="xs:double"/>
            <xsl:variable name="barHeight_Comparison" select="$totalAmp * $maxHeight" as="xs:double"/>
            <xsl:variable name="barHeight_Imagery" select="$totalAmp * $maxHeight" as="xs:double"/>
            <xsl:variable name="barHeight_Repetition" select="$totalAmp * $maxHeight" as="xs:double"/>
            <xsl:variable name="barHeight_Allusion" select="$totalAmp * $maxHeight" as="xs:double"/>
            <xsl:variable name="barHeight_Irony" select="$totalAmp * $maxHeight" as="xs:double"/>
            <xsl:variable name="barHeight_RetoricalQ" select="$totalRetoricalQ * $maxHeight"
                as="xs:double"/>

            <xsl:variable name="device" select="." as="xs:string"/>

            <rect x="{$xPosition}" y="-{$barHeight_Amp}" stroke="black" stroke-width=".5"
                fill="blue" width="{$barWidth}" height="{$barHeight_Amp}"/>
            <text x="{$midBarPostion}" y="20" text-anchor="middle" fill="black" font-size="small">
                <xsl:value-of select="$device"/>
            </text>

        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
