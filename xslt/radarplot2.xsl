<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
    <!-- ================================================================== -->
    <!-- Stylesheet variables                                               -->
    <!-- ================================================================== -->
    <xsl:variable name="surahs" as="document-node()+"
        select="collection('../analyzedsuwarXML?select=*.xml')"/>
    <xsl:variable name="max_devices" as="xs:double" select="88"/>
    <xsl:variable name="max_height" as="xs:double" select="$max_devices * 2"/>
    <xsl:variable name="max_width" as="xs:double" select="$max_devices * 2"/>
    <!-- ================================================================== -->
    <!-- Unordered inventory of element types and @device attribute values  -->
    <!-- ================================================================== -->
    <xsl:variable name="element_types" as="xs:string+"
        select="'amplification', 'imagery', 'emph', 'rhetoricalQuestion', 'allusion', 'irony'"/>
    <xsl:variable name="device_types" as="xs:string+"
        select="'simile', 'metaphor', 'parallelism', 'anaphora', 'contrast'"/>
    <!-- ================================================================== -->
    <!-- All element types and device values according to spoke order       -->
    <!-- ================================================================== -->
    <xsl:variable name="features" as="xs:string+" select="
            'amplification',
            'simile',
            'metaphor',
            'imagery',
            'emph',
            'rhetoricalQuestion',
            'parallelism',
            'anaphora',
            'allusion',
            'contrast',
            'irony'
            "/>
    <!-- ================================================================== -->
    <!-- Templates                                                          -->
    <!-- ================================================================== -->
    <xsl:template name="xsl:initial-template">
        <xsl:for-each-group select="$surahs" group-by="descendant::metadata/title/@n">
            <!-- ============================================================== -->
            <!-- First group by surah                                           -->
            <!-- ============================================================== -->
            <xsl:result-document method="xml" indent="yes" omit-xml-declaration="yes"
                xmlns="http://www.w3.org/2000/svg" href="radar_{current-grouping-key()}.svg">
                <svg  preserveAspectRatio="xMinYMin meet" viewBox="-800 -800 1600 1600" width="100%"
                    height="100%">
                    <!-- ============================================================== -->
                    <!-- Title                                                          -->
                    <!-- ============================================================== -->
                    <text x="{$max_width div 2}" y="-{$max_height + 500}" text-anchor="middle"
                        font-size="50" font-weight="bold">
                        Surah <xsl:value-of select="@n"/>
                    </text>
                       <!-- Axis and Labels -->
                    <xsl:for-each select="1 to 11">  
                            <!-- ==================================================== -->
                            <!-- Variables                                            -->
                            <!-- ==================================================== -->
                            <xsl:variable name="angle" as="xs:double" select="360 div 11 * ."/>
                        <xsl:variable name="x1" as="xs:double" select="($angle * math:pi() div 180) => math:cos()*50"/>
                        <xsl:variable name="y1" as="xs:double" select="($angle * math:pi() div 180) => math:sin()*50"/>
                            <xsl:variable name="x2" as="xs:double" select="($angle * math:pi() div 180) => math:cos()*500"/>
                            <xsl:variable name="y2" as="xs:double" select="($angle * math:pi() div 180) => math:sin()*500"/>
                            <!-- ================================================== -->
                            <!-- Lines                                               -->
                            <!-- ================================================== -->
                            <line x1="{$x1}" y1="{$y1}" x2="{$x2}"
                                y2="{$y2}" stroke="black"/>
                                                                      
                            <text x="{. * .25 * $max_width}" y="0" dominant-baseline="middle" text-anchor="end"
                                font-size="10">
                                <xsl:value-of select=". * 5"/>
                            </text>
                            </xsl:for-each>
                    
                    <!-- ==================================================== -->
                    <!-- Outer Guidelines                                     -->
                    <!-- Needed variable to be repeated for 1-12 instead of 
                        1-11 for a full shape
                                                                              -->
                    <!-- ==================================================== -->
                    <xsl:variable name="xpoints" as="xs:string+">
                    <xsl:for-each select="1 to 12">  
                        <!-- ==================================================== -->
                        <!-- Variables                                            -->
                        <!-- ==================================================== -->
                        <xsl:variable name="angle" as="xs:double" select="360 div 11 * ."/>
                        <xsl:variable name="x3" as="xs:double" select="($angle * math:pi() div 180) => math:cos()*500"/>
                        <xsl:variable name="y3" as="xs:double" select="($angle * math:pi() div 180) => math:sin()*500"/>
                        <!-- ================================================== -->
                        <!-- Lines                                               -->
                        <!-- ================================================== -->
                        <xsl:value-of select="string-join(($x3, $y3), ',')"/>
                    </xsl:for-each>
                    </xsl:variable>
                    <polyline fill="none"
                        stroke="black"
                        stroke-width="3" 
                        points="{$xpoints}"/>
                    
                    
                    <!-- ==================================================== -->
                    <!-- Inner Guidelines for 0                               -->
                    <!-- Needed variable to be repeated for 1-12 instead of 
                        1-11 for a full shape and to define variable
                                                                              -->
                    <!-- ==================================================== -->
                    <xsl:variable name="xpoints0" as="xs:string+">
                        <xsl:for-each select="1 to 12">  
                            <!-- ==================================================== -->
                            <!-- Variables                                            -->
                            <!-- ==================================================== -->
                            <xsl:variable name="angle" as="xs:double" select="360 div 11 * ."/>
                            <xsl:variable name="x4" as="xs:double" select="($angle * math:pi() div 180) => math:cos()*50"/>
                            <xsl:variable name="y4" as="xs:double" select="($angle * math:pi() div 180) => math:sin()*50"/>
                            <!-- ================================================== -->
                            <!-- Lines                                               -->
                            <!-- ================================================== -->
                            <xsl:value-of select="string-join(($x4, $y4), ',')"/>
                        </xsl:for-each>
                    </xsl:variable>
                    <polyline fill="none"
                        stroke="black"
                        stroke-width="3" 
                        points="{$xpoints0}"/>
                                       
                    <!-- ============================================================== -->
                    <!-- Create new output document               -->
                    <!-- ============================================================== -->
                    <xsl:for-each-group select="current-group()"
                        group-by="concat(descendant::body/@xml:lang, descendant::translator)">
                        <!-- ======================================================== -->
                        <!-- Within surah, subgroup by Arabic, Ali, Pickthall         -->
                        <!-- Save subgroup position (1, 2, 3) to choose color         -->
                        <!-- ======================================================== -->
                        <xsl:variable name="subgroup_position" as="xs:integer" select="position()"/>
                        <xsl:variable name="points" as="xs:string+">
                            <xsl:for-each select="1 to count($features)">
                                <!-- ==================================================== -->
                                <!-- Which of the ordered values are we plotting now?     -->
                                <!-- ==================================================== -->
                                <xsl:variable name="spoke_offset" as="xs:double"
                                    select="current() * 360 div count($features)"/>
                                <xsl:variable name="ordered_value" as="xs:string"
                                    select="$features[current()]"/>
                                <xsl:variable name="count" as="xs:integer">
                                    <!-- ================================================== -->
                                    <!-- Count within current-group(), not all $surahs      -->
                                    <!-- ================================================== -->
                                    <xsl:choose>
                                        <xsl:when test="$ordered_value = $element_types">
                                            <!-- It's an element, so match by element name -->
                                            <xsl:value-of
                                                select="count(current-group()//*[local-name() eq $ordered_value])"
                                            />
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <!-- It's a @device value, so count matching @device instances -->
                                            <xsl:value-of
                                                select="count(current-group()//@device[. eq $ordered_value])"
                                            />
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:variable>
                                <xsl:variable name="scalingFactor" as="xs:double" select="5"/>
                                <!-- these variables need to be off-set by inner guideline for 0 -->
                                <xsl:variable name="x_pos" as="xs:double"
                                    select="($spoke_offset * math:pi() div 180) => math:cos()* $count *$scalingFactor"/>
                                
                                <xsl:variable name="y_pos" as="xs:double"
                                    select="($spoke_offset * math:pi() div 180) => math:sin()* $count *$scalingFactor"/>
                                
                                <xsl:value-of select="string-join(($x_pos, $y_pos), ',')"/>
                                <!--<xsl:message select="$ordered_value, $count, $x_pos, $y_pos"/>-->
                            </xsl:for-each>
                        </xsl:variable>
                        <polyline points="{$points}"
                            stroke="{('red', 'blue', 'green')[$subgroup_position]}"
                            fill="none"
                            stroke-width="3"/>
                    </xsl:for-each-group>
                </svg>
            </xsl:result-document>
        </xsl:for-each-group>
    </xsl:template>
</xsl:stylesheet>
