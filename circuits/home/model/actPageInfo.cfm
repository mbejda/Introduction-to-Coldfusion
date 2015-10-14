<cfparam name="url.fuseaction" default="home.main">
<cfswitch expression="#url.fuseaction#">

  <cfcase value="home.demo">
    <cfscript>
      request.cssData.pagename = "home.dspDemo"; //Body id="#request.cssData.pagename#"
      request.cssData.title = "DemoTitle"; //Body id="#request.cssData.pagename#"
      request.cssData.layout = "static-main"; //Static, Liquid, Adaptive, or Responsive
      request.metadata.title = "DemoTitle";
      request.metadata.description = "DemoMetaData";
      request.metadata.keywords = "DemoWebSite";
    </cfscript>
  </cfcase>


  <!--- If none of the cfcase match, then run code below --->
  <cfdefaultcase>
    <cfscript>
      request.cssData.pagename = "default";
      request.metadata.title = "RP Digital";
      request.metadata.description = "RP Digital Marketing";
      request.metadata.keywords = "RP Digital Marketing Website";
    </cfscript>
  </cfdefaultcase>

</cfswitch>
