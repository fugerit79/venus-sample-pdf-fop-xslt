# venus-sample-pdf-fop-xslt

This is a sample project configured using [fj-doc-maven-plugin init plugin](https://venusdocs.fugerit.org/guide/#maven-plugin-goal-init).

[![Keep a Changelog v1.1.0 badge](https://img.shields.io/badge/changelog-Keep%20a%20Changelog%20v1.1.0-%23E05735)](CHANGELOG.md)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=fugerit79_venus-sample-pdf-fop-xslt&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=fugerit79_venus-sample-pdf-fop-xslt)
[![Coverage](https://sonarcloud.io/api/project_badges/measure?project=fugerit79_venus-sample-pdf-fop-xslt&metric=coverage)](https://sonarcloud.io/summary/new_code?id=fugerit79_venus-sample-pdf-fop-xslt)
[![License: MIT](https://img.shields.io/badge/License-MIT-teal.svg)](https://opensource.org/licenses/MIT)
[![code of conduct](https://img.shields.io/badge/conduct-Contributor%20Covenant-purple.svg)](https://github.com/fugerit-org/fj-universe/blob/main/CODE_OF_CONDUCT.md)

This project is part of a series of mini tutorial on [Venus Fugerit Doc](https://github.com/fugerit-org/fj-doc),
here you can find the [other tutorials](https://github.com/fugerit79/venus-sample-index).

## Requirement

* JDK 8+ (*)
* Maven 3.8+

(*) Currently FOP not working on [JDK 25, See bug JDK-8368356](https://bugs.openjdk.org/browse/JDK-8368356).

## Project initialization

This project was created with [Venus Maven plugin](https://venusdocs.fugerit.org/guide/#maven-plugin-goal-init)

```shell
mvn org.fugerit.java:fj-doc-maven-plugin:8.17.2:init \
-DgroupId=org.fugerit.java.demo \
-DartifactId=venus-sample-pdf-fop-xslt \
-Dextensions=base,freemarker,mod-fop \
-DaddJacoco=true \
-DaddJacoco=addFormatting=true \
-DwithCI=github \
-Dflavour=vanilla
```

## Mod FOP XSLT Processing

We need to add the [mod-fop-xslt-path](https://venusdocs.fugerit.org/guide/#doc-handler-mod-fop-xslt-path) attribute : 

```xml
<info name="mod-fop-xslt-path">venus-sample-pdf-fop-xslt/fop-xslt/xslt-sample.xsl</info>
```

Optionally set the [mod-fop-xslt-debug](https://venusdocs.fugerit.org/guide/#doc-handler-mod-fop-xslt-debug) attribute :

```xml
<info name="mod-fop-xslt-debug">true</info>
```

In our document there are two tables. The second one is not fitting the page.

Our XSLT template : 

```xml
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

    <!-- Specific template for elements with id="end-element" -->
    <xsl:template match="*[@id='end-element']">
        <xsl:copy>
            <!-- Copy existing attributes -->
            <xsl:apply-templates select="@*"/>
            <!-- Add the keep-together attribute -->
            <xsl:attribute name="keep-together.within-page">always</xsl:attribute>
            <!-- Copy child nodes -->
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
```

Will add the attribute *keep-together.within-page* to the resulting XSLT : 

```xml
<xsl:attribute name="keep-together.within-page">always</xsl:attribute>
```

