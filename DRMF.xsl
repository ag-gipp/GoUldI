<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet exclude-result-prefixes="ltx" version="1.0" xmlns:ltx="http://dlmf.nist.gov/LaTeXML"
                xmlns:m="http://www.w3.org/1998/Math/MathML" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xpath-default-namespace="http://www.w3.org/1998/Math/MathML">
    <!-- Include all LaTeXML to xhtml modules -->
    <xsl:import href="LaTeXML-common.xsl"/>
    <xsl:import href="LaTeXML-math-xhtml.xsl"/>
    <xsl:template match="m:csymbol[@cd='ambiguous' and text() = 'superscript']">
        <xsl:element name="power" namespace="{$mml_ns}">
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:copy-of select="@xref"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="m:apply//m:mtext">
        <xsl:element name="ci" namespace="{$mml_ns}">
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:copy-of select="@xref"/>
            <!-- merges subsequent text elements -->
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="m:apply">
        <xsl:choose>
            <xsl:when
                    test="count(*)=3 and ./m:times/following-sibling::m:csymbol[@cd='latexml'][starts-with(text(),'function-')]">
                <xsl:element name="apply" namespace="{$mml_ns}">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@xml:id"/>
                    </xsl:attribute>
                    <xsl:copy-of select="@xref"/>
                    <xsl:comment>multiplication with two factors changed to function application</xsl:comment>
                    <xsl:apply-templates select="./m:times/following-sibling::*"/>
                </xsl:element>
            </xsl:when>
            <xsl:when
                    test="count(*) &gt; 3 and ./m:times/following-sibling::m:csymbol[@cd='latexml'][starts-with(text(),'function-')]">
                <xsl:element name="apply" namespace="{$mml_ns}">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@xml:id"/>
                    </xsl:attribute>
                    <xsl:copy-of select="@xref"/>
                    <xsl:comment>multiplication with multiple factors changed to function application with child</xsl:comment>
                    <xsl:apply-templates select="./m:times//following-sibling::m:csymbol[1]"/>
                    <xsl:element name="apply" namespace="{$mml_ns}">
                        <xsl:attribute name="id">
                            <xsl:value-of select="concat('a-',@xml:id)"/>
                        </xsl:attribute>
                        <xsl:copy-of select="@xref"/>
                        <xsl:apply-templates select="./*[not(position() =2)]"/>
                    </xsl:element>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="apply" namespace="{$mml_ns}">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@xml:id"/>
                    </xsl:attribute>
                    <xsl:copy-of select="@xref"/>
                    <!-- merges subsequent text elements -->
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="m:csymbol[@cd='latexml'][starts-with(text(),'function-')]">
        <!--TODO: update as soon as XSLT2 is used-->
        <xsl:element name="csymbol" namespace="{$mml_ns}">
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:copy-of select="@xref"/>
            <xsl:attribute name="cd">
                <xsl:text>wikidata</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="substring(./text(),10)"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="m:csymbol[@cd='ambiguous' and text() = 'subscript']">
        <!-- interpret subscripts as parameters -->
    </xsl:template>
    <xsl:template match="m:csymbol[@cd='dlmf' and text() = 'apply-upper-index']"/>
    <xsl:template match="m:csymbol[@cd='dlmf' and text() = 'apply-infix-operator']"/>
</xsl:stylesheet>
