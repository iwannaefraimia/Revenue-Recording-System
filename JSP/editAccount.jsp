<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>


<%

// Variables set 
String accNum = request.getParameter("accNum");

AccountService accountService = new AccountService();
Account accountOnEdit = accountService.findAccount(accNum);




// Null error check 
if (accountOnEdit == null) {
    request.setAttribute("errorMessage", "Ο Λογαριασμός " + accountOnEdit + " δεν βρέθηκε!");
%>

<jsp:forward page="listAccounts.jsp"/>

<%
return;
}else{
%>





<!DOCTYPE html>
<html lang="en">
	<head>        
		<title>Omadiki5 - Επεξεργασία Λογαριασμού κατάθεσης εσόδων</title>

<%@include file="components\header.jsp" %>

	</head>

	
	
	<body class="d-flex flex-column">



<!-- login guard (at the end of the body, an extra bracket needed to close the include-file loop!) -->
<%@include file="components\loginGuard.jsp" %>	



		<div class="container theme-showcase" role="main">

			<!-- Page Title -->
			<div class="page-header">
				<h1>Επεξεργασία Λογαριασμού (κατάθεσης εσόδων)</h1>
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

<%  }  %>

		</div>
			<div class="row">
				<div class="col-xs-12">
					<form class="form-horizontal" method="POST" action="editAccountController.jsp">
						
						<!-- account number -->
						<div class="form-group">
							<label for="AccountNumber" class="col-sm-3 control-label main-label">Αριθμ. Λογ.: </label>
							<div class="col-sm-7">
							<input readonly value="<%= accountOnEdit.getAccNum() %>" type="text" name="AccountNumber" id="AccountNumber" class="form-control" 
							title="Τροποποιήστε τον αριθμό του λογαριασμού (συντομευμένη μορφή, όπως χρησιμοποιείται συχνά στο ΓΛΚ)">
							</div>
						</div>

						<!-- account name -->
						<div class="form-group">
							<label for="AccountName" class="col-sm-3 control-label main-label">Όνομα Λογ.: </label>
							<div class="col-sm-7">
							<input value="<%= accountOnEdit.getAccName() %>" type="text" name="AccountName" id="AccountName" class="form-control" placeholder="Εισάγετε το (επίσημο) όνομα του λογαριασμού" title="Εισάγετε το όνομα του λογαριασμού (όπως κωδικοποιείται από την Τράπεζα της Ελλάδος)">
							</div>
						</div>

						<!-- account IBAN -->
						<div class="form-group">
							<label for="AccountIBAN" class="col-sm-3 control-label main-label">IBAN Λογ.: </label>
							<div class="col-sm-7">
							<input value="<%= accountOnEdit.getAccIBAN() %>" type="text" name="AccountIBAN" id="AccountIBAN" class="form-control" placeholder="Εισάγετε τον IBAN του λογαριασμού (μορφή: GRxxxxxxxxxxxxxx)" title="Εισάγετε τον IBAN κωδικό του λογαριασμού (IBAN = International Bank Account Number)">
							</div>
						</div>

						<!-- account description -->
						<div class="form-group">
							<label for="AccountDescr" class="col-sm-3 control-label main-label">Αναλυτική<br>περιγραφή Λογ.: </label>
							<div class="col-sm-7">
							<textarea name="AccountDescr" id="AccountDescr" class="form-control" rows="5" placeholder="Εισάγετε αναλυτική περιγραφή του Λογαριασμού" title="Εισάγετε αναλυτική περιγραφή του Λογαριασμού, δηλαδή επιπλέον στοιχεία που δεν έχουν δηλωθεί στα υπόλοιπα πεδία της φόρμας εισόδου (free-form)"><%= accountOnEdit.getAccDescr() %></textarea>
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
