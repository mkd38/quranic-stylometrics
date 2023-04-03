<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no"
        indent="yes"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="surah/metadata/title"/>
                    <link rel="stylesheet" type="text/css" href="draftstyle.css"/>
                </title>
                <style>
                    table {
                        border-collapse: collapse;
                    }
                    table,
                    th,
                    td {
                        border: 1px solid black;
                    }</style>
            </head>
            <body>
                <!-- checkboxes for rhetorical devices -->
                <div class="checkbox-container">
                    <label><input type="checkbox" name="amplification"/>Amplification</label>
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

                <h1>
                    <xsl:value-of select="surah/metadata/title"/>
                </h1>
                <p>
                    <span>Editor:</span>
                    <xsl:value-of select="surah/metadata/editor"/>
                </p>
                <p>
                    <span>Translator:</span>
                    <xsl:value-of select="surah/metadata/translator"/>
                </p>
                <p>
                    <span>Source:</span>
                    <a href="{surah/metadata/source}">
                        <xsl:value-of select="surah/metadata/source"/>
                    </a>
                </p>

                <table>
                    <tr>
                        <th>Ayah</th>
                        <th>Text</th>
                    </tr>
                    <xsl:for-each select="surah/body/ayah">
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
            </body>
        </html>
    </xsl:template>

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
