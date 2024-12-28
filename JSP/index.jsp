<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>


<!DOCTYPE html>
<html lang="en">
	<head>        
		<meta name="description" content="3η Ατομική Άσκηση - Dashboard">
		<title>Home</title>

<%@include file="components\header.jsp" %>

	</head>
	
	<body class="d-flex flex-column" style="padding-bottom: 77px; padding-top: 110px;">


<%@include file="components\navbar.jsp" %>


<%@include file="components\loginGuard.jsp" %>
	

		<div class="container theme-showcase" role="main">

			<!-- Page Title -->
			<div class="page-header">
			 <h1> <p class="text-info"> Μ.Α.Δ.Κ.Α.Ε.Σ. - Μονάδα Αποκρατικοποιήσεων, <br> Διαχείρισης Κινητών Αξιών και Επιχειρησιακού Σχεδιασμού. </p> </br> </h1> 
			</div>



<!-- error or success message -->
<%@include file="components\messages.jsp" %>



			<div class="col-xs-12">
				<h3 style="color: rgb(40, 216, 40); text-decoration: underline;">Hints για βασικές λειτουργίες: </h3> 
				<ul>
					<li>Για τη δημιουργία νέου Εσόδου ή Περιουσιακού Στοιχείου ή παραμέτρου, επιλέξτε το μενού "Εισαγωγή νέο"</li>
					<li>Για την αναζήτηση δεδομένων για Έσοδα ή Περιουσιακά Στοιχεία & παραγωγή των αντίστοιχων reports, επιλέξτε το μενού "Αναζήτηση & Reports"</li>
					<li>Για τη διαχείριση των παραμέτρων της εφαρμογής (Λογαριασμοί, ΑΛΕ κτλ), επιλέξτε το μενού "Λίστες παραμέτρων"</li>
					<li>Για τη διαχείριση των στοιχείων σας ως χρήστης, επιλέξτε το μενού "User"</li>
				</ul>
			</div>

		</div>


<%@include file="components\footer.jsp" %>



<!-- this extra bracket } marks the end of the included loginGuard.jsp -->
<% 
}
%>



	</body>
</html>
