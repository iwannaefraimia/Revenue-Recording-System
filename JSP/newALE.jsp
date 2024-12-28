<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>


<%

ALEService aleService = new ALEService();
List<ALE> ales = aleService.getALEs();

%>






<!DOCTYPE html>
<html lang="en">
	<head>        
		<title>Omadiki5 - Εγγραφή νέου ΑΛΕ</title>

<%@include file="components\header.jsp" %>

	</head>

	
	<body class="d-flex flex-column">


<!-- login guard (it needs an extra bracket at the end to close the loop) -->
<%@include file="components\loginGuard.jsp" %>


		<div class="container theme-showcase" role="main">

			<!-- Page Title -->
			<div class="page-header">
				<h1>Εγγραφή νέου ΑΛΕ εσόδων</h1>
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

					<form class="form-horizontal" method="POST" action="newALEController.jsp">
						
						<!-- ALE number -->
						<div class="form-group">
							<label for="ALENumber" class="col-sm-3 control-label main-label">Κωδ. ΑΛΕ: </label>
							<div class="col-sm-7">
							<input type="text" name="ALENumber" id="ALENumber" class="form-control" placeholder="Εισάγετε τον κωδικό αριθμό του νέου ΑΛΕ" title="Εισάγετε τον κωδικό αριθμό του νέου ΑΛΕ (όπως κωδικοποιήθηκε από το ΓΛΚ)">
							</div>
						</div>

						<!-- ALE description -->
						<div class="form-group">
							<label for="ALEDescr" class="col-sm-3 control-label main-label">Όνομα ΑΛΕ: </label>
							<div class="col-sm-7">
							<input type="text" name="ALEDescr" id="ALEDescr" class="form-control" placeholder="Εισάγετε το όνομα (περιγραφή) του νέου ΑΛΕ" title="Εισάγετε το όνομα του νέου ΑΛΕ (όπως κωδικοποιήθηκε από το ΓΛΚ)">
							</div>
						</div>

						<!-- old KAE -->
						<div class="form-group">
							<label for="oldKAE" class="col-sm-3 control-label main-label">Κωδ. παλιού ΚΑΕ: </label>
							<div class="col-sm-7">
							<input type="text" name="oldKAE" id="oldKAE" class="form-control" placeholder="Εισάγετε τον κωδικό του παλιού ΚΑΕ" title="Εισάγετε τον κωδικό του παλιού ΚΑΕ (αν υπάρχει), τον οποίο αντικατέστησε ο νέος ΑΛΕ">
							</div>
						</div>



						<!-- buttons -->
						<div class="form-group">
							<div class="col-sm-offset-3 col-sm-9">
								<button type="submit" class="btn btn-success"><span class="glyphicon glyphicon-ok"></span> Δημιουργία</button> 
								<button type="reset" class="btn btn-warning"><span class="glyphicon glyphicon-flash"></span> Αρχικοποίηση (reset form)</button>
								<button type="button" class="btn btn-danger" onclick="closePopup()"><span class="glyphicon glyphicon-floppy-remove"></span> Ακύρωση & κλείσιμο</button>
							</div>
						</div>					

					</form>
				</div>
			</div>
		</div>


<!-- this last } seems stand-alone, but it completes the one in loginGuard! -->
<% } %>


	</body>
</html>



<!-- JS script for deletion confirmation process on 2 steps -->
<script>


    function closePopup() {
      window.close();
    }


</script>
