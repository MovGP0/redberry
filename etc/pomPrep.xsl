<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://maven.apache.org/POM/4.0.0"
                xmlns:m="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd"
                exclude-result-prefixes="m">

    <xsl:output method="xml" indent="no"/>

    <xsl:param name="releaseVersion"/>
    <xsl:param name="release" select="'no'"/>
    <xsl:strip-space elements="m:url"/>

    <xsl:template match="/m:project/m:version">
        <version>
            <xsl:value-of select="$releaseVersion"/>
        </version>
    </xsl:template>

    <xsl:template match="m:version[../m:groupId='cc.redberry']">
        <version>
            <xsl:value-of select="$releaseVersion"/>
        </version>
    </xsl:template>

    <xsl:template match="/m:project/m:scm">
        <!-- <xsl:param name="connection" select="connection"></xsl:param> -->
        <scm>
            <connection>scm:hg:http://bitbucket.org/redberry/redberry-<xsl:value-of select="/m:project/m:artifactId"/>
            </connection>
            <xsl:if test="$release='yes'">
                <tag>v<xsl:value-of select="$releaseVersion"/>
                </tag>
            </xsl:if>
            <xsl:if test="$release='yes'">
                <url>https://bitbucket.org/redberry/redberry-<xsl:value-of select="/m:project/m:artifactId"/>/src/?at=v<xsl:value-of
                        select="$releaseVersion"/>
                </url>
            </xsl:if>
            <xsl:if test="not($release='yes')">
                <url>https://bitbucket.org/redberry/redberry-<xsl:value-of select="/m:project/m:artifactId"/>/src/</url>
            </xsl:if>
        </scm>
    </xsl:template>

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>