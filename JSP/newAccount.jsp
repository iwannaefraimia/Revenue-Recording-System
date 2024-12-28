<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>


<%

AccountService accService = new AccountService();
List<Account> accounts = accService.getAccounts();

%>






<!DOCTYPE html>
<html lang="en">
	<head>        
		<title>Omadiki5 - Εγγραφή νέου Λογαριασμού κατάθεσης εσόδων</title>

<%@include file="components\header.jsp" %>

	</head>

	
	<body class="d-flex flex-column">


<!-- login guard (it needs an extra bracket at the end to close the loop) -->
<%@include file="components\loginGuard.jsp" %>	


		<div class="container theme-showcase" role="main">

			<!-- Page Title -->
			<div class="page-header">
				<h1>Εγγραφή νέου Λογαριασμού (κατάθεσης εσόδων)</h1>
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
<%  }   %>

			<div class="row">
				<div class="col-xs-12">

					<form class="form-horizontal" method="POST" action="newAccountController.jsp">
						
						<!-- account number -->
						<div class="form-group">
							<label for="AccountNumber" class="col-sm-3 control-label main-label">Αριθμ. Λογ.: </label>
							<div class="col-sm-7">
							<input type="text" name="AccountNumber" id="AccountNumber" class="form-control" placeholder="Εισάγετε τον (συντομευμένο) αριθμό του νέου λογαριασμού" title="Εισάγετε τον αριθμό του νέου λογαριασμού (συντομευμένη μορφή, όπως χρησιμοποιείται συχνά στο ΓΛΚ)">
							</div>
						</div>

						<!-- account name -->
						<div class="form-group">
							<label for="AccountName" class="col-sm-3 control-label main-label">Όνομα Λογ.: </label>
							<div class="col-sm-7">
							<input type="text" name="AccountName" id="AccountName" class="form-control" placeholder="Εισάγετε το (επίσημο) όνομα του νέου λογαριασμού" title="Εισάγετε το όνομα του νέου λογαριασμού (όπως κωδικοποιείται από την Τράπεζα της Ελλάδος)">
							</div>
						</div>

						<!-- account IBAN -->
						<div class="form-group">
							<label for="AccountIBAN" class="col-sm-3 control-label main-label">IBAN Λογ.: </label>
							<div class="col-sm-7">
							<input type="text" name="AccountIBAN" id="AccountIBAN" class="form-control" placeholder="Εισάγετε τον IBAN του νέου λογαριασμού (μορφή: GRxxxxxxxxxxxxxx)" title="Εισάγετε τον IBAN κωδικό του νέου λογαριασμού (IBAN = International Bank Account Number), μορφής GR με άλλα 25 ψηφία">
							</div>
						</div>

						<!-- account description -->
						<div class="form-group">
							<label for="AccountDescr" class="col-sm-3 control-label main-label">Αναλυτική<br>περιγραφή Λογ.: </label>
							<div class="col-sm-7">
							<textarea name="AccountDescr" id="AccountDescr" class="form-control" rows="5" placeholder="Εισάγετε αναλυτική περιγραφή του νέου Λογαριασμού" title="Εισάγετε αναλυτική περιγραφή του νέου Λογαριασμού, δηλαδή επιπλέον στοιχεία που δεν έχουν δηλωθεί στα υπόλοιπα πεδία της φόρμας εισόδου (free-form)"></textarea>	
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


<!-- This extra bracket } exists to complete the loginGuard.jsp loop -->
<% } %>


	</body>
</html>



<!-- JS script for deletion confirmation process on 2 steps -->
<script>


    function closePopup() {
      window.close();
    }


</script>
