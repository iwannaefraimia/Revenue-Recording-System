<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>





<%
// Getting the reference parameters from the form.
String incomeTypeName = request.getParameter("IncomeTypeName");
String incomeTypeALE = request.getParameter("ALE");





// If page is called directly from url (not via newAccount.jsp), then all parameters will be null & errorpage.jsp will come up! 
if (incomeTypeName == null && incomeTypeALE == null) {
    throw new Exception("Δεν έχουν εισαχθεί δεδομένα σε ολα τα υποχρεωτικά πεδία (Όνομα είδους εσόδου & συνδεδεμένος ΑΛΕ), παρακαλώ συμπληρώστε ξανά στη <a href='newIncomeTypes.jsp'>φόρμα εισαγωγής της νέας κατηγορίας εσόδου</a>");
}




// convert variables to UTF-8 to support Greek (GR) characters input
if (incomeTypeName != null) {
  incomeTypeName = new String(incomeTypeName.getBytes("ISO-8859-1"), "UTF-8");
}




// variables conditional check 
int countErrors = 0;
List<String> errorsFound = new ArrayList<String>();

if (incomeTypeName == null || incomeTypeName.length() > 10 || incomeTypeName.equals("")) {
    errorsFound.add("Παρακαλώ εισάγετε συντομευμένο όνομα του νέου είδους εσόδου");
    countErrors++;
}

if (incomeTypeALE == null || incomeTypeALE.equals("")) {
  errorsFound.add("Παρακαλώ εισάγετε συνδεδεμένο ΑΛΕ");
  countErrors++;
}

%>




<!DOCTYPE html>
<html>

<head>

    <title>Omadiki5 - Αποτελέσματα εγγραφής νέου είδους εσόδου</title>

<%@include file="components\header.jsp" %>

<%@include file="components\navbar.jsp" %>

</head>

<body class="d-flex flex-column">



<!-- login guard (needs an extra - blind - bracket at the end!) -->
<%@include file="components\loginGuard.jsp" %>





<!-- Part if there are NO errors -->
<% 
IncomeType newIncomeType = new IncomeType(incomeTypeName, incomeTypeALE);
IncomeTypeService itService = new IncomeTypeService();



if (countErrors == 0) { 

  try {

    itService.insertIncomeType(newIncomeType);

} catch (Exception e) {
    e.printStackTrace();
    errorsFound.add("Παρουσιάστηκε σφάλμα κατά την εγγραφή του νέου Λογαριασμού");
    countErrors++;
}

request.setAttribute("successMessage", "Το είδος εσόδου με όνομα " + newIncomeType.getIncomeTypeName() + " καταχωρήθηκε επιτυχώς!");
%>

<jsp:forward page="listIncomeTypes.jsp"/>





<!-- Part if there are errors (at least 1) -->
<%
}else{
%> 
      <div class="page-header">
        <h1>Υπάρχουν λάθη στη φόρμα εισαγωγής!</h1>
      </div>

      <div class="row">
        <div class="col-xs-12">
          <div class="alert alert-danger">
            <ol>
<% for (String error : errorsFound) { %>
              <li><%=error %></li>
<% } %>
            </ol>
          </div>
        </div>
      </div>

      <div>
        <a href="newIncomeTypes.jsp" class="btn btn-info btn-primary">
          <span class="glyphicon glyphicon-menu-left"></span> Πίσω στη φόρμα εισαγωγής</a>
      </div>


<% 
} 
%>

<%@include file="components\footer.jsp" %>



<!-- extra - blind - bracket for loginGuard include! -->
<% 
}
%>

    </body>
</html>
