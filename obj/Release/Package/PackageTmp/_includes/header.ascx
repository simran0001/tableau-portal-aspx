<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="header.ascx.cs" Inherits="ProPortal_Portal._includes.header" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<% 
    // get the form vars
    NameValueCollection frm = Request.Form;

    // ##############################################################################
    // if this person is not authenticated, then we will process their authentication
    if (frm != null && Request.Form["user_email"] != null)
    {

        // ###########################################################
        // Here we load the user profile IF they are allowed to access
        // Tableau Server.  This function will return a my_info array
        // that will tell us if this user is allowed to enter.  If they 
        // are, then it returns all of the user profile information.
        // This function is found in the header.ascx.cs file.
        ArrayList my_info = tableau_load_profile(Request.Form["user_email"], Request.Form["user_pass"]);

        // ###########################################################
        // Take the first options as login_token.  This will always be 
        // returned.
        string login_token = my_info[0].ToString();

        // ###########################################################
        // If the user is NOT allowed to access Tableau Server, this
        // will equal "failed".  Otherwise, it will contain the
        // user information and we need to load these info session
        // variables.
        if (login_token != "failed")
        {
            Session["rest_token"] = login_token;
            Session["user_id"] = my_info[1].ToString();
            Session["site_id"] = my_info[2].ToString();
            Session["name"] = my_info[3].ToString();
            Session["site_role"] = my_info[4].ToString();
            Session["last_login"] = my_info[5].ToString();
            Session["full_name"] = my_info[6].ToString();
            Session["my_workbooks"] = my_info[7].ToString();
            Session["workbook_count"] = my_info[8].ToString();
            Session["tableau_url"] = my_info[9].ToString();
            Session["user_name"] = my_info[10].ToString();
        }
        else
        {
            // ###########################################################
            // If this user is not allowed to access Tableau Server, then
            // we will redirect them to the index.aspx page with an error
            // message.
            Response.Redirect("/index.aspx?error_message=Login%20Not%20Correct");
            Response.End();
        }
    }
    else if(Session["user_id"] != null )
    {
        // ###########################################################
        // Do nothing, they are already logged in and they have a valid
        // user_id
    }
    else
    {
        // ###########################################################
        // Otherwise, make sure that all of the session vars are set
        // to NULL. Then redirect them to the index.aspx page with an
        // error_message.
        Session["rest_token"] = "";
        Session["user_id"] = "";
        Session["site_id"] = "";
        Session["name"] = "";
        Session["site_role"] = "";
        Session["last_login"] = "";
        Session["full_name"] = "";
        Session["my_workbooks"] = "";
        Session["workbook_count"] = "";
        Session["tableau_url"] = "";
        Session["user_name"] = "";

        Response.Redirect("/index.aspx?error_message=Your%20Session%20Expired");
        Response.End();
    }


    // ###########################################################
    // Here we want to test the user_id session variable to ensure
    // that the user successfully signed in.  If not, then we will
    // redirect them to index.aspx with an error message.
    if (Session["user_id"] != null && Session["user_id"] != "failed")
    {
        // all good, lets go
    }
    else
    {
        Session["rest_token"] = "";
        Session["user_id"] = "";
        Session["site_id"] = "";
        Session["name"] = "";
        Session["site_role"] = "";
        Session["last_login"] = "";
        Session["full_name"] = "";
        Session["my_workbooks"] = "";
        Session["workbook_count"] = "";
        Session["tableau_url"] = "";
        Session["tableau_user"] = "";

        Response.Redirect("/index.aspx?error_message=Your%20Session%20Expired");
        Response.End();
    }

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ProPortal - Guided Analytics Portal</title>
    <script type='text/javascript' src='http://ts1.datapainters.com/javascripts/api/tableau-2.0.0.js'></script>
    <!-- Fonts START -->
    <!--<link href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700|PT+Sans+Narrow|Source+Sans+Pro:200,300,400,600,700,900&subset=all" rel="stylesheet" type="text/css">-->
    <link href='https://fonts.googleapis.com/css?family=Titillium+Web' rel='stylesheet' type='text/css'>
    <!-- Fonts END -->
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="/_css/bootstrap-min.css">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <style>
        body
        {
            font-family: 'Titillium Web';
        }

    </style>

</head>
<body style="background-color: #fff;">
    <%

        // ###########################################################
        // Just in case something wen wrong,  we want to test the user_id 
        // session variable to ensure that the user successfully signed in.  
        // If not, then we will redirect them to index.aspx with an error message.
        if (Session["user_id"] == "failed")
        {
            // return to login page
            %>
            <script>alert("I was not able to locate your login or your session might have expired.  Please try to login again."); location.href = '/index.aspx';</script>
            <%
            Response.End();
        }


    %>