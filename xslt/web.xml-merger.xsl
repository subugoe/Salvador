<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:j2ee="http://java.sun.com/xml/ns/j2ee"
    xmlns="http://java.sun.com/xml/ns/j2ee"
    exclude-result-prefixes="xs xd j2ee"
    version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Apr 10, 2014</xd:p>
            <xd:p><xd:b>Author:</xd:b> cmahnke</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    <!-- Taken from https://scm.mmbase.org/didactor/trunk/old-ant-build/merge-web.xml.xslt -->
    <xsl:output method="xml" standalone="yes" indent="yes"/>
    <xsl:param name="merge-xml-file"/>

    
    <xsl:template match="/">
        <web-app xmlns="http://java.sun.com/xml/ns/j2ee">
        <xsl:choose>
            <!-- process a single file -->
            <xsl:when test="$merge-xml-file != ''">
                <xsl:variable name="merge-xml" select="document($merge-xml-file)"/>
                <xsl:copy-of select="/*:web-app/@*"/>
                <xsl:apply-templates select="/*:web-app/*:description"/>
                <xsl:apply-templates select="/*:web-app/*:display-name"/>
                <!-- Needed for specific Solr settings -->
                <xsl:apply-templates select="/*:web-app/*:system-property"/>
                <xsl:apply-templates select="$merge-xml/*:web-app/*:system-property"/>
                <xsl:apply-templates select="/*:web-app/*:env-entry"/>
                <xsl:apply-templates select="$merge-xml/*:web-app/*:env-entry"/>
                <!-- End of additions -->
                <xsl:apply-templates select="/*:web-app/*:context-param"/>
                <xsl:apply-templates select="$merge-xml/*:web-app/*:context-param"/>
                <xsl:apply-templates select="/*:web-app/*:filter"/>
                <xsl:apply-templates select="$merge-xml/*:web-app/*:filter"/>
                <xsl:apply-templates select="/*:web-app/*:filter-mapping"/>
                <xsl:apply-templates select="$merge-xml/*:web-app/*:filter-mapping"/>
                <xsl:apply-templates select="/*:web-app/*:listener"/>
                <xsl:apply-templates select="$merge-xml/*:web-app/*:listener"/>
                <xsl:apply-templates select="/*:web-app/*:servlet"/>
                <xsl:apply-templates select="$merge-xml/*:web-app/*:servlet"/>
                <xsl:apply-templates select="/*:web-app/*:servlet-mapping"/>
                <xsl:apply-templates select="$merge-xml/*:web-app/*:servlet-mapping"/>
                <xsl:apply-templates select="/*:web-app/*:mime-mapping"/>
                <xsl:apply-templates select="$merge-xml/*:web-app/*:mime-mapping"/>
                <xsl:apply-templates select="/*:web-app/*:welcome-file-list"/>
                <xsl:apply-templates select="/*:web-app/*:taglib"/>
                <xsl:apply-templates select="$merge-xml/*:web-app/*:taglib"/>
                <xsl:apply-templates select="/*:web-app/*:error-page"/>
            </xsl:when>
            <!-- process a collection -->
            <xsl:when test="$merge-xml-file != ''">
                <!-- Not implemented yet -->
            </xsl:when>
            <!-- nothig given, error -->
            <xsl:otherwise>
                <xsl:message terminate="yes">No merge file</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
        </web-app>
    </xsl:template>
    <xsl:template match="text()|comment()|processing-instruction()">
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="*">
        <xsl:element name="{name()}">
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="text()|*"/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>