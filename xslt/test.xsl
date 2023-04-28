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
      <!-- First group by surah, create new output document               -->
      <!-- ============================================================== -->
      <xsl:result-document method="xml" indent="yes" omit-xml-declaration="yes"
        xmlns="http://www.w3.org/2000/svg" href="radar_{current-grouping-key()}.svg">
        <svg>
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
                <xsl:variable name="ordered_value" as="xs:string" select="$features[current()]"/>
                <xsl:variable name="count" as="xs:integer">
                  <!-- ================================================== -->
                  <!-- Count within current-group(), not all $surahs      -->
                  <!-- ================================================== -->
                  <xsl:choose>
                    <xsl:when test="$ordered_value = $element_types">
                      <!-- It's an element, so match by element name -->
                      <xsl:value-of
                        select="count(current-group()//*[local-name() eq $ordered_value])"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <!-- It's a @device value, so count matching @device instances -->
                      <xsl:value-of select="count(current-group()//@device[. eq $ordered_value])"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:variable>
                <xsl:variable name="x_pos" as="xs:double" select="$spoke_offset * $count"/>
                <xsl:variable name="y_pos" as="xs:double" select="$spoke_offset * $count"/>
                <xsl:value-of select="string-join(($x_pos, $y_pos), ',')"/>
                <!--<xsl:message select="$ordered_value, $count, $x_pos, $y_pos"/>-->
              </xsl:for-each>
            </xsl:variable>
            <polyline points="{$points}" stroke="{('red', 'blue', 'green')[$subgroup_position]}"/>
          </xsl:for-each-group>
        </svg>
      </xsl:result-document>
    </xsl:for-each-group>
  </xsl:template>
</xsl:stylesheet>
