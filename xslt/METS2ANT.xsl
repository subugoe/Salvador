<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:DC="http://purl.org/dc/elements/1.1/" xmlns:MODS="http://www.loc.gov/mods/v3" xmlns:METS="http://www.loc.gov/METS/" exclude-result-prefixes="xs xd MODS METS DC xlink" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Oct 24, 2013</xd:p>
            <xd:p><xd:b>Author:</xd:b> cmahnke</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>
    <!-- This param lets you specify a other prefix folder
         Example: images/
    -->
    <xsl:param name="local-prefix-folder" select="''" as="xs:string"/>
    <!-- This param lets you specify the URL Prefix to cut (with trailing slash)
         Example: http://134.76.21.92:8080/images/     
    -->
    <xsl:param name="cut-prefix" select="''" as="xs:string"/>
    <xsl:output indent="yes"/>
    <xsl:template match="/">
        <project name="METS2ANT Download" basedir="." default="download">
            <description>
                This Ant file will download all images of all file groups with remote (http) locations for the mets file <xsl:value-of select="document-uri(/)"/>
            </description>
            <xsl:for-each select="//METS:fileGrp[not(descendant::METS:FLocat[starts-with(@xlink:href, 'file://')])]">
                <xsl:variable name="group-name" select="@USE" as="xs:string"/>
                <xsl:comment>Downloads the files of the '<xsl:value-of select="$group-name"/>' section</xsl:comment>
                <xsl:element name="target">
                    <xsl:attribute name="name" select="concat('download.', $group-name)"/>
                    <xsl:attribute name="description">
                        <xsl:text>Downloads the files of the '</xsl:text>
                        <xsl:value-of select="$group-name"/>
                        <xsl:text>' section</xsl:text>
                    </xsl:attribute>
                    <xsl:for-each select="//METS:fileGrp[@USE = $group-name]//METS:FLocat[@LOCTYPE='URL']">
                        <xsl:variable name="dest" as="xs:string">
                            <xsl:choose>
                                <xsl:when test="$cut-prefix = ''">
                                    <xsl:value-of select="concat('./', $local-prefix-folder, @xlink:href)"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('./', $local-prefix-folder, replace(@xlink:href, $cut-prefix,''))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="dest-dir" as="xs:string" select="replace($dest, '^(.*/)([^/]*)$' , '$1')"/>
                        <xsl:element name="mkdir">
                            <xsl:attribute name="dir" select="$dest-dir"/>
                        </xsl:element>
                        <xsl:element name="get">
                            <xsl:attribute name="src" select="@xlink:href"/>
                            <xsl:attribute name="dest" select="$dest"/>
                            <xsl:attribute name="verbose" select="'on'"/>
                            <xsl:attribute name="usetimestamp" select="'true'"/>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>
            </xsl:for-each>
            <xsl:comment>Download of all files</xsl:comment>
            <xsl:element name="target">
                <xsl:attribute name="name" select="'download.all'"/>
                <xsl:attribute name="depends">
                    <xsl:for-each select="//METS:fileGrp[not(descendant::METS:FLocat[starts-with(@xlink:href, 'file://')])]">
                        <xsl:variable name="group-name" select="@USE" as="xs:string"/>
                        <xsl:value-of select="concat('download.', $group-name)"/>
                        <xsl:if test="position() != last()">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:attribute>
                <xsl:attribute name="description">Download of all files</xsl:attribute>
            </xsl:element>
        </project>
    </xsl:template>
</xsl:stylesheet>
