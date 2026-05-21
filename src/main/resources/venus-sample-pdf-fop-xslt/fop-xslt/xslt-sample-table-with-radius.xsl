<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

    <!-- Identity template - copies everything as-is -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- ================================================================== -->
    <!-- TABLE STYLING: Apply rounded borders to the main data table       -->
    <!-- ================================================================== -->

    <!-- Specific template for fo:table with id="data-table" -->
    <!-- Applies rounded corners (fox:border-radius) to the entire table -->
    <!-- Removes border-separation attribute for proper border styling -->
    <xsl:template match="fo:table[@id='data-table']">
        <xsl:copy>
            <!-- Copy existing attributes, excluding border-separation -->
            <xsl:apply-templates select="@*[name() != 'border-separation']"/>
            <!-- Add the border-radius attribute for rounded table corners (Apache FOP extension) -->
            <xsl:attribute name="fox:border-radius">8pt</xsl:attribute>
            <!-- Copy child nodes (table-column, table-body, etc.) -->
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- ================================================================== -->
    <!-- CELL CORNER STYLING: Apply rounded radius to table corner cells   -->
    <!-- ================================================================== -->

    <!-- Template for top-left corner cell -->
    <!-- Applies rounded radius to the top-left corner of the table -->
    <xsl:template match="*[@id='top-left-border']">
        <xsl:copy>
            <!-- Copy existing attributes -->
            <xsl:apply-templates select="@*"/>
            <!-- Add the top-left radius attribute (Apache FOP extension) -->
            <xsl:attribute name="fox:border-before-start-radius">8pt</xsl:attribute>
            <!-- Copy child nodes -->
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- Template for top-right corner cell -->
    <!-- Applies rounded radius to the top-right corner of the table -->
    <xsl:template match="*[@id='top-right-border']">
        <xsl:copy>
            <!-- Copy existing attributes -->
            <xsl:apply-templates select="@*"/>
            <!-- Add the top-right radius attribute (Apache FOP extension) -->
            <xsl:attribute name="fox:border-before-end-radius">8pt</xsl:attribute>
            <!-- Copy child nodes -->
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- Template for bottom-left corner cell -->
    <!-- Applies rounded radius to the bottom-left corner of the table -->
    <xsl:template match="*[@id='bottom-left-border']">
        <xsl:copy>
            <!-- Copy existing attributes -->
            <xsl:apply-templates select="@*"/>
            <!-- Add the bottom-left radius attribute (Apache FOP extension) -->
            <xsl:attribute name="fox:border-after-start-radius">8pt</xsl:attribute>
            <!-- Copy child nodes -->
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- Template for bottom-right corner cell -->
    <!-- Applies rounded radius to the bottom-right corner of the table -->
    <xsl:template match="*[@id='bottom-right-border']">
        <xsl:copy>
            <!-- Copy existing attributes -->
            <xsl:apply-templates select="@*"/>
            <!-- Add the bottom-right radius attribute (Apache FOP extension) -->
            <xsl:attribute name="fox:border-after-end-radius">8pt</xsl:attribute>
            <!-- Copy child nodes -->
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>