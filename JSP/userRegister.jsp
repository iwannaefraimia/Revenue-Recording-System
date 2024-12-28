<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>





<!DOCTYPE html>
<html lang="en">
	<head>        
		<meta name="description" content="ΜΑΔΚΑΕΣ Έσοδα - Login">
		<title>Εγγραφή νέου χρήστη στο Σύστημα Εσόδων (ΜΑΔΚΑΕΣ)</title>



<%@include file="components\header.jsp" %>



	<style>
		.container {
			max-width: 850px;
			margin: auto;
		}
		.container .form-control {
					position: relative;
					height: auto;
					-webkit-box-sizing: border-box;
					-moz-box-sizing: border-box;
					box-sizing: border-box;
					padding: 10px;
					font-size: 16px;
		}
	</style>

	</head>
	



	<body class="d-flex flex-column" style="padding-bottom: 77px; padding-top: 100px;">


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

		<h2 class="form-signin-heading text-center">Εγγραφή νέου χρήστη<br>στο Σύστημα Εσόδων της ΜΑΔΚΑΕΣ</h2>

		<div class="container theme-showcase" role="main">
			<div class="row" style="height: 20px;"></div> <!-- Empty row to seperate from heading -->
			<form action="userRegisterController.jsp" method="POST" class="form-horizontal">

				<form id="userRegistrationForm" class="form-horizontal">
					
					<div class="form-group">
						<label for="inputFullname" class="col-sm-2">Ονοματεπώνυμο</label>
						<div class="col-sm-10">
							<input type="text" name="fullname" class="form-control" id="inputFullame" placeholder="πχ:  Νικολάου Γεώργιος" title="Πλήρες ονοματεπώνυμο με min 5 χαρακτήρες (πχ:  Νικολάου Γεώργιος).">
						</div>
					</div>

					<div class="form-group">
						<label for="inputEmail" class="col-sm-2 control-label">Email</label>
						<div class="col-sm-10">
							<input type="text" name="email" class="form-control" id="inputEmail" placeholder="πχ:  emailowner@mailservice.gr">
						</div>
					</div>

					<div class="form-group">
						<label for="inputPhone" class="col-sm-2 control-label">Τηλέφωνο</label>
						<div class="col-sm-10">
							<input type="text" name="phone" class="form-control" id="inputPhone" placeholder="πχ:  69xxxxxxxx" title="Αριθμός τηλεφώνου με ακριβώς 10 χαρακτήρες (πχ:  69xxxxxxxx)">
						</div>
					</div>

					<div class="form-group">
						<label for="inputUsername" class="col-sm-2 control-label">Username</label>
						<div class="col-sm-10">
							<input type="text" name="username" class="form-control" id="inputUsername" placeholder="min 5 χαρακτήρες" title="Επιλέξτε username με min 5 χαρακτήρες">
						</div>
					</div>

					<div class="form-group">
						<label for="inputPassword" class="col-sm-2 control-label">Password</label>
						<div class="col-sm-10">
							<input type="password" name="password" class="form-control" id="inputPassword" placeholder="min 8 χαρακτήρες" title="Επιλέξτε password με min 8 χαρακτήρες">
						</div>
					</div>

					<div class="form-group">
						<label for="inputConfirm" class="col-sm-2 control-label">Repeat password</label>
						<div class="col-sm-10">
							<input type="password" name="confirm" class="form-control" id="inputConfirm" placeholder="Ξανά το password" title="Επαναλάβετε το password που πληκτρολογήσατε στο προηγούμενο πεδίο">
						</div>
					</div>



					<div class="form-group">
						<div class="col-sm-10 col-sm-offset-2">
							<div class="checkbox">
								<label>
									<input type="checkbox" name="terms"> <p class="text-primary"> </p> <strong style="color: rgb(63, 130, 192);">Έχω διαβάσει & συμφωνώ με τους όρους χρήσης</strong>
								</label>
							</div>
						</div>
					</div>

					<div class="form-group">
						<div class="col-sm-10 col-sm-offset-2">
							<span style="color: red">ΠΡΟΣΟΧΗ!<br></span> Ο λογαριασμός σας πρέπει να ενεργοποιηθεί από τον υπεύθυνο διαχείρισης του συστήματος, προκειμένου να αποκτήσετε πρόσβαση σε αυτό.
						</div>
					</div>


					<!-- form buttons -->
					<div class="form-group">
						<div class="col-sm-10 col-sm-offset-2">
							<button type="submit" class="btn btn-lg" style="background-color: #346eeb; color: white;">
								Υποβολή
							</button>
						</div>
					</div>

					<div class="form-group">
						<div class="col-sm-10 col-sm-offset-2">
							Έχετε ήδη λογαριασμό; <a href="<%=request.getContextPath()%>/omadiki5/userLogin.jsp">Σύνδεση</a> 
						</div>
					</div>

				</form>
			</form>
		</div>
 
<%@include file="components\footer.jsp" %>


	</body>
</html>
