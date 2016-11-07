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
        Current Reports Available
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
    </div>
</div>

<!-- ######################## -->
<!-- DISPLAY The footer       -->
<!-- ######################## -->
<footer:footer ID="footer" runat="server" />