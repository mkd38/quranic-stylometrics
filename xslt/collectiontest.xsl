<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:variable name="surahs" as="document-node()+"
        select="collection('../analyzedsuwarXML?select=*.xml')"/>
    <xsl:template name="xsl:initial-template">
        <xsl:for-each-group select="$surahs" group-by="descendant::metadata/title/@n">
            <xsl:result-document href="surah_{format-integer(current-grouping-key(), '00')}.xhtml"
                method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no"
                indent="yes">
                <html>
                    <head>
                        <link rel="stylesheet" type="text/css" href="../Website/style.css"/>
                        <link rel="stylesheet" type="text/css" href="../Website/readingview.css"/>
                        <!--you cannot have CSS style in HTML, must be in CSS stylesheet -->
                        <title>
                            <xsl:text>Surah </xsl:text>
                            <xsl:value-of select="current-grouping-key()"/>
                        </title>
                    </head>
                    <body>
                        <!-- checkboxes for rhetorical devices -->
                        <div class="checkbox-container">
                            <label><input type="checkbox" name="amplification"
                                />Amplification</label>
                            <label><input type="checkbox" name="emph"/>Emphasis</label>
                            <label><input type="checkbox" name="irony"/>Irony</label>
                            <label><input type="checkbox" name="imagery"/>Imagery</label>
                            <label><input type="checkbox" name="allusion"/>Allusion</label>
                            <label><input type="checkbox" name="contrast"/>Contrast</label>
                            <label><input type="checkbox" name="name"/>Name</label>
                            <label><input type="checkbox" name="place"/>Place</label>
                            <label><input type="checkbox" name="rhetoricalQuestion"/>Rhetorical
                                Question</label>
                            <label><input type="checkbox" name="motif"/>Motif</label>
                            <label><input type="checkbox" name="anaphora"/>Anaphora</label>
                            <label><input type="checkbox" name="parallelism"/>Parallelism</label>
                            <label><input type="checkbox" name="metaphor"/>Metaphor</label>
                            <label><input type="checkbox" name="simile"/>Simile</label>
                        </div>
                        <!-- ^^^ this is solid. I would suggest you experiment with how you want this checkbox to be
                portrayed on the site. work with CSS a bit and make sure you have these highlighted according to
                what color they are in  the text. Also, think about trying to get the checkbox to "stick" as one scrolls 
                so they dont have to keep scrollin  g back up. ALSO create label that says "Rhetorical Devices"-->
                        <main>
                            <xsl:for-each-group select="current-group()//ayah" group-by="@n">
                                <xsl:sort select="current-grouping-key()" data-type="number"/>
                                <xsl:for-each select="current-group()">
                                    <div>
                                        <xsl:text>(</xsl:text>
                                        <xsl:value-of select="current-grouping-key()"/>
                                        <xsl:text>) </xsl:text>
                                        <xsl:value-of select="."/>
                                    </div>
                                </xsl:for-each>
                            </xsl:for-each-group>
                            <!-- <section>
                                <xsl:apply-templates
                                    select="current-group()[not(descendant::metadata/translator)]"/>
                            </section>
                            <section>
                                <xsl:apply-templates
                                    select="current-group()[ends-with(descendant::metadata/translator, 'Pickthall')]"
                                />
                            </section>
                            <section>
                                <xsl:apply-templates
                                    select="current-group()[ends-with(descendant::metadata/translator, 'Ali')]"
                                />
                            </section> -->
                        </main>
                        <!-- use schematron to make sure matadata is correct for each, using grid to line up surahs -->
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each-group>
    </xsl:template>
    <xsl:template match="surah">
        <h1>
            <xsl:value-of select="metadata/title"/>
        </h1>
        <p>
            <span>Editor:</span>
            <xsl:value-of select="metadata/editor"/>
        </p>
        <p>
            <span>Translator:</span>
            <xsl:value-of select="metadata/translator"/>
        </p>
        <p>
            <span>Source:</span>
            <a href="{metadata/source}">
                <xsl:value-of select="metadata/source"/>
            </a>
        </p>

        <!--<table>
            <tr>
                <th>Ayah</th>
                <th>Text</th>
            </tr>
            <xsl:for-each select="body/ayah">
                <tr>
                    <td>
                        <xsl:value-of select="@n"/>
                    </td>
                    <td>
                        <xsl:apply-templates/>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
-->
    </xsl:template>
    <!-- ^^ we should use grid for this instead of table -->
    <xsl:template match="amplification">
        <span class="amplification highlightable">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="emph">
        <span class="emph highlightable">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="irony">
        <span class="irony highlightable">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="imagery">
        <span class="imagery highlightable">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="allusion">
        <span class="allusion highlightable">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="contrast">
        <span class="contrast highlightable">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="name">
        <span class="name highlightable">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="place">
        <span class="place highlightable">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="rhetoricalQuestion">
        <span class="rhetoricalQuestion highlightable">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="repetition[@type = 'motif']">
        <span class="motif highlightable">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="repetition[@type = 'anaphora']">
        <span class="anaphora highlightable">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="repetition[@type = 'parallelism']">
        <span class="parallelism highlightable">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="comparison[@type = 'metaphor']">
        <span class="metaphor highlightable">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="comparison[@type = 'simile']">
        <span class="simile highlightable">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
</xsl:stylesheet>
