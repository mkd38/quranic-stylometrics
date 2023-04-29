<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/2000/svg"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <!-- ================================================================ -->
    <!-- Document Collection                                                    -->
    <!-- ================================================================ -->
    <xsl:variable name="surahs" as="document-node()+"
        select="collection('../analyzedsuwarXML?select=*.xml')"/>
    <!-- ================================================================ -->
    <!-- Whole Stylesheet Variables                                             -->
    <!-- ================================================================ -->
    <xsl:variable name="max_devices" as="xs:double" select="88"/>
    <xsl:variable name="max_height" as="xs:double" select="$max_devices * 2"/>
    <xsl:variable name="max_width" as="xs:double" select="$max_devices * 2"/>
    <!-- template match -->
    <xsl:template name="xsl:initial-template">
        <svg preserveAspectRatio="xMinYMin meet" viewBox="-800 -800 1600 1600" width="100%"
            height="100%">
            <!-- ==================================================== -->
            <!-- Graph Title and Axis Labels                          -->
            <!-- ==================================================== -->
            <text x="{$max_width div 2}" y="-{$max_height + 500}" text-anchor="middle"
                font-size="50" font-weight="bold">Instances of Rhetorical Device by Text</text>
            <xsl:for-each select="1 to 5">
                <!-- Ruling Lines  -->
                <polygon points=""> </polygon>

            </xsl:for-each>
            <!-- ==================================================== -->
            <!-- Axis Lines                                           -->
            <!-- ==================================================== -->
            
            <xsl:for-each select="1 to 11">
                <xsl:variable name="angle" as="xs:double" select="360 div 11 * ."/>
                <xsl:variable name="x2" as="xs:double" select="($angle*math:pi() div 180) => math:cos()*500"/>
                <xsl:variable name="y2" as="xs:double" select="($angle*math:pi() div 180) => math:sin()*500"/>
                <line x1="0" y1="0" x2="{$x2}"
                    y2="{$y2}" stroke="black"/>

                <text x="{. * .25 * $max_width}" y="0" dominant-baseline="middle" text-anchor="end"
                    font-size="10">
                    <xsl:value-of select=". * 25"/>
                </text>
                
            </xsl:for-each>
            
           
           
            <!-- per surah graphs -->
            <!-- rhetorical device variables -->
            <xsl:for-each-group select="$surahs" group-by="descendant::metadata/title/@n">
                <xsl:variable name="pos" as="xs:integer" select="position()"/>
                <xsl:message select="('red', 'blue', 'green')[$pos]"/>
                <!-- Shared variables -->
                <xsl:variable name="ScalingFactor" as="xs:double" select="15"/>
                <!-- amplification -->
                <xsl:variable name="amp" as="xs:double"
                    select="count(current-group()//amplification)"/>
                <xsl:variable name="amp_x" as="xs:double"
                    select="(360 div 11 * math:pi() div 180) => math:cos() * $amp* $ScalingFactor"/>
                <xsl:variable name="amp_y" as="xs:double"
                    select="(360 div 11  * math:pi() div 180) => math:sin()* $amp * $ScalingFactor"/>
                <!-- simile -->
                <xsl:variable name="sim" as="xs:double"
                    select="count(current-group()//comparison[@device = 'simile'])"/>
                <xsl:variable name="sim_x" as="xs:double"
                    select="(360 div 11 * 2 * math:pi() div 180) => math:cos() * $sim * $ScalingFactor"/>
                <xsl:variable name="sim_y" as="xs:double"
                    select="(360 div 11 * 2 * math:pi() div 180) => math:sin() * $sim * $ScalingFactor"/>
                <!-- metaphor -->
                <xsl:variable name="met" as="xs:double"
                    select="count(current-group()//comparison[@device = 'metaphor'])"/>
                <xsl:variable name="met_x" as="xs:double"
                    select="(360 div 11 * 3 * math:pi() div 180) => math:cos() * $met * $ScalingFactor"/>
                <xsl:variable name="met_y" as="xs:double"
                    select="(360 div 11 * 3 * math:pi() div 180) => math:sin() * $met * $ScalingFactor"/>

                <polyline fill="none" stroke="{('red','blue','green')[$pos]}" stroke-width="3"
                    points=" {$amp_x},{$amp_y}
                {$sim_x},{$sim_y}
                {$met_x},{$met_y}
                                "/>

            </xsl:for-each-group>



        </svg>
    </xsl:template>




</xsl:stylesheet>
