<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>




<%

// Gets the username from session (in loginGuard.jsp)
String username = (String)session.getAttribute("username");

%>





<!DOCTYPE html>
<html lang="en">

    <head>
		
<%@include file="components\header.jsp" %>

		<title>Omadiki5 - Επεξεργασία στοιχείων χρήστη</title>

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
	
	<body class="d-flex flex-column" style="padding-bottom: 77px; padding-top: 110px;">

<%@include file="components\navbar.jsp" %>

<!-- login guard, needs extra bracket at the end to close loop -->
<%@include file="components\loginGuard.jsp" %>


		<div class="container theme-showcase" role="main">

			<!-- Page Title -->
			<div class="page-header">
				<h1>Επεξεργασία στοιχείων χρήστη</h1>
            </div>

<%
	if (request.getAttribute("errorMessage") != null) {	
%>				
			<div class="row">
				<div class="col-xs-12">

					<div class="alert alert-danger">
						<%=(String)request.getAttribute("errorMessage") %>
					</div>

				</div>
			</div>
<%
	}			
%>
            
            <div class="row">
                    
                <div class="col-xs-12">

                    <form class="form-horizontal" method="POST" action="userDetailsUpdate.jsp">
                    
                        <div class="form-group">
                            <label for="inputUsername" class="col-sm-2 control-label">Username</label>
                            <div class="col-sm-10">
                                <input readonly value="<%= authenticatedUser.getUsername() %>" type="text" name="username" class="form-control" id="inputUsername" placeholder="Όνομα Χρήστη (username)">
                            </div>
                        </div>
                                            
                        <div class="form-group">
                            <label for="inputFullname" class="col-sm-2">Ονοματεπώνυμο</label>
                            <div class="col-sm-10">
                                <input value="<%= authenticatedUser.getFullname() %>" type="text" name="fullname" class="form-control" id="inputFullame" placeholder="πχ:  Νικολάου Γεώργιος" title="Πλήρες ονοματεπώνυμο με min 5 χαρακτήρες (πχ:  Νικολάου Γεώργιος). ΠΡΟΣΟΧΗ! Το παλιό όνομα θα αλλάξει σε αυτό!">
                            </div>
                        </div>
    
                        <div class="form-group">
                            <label for="inputEmail" class="col-sm-2 control-label">Email</label>
                            <div class="col-sm-10">
                                <input value="<%= authenticatedUser.getEmail() %>" type="text" name="email" class="form-control" id="inputEmail" placeholder="πχ:  emailowner@mailservice.gr" title="Εισάγετε νέο email επικοινωνίας. ΠΡΟΣΟΧΗ! Το παλιό email θα αλλάξει σε αυτό & εκεί θα αποστέλλονται πλέον οι ειδοποιήσεις!">
                            </div>
                        </div>
    
                        <div class="form-group">
                            <label for="inputPhone" class="col-sm-2 control-label">Τηλέφωνο</label>
                            <div class="col-sm-10">
                                <input value="<%= authenticatedUser.getPhone() %>" type="text" name="phone" class="form-control" id="inputPhone" placeholder="πχ:  69xxxxxxxx" title="Αριθμός τηλεφώνου με ακριβώς 10 χαρακτήρες (πχ:  69xxxxxxxx)">
                            </div>
                        </div>
    
                        <div class="form-group">
                            <div class="col-sm-10 col-sm-offset-2">
                                <span style="color: red">ΠΡΟΣΟΧΗ! </span> Για να δείτε τα ενημερωμένα στοιχεία σας, θα πρέπει να κάνετε logout & νέο login!
                            </div>
                        </div>

		                <!-- action buttons -->
                        <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-9">
                            <button type="submit" class="btn btn-success"><span class="glyphicon glyphicon-ok"></span> Ενημέρωση στοιχείων χρήστη</button> 
                            <a href="index.jsp" class="btn btn-default"><span class="glyphicon glyphicon-remove"></span> Πίσω στη βασική οθόνη</a>
                            </div>
                        </div>					

                    </form>


                </div>

            </div>
			
		</div>
		<!-- /container -->


<%@include file="components\footer.jsp" %>

    </body>
</html>



<!-- Extra bracket } to close the loginGuard loop -->
<% 
} 
%>
