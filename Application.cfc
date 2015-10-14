<cfcomponent output="false" extends="fusebox551.Application">
  <cfscript>
    this.name="NAME";
    this.applicationTimeout = createTimeSpan(7,0,0,0);
    this.sessionManagement = true;
    this.sessionTimeout = createTimeSpan(0,0,20,0);
    this.clientManagement = true;
  </cfscript>

  <cffunction name="onApplicationStart" returntype="boolean" output="false">
    <cfscript>
      application.sessions = 0 ;
      application.fusebox.self = "/index.cfm";
      application.mail = StructNew();
      application.mail.username="xxxxxxx"; //<!--- Account must match from email --->
      application.mail.password="xxxxxxx";
      application.mail.server = "10.26.78.203";
      application.mail.fromAddress = "xxxxxxx";
      application.mail.toAddress = "";
    </cfscript>

    <cfreturn True />
  </cffunction>

  <cffunction name="onApplicationEnd" output="false">
    <cfargument name="applicationScope" required="true" />
  </cffunction>

  <cffunction name="onFuseboxApplicationStart">
    <cfset super.onFuseboxApplicationStart() />
  </cffunction>

  <cffunction name="onSessionStart">
    <cfset session.message="">
  </cffunction>

  <cffunction name="sesPhrase" access="public" returntype="string" output="false">
    <cfargument name="inString" />

    <cfset outString=rereplace(arguments.inString,"[^a-zA-Z0-9_]","-","all") />
    <cfset outString=lCase(outString) />
    <cfset outString=replace(outString,"--","-","all")>
    <cfset outString=replace(outString,"--","-","all")>
    <cfreturn outString />
  </cffunction>

  <cffunction name="onRequestStart">
    <cfargument name="targetPage" />
    <cfset super.onRequestStart(arguments.targetPage) />

  <cfif isdefined("URL.APPReload")>
       <cfset applicationStop() />
       <cflocation url="/index.cfm" addtoken="false">
    </cfif>


    <!--- environment variables --->
    <cfif cgi.HTTP_HOST contains("localhost")
      OR left(cgi.REMOTE_ADDR,9) IS "127.0.0.1">

      <cfset request.mode="local">
      <cfset request.frontBaseHref="">
      <cfset request.mainDSN = "">
      <cfset request.contact.errorToEmail="webteam@rpfunding.com">

      <!--- Developver - Local Host --->
      <cfif cgi.HTTP_HOST contains("localhost")>
        <cfset request.baseHref="http://localhost/_projectShell">

      <!--- Developver - Local IP --->
      <cfelseif left(cgi.REMOTE_ADDR,9) IS "127.0.0.1">
        <cfset request.baseHref="http://127.0.0.1:8500/resources/_projectShell">
      </cfif>

    <!--- Staging - Server Domain Type --->
    <cfelseif cgi.http_host contains(".dev")>
      <!--- <cfset request.mode="dev">
      <cfset request.mainDSN = "">
      <cfset request.baseHref="http://digitalPropSites.dev/">
      <cfset request.frontBaseHref="">
      <cfset request.contact.errorToEmail="webteam@rpfunding.com"> --->

    <!--- Live Site mode - If not developer mode --->
    <cfelse>
      <!--- <cfset request.mode="live">
      <cfset request.mainDSN = "">
      <cfset request.baseHref=cgi.HTTP_HOST>
      <cfset request.frontBaseHref=cgi.HTTP_HOST>
      <cfset request.contact.toEmail="webteam@rpfunding.com"> --->
    </cfif>
    <!--- [END] environment variables --->


    <!--- It's required for app --->
    <cfset request.sesPhrase=this.sesPhrase>


    <cfscript>
      self = myFusebox.getSelf();
      myself = myFusebox.getMyself();
      crlf = chr(13) & chr(10);
      tab='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';

      // var setup

      cssData=structNew();
      request.cssData.pagename = ""; //Body id="#request.cssData.pagename#"
      request.cssData.title = ""; //Body id="#request.cssData.pagename#"
      request.cssData.layout = "static-main"; //Static
      // Found circuits/home/model/actPageData.cfm

      metadata=structNew();
      request.metadata.title = "";
      request.metadata.description = "";
      request.metadata.keywords = "";
      request.metadata.robots="index, follow";
      // Found circuits/home/model/actPageData.cfm


      // request scope

      request.cssDir = "assets/css/";
      request.favIconDir = "assets/favicon/";
      request.fontsDir = "assets/fonts/";
      request.imageDir = "assets/images/";
      request.jsDir = "assets/js/";
      request.jsDir = "assets/js/";
      request.vendorDir = "assets/vendors/";

      request.uploadDir="../_client/_upload/";
      request.uploadPath=expandPath(request.uploadDir);
    </cfscript>
  </cffunction>

  <cffunction name="onRequestEnd">
      <cfargument name="targetPage" type="string" required="true" />

      <cfif ListLast(arguments.targetPage, "\/") eq myFusebox.getSelf()>
          <!--- Pass request to Fusebox. --->
          <cfset super.onRequestEnd(arguments.targetPage) />
      </cfif>
  </cffunction>

  <cffunction name="onError" output="true">
    <cfargument name="exception" required="true" default="none">
    <cfargument name="EventName" type="String" required="true" default="none">
    <cfif cgi.REMOTE_ADDR contains "50.59.222" OR cgi.REMOTE_ADDR contains "127.0." OR cgi.HTTP_HOST contains( "localhost")>
      <cfdump var="#arguments.exception#">
      <cfdump var="#arguments.EventName#">
    <cfelse>
      <cfparam name="exception.message" default="none">
      <cfparam name="exception.detail" default="none">
      <cfparam name="exception.type" default="none">
      <cfparam name="exception.RootCause.Message" default="none">
      <!--- |Trace:#exception.TagContext[1].raw_Trace#|Line:#exception.TagContext[1].line# --->
      <cfif isDefined("exception.TagContext") AND ArrayLen(exception.TagContext)>
        <cfset template=exception.TagContext[1].template>
        <cfset line=exception.TagContext[1].line>
      <cfelse>
        <cfset template="N/A">
        <cfset line="N/A">
      </cfif>
      <cfif (trim(arguments.eventName) IS NOT "onSessionEnd") AND (trim(arguments.eventName) IS NOT "onApplicationEnd")>
        <cfmail to="webteam@rpFunding.com"
    from="#application.mail.fromAddress#"
    subject="XXX - Error"
    type="html"
    server='#application.mail.server#'
    username="#application.mail.username#"
    password="#application.mail.password#">
          <html>
            <head></head>
            <body>
              Error message from application.cfc (front - not admin)<br /><br />
              Exception:<br />
              <cftry>
                <cfdump var="#exception#">  <br />
                #eventName#<br />
                <cfcatch type="any">
                  NO EXCEPTION!<br /><br />
                </cfcatch>
              </cftry>
              Session:<br />
              <cftry>
                <cfdump var="#Session#"> <br />
                <cfcatch type="any">
                  NO SESSION!<br /><br />
                </cfcatch>
              </cftry>
              CGI:<br />
              <cftry>
                <cfdump var="#cgi#"><br /><br />
                <cfcatch type="any">
                  NO CGI!!<br /><br />
                </cfcatch>
              </cftry>
              Client:<br />
              <cftry>
                <cfdump var="#client#" />
                <cfcatch type="any">
                  NO CLIENT!<br /><br />
                </cfcatch>
              </cftry>
              <cftry>
                Sessions:#application.sessions#<br /><br />
                <cfcatch type="any">
                  NO SESSIONS!<br /><br />
                </cfcatch>
              </cftry>
              Time:#dateFormat(now(),"full")# @ #timeFormat(now(), "full")#  <br /><br />
            </body>
          </html>
        </cfmail>
      </cfif>
      <cfinclude template="error.cfm">
    </cfif>
  </cffunction>

  <!--- autoVersion -> is to add version number to any css js files --->
  <!--- https://cfdeepak.wordpress.com/2014/09/13/autoversioning-js-and-css-files-using-coldfusion/ --->
  <cffunction name="autoVersion" access="public" output="false" returntype="string" >
    <cfargument name="fileName" type="string" required="true" >

    <cfset var absPath = expandPath("#ARGUMENTS.fileName#")>
    <cfif !fileExists(absPath)>
        <cfreturn absPath & '!!FileMissing!!'>
    </cfif>
    <!--- get the last modified datetime of the file --->
    <cfset  lstModified = getfileInfo(absPath).lastmodified >
    <!--- <cfset  lstModified = getfileInfo(ARGUMENTS.fileName).lastmodified > --->

    <!--- get the unix timestamp --->
    <cfset  mtime =  dateDiff("s", "January 1 1970 00:00", lstModified)>

    <!--- <cfset var fileNameWithTimestamp = listFirst(ARGUMENTS.fileName, '.') & '.' & mtime & '.' & listLast(ARGUMENTS.fileName, '.')> --->
    <!--- Temp using next line vs the above because the one above needs to have a re-write in place --->
    <cfreturn #trim("#ARGUMENTS.fileName#?v=#mtime#")# >
  </cffunction><!--- [END] autoVersion --->

</cfcomponent>
