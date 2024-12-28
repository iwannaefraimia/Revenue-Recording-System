<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>





<%
// Getting the reference parameters from the form.
String accNum = request.getParameter("AccountNumber");
String accName = request.getParameter("AccountName");
String accIBAN = request.getParameter("AccountIBAN");
String accDescr = request.getParameter("AccountDescr");



// If page is called directly from url (not via newAccount.jsp), then all parameters will be null & errorpage.jsp will come up! 
if (accNum == null && accName == null && accIBAN == null) {
    throw new Exception("Δεν έχουν εισαχθεί δεδομένα σε ολα τα υποχρεωτικά πεδία, παρακαλώ συμπληρώστε ξανά στη <a href='newAccount.jsp'>φόρμα εισαγωγής του νέου Λογαριασμού</a>");
}



// convert variables to UTF-8 to support Greek (GR) characters input
if (accName != null) {
    accName = new String(accName.getBytes("ISO-8859-1"), "UTF-8");
}

if (accDescr != null) {
    accDescr = new String(accDescr.getBytes("ISO-8859-1"), "UTF-8");
}



// variables conditional check 
int countErrors = 0;
List<String> errorsFound = new ArrayList<String>();

if (accNum == null || accNum.length() > 10 || accNum.equals("")) {
    errorsFound.add("Παρακαλώ εισάγετε τον (συντομευμένο) Αριθμό του νέου Λογαριασμού");
    countErrors++;
}

if (accName == null || accName.length() > 100 || accName.equals("")) {
    errorsFound.add("Παρακαλώ εισάγετε το (επίσημο) όνομα του νέου Λογαριασμού");
    countErrors++;
}

if (accIBAN == null || accIBAN.length() != 27 || accIBAN.equals("")) {
    errorsFound.add("Παρακαλώ εισάγετε το IBAN νέου Λογαριασμού (μορφή: GRxxxxxxxxxxxxxx, δηλαδή GR και 25 ψηφία)");
    countErrors++;
}


%>




<!DOCTYPE html>
<html>

<head>

    <title>Omadiki5 - Αποτελέσματα εγγραφής νέου Λογαριασμού</title>

<%@include file="components\header.jsp" %>

<%@include file="components\navbar.jsp" %>

</head>

<body class="d-flex flex-column">



<!-- login guard (needs an extra - blind - bracket at the end!) -->
<%@include file="components\loginGuard.jsp" %>





<!-- Part if there are NO errors -->
<% 
Account newAccount = new Account(accNum, accName, accIBAN, accDescr);
AccountService accService = new AccountService();


// create new account record from the form data
if (countErrors == 0) { 

  try {

accService.insertAccount(newAccount);

} catch (Exception e) {
    e.printStackTrace();
    errorsFound.add("Παρουσιάστηκε σφάλμα κατά την εγγραφή του νέου Λογαριασμού");
    countErrors++;
}

request.setAttribute("successMessage", "Ο λογαριασμός με αριθμό " + newAccount.getAccNum() + " καταχωρήθηκε επιτυχώς!");
%>

<jsp:forward page="listAccounts.jsp"/>





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
        <a href="newAccount.jsp" class="btn btn-info btn-primary">
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
