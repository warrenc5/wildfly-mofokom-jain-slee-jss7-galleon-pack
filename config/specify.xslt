<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:jboss="urn:jboss:domain:14.0"
    xmlns:slee="urn:telestax:slee-container:3.0"
    xmlns:ss7="urn:org.restcomm:ss7-wildfly:1.0"
    exclude-result-prefixes="jboss slee ss7">

    <xsl:output method="xml" indent="yes"/>

    <!-- Parameter to specify subsystem type: 'ss7', 'slee', or '' for both -->
    <xsl:param name="subsystem" select="''"/>

    <!-- Match document root -->
    <xsl:template match="/">
        <features>
            <xsl:choose>
                <xsl:when test="$subsystem = 'ss7'">
                    <xsl:apply-templates select="//ss7:subsystem"/>
                </xsl:when>
                <xsl:when test="$subsystem = 'slee'">
                    <xsl:apply-templates select="//slee:subsystem"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="//slee:subsystem | //ss7:subsystem"/>
                </xsl:otherwise>
            </xsl:choose>
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
            <param name="mbean" >
                <xsl:attribute name="value">
                    <xsl:value-of select="@name"/>
                </xsl:attribute>
            </param>

            <param name="name">
                <xsl:attribute name="value">
                    <xsl:value-of select="@name"/>
                </xsl:attribute>
            </param>
            <xsl:if test="namespace-uri() = 'urn:org.restcomm:ss7-wildfly:1.0'">
                <xsl:if test="@type">
                    <param name="type">
                        <xsl:attribute name="value">
                            <xsl:value-of select="@type"/>
                        </xsl:attribute>
                    </param>
                </xsl:if>
                <xsl:if test="@class">
                    <param name="class">
                        <xsl:attribute name="value">
                            <xsl:value-of select="@class"/>
                        </xsl:attribute>
                    </param>
                </xsl:if>
                <xsl:if test="@enabled">
                    <param name="enabled">
                        <xsl:attribute name="value">
                            <xsl:value-of select="@enabled"/>
                        </xsl:attribute>
                    </param>
                </xsl:if>
                <xsl:if test="@interface">
                    <param name="interface">
                        <xsl:attribute name="value">
                            <xsl:value-of select="@interface"/>
                        </xsl:attribute>
                    </param>
                </xsl:if>
                <xsl:if test="@reflection">
                    <param name="reflection">
                        <xsl:attribute name="value">
                            <xsl:value-of select="@reflection"/>
                        </xsl:attribute>
                    </param>
                </xsl:if>
            </xsl:if>
            <xsl:apply-templates select="slee:property | ss7:property"/>
        </feature>
    </xsl:template>

    <xsl:template match="slee:property | ss7:property">
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

            <param name="property" >
                <xsl:attribute name="value">
                    <xsl:value-of select="@name"/>
                </xsl:attribute>
            </param>

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

            <xsl:apply-templates select="ss7:entry"/>
        </feature>
    </xsl:template>
    <xsl:template match="ss7:entry">
        <feature>
            <xsl:attribute name="spec">
                <xsl:choose>
                    <xsl:when test="namespace-uri() = 'urn:org.restcomm:ss7-wildfly:1.0'">
                        <xsl:text>subsystem.restcomm-ss7.mbean.property.entry</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </xsl:attribute>

            <param name="entry" >
                <xsl:attribute name="value">
                    <xsl:value-of select="@value"/>
                </xsl:attribute>
            </param>

            <param name="key">
                <xsl:attribute name="value">
                    <xsl:value-of select="@key"/>
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
    </xsl:template>
</xsl:stylesheet>
