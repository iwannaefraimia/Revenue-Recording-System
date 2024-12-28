<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="omadiki5.*"%>
<%@ page errorPage="error.jsp"%>



<%
String fullname = request.getParameter("fullname");
String email = request.getParameter("email");
String phone = request.getParameter("phone");
String username = request.getParameter("username");
String password = request.getParameter("password");
String confirm = request.getParameter("confirm");
String terms = request.getParameter("terms");

int countErrors = 0;
%>



<!DOCTYPE html>
<html lang="en">
	<head>        
		<title>Εγγραφή νέου χρήστη στο Σύστημα Εσόδων (ΜΑΔΚΑΕΣ)</title>

<%@include file="components\header.jsp" %>

    </head>


    <body class="d-flex flex-column" style="padding-bottom: 77px; padding-top: 110px;">

<%@include file="components\navbar.jsp" %>

        <div class="container theme-showcase" role="main">



<!-- Converting greek characters to readable -->
<% 
if (fullname != null) {
	fullname = new String(fullname.getBytes("ISO-8859-1"), "UTF-8");
   }
%>




<!-- Cconstraints check -->
<% 
if (fullname == null || fullname.length() < 5) {
    countErrors++;
}

if (phone == null || phone.length() != 10) {
    countErrors++;
}

if (username == null || username.length() < 5) {
    countErrors++;
}

if (password == null || password.length() < 8) {
    countErrors++;
}

if (confirm == null || !confirm.equals(password)) {
    countErrors++;
}

if (terms == null) {
    countErrors++;
}
%>


<!-- Case of NO errors in registration form -->
<% if (countErrors == 0) { 
	User user = new User(username, password, fullname, email, phone);
	UserDAO userDaoObject = new UserDAO();
	try {
        userDaoObject.register(user);
     } catch (Exception e) { 
        request.setAttribute("message", e.getMessage());
     }
	 if (request.getAttribute("message") != null) { 
%>

		    <div class="alert alert-danger text-center" role="alert"><%=(String)request.getAttribute("message") %></div>
                <a href="userRegister.jsp" type="button" class="btn" role="button" style="background-color: #346eeb; color: white"> <span class="glyphicon glyphicon-chevron-left"></span> Πίσω στη φόρμα</a>




<%} else {
%>

        <!-- Page Title -->
			<div class="page-header">
				<h1>Στοιχεία λογαριασμού ΜΑΔΚΑΕΣ</h1>
			</div>
			<form class="form-horizontal">
                <div class="alert alert-success" role="alert">Η δημιουργία του λογαριασμού πραγματοποιήθηκε με επιτυχία!</div>
                <ul class="list-inline">
                    <li><strong>Ονοματεπώνυμο: </strong><%=fullname%></li>
                </ul>
                <ul class="list-inline">
                    <li><strong>Email: </strong><%=email%></li>
                </ul>
                <ul class="list-inline">
                    <li><strong>Τηλέφωνο: </strong><%=phone%></li>
                </ul>
                <ul class="list-inline">
                    <li><strong>Username: </strong><%=username%></li>
                </ul>
            </form>

		</div>
		<!-- /container -->



<!-- Case of errors found in registration form -->
<% } }else { 
int counter = 0;
%>

        <!-- Page Title -->
        <div class="page-header">
			<h1>Η φόρμα υποβολής έχει σφάλματα</h1>
		</div>
		<form class="form-horizontal">
            <div class="alert alert-danger" role="alert">

<% 
if (fullname == null || fullname.length() < 5) { 
counter++;
%>
                <li><%=counter %>. Το ονοματεπώνυμο σας πρέπει να αποτελείται από τουλάχιστον 5 χαρακτήρες </li>
<% 
}

if (phone == null || phone.length() != 10) { 
counter++;
%>
                <li><%=counter %>. Το τηλέφωνο πρέπει να αποτελείται από 10 ψηφία ακριβώς. </li>
<% 
}

if (username == null || username.length() < 5) { 
counter++;
%>
                <li><%=counter %>. Το όνομα χρήστη πρέπει να αποτελείται από τουλάχιστον 5 χαρακτήρες </li>
<% 
}

if (password == null|| password.length() < 8) { 
counter++;
%>
                <li><%=counter %>. Ο κωδικός πρέπει να αποτελείται από τουλάχιστον 8 χαρακτήρες </li>
<%
}

if (confirm == null || !confirm.equals(password)) { 
counter++;
%>
                <li><%=counter %>. Οι κωδικοί δεν ταυτίζονται </li>
<% 
}

if (terms == null) { 
counter++;
%>
                <li><%=counter %>. Δεν συμφωνήσατε σε όρους και προϋποθέσεις </li>
<% 
}
%>

            </div>
            <div class="container">
                <a href="userRegister.jsp" class="btn" style="background-color: #346eeb; color: white">
                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> Πίσω στη φόρμα</a>
            </div>

        </form>
		<!-- /container -->
<% 
}
%>
    

<%@include file="components\footer.jsp" %>


	</body>
</html>

