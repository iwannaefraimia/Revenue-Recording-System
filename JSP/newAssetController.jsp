<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page errorPage="errorpage.jsp" %>





<%
// Getting the reference parameters from the form.

  //Name
  String assetName = request.getParameter("AssetName");

  //Descr
  String assetDescr = request.getParameter("AssetDescr");

  //Timima
      String assetTimimaStr = request.getParameter("AssetTotalTimima");
      BigDecimal assetTimima = null;
      try {
  assetTimima = (assetTimimaStr != null && !assetTimimaStr.isEmpty()) ? new BigDecimal(assetTimimaStr) : null;
      } catch (NumberFormatException e) {
      e.printStackTrace();
      }

  //CategoryID
      String assetCatIDStr = request.getParameter("AssetCat");
  int assetCatID = -1; 
      if (assetCatIDStr != null && assetCatIDStr.matches("\\d+")) {
        assetCatID = Integer.parseInt(assetCatIDStr);
      }







// If page is called directly from url (not via newAsset.jsp), then all parameters will be null & errorpage.jsp will come up! 
if (assetCatIDStr == null && assetName == null) {
    throw new Exception("Δεν έχουν εισαχθεί δεδομένα στα υποχρεωτικά πεδία (Όνομα & κατηροία Π/Σ). Παρακαλώ συμπληρώστε ξανά στη <a href='newAsset.jsp'>φόρμα εισαγωγής του νέου Π/Σ</a>");
}





// convert variables to UTF-8 to support Greek (GR) characters input
if (assetName != null) {
  assetName = new String(assetName.getBytes("ISO-8859-1"), "UTF-8");
}

if (assetDescr != null) {
  assetDescr = new String(assetDescr.getBytes("ISO-8859-1"), "UTF-8");
}





// variables conditional check 
int countErrors = 0;
List<String> errorsFound = new ArrayList<String>();

if (assetName == null || assetName.length() > 200 || assetName.equals("")) {
  errorsFound.add("Παρακαλώ εισάγετε το (επίσημο) όνομα του νέου Π/Σ (μέχρι 200 χαρακτήρες)");
  countErrors++;
}

if (assetDescr.length() > 2000) {
  errorsFound.add("Παρακαλώ περιορίστε την περιγραφή του Π/Σ στους 2000 χαρακτήρες");
  countErrors++;
}

if (assetCatIDStr == null || assetCatIDStr.equals("")) {
  errorsFound.add("Παρακαλώ επιλέξτε κατηγορία Π/Σ");
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



<!-- login guard (needs an extra - blind - bracket } at the end!) -->
<%@include file="components\loginGuard.jsp" %>





<!-- Part if there are NO errors -->
<% 
Asset newAsset = new Asset(assetName, assetDescr, assetTimima, assetCatID);
AssetService assetService = new AssetService();


// create new account record from the form data
if (countErrors == 0) { 

  try {

assetService.insertAsset(newAsset);

} catch (Exception e) {
    e.printStackTrace();
    errorsFound.add("Παρουσιάστηκε σφάλμα κατά την εγγραφή του νέου Π/Σ");
    countErrors++;
}

request.setAttribute("successMessage", "Το Π/Σ " + newAsset.getAssetName() + " καταχωρήθηκε επιτυχώς!");
%>

<jsp:forward page="index.jsp"/>





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
        <a href="newAsset.jsp" class="btn btn-info btn-primary">
          <span class="glyphicon glyphicon-menu-left"></span> Πίσω στη φόρμα εισαγωγής</a>
      </div>


<% 
} 
%>

<%@include file="components\footer.jsp" %>



<!-- extra - blind - bracket } for loginGuard include! -->
<% 
}
%>

    </body>
</html>
