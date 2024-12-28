<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>


<%
String aleNum = request.getParameter("aleNum");
ALEService aleService = new ALEService();
ALE aleOnEdit = aleService.findALE(aleNum);


// Null error check 
if (aleOnEdit == null) {
    request.setAttribute("errorMessage", "Ο ΑΛΕ " + aleOnEdit + " δεν βρέθηκε!");
%>

<jsp:forward page="listALEs.jsp"/>

<%
return;
}else{
%>







<!DOCTYPE html>
<html lang="en">
	<head>        
		<title>Omadiki5 - Επεξεργασία ΑΛΕ</title>

<%@include file="components\header.jsp" %>

	</head>

	
	<body class="d-flex flex-column">


<!-- login guard (at the end of the body, an extra bracket needed to close the include-file loop!) -->
<%@include file="components\loginGuard.jsp" %>	


		<div class="container theme-showcase" role="main">

			<!-- Page Title -->
			<div class="page-header">
				<h1>Επεξεργασία ΑΛΕ εσόδων</h1>
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

<%
if (request.getAttribute("successMessage") != null) {	
%>				
			<div class="row">
				<div class="col-xs-12">

					<div class="alert alert-success">
						<%=(String)request.getAttribute("successMessage") %>
					</div>

				</div>
			</div>
<%
}			
%>



			<div class="row">
				<div class="col-xs-12">

					<form class="form-horizontal" method="POST" action="editALEController.jsp">
						
						<!-- ALE number -->
						<div class="form-group">
							<label for="ALENumber" class="col-sm-3 control-label main-label">Κωδ. ΑΛΕ: </label>
							<div class="col-sm-7">
							<input readonly value="<%= aleOnEdit.getALENum() %>" type="text" name="ALENumber" id="ALENumber" class="form-control" 
							title="Τροποποιήστε τον κωδικό αριθμό του ΑΛΕ (όπως κωδικοποιήθηκε από το ΓΛΚ)">
							</div>
						</div>

						<!-- ALE description -->
						<div class="form-group">
							<label for="ALEDescr" class="col-sm-3 control-label main-label">Όνομα ΑΛΕ: </label>
							<div class="col-sm-7">
							<input value="<%= aleOnEdit.getALEDescr() %>" type="text" name="ALEDescr" id="ALEDescr" class="form-control" 
							title="Τροποποιήστε το όνομα του ΑΛΕ (όπως κωδικοποιήθηκε από το ΓΛΚ)">
							</div>
						</div>

						<!-- old KAE -->
						<div class="form-group">
							<label for="oldKAE" class="col-sm-3 control-label main-label">Κωδ. παλιού ΚΑΕ: </label>
							<div class="col-sm-7">
							<input value="<%= aleOnEdit.getALEOldKAE() %>" type="text" name="oldKAE" id="oldKAE" class="form-control" 
							title="Εισάγετε τον κωδικό (ή κωδικούς) του παλιού ΚΑΕ (αν υπάρχουν), τον οποίο αντικατέστησε ο ΑΛΕ αυτός">
							</div>
						</div>

						<!-- buttons -->
						<div class="form-group">
							<div class="col-sm-offset-3 col-sm-9">
								<button type="submit" class="btn btn-success"><span class="glyphicon glyphicon-ok"></span> Οριστικοποίηση</button> 
								<button type="button" class="btn btn-danger" onclick="closePopup()"><span class="glyphicon glyphicon-remove"></span> Ακύρωση & κλείσιμο</button>
							</div>
						</div>					

					</form>
				</div>
			</div>
		</div>



<!-- the last bracket } seems stand-alone, but it completes the one in loginGuard! -->
<% 
}
} 
%>

	</body>
</html>


<script>
	function closePopup() {
		window.close();
	}
</script>
