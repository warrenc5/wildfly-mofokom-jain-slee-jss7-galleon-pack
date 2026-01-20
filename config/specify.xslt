<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:jboss="urn:jboss:domain:14.0"
    xmlns:slee="urn:telestax:slee-container:3.0"
    xmlns:ss7="urn:org.restcomm:ss7-wildfly:1.0"
    exclude-result-prefixes="jboss slee ss7">

    <xsl:output method="xml" indent="yes"/>

    <!-- Match document root -->
    <xsl:template match="/">
        <features>
            <xsl:apply-templates select="//slee:subsystem | //ss7:subsystem"/>
        </features>
    </xsl:template>

    <xsl:template match="slee:subsystem | ss7:subsystem">
        <xsl:apply-templates select="slee:mbean | ss7:mbean"/>
    </xsl:template>

    <xsl:template match="slee:mbean | ss7:mbean">
        <feature>
            <xsl:attribute name="spec">
                <xsl:choose>
                    <xsl:when test="namespace-uri() = 'urn:org.restcomm:ss7-wildfly:1.0'">
                        <xsl:text>subsystem.restcomm-ss7.mbean</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>subsystem.slee-container.mbean</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <param name="name">
                <xsl:attribute name="value">
                    <xsl:value-of select="@name"/>
                </xsl:attribute>
            </param>
            <xsl:for-each select="slee:property | ss7:property">
                <feature>
                    <xsl:attribute name="spec">
                        <xsl:choose>
                            <xsl:when test="namespace-uri() = 'urn:org.restcomm:ss7-wildfly:1.0'">
                                <xsl:text>subsystem.restcomm-ss7.mbean.property</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>subsystem.slee-container.mbean.property</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <param name="name">
                        <xsl:attribute name="value">
                            <xsl:value-of select="@name"/>
                        </xsl:attribute>
                    </param>
                    <param name="value">
                        <xsl:attribute name="value">
                            <xsl:value-of select="@value"/>
                        </xsl:attribute>
                    </param>
                    <xsl:if test="@type">
                        <param name="type">
                            <xsl:attribute name="value">
                                <xsl:value-of select="@type"/>
                            </xsl:attribute>
                        </param>
                    </xsl:if>
                </feature>
            </xsl:for-each>
        </feature>
    </xsl:template>
</xsl:stylesheet>
