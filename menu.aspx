<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="menu.aspx.cs" Inherits="ProPortal_Portal.menu" %>
<!-- ######################## -->
<!-- INCLUDE The menu library -->
<!-- ######################## -->
<%@ Register Src="/_includes/menu_top.ascx" TagName="Menu" TagPrefix="top_menu" %>
<!-- ######################## -->
<!-- INCLUDE The header library -->
<!-- ######################## -->
<%@ Register Src="/_includes/header.ascx" TagName="Header" TagPrefix="top_header" %>
<!-- ######################## -->
<!-- INCLUDE The footer library -->
<!-- ######################## -->
<%@ Register Src="/_includes/footer.ascx" TagName="Footer" TagPrefix="footer" %>

<!-- #################################### -->
<!-- DISPLAY The header                   -->
<!-- -- this comes from header.ascx     -->
<!-- #################################### -->
<top_header:header ID="top_header" runat="server" />
<!-- #################################### -->
<!-- DISPLAY The top menu                 -->
<!-- -- this comes from menu_top.ascx     -->
<!-- #################################### -->

<top_menu:Menu ID="top_menu" runat="server" />

<div class="container marketing" style="margin-top: 0px; padding-top: 0px;">

    <div class="row featurette" style="padding: 1px; font-size: 34px; color: #878a8f; margin-left: 1px; margin-right: 3px;">
        <h2>Featured Workbooks</h2>
    </div>
    <div style="clear: both;"></div>
    <br />
    <%

        // Draw the menu into the center of the page
        // -- This comes from the menu.aspx.cs file
        Response.Write(load_menu(Session["my_workbooks"].ToString(),Session["user_id"].ToString()));

    %>
    </div>

</div>
<div style="clear: both;"></div>
<br /><br />
<div>
    <h3>Resources</h3>
    <ul>
        <li>
            <a href="https://github.com/jdomingu/tableau-portal-aspx">Sample on Github</a>
        </li>
        <li>
            <a href="http://onlinehelp.tableau.com/current/api/js_api/en-us/JavaScriptAPI/js_api.htm">JavaScript API Documentation</a>
        </li>
        <li>
            <a href="http://onlinehelp.tableau.com/current/api/rest_api/en-us/help.htm">REST API Documentation</a>
            </i>
    </ul>
</div>


<!-- ######################## -->
<!-- DISPLAY The footer       -->
<!-- ######################## -->
<footer:footer ID="footer" runat="server" />
