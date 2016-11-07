<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="ProPortal_Portal.index" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>ProPortal - Guided Analytics Portal</title>

    <!-- Fonts START -->
    <!-- <link href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700|PT+Sans+Narrow|Source+Sans+Pro:200,300,400,600,700,900&subset=all" rel="stylesheet" type="text/css"> -->
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
        body {
            font-family: 'Titillium Web';
        }
    </style>

</head>
<body style="">

    <div class="navbar-wrapper">
        <div class="container">
            <div style="float: left; width: 120px;">
                <img src="/_imgs/logo.png" border="0" style="margin-top: 12px; margin-right: 5px; background-color: #fff; width: 250px;" />
            </div>
            <div style="float: left; width: 1005px; margin-top: 50px; font-size: 44px; color: #878a8f; text-align: right;">
                Analytic Portal Example
            </div>
            <div style="clear: both;"></div>
    </div>

    <div class="container marketing">
        <hr class="featurette-divider" style="margin-top: 10px; padding-top: 0px;">

        <!-- START THE FEATURETTES -->
        <div class="row featurette">
            <div style="">
                <div style="margin-top: 10px; margin-bottom: 20px; font-size: 34px; font-weight: Bold; line-height: 45px; color: #3277a7; text-align: center;">Self Service Analytics</div>
                <div style="font-size: 20px; font-style: Light; text-align: center;">Organized into an easy to use portal experience for everyone.</div>
            </div>
        </div>
        <hr class="featurette-divider" style="margin-top: 40px; margin-bottom: 40px;">
        <div class="row featurette">
            <div style="width: 325px; margin-left: 420px;">
                <%
                    // ########################################
                    // If there is an error_message returned
                    // then display it
                    // ########################################
                    NameValueCollection frm = Request.Form;
                    if (frm != null && Request.Form["error_message"] != null)    
                    {
                        %>
                        <div style=""><% Response.Write(Request.Form["error_message"]); %></div>
                        <%
                    }
                %>
                <form class="form-signin" action="menu.aspx" method="post">
                    <label for="inputEmail" class="sr-only">Email address</label>
                    <input type="text" id="inputEmail" name="user_email" class="form-control" placeholder="Tableau Username" required autofocus>
                    <br />
                    <label for="inputPassword" class="sr-only">Password</label>
                    <input type="password" id="inputPassword" name="user_pass" class="form-control" placeholder="Tableau Password" required>
                    <div class="checkbox" style="float: left;">
                        <label>
                            <input type="checkbox" value="remember-me"> Remember me
                        </label>
                    </div>
                    <div style="float: left; width: 110px; margin-left: 100px; margin-top: 10px;">
                        
                    </div>
                    <button class="btn btn-lg btn-primary btn-block" type="submit" style="background-color: #3277a7; border-color: #000;">LOG IN</button>
                </form>

            </div>
        </div>
        <hr class="featurette-divider" style="margin-top: 40px; margin-bottom: 40px;">
        <div class="row featurette">
 
        
        </div>

        <hr class="featurette-divider" style="margin-top: 40px; margin-bottom: 10px;">
        <!-- FOOTER -->
        <style>
            .bottom_link
            {
                text-decoration: none;
                color: #fff;
            }
            .bottom_link:hover
            {
                color: #4c4d6d;
                text-decoration: underline;
            }
        </style>
        <footer style="font-size: 12px;">
            <p>&copy; 2016, <a href="http://www.datapainters.com" class="" target="_blank">Your Company Name Here.</a> All Rights Reserved.
            </p>

        </footer>
    </div><!-- /.container -->

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

</body>
</html>
