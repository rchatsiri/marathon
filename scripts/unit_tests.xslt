<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:param name="project_name" select="'no_project_name_defined'"/>
    <xsl:param name="pipeline_name" select="'no_pipeline_name_defined'"/>
    <xsl:param name="build_id" select="'no_build_id_definied'"/>
    <xsl:param name="build_timestamp" select="'no_build_timestamp_defined'"/>
    <xsl:output method="text" encoding="utf-8" indent="no"/>
    <xsl:template match="/"><xsl:text>project_name,pipeline_name,build_id,build_timestamp,package_name,class_name,class_file_name,statement_count,statements_invoked,statement_rate&#xa;</xsl:text>
        <xsl:for-each select="//class">
            <xsl:value-of select="$project_name"/>,<xsl:value-of select="$pipeline_name"/>,<xsl:value-of select="$build_id"/>,<xsl:value-of select="$build_timestamp"/>,<xsl:value-of select="ancestor::package[1]/@name" />,<xsl:value-of select="@name" />,<xsl:value-of select="@filename" />,<xsl:value-of select="@statement-count" />,<xsl:value-of select="@statements-invoked" />,<xsl:value-of select="@statement-rate" /><xsl:text>&#xa;</xsl:text>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
