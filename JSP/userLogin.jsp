<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>


<!DOCTYPE html>
<html lang="en">
	<head>        
		<meta name="description" content="ΜΑΔΚΑΕΣ Έσοδα - Login">
		<title>Είσοδος στο Σύστημα Εσόδων (ΜΑΔΚΑΕΣ)</title>

<%@include file="components\header.jsp" %>


		<style>
			.login-box {
				max-width: 400px;
				margin: auto;
				margin-top: 50px;
			}
			.login-box .form-control {
				position: relative;
				height: auto;
				-webkit-box-sizing: border-box;
				-moz-box-sizing: border-box;
				box-sizing: border-box;
				padding: 10px;
				font-size: 16px;
				margin-bottom: 10px;
			}
		</style>

	</head>
	
	<body class="d-flex flex-column" style="padding-bottom: 77px; padding-top: 110px;">


<%@include file="components\navbar.jsp" %>

<% if (request.getAttribute("session")!=null) { %>
    <div class="alert alert-danger">

        <center><strong> <%=(String)request.getAttribute("session") %> </strong></center>

    </div>
<% } %>


<% if (request.getAttribute("success_message")!=null) { %>
    <div class="alert alert-success">

        <center><strong> <%=(String)request.getAttribute("success_message") %> </strong></center>

    </div>
<% }

if (request.getAttribute("error_message")!=null) { %>
	<div class="alert alert-danger">

       <center><strong> <%=(String)request.getAttribute("error_message") %></strong> </center> 

    </div>
<% } %>

<div class="login-box">
	<form class="login" method="POST" action="userLoginController.jsp">
		<h2 class="form-signin-heading text-center">Σύνδεση χρήστη ΜΑΔΚΑΕΣ</h2>

		<label for="insertUsername">Username</label> 
		<input type="text" name="username" id="insertUsername" class="form-control" placeholder="Εισάγετε username" required>
		<label for="insertPassword">Password</label>
		<input type="password" name="password" id="insertPassword" class="form-control" placeholder="Εισάγετε password" required autocomplete="off">

		<button class="btn btn-lg" type="submit" style="background-color: #346eeb; color: white;">Σύνδεση <a href="userLoginController.jsp"></a> </button>
        <br>
        <br>
        <br>
        Δεν έχετε λογαριασμό; Δημιουργήστε <a href="userRegister.jsp">εδώ</a>
	</form>
	<div class="alert alert-info">
		<strong>test for logged: </strong>						
			<ul>
				<li>username: kpram</li>
				<li>password: 9999</li>
			</ul>
	</div>


</div>


 

<%@include file="components\footer.jsp" %>


	</body>
</html>
