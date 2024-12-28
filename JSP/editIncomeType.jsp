<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>


<%

// Variables set 
String incometypeID = request.getParameter("incometypeID");

IncomeTypeService itService = new IncomeTypeService();
IncomeType incometypeOnEdit = itService.findIncomeType(incometypeID);


ALEService aleService = new ALEService();
List<ALE> ales = aleService.getALEs();

// Sort the list based on ALE description
ales.sort(new Comparator<ALE>() {
	public int compare(ALE ale1, ALE ale2) {
		return ale1.getALEDescr().compareTo(ale2.getALEDescr());
	}
});




// Null error check 
if (incometypeOnEdit == null) {
	request.setAttribute("errorMessage", "Το είδος εσόδου " + incometypeOnEdit + " δεν βρέθηκε!");
%>

<jsp:forward page="listAssetCat.jsp"/>

<%
return;
}else{
%>






<!DOCTYPE html>
<html lang="en">
	<head>        
		<title>Omadiki5 - Επεξεργασία είδους εσόδου</title>

<%@include file="components\header.jsp" %>


	</head>

	
	<body class="d-flex flex-column">


<!-- login guard (at the end of the body, an extra bracket needed to close the include-file loop!) -->
<%@include file="components\loginGuard.jsp" %>


		<div class="container theme-showcase" role="main">

			<!-- Page Title -->
			<div class="page-header">
				<h1>Επεξεργασία είδους εσόδου</h1>
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


		</div>
			<div class="row">
				<div class="col-xs-12">

					<form class="form-horizontal" method="POST" action="editIncomeTypeController.jsp">

						<!-- incometype ID (hidden from user, only for reference on editIncomeTypeController.JSP) -->
						<div class="form-group">
							<input type="hidden" value="<%= incometypeOnEdit.getIncomeTypeID() %>" type="text" name="IncomeTypeID" id="IncomeTypeID" class="form-control">
						</div>

						<!-- income type category name -->
						<div class="form-group">
							<label for="IncomeTypeName" class="col-sm-3 control-label main-label">Όνομα κατηγορίας εσόδων: </label>
							<div class="col-sm-6">
								<input value="<%= incometypeOnEdit.getIncomeTypeName() %>" type="text" name="IncomeTypeName" id="IncomeTypeName" class="form-control" title="Τροποποιήστε το όνομα του τύπου εσόδου">
							</div>
						</div>


						<!-- ALE -->
						<div class="form-group">
							<label for="ALE" class="col-sm-3 control-label main-label">Συνδεδεμένο ΑΛΕ: </label>
							<div class="col-sm-6">
								<select id="ALE" name="ALE" class="form-control" 
								title="Επιλέξτε ΑΛΕ, με τον οποίο συνδέεται το είδος εσόδου που εισάγετε">
<% for (ALE ale : ales) { %>
								<option value="<%= ale.getALENum() %>"<%= (incometypeOnEdit.getIncomeTypeALE().equals(ale.getALENum())) ? "selected" : "" %>><%= ale.getALEDescr() %>
								</option>
<% } %>
								</select>
							</div>
							<div class="col-sm-1">
								<button type="button" class="btn btn-warning btn-xs" 
									onclick="openPopup('newALE.jsp')" 
									data-toggle="tooltip" data-placement="top" title="Προσθήκη νέου ΑΛΕ">
									<span class="glyphicon glyphicon-plus"></span></button>
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
		</div><!-- /.container -->



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
