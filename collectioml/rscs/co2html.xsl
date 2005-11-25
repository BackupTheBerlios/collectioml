<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:co="http://collectio.org/collectioML/"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" encoding="UTF-8" indent="yes" method="xml"
    omit-xml-declaration="no" version="1.0"/>
  <!--
  &amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;lt;xsl:include
  href="do_collectio_dc.xsl" /&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;gt;
  -->
  <xsl:template match="/">
    <html xsl:exclude-result-prefixes="co">
      <xsl:attribute name="xml:lang">
        <xsl:value-of select="co:object/@xml:lang"/>
      </xsl:attribute>
      <xsl:attribute name="lang">
        <xsl:value-of select="co:object/@xml:lang"/>
      </xsl:attribute>
      <head>
        <title>
          <xsl:value-of select="concat('Object ', co:object/@xml:id)"/>
        </title>
        <!-- call dctags -->
        
        
        <!-- &amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;lt;xsl:call-template name="do-dctags"/&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;gt; -->
<meta content="text/html; charset=UTF-8" http-equiv="Content-Type" />
<link type="text/css" title="standard" rel="stylesheet" href="rscs/standard.css" />
      </head>
      <body>
        <h1>
          <xsl:value-of select="concat('Object ', co:object/@xml:id)"/>
        </h1>
        <p style="font-size: 90%; position: absolute; top: 32px; left: 60%;">
          <xsl:call-template name="do-edit-urn"/> </p>
        <xsl:for-each select="co:object/co:page">
          <xsl:apply-templates select="."/>
        </xsl:for-each>
        <xsl:apply-templates select="co:object/co:bibliography"/>
        <xsl:apply-templates select="co:object/co:editing"/>
        <p style="position: absolute; top: 32px; right: 50px;">Valid
      <a href="http://validator.w3.org/check?uri=referer">XHTML</a> and 
          <a href="http://jigsaw.w3.org/css-validator/check/referer">CSS</a>
    </p>
      </body>
    </html>
  </xsl:template>
  <xsl:template name="do-edit-urn"> <a class="urnlink" xsl:exclude-result-prefixes="co">
    <xsl:attribute name="href">
      <xsl:value-of
        select="concat('http://localhost:8080/exist/servlet/db/muscap/objects/', co:object/@xml:id,
          '.xml')"/>
    </xsl:attribute>
    <xsl:attribute name="title">
      <xsl:value-of select="concat('Load ', co:object/@xml:id)"/>
    </xsl:attribute>
    <xsl:text>[ Load ]</xsl:text> </a>
  </xsl:template>
  <xsl:template match="co:page">
    <div class="division" xsl:exclude-result-prefixes="co">
      <xsl:variable name="beginformula">
        <xsl:choose>
          <xsl:when test="co:begin and co:end">
            <xsl:value-of select="'from '"/>
          </xsl:when>
          <xsl:when test="co:begin and not(co:end)">
            <xsl:value-of select="'since '"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="''"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="endformula">
        <xsl:choose>
          <xsl:when test="co:end">
            <xsl:value-of select="' until '"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="''"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="beginslash">
        <xsl:choose>
          <xsl:when test="co:begin/co:date[2]">
            <xsl:value-of select="'/'"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="''"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="endslash">
        <xsl:choose>
          <xsl:when test="co:end/co:date[2]">
            <xsl:value-of select="'/'"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="''"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <h2>
        <xsl:value-of
          select="concat($beginformula, co:begin/co:date[1], $beginslash, co:begin/co:date[2], $endformula, co:end/co:date[1], $endslash, co:end/co:date[2])"/>
      </h2>
      <xsl:apply-templates select="co:administration"/>
      <xsl:apply-templates select="co:location"/>
      <xsl:apply-templates select="co:techdata"/>
      <xsl:apply-templates select="co:event"/>
      <xsl:apply-templates select="co:iconography"/>
    </div>
  </xsl:template>
  <xsl:template match="co:administration">
    <h3 xsl:exclude-result-prefixes="co">
      <xsl:value-of select="local-name(.)"/>
    </h3>
    <p xsl:exclude-result-prefixes="co">
      <xsl:value-of select="concat(co:owner, ' (', co:owner/@type, '). ')"/>
      <xsl:value-of select="concat(co:inventary/@name, ', inv.', co:inventary)"/> </p>
    <p xsl:exclude-result-prefixes="co">
      <xsl:value-of select="concat('Responsibility ', '(', co:responsibility/@type, '): ', co:responsibility, '. ')"/>
      <xsl:value-of select="concat('Jurisdiction: ', co:jurisdiction/@type)"/> </p>
<xsl:for-each select="co:valuation">
      <p xsl:exclude-result-prefixes="co">
      <xsl:value-of select="concat('Valuation of ', @type, ': ')"/>
      <xsl:value-of
        select="concat(./co:value, ' ', ./co:value/@currency, '. ')"/> </p>
