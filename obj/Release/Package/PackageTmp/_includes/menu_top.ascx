<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="menu_top.ascx.cs" Inherits="ProPortal_Portal._includes.menu_top" %>
<% 
    // get the form vars
    NameValueCollection frm = Request.Form;

    //Response.Write(current_menu);                          
    
%>
    <div class="navbar-wrapper">
        <div class="container">
            <div style="float: left; width: 120px;">
                <a href="/menu.aspx">
                    <%

                        %><img src="/_imgs/logo.png" border="0" style="margin-top: 12px; margin-right: 5px; background-color: #fff; width: 250px;" /><%

                    %>                    
                </a>
            </div>
            <div style="float: left; width: 515px; margin-top: 50px; font-size: 24px; color: #4c4d6d;">
                
            </div>
            <div style="float: right; width: 245px; margin-top: 40px; text-align: right; font-size: 16px;">
                <!--<img src="/_imgs/genex-logo.jpg" border="0" style="" /> -->
                <br />
                Welcome <%Response.Write(Session["full_name"]);%>
                <br />
                <a href="/index.html">Logout</a>
            </div>
            <div style="clear: both;"></div>

            <nav class="navbar navbar-inverse navbar-static-top">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                    </div>
                    <div id="navbar" class="navbar-collapse collapse">
                        <ul class="nav navbar-nav">
                            <li><a href='#' onclick="location.href='/menu.aspx';">Home</a></li>
                            <%
                                    
                            Response.Write(load_menu(Session["my_workbooks"].ToString()));              
                                       
                            %>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
    </div>
