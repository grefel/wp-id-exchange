<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml"/>
	
	<xsl:template match="@*|node()" name="identityPattern" priority="-2">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="text()">
		<xsl:variable name="input"
			select="translate(string(.), '&#x20;&#x9;&#xD;&#xA;', ' ') "/>
		<xsl:value-of select="substring($input, string-length( substring-before($input, substring(translate($input, ' ', ''),  1, 1) ) ) +1)"/>
	</xsl:template>
	
	
	<xsl:template match="indesign-export">
		<indesign-export>
			
			<xsl:for-each select="*">
				<xsl:copy>
					<xsl:attribute name="id">
						<xsl:value-of select="@id" />
					</xsl:attribute>
					<xsl:attribute name="name">
						<xsl:value-of select="@name" />
					</xsl:attribute>
					<xsl:if test="post_thumbnail">
						<xsl:copy-of select="post_thumbnail" /><xsl:text disable-output-escaping="yes">
<!-- create a new line --></xsl:text></xsl:if>
					<post_title><xsl:value-of select="post_title" /></post_title><xsl:text disable-output-escaping="yes">
<!-- create a new line --></xsl:text>
					<post_date><xsl:value-of select="post_date" /></post_date><xsl:text disable-output-escaping="yes">
<!-- create a new line --></xsl:text>
					<post_author><xsl:value-of select="post_author" /></post_author><xsl:text disable-output-escaping="yes">
<!-- create a new line --></xsl:text>
					<xsl:if test="post_excerpt"><post_excerpt><xsl:value-of select="post_excerpt" /></post_excerpt><xsl:text disable-output-escaping="yes">
<!-- create a new line --></xsl:text></xsl:if>
					<post_content>
						<xsl:apply-templates/>
					</post_content>
				</xsl:copy><xsl:text disable-output-escaping="yes">
<!-- create a new line --></xsl:text>
			</xsl:for-each>
		</indesign-export>
	</xsl:template>
	
	<xsl:template match="p | li | h1 | h2 | h3 | h4 | h5 | h6 ">
		<xsl:copy>
			<xsl:apply-templates/>
		</xsl:copy>
		<xsl:text disable-output-escaping="yes">
<!-- create a new line --></xsl:text>
	</xsl:template>
	
	<!--Elemente ignorieren-->
	<xsl:template match="img | ul | ol">
		<xsl:apply-templates/>
	</xsl:template>
	
	
	<xsl:template name="replace-string">
		<xsl:param name="text"/>
		<xsl:param name="replace"/>
		<xsl:param name="with"/>
		<xsl:choose>
			<xsl:when test="contains($text,$replace)">
				<xsl:value-of select="substring-before($text,$replace)"/>
				<xsl:value-of select="$with"/>
				<xsl:call-template name="replace-string">
					<xsl:with-param name="text"
						select="substring-after($text,$replace)"/>
					<xsl:with-param name="replace" select="$replace"/>
					<xsl:with-param name="with" select="$with"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
</xsl:stylesheet>