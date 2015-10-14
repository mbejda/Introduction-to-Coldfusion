<cfoutput>
<cfparam name="url.fuseaction" default="home.main">
  <cfswitch expression="#url.fuseaction#">

    <cfcase value="home.demo">
      <link href="#autoVersion('#request.cssDir#demo.css')#" rel="stylesheet" type="text/css" media="all" />
    </cfcase>


    <!--- If none of the cfcase match, then run code below --->
    <cfdefaultcase>
      <link href="#autoVersion('#request.cssDir#error.css')#" rel="stylesheet" type="text/css" media="all" />
    </cfdefaultcase>

  </cfswitch>
</cfoutput>
