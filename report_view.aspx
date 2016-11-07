<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="report_view.aspx.cs" Inherits="ProPortal_Portal.report_view" %>
<%@ Register Src="/_includes/menu_top.ascx" TagName="Menu" TagPrefix="top_menu" %>
<%@ Register Src="/_includes/header.ascx" TagName="Header" TagPrefix="top_header" %>
<%@ Register Src="/_includes/footer.ascx" TagName="Footer" TagPrefix="footer" %>
<top_header:header ID="top_header" runat="server" />
<% 
    // ###########################################################
    // Get the report_id from the url query string
    string report_id = Request.QueryString["report_id"];

    // ###########################################################
    // Get the trusted ticket using the Tableau Trusted Auth.
    // This function is located in the report_view.aspx.cs file.  
    string ts_ticket = getTsTicket(Session["tableau_url"]+"/trusted",Session["user_name"].ToString());

    // ###########################################################
    // Get the report string for calling the view. This function
    // is located in the report_view.aspx.cs file.
    string report_url = getReportString(report_id, ts_ticket, Session["my_workbooks"].ToString());

    %>
    <top_menu:Menu ID="top_menu" runat="server" current_menu="reports" />

    <div class="container marketing">

        <div class="row featurette" style="padding-left: 25px; padding-bottom: 10px;">
            <div style="font-size: 24px; font-weight: Bold; color: #878a8f;" id="report_name"></div>
            <div style="" id="report_desc"></div>
        </div>
        <div style="clear: both;"></div>

        <div class="row featurette" style="border-color: #fff; border-width: 0px; border-style: solid; margin: 5px; margin-top: 15px;">
            <!-- ############################################################### -->
            <!-- This is the placeholder DIV for where we want the Viz to appear -->
            <div id="vizDisplay" class="viz_area" style="width: 1128px; height: 800px; ">    </div>
            <!-- ############################################################### -->
        </div>

    <script>

    var tableauViz, wbook, currentSheet, Sheet1, Sheet2;

    // ###########################################################
    // loadTabViz() function is used to display a Tableau Viz
    // in the page.

    function loadTabViz(url) {
        // ###########################################################
        // clear out old viz if there is one
        if (tableauViz) {
            tableauViz.dispose();
        }

        // ###########################################################
        // get a handler for our display DIVs
        var vizDiv = document.getElementById("vizDisplay");

        // ###########################################################
        // setup the options for the viz emb
        var vizOpts = {
            width: vizDiv.offsetWidth,
            height: vizDiv.offsetHeight,
            hideTabs: false,
            hideToolbar: true,
            onFirstInteractive: function () {
                // ###########################################################
                // This function is called immediately after the Tableau Viz
                // is fully loaded on the screen.
                // Here we store the default workbook/sheet from the first load
                wbook = tableauViz.getWorkbook();
                currentSheet = wbook.getActiveSheet();
            }
        };

        // ###########################################################
        // now get a handle for the final viz
        tableauViz = new tableau.Viz(vizDiv, url, vizOpts);

    }
    
    // ###########################################################
    // Here we build out the full Viz url that we will be calling.
    // We have added :refresh to the end of this call to force
    // Tableau Server to not cache data.
    var first_viz = "<% Response.Write(Session["tableau_url"]); %>/<% Response.Write(report_url); %>?:refresh";

    // ###########################################################
    // Now we call the loadTabViz() function from above
    loadTabViz(first_viz);

    </script>

<footer:footer ID="footer" runat="server" />

