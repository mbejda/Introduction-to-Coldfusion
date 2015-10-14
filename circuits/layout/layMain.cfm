<cfoutput><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="#request.baseHref#" />

    <title>#request.metadata.title#</title>
    <meta name="keywords" content="#request.metadata.keywords#" />
    <meta name="description" content="#request.metadata.description#" />

    <!--- Fav Icon --->
    <link rel="apple-touch-icon" sizes="57x57" href="#request.favIconDir#apple-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="60x60" href="#request.favIconDir#apple-icon-60x60.png">
    <link rel="apple-touch-icon" sizes="72x72" href="#request.favIconDir#apple-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="76x76" href="#request.favIconDir#apple-icon-76x76.png">
    <link rel="apple-touch-icon" sizes="114x114" href="#request.favIconDir#apple-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="120x120" href="#request.favIconDir#apple-icon-120x120.png">
    <link rel="apple-touch-icon" sizes="144x144" href="#request.favIconDir#apple-icon-144x144.png">
    <link rel="apple-touch-icon" sizes="152x152" href="#request.favIconDir#apple-icon-152x152.png">
    <link rel="apple-touch-icon" sizes="180x180" href="#request.favIconDir#apple-icon-180x180.png">
    <link rel="icon" type="image/png" sizes="192x192"  href="#request.favIconDir#android-icon-192x192.png">
    <link rel="icon" type="image/png" sizes="32x32" href="#request.favIconDir#favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="96x96" href="#request.favIconDir#favicon-96x96.png">
    <link rel="icon" type="image/png" sizes="16x16" href="#request.favIconDir#favicon-16x16.png">
    <link rel="manifest" href="#request.favIconDir#manifest.json">
    <meta name="msapplication-TileColor" content="##ffffff">
    <meta name="msapplication-TileImage" content="#request.favIconDir#ms-icon-144x144.png">
    <meta name="theme-color" content="##ffffff">
    <!--- [END] Fav Icon --->

    <!-- jQuery -->
    <!--- <script language="javascript" src="#request.vendorDir#jquery-1.11.3.min.js"></script> --->

    <!-- Font Awsome -->
    <style>
      /*@font-face {
        font-family: 'FontAwesome';
        src: url('#request.vendorDir#font-awesome/fonts/fontawesome-webfont.eot?v=4.3.0');
        src: url('#request.vendorDir#font-awesome/fonts/fontawesome-webfont.eot?##iefix&v=4.3.0') format('embedded-opentype'),
          url('#request.vendorDir#font-awesome/fonts/fontawesome-webfont.woff2?v=4.3.0') format('woff2'),
          url('#request.vendorDir#font-awesome/fonts/fontawesome-webfont.woff?v=4.3.0') format('woff'),
          url('#request.vendorDir#font-awesome/fonts/fontawesome-webfont.ttf?v=4.3.0') format('truetype'),
          url('#request.vendorDir#font-awesome/fonts/fontawesome-webfont.svg?v=4.3.0##fontawesomeregular') format('svg');
        font-weight: normal;
        font-style: normal;
      }*/
    </style>
    <!--- <link rel="stylesheet" href="#request.vendorDir#font-awesome/css/font-awesome.min.css"><!--- <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"> ---> --->
    <!-- [END] Font Awsome -->

    <!-- CSS and JS resources -->#(IsDefined("content.resources")) ? content.resources : ''#  <!-- [END] CSS and JS resources -->
  </head>

  <!-- HTML BODY -->
  <body id="#request.cssData.pagename#">

    <!--- Header --->
    <!--- [END] Header --->

    #content.main#

    <!--- Footer --->
    <!--- [END] Footer --->

  </body><!-- [END] HTML BODY -->


  <!--- Scripts - After Page load --->
  <cfif len(trim(session.message))>
    <script language="javascript">
      alert('#session.message#');
    </script>
    <cfset session.message=''>
  </cfif>
  <!--- [END] Scripts --->

</html>
</cfoutput>
