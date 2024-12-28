<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>





<%
// Getting the reference parameters from the form.
String assetCatName = request.getParameter("AssetCatName");




// If page is called directly from url (not via newAccount.jsp), then all parameters will be null & errorpage.jsp will come up! 
if (assetCatName == null) {
    throw new Exception("Δεν έχουν εισαχθεί δεδομένα στο υποχρεωτικό πεδίο (Όνομα κατηγορίας Π/Σ), παρακαλώ συμπληρώστε ξανά στη <a href='newAssetCat.jsp'>φόρμα εισαγωγής της νέας κατηγορίας Π/Σ</a>");
}




// convert variables to UTF-8 to support Greek (GR) characters input
if (assetCatName != null) {
  assetCatName = new String(assetCatName.getBytes("ISO-8859-1"), "UTF-8");
}





// variables conditional check 
int countErrors = 0;
List<String> errorsFound = new ArrayList<String>();

if (assetCatName == null || assetCatName.length() > 150 || assetCatName.equals("")) {
    errorsFound.add("Παρακαλώ εισάγετε το όνομα της νέας κατηγορίας Π/Σ");
    countErrors++;
}


%>






<!DOCTYPE html>
<html>

<head>

    <title>Omadiki5 - Αποτελέσματα εγγραφής νέας κατηγορίας Π/Σ</title>

<%@include file="components\header.jsp" %>

<%@include file="components\navbar.jsp" %>

</head>

<body class="d-flex flex-column">



<!-- login guard (needs an extra - blind - bracket at the end!) -->
<%@include file="components\loginGuard.jsp" %>





<!-- Part if there are NO errors -->
<% 
AssetCat newAssetCat = new AssetCat(assetCatName);
AssetCatService acService = new AssetCatService();


// create new account record from the form data
if (countErrors == 0) { 

  try {

  acService.insertAssetCat(newAssetCat);

} catch (Exception e) {
    e.printStackTrace();
    errorsFound.add("Παρουσιάστηκε σφάλμα κατά την εγγραφή της νέας κατηγορίας Π/Σ");
    countErrors++;
}

request.setAttribute("successMessage", "Η κατηγορία Π/Σ με όνομα " + newAssetCat.getAssetCatName() + " καταχωρήθηκε επιτυχώς!");
%>

<jsp:forward page="listAssetCats.jsp"/>





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
        <a href="newAssetCat.jsp" class="btn btn-info btn-primary">
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
