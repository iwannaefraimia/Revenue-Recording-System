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

                    <form class="form-horizontal" method="POST" action="userPswChangeUpdate.jsp">
                    
                        <div class="form-group">
                            <label for="inputUsername" class="col-sm-2 control-label">Username</label>
                            <div class="col-sm-10">
                                <input readonly value="<%= authenticatedUser.getUsername() %>" type="text" name="username" class="form-control" id="inputUsername" placeholder="Όνομα Χρήστη (username)">
                            </div>
                        </div>
                                            
                        <div class="form-group">
                            <label for="inputPassword" class="col-sm-2 control-label">Παλιό password</label>
                            <div class="col-sm-10">
                                <input type="password" name="oldPassword" class="form-control" id="inputPassword" placeholder="Παλιό (υφιστάμενο) password" title="Παλιό (υφιστάμενο) password">
                            </div>
                        </div>
                                                
                        <div class="form-group">
                            <label for="inputPassword" class="col-sm-2 control-label">Νέο password</label>
                            <div class="col-sm-10">
                                <input type="password" name="newPassword" class="form-control" id="inputPassword" placeholder="Νέο password, με min 8 χαρακτήρες" title="Επιλέξτε νέο password, με min 8 χαρακτήρες">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="inputConfirm" class="col-sm-2 control-label">Επανάληψη νέου password</label>
                            <div class="col-sm-10">
                                <input type="password" name="newPassword2" class="form-control" id="inputConfirm" placeholder="Ξανά το νέο password" title="Επαναλάβετε το νέο password που πληκτρολογήσατε">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-9">
                            <button type="submit" class="btn btn-success"><span class="glyphicon glyphicon-ok"></span> Ενημέρωση στοιχείων password</button> 
                            <a href="index.jsp" class="btn btn-default"><span class="glyphicon glyphicon-remove"></span> Πίσω στη βασική οθόνη</a>
                            </div>
                        </div>					

                    </form>


                </div>

            </div>
			
		</div> <!-- /container -->


<%@include file="components\footer.jsp" %>

    </body>
</html>



<!-- Extra bracket } to close the loginGuard loop -->
<% 
} 
%>
