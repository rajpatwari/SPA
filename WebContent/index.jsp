<%-- 
    Document   : index
    Created on : Mar 28, 2013, 10:31:27 PM
    Author     : admin
--%>

<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="org.spa.connect.dbConnection" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">



<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome to SHALEY POSHAN AHAR - Login</title>

        <!-- Stylesheets -->
	<link rel="stylesheet" href="resources/css/style.css">
        <script type="text/javascript">
            function submitForm()
            {
                document.getElementById("login-form").submit();
            }
        </script>
    </head>
    <body>
        <div id="top-bar">

		<!-- end full-width -->

	</div> <!-- end top-bar -->



	<!-- HEADER -->
	<div id="header">

		<div class="page-full-width cf">

			<div id="login-intro" class="fl">

				<h1>Login to SHALEY POSHAN AHAR </h1>
				<h5>Enter your credentials below</h5>

			</div> <!-- login-intro -->

			<!-- Change this image to your own company's logo -->
			<!-- The logo will automatically be resized to 39px height. -->
                        <div id="company-branding" class="fr-1"><br/><img src="" /> <h1>SHALEY POSHAN AHAR</h1></div>

		</div> <!-- end full-width -->

	</div> <!-- end header -->



	<!-- MAIN CONTENT -->
	<div id="content">

		<form action="loginsubmit.jsp" method="POST" id="login-form" name="login-form">

			<fieldset>

				<p>
					<label for="login-username">username:</label>
					<input type="text" id="username" name="username" class="round full-width-input" autofocus/>
				</p>

				<p>
					<label for="login-password">password:</label>
					<input type="password" id="password" name="password" class="round full-width-input" />
				</p>
				<p>
					<select class="round full-width-input" style="border:1px solid #D9DBDD;" name="financial-year">
						<option value="select">Select financial years</option>
						<!--
						<option value="01/04/2010>31/03/2011">01/04/2010 to 31/03/2011</option>
						<option value="01/04/2011>31/03/2012">01/04/2011 to 31/03/2012</option>
						<option value="01/04/2012>31/03/2013">01/04/2012 to 31/03/2013</option>
						<option value="01/04/2013>31/03/2014">01/04/2013 to 31/03/2014</option>
						<option value="01/04/2014>31/03/2015">01/04/2014 to 31/03/2015</option>
						<option value="01/04/2015>31/03/2016">01/04/2015 to 31/03/2016</option>
						<option value="01/04/2016>31/03/2017">01/04/2016 to 31/03/2017</option>
						<option value="01/04/2017>31/03/2018">01/04/2017 to 31/03/2018</option>
						<option value="01/04/2018>31/03/2019">01/04/2018 to 31/03/2019</option>
						<option value="01/04/2019>31/03/2020">01/04/2019 to 31/03/2020</option>
						<option value="01/04/2020>31/03/2021">01/04/2020 to 31/03/2021</option>
						-->
						<option value="01/04/2021>31/03/2022">01/04/2021 to 31/03/2022</option>
						<option value="01/04/2022>31/03/2023">01/04/2022 to 31/03/2023</option>
						<option value="01/04/2023>31/03/2024">01/04/2023 to 31/03/2024</option>
						<option value="01/04/2024>31/03/2025">01/04/2024 to 31/03/2025</option>
						<option value="01/04/2025>31/03/2026">01/04/2025 to 31/03/2026</option>
						<option value="01/04/2026>31/03/2027" selected>01/04/2026 to 31/03/2027</option>
					</select>
				</p>


				<a href="javascript:submitForm()" class="button round blue image-right ic-right-arrow">LOG IN</a>

			</fieldset>

		</form>

	</div> <!-- end content -->



	<!-- FOOTER -->
	<div id="footer">

		<p> Copyright © 2010-2012<a href="http://www.CurrentechSoftwares.com" target="_blank"> Currentech Softwares, Pune.</a>. All rights reserved.</p>

	</div> <!-- end footer -->
    </body>
</html>

