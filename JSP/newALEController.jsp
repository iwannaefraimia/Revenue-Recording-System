<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>





<%
// Getting the reference parameters from the form.
String aleNum = request.getParameter("ALENumber");
String aleDescr = request.getParameter("ALEDescr");
String oldKAE = request.getParameter("oldKAE");





// If page is called directly from url (not via newAccount.jsp), then all parameters will be null & errorpage.jsp will come up! 
if (aleNum == null && aleDescr == null) {
    throw new Exception("Δεν έχουν εισαχθεί δεδομένα στα υποχρεωτικά πεδία (Αριθμός & περιγραφή ΑΛΕ), παρακαλώ συμπληρώστε ξανά στη <a href='newALE.jsp'>φόρμα εισαγωγής της νέας κατηγορίας Π/Σ</a>");
}




// convert variables to UTF-8 to support Greek (GR) characters input
if (aleNum != null) {
  aleNum = new String(aleNum.getBytes("ISO-8859-1"), "UTF-8");
}

if (aleDescr != null) {
  aleDescr = new String(aleDescr.getBytes("ISO-8859-1"), "UTF-8");
}




// variables conditional check 
int countErrors = 0;
List<String> errorsFound = new ArrayList<String>();

if (aleNum == null || aleNum.length() > 10 || aleNum.equals("")) {
    errorsFound.add("Παρακαλώ εισάγετε τον αριθμό του νέου ΑΛΕ");
    countErrors++;
}

if (aleDescr == null || aleNum.length() > 500 || aleNum.equals("")) {
  errorsFound.add("Παρακαλώ εισάγετε περιγραφή του νέου ΑΛΕ");
  countErrors++;
}

%>






<!DOCTYPE html>
<html>

<head>

    <title>Omadiki5 - Αποτελέσματα εγγραφής νέου ΑΛΕ</title>

<%@include file="components\header.jsp" %>

<%@include file="components\navbar.jsp" %>

</head>

<body class="d-flex flex-column">



<!-- login guard (needs an extra - blind - bracket at the end!) -->
<%@include file="components\loginGuard.jsp" %>





<!-- Part if there are NO errors -->
<% 
ALE newALE = new ALE(aleNum, aleDescr, oldKAE);
ALEService aleService = new ALEService();


// create new account record from the form data
if (countErrors == 0) { 

  try {

  aleService.insertALE(newALE);

} catch (Exception e) {
    e.printStackTrace();
    errorsFound.add("Παρουσιάστηκε σφάλμα κατά την εγγραφή του νέου ΑΛΕ");
    countErrors++;
}

request.setAttribute("successMessage", "Ο ΑΛΕ με όνομα " + newALE.getALENum() + " καταχωρήθηκε επιτυχώς!");
%>

<jsp:forward page="listALEs.jsp"/>





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
        <a href="newALE.jsp" class="btn btn-info btn-primary">
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
