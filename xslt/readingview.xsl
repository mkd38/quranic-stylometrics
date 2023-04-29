<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:variable name="surahs" as="document-node()+"
        select="collection('../analyzedsuwarXML?select=*.xml')"/>
    <xsl:template name="xsl:initial-template">
        <xsl:for-each-group select="$surahs" group-by="descendant::metadata/title/@n">
            <xsl:result-document
                href="../Website/surah_{format-integer(current-grouping-key(), '00')}.xhtml"
                method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no"
                indent="yes">
                <html>
                    <head>
                        <link rel="stylesheet" type="text/css" href="style.css"/>
                        <link rel="stylesheet" type="text/css" href="readingview.css"/>
                        <script type="application/javascript" src="readingview.js"/>
                        <!--you cannot have CSS style in HTML, must be in CSS stylesheet -->
                        <title>
                            <xsl:text>Surah</xsl:text>
                            <xsl:value-of select="current-grouping-key()"/>
                        </title>
                    </head>
                    <body>
                        <!-- checkboxes for rhetorical devices -->
                        <div class="checkbox-container">
                            <label class="amplification"><input type="checkbox" id="amplification"
                                />Amplification</label>
                            <label class="emph"><input type="checkbox" id="emph"/>Emphasis</label>
                            <label class="irony"><input type="checkbox" id="irony"/>Irony</label>
                            <label class="imagery"><input type="checkbox" id="imagery"
                                />Imagery</label>
                            <label class="allusion"><input type="checkbox" id="allusion"
                                />Allusion</label>
                            <label class="contrast"><input type="checkbox" id="contrast"
                                />Contrast</label>
                            <label class="name"><input type="checkbox" id="name"/>Name</label>
                            <label class="place"><input type="checkbox" id="place"/>Place</label>
                            <label class="rhetoricalQuestion"><input type="checkbox"
                                    id="rhetoricalQuestion"/>Rhetorical Question</label>
                            <label class="motif"><input type="checkbox" id="motif"/>Motif</label>
                            <label class="anaphora"><input type="checkbox" id="anaphora"
                                />Anaphora</label>
                            <label class="parallelism"><input type="checkbox" id="parallelism"
                                />Parallelism</label>
                            <label class="metaphor"><input type="checkbox" id="metaphor"
                                />Metaphor</label>
                            <label class="simile"><input type="checkbox" id="simile"/>Simile</label>
                        </div>
                        <!-- ^^^ this is solid. I would suggest you experiment with how you want this checkbox to be
                portrayed on the site. work with CSS a bit and make sure you have these highlighted according to
                what color they are in  the text. Also, think about trying to get the checkbox to "stick" as one scrolls 
                so they dont have to keep scrollin  g back up. ALSO create label that says "Rhetorical Devices"-->
                        <section>
                            <h2>Arabic</h2>
                            <h2>Ali</h2>
                            <h2>Pickthall</h2>
                        </section>
                        <main>
                            <xsl:for-each-group select="current-group()//ayah" group-by="@n">
                                <xsl:sort select="current-grouping-key()" data-type="number"/>
                                <xsl:text>(</xsl:text>
                                <xsl:value-of select="current-grouping-key()"/>
                                <xsl:text>) </xsl:text>
                                <xsl:for-each select="current-group()">
                                    <xsl:sort select="ancestor::body/@xml:lang"/>
                                    <xsl:sort select="ancestor::surah/metadata/translator"/>
                                    <div lang="{ancestor::body/@xml:lang}">
                                        <xsl:apply-templates select="."/>
                                    </div>
                                </xsl:for-each>
                            </xsl:for-each-group>
                        </main>
                        <!-- use schematron to make sure matadata is correct for each, using grid to line up surahs -->
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each-group>
    </xsl:template>
    <!-- ^^ we should use grid for this instead of table -->
    <xsl:template match="ayah" mode="guide">
        <xsl:apply-templates select="//*/name() => distinct-values()"/>
        <xsl:text> ,</xsl:text>
        <xsl:if test="//*/name() eq repetition or comparison">
            <xsl:value-of select="@device"/>
            <xsl:text> ,</xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="amplification">
        <span class="amplification">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="emph">
        <span class="emph">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="irony">
        <span class="irony">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="imagery">
        <span class="imagery">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="allusion">
        <span class="allusion">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="contrast">
        <span class="contrast">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="name">
        <span class="name">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="place">
        <span class="place">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="rhetoricalQuestion">
        <span class="rhetoricalQuestion">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="repetition[@device = 'motif']">
        <span class="motif">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="repetition[@device = 'anaphora']">
        <span class="anaphora">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="repetition[@device = 'parallelism']">
        <span class="parallelism">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="comparison[@device = 'metaphor']">
        <span class="metaphor">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="comparison[@device = 'simile']">
        <span class="simile">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="comparison[@device = 'contrast']">
        <span class="contrast">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
</xsl:stylesheet>