</xsl:for-each>
  </xsl:template>
  <xsl:template match="co:denomination">
    <p xsl:exclude-result-prefixes="co">
      <xsl:value-of select="concat(local-name(.), ' (', @*, '): ', .)"/> </p>
  </xsl:template>
  <xsl:template match="co:observation">
    <xsl:apply-templates select="co:description"/>
  </xsl:template>
  <xsl:template match="co:material">
    <p xsl:exclude-result-prefixes="co">
      <xsl:value-of select="."/> </p>
  </xsl:template>
  <xsl:template match="co:depth | co:weight | co:diameter | co:length | co:height | co:width">
    <xsl:value-of select="concat(local-name(.), ': ', ., ' ', @*, '. ')"/>
  </xsl:template>
    <xsl:template match="co:authorship">
    <p xsl:exclude-result-prefixes="co">
      <xsl:value-of
          select="concat(local-name(.), ' of ', @type, ' (', child::node()/@schema, ': ', child::node()/@coverage, '): ')"/>
      <xsl:apply-templates/></p>
  </xsl:template>
    <xsl:template
      match="co:authorship/child::*/child::*         | co:authorship/child::*/child::*/child::*         |
    co:authorship/child::*/child::*/child::*/child::*         |
    co:authorship/child::*/child::*/child::*/child::*/child::*         |
    co:authorship/child::*/child::*/child::*/child::*/child::*/child::*/child::*         |
    co:authorship/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*         |
    co:authorship/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*         |
    co:authorship/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*     |
    co:authorship/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
    |
    co:authorship/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
    |
    co:authorship/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
    |
    co:authorship/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
    |
    co:authorship/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
    |
    co:authorship/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*">
      <xsl:value-of select="concat(@*, ', ')"/>
      <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="co:part[number(count(parent::co:techdata/co:part))>1]">
    <p xsl:exclude-result-prefixes="co"><xsl:value-of select="concat(local-name(.), ' ')"/><xsl:number count="co:part" format="1"/><xsl:text>: </xsl:text><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="co:part[number(count(parent::co:techdata/co:part))=1]">
        <p xsl:exclude-result-prefixes="co"><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="co:description | co:notes">
    <xsl:apply-templates select="co:para | co:inscription"/>
  </xsl:template>
  <xsl:template match="co:inscription[@transcription='basic']">
    <table xsl:exclude-result-prefixes="co">
      <col style="width: 10px; text-align: right;"/>
      <col style="width: 20px"/>
      <xsl:for-each select="co:line">
        <tr>
          <td>
            <span style="color: rgb(150,150,100)">
              <xsl:number count="co:line" format="                     1"/>
            </span>
          </td>
          <td/>
          <td>
            <xsl:value-of select="."/>
          </td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>
  <xsl:template match="co:para">
    <p xsl:exclude-result-prefixes="co">
      <xsl:apply-templates/> </p>
  </xsl:template>
  <xsl:template match="co:bibliography">
    <div class="division" xsl:exclude-result-prefixes="co">
      <h3 xsl:exclude-result-prefixes="co">
        <xsl:value-of select="local-name(.)"/>
      </h3>
      <p>
        <xsl:for-each select="co:entry">
          <xsl:value-of select="concat(., ' (', @type, '). ')"/>
        </xsl:for-each> </p>
    </div>
  </xsl:template>
  <xsl:template match="co:event">
    <h3 xsl:exclude-result-prefixes="co">
      <xsl:value-of select="concat(local-name(.), ' - ', @type)"/>
    </h3>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="co:location">
    <h3 xsl:exclude-result-prefixes="co">
      <xsl:value-of select="local-name(.)"/>
    </h3>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="co:location/child::*">
    <p xsl:exclude-result-prefixes="co">
        <xsl:value-of select="local-name(.)"/>
        <a>
            <xsl:attribute name="title">
                <xsl:value-of select="concat('Schema: ', @schema, '; Coverage: ', @coverage)"/>
            </xsl:attribute>
            <xsl:text> [Info]: </xsl:text>
        </a>
      <xsl:apply-templates/> </p>
  </xsl:template>
  <xsl:template match="co:iconography">
    <h3 xsl:exclude-result-prefixes="co">
      <xsl:value-of select="local-name(.)"/>
    </h3>
    <xsl:apply-templates/>
  </xsl:template>
    <xsl:template match="co:techdata">
        <h3 xsl:exclude-result-prefixes="co">
            <xsl:value-of select="local-name(.)"/>
        </h3>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="co:iconclass | co:objectclass | co:materialclass">
    <p xsl:exclude-result-prefixes="co">
        <xsl:value-of select="local-name(.)"/>
        <a>
            <xsl:attribute name="title">
                <xsl:value-of select="concat('Schema: ', @schema, '; Coverage: ', @coverage)"/>
            </xsl:attribute>
            <xsl:text> [Info]: </xsl:text>
        </a>
        <xsl:apply-templates/> </p>
  </xsl:template>
    <xsl:template
    match="co:location/child::*/child::*         | co:location/child::*/child::*/child::*         |
    co:location/child::*/child::*/child::*/child::*         |
    co:location/child::*/child::*/child::*/child::*/child::*         |
    co:location/child::*/child::*/child::*/child::*/child::*/child::*/child::*         |
    co:location/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*         |
    co:location/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*         |
    co:location/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*     |
    co:location/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
    |
    co:location/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
    |
    co:location/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
    |
    co:location/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
    |
    co:location/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
    |
    co:location/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*">
    <xsl:value-of select="concat(@*, ', ')"/>
    <xsl:apply-templates/>
  </xsl:template>
    <xsl:template
        match="co:objectclass/child::* | co:objectclass/child::*/child::*         | co:objectclass/child::*/child::*/child::*     |
    co:objectclass/child::*/child::*/child::*/child::*         |
    co:objectclass/child::*/child::*/child::*/child::*/child::*         |
    co:objectclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*         |
    co:objectclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*         |
    co:objectclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*         |
    co:objectclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
    |
    co:objectclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
    |
    co:objectclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
    |
    co:objectclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
    |
    co:objectclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
    |
    co:objectclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
    |
    co:objectclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*">
    <xsl:value-of select="concat(local-name(.), ': ', @*, ', ')"/>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template
    match="co:iconclass/child::* | co:iconclass/child::*/child::*         | co:iconclass/child::*/child::*/child::*
    |     co:iconclass/child::*/child::*/child::*/child::*         |
    co:iconclass/child::*/child::*/child::*/child::*/child::*         |
    co:iconclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*         |
    co:iconclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*         |
    co:iconclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*         |
    co:iconclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
    |
    co:iconclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
    |
    co:iconclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
    |
    co:iconclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
    |
    co:iconclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
    |
    co:iconclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
    |
    co:iconclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*">
    <xsl:value-of select="concat(local-name(.), ': ', @*, ', ')"/>
    <xsl:apply-templates/>
  </xsl:template>
    <xsl:template
        match="co:materialclass/child::* | co:materialclass/child::*/child::*         | co:materialclass/child::*/child::*/child::*     |
        co:materialclass/child::*/child::*/child::*/child::*         |
        co:materialclass/child::*/child::*/child::*/child::*/child::*         |
        co:materialclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*         |
        co:materialclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*         |
        co:materialclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*         |
        co:materialclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
        |
        co:materialclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
        |
        co:materialclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
        |
        co:materialclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
        |
        co:materialclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
        |
        co:materialclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*
        |
        co:materialclass/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*/child::*">
        <xsl:value-of select="concat(local-name(.), ': ', @*, ', ')"/>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="co:editing">
    <div class="division" xsl:exclude-result-prefixes="co">
      <h3>
        <xsl:value-of select="local-name(.)"/>
      </h3>
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  <xsl:template match="co:editorship">
    <p xsl:exclude-result-prefixes="co">
      <xsl:value-of select="concat(co:date, ': ', co:name)"/> </p>
    <xsl:apply-templates select="co:description"/>
  </xsl:template>
  <xsl:template match="co:olink"> <a xsl:exclude-result-prefixes="co">
    <xsl:attribute name="href">
      <xsl:value-of
        select="concat('http://localhost:8080/exist/xquery/biblio.xq?field1=any&amp;term1=',
          @targetdoc, '&amp;mode1=contains')"/>
    </xsl:attribute>
    <xsl:attribute name="title">
      <xsl:value-of select="concat('External link to ', @targetdoc, '. Linkmode: ', @linkmode)"/>
    </xsl:attribute>
    <xsl:apply-templates/>
    <xsl:text>
    </xsl:text>
    <span class="urnlink">
      <xsl:value-of select="@targetdoc"/>
    </span></a>
  </xsl:template>
  <xsl:template name="do-long-date">
    <xsl:variable name="date">
      <xsl:value-of select="co:article/co:articleinfo/co:date"/>
    </xsl:variable>
    <!-- Day -->
    <xsl:value-of select="number(substring($date, 9, 2))"/>
    <xsl:text>.</xsl:text>
    <!-- Month -->
    <xsl:variable name="month" select="number(substring($date, 6, 2))"/>
    <xsl:choose>
      <xsl:when test="$month=1">Januar</xsl:when>
      <xsl:when test="$month=2">Februar</xsl:when>
      <xsl:when test="$month=3">März</xsl:when>
      <xsl:when test="$month=4">April</xsl:when>
      <xsl:when test="$month=5">Mai</xsl:when>
      <xsl:when test="$month=6">Juni</xsl:when>
      <xsl:when test="$month=7">Juli</xsl:when>
      <xsl:when test="$month=8">August</xsl:when>
      <xsl:when test="$month=9">September</xsl:when>
      <xsl:when test="$month=10">Oktober</xsl:when>
      <xsl:when test="$month=11">November</xsl:when>
      <xsl:when test="$month=12">Dezember</xsl:when>
    </xsl:choose>
    <xsl:text/>
    <!-- Year -->
    <xsl:value-of select="substring($date, 1, 4)"/>
  </xsl:template>
</xsl:transform>
