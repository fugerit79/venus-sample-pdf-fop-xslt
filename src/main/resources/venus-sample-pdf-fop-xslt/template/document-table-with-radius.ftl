<?xml version="1.0" encoding="utf-8"?>
<doc
        xmlns="http://javacoredoc.fugerit.org"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://javacoredoc.fugerit.org https://www.fugerit.org/data/java/doc/xsd/doc-2-1.xsd" >

    <#--
        This is a Venus Fugerit Doc (https://github.com/fugerit-org/fj-doc) FreeMarker Template XML (ftl[x]).
        For consideration of Venus Fugerit Doc and Apache FreeMarker integration see :
        https://venusdocs.fugerit.org/guide/#doc-freemarker-entry-point
        The result will be a :
    -->
    <!--
        This is a Venus Fugerit Doc (https://github.com/fugerit-org/fj-doc) XML Source Document.
        For documentation on how to write a valid Venus Doc XML Meta Model refer to :
        https://venusdocs.fugerit.org/guide/#doc-format-entry-point
    -->

    <#assign defaultTitle="My sample title XML">

    <!-- ========================================= -->
    <!-- DOCUMENT CONFIGURATION AND METADATA      -->
    <!-- ========================================= -->
    <metadata>
        <!-- Document page margins: left;right;top;bottom -->
        <info name="margins">10;10;10;30</info>

        <!-- Document metadata information for PDF generation -->
        <info name="doc-title">${docTitle!defaultTitle}</info>
        <info name="doc-subject">fj doc venus sample source FreeMarker Template XML - ftlx</info>
        <info name="doc-author">fugerit79</info>
        <info name="doc-language">en</info>

        <!-- Format-specific table identifiers -->
        <!-- Excel/XLSX table ID (with print flag for print area) -->
        <info name="excel-table-id">data-table=print</info>
        <!-- CSV export will include this table -->
        <info name="csv-table-id">data-table</info>

        <info name="html-css-style">
            table#data-table {
              border-collapse: separate;
              border-spacing: 0;
            }
            th#top-left-border {
              border-top-left-radius: 12px;
            }
            th#top-right-border {
              border-top-right-radius: 12px;
            }
            td#bottom-left-border {
              border-bottom-left-radius: 12px;
            }
            td#bottom-right-border {
              border-bottom-right-radius: 12px;
            }
        </info>

        <!-- ========================================= -->
        <!-- XSLT CONFIGURATION FOR ROUNDED BORDERS   -->
        <!-- ========================================= -->
        <!-- Apply XSLT transformation when enableXslt parameter is true -->
        <!-- This stylesheet processes the generated FO document to add -->
        <!-- rounded border radius properties to the data-table and corner cells -->
        <#if enableXslt!false >
            <info name="mod-fop-xslt-path">venus-sample-pdf-fop-xslt/fop-xslt/xslt-sample-table-with-radius.xsl</info>
            <!-- Enable debug output to view the FO document after XSLT processing -->
            <info name="mod-fop-xslt-debug">${(debugXslt!false)?string('true', 'false')}</info>
        </#if>

        <footer-ext>
            <para align="right">${r"${currentPage}"} / ${r"${pageCount}"}</para>
        </footer-ext>
    </metadata>

    <!-- ========================================= -->
    <!-- DOCUMENT BODY WITH SAMPLE TABLES         -->
    <!-- ========================================= -->
    <body>
    <para>${docTitle!defaultTitle}</para>

    <!-- ========================================= -->
    <!-- TABLE 1: DATA TABLE WITH ROUNDED BORDERS -->
    <!-- ========================================= -->
    <!-- Features:                                -->
    <!-- - id="data-table" matches XSLT template  -->
    <!-- - Corner cells have special IDs to apply -->
    <!--   rounded border-radius via XSLT         -->
    <!-- - Dynamic last row detection for bottom  -->
    <!--   corner cell styling                    -->
    <!-- ========================================= -->
    <table columns="3" colwidths="30;30;40"  width="100" id="data-table" padding="2" space-after="30">
        <!-- Table header row -->
        <row header="true">
            <!-- Top-left corner: will have fox:border-before-start-radius applied -->
            <cell id="top-left-border" align="center"><para>Name</para></cell>
            <!-- Middle column header -->
            <cell align="center"><para>Surname</para></cell>
            <!-- Top-right corner: will have fox:border-before-end-radius applied -->
            <cell id="top-right-border" align="center"><para>Title</para></cell>
        </row>

        <!-- Data rows: iterate through listPeople -->
        <!-- Last row cells dynamically get bottom corner IDs -->
        <#if listPeople??>
            <#list listPeople as current>
                <row>
                    <!-- Left column: bottom-left corner ID added on last row (current?is_last) -->
                    <cell<#if current?is_last> id="bottom-left-border"</#if>><para>${current.name}</para></cell>
                    <!-- Middle column -->
                    <cell><para>${current.surname}</para></cell>
                    <!-- Right column: bottom-right corner ID added on last row (current?is_last) -->
                    <cell<#if current?is_last> id="bottom-right-border"</#if>><para>${current.title}</para></cell>
                </row>
            </#list>
        </#if>
    </table>

    </body>

</doc>