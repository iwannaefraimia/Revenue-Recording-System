<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page errorPage="errorpage.jsp" %>





<%
// Getting the reference parameters from the form.

    // Date katathesis (in Dimosio)
        String datekatathStr = request.getParameter("DateKatath");
        java.sql.Date datekatath = null;
        if (datekatathStr != null && !datekatathStr.isEmpty()) {
            try {
    datekatath = java.sql.Date.valueOf(datekatathStr);
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
            }
        }


        // Date katathesis (in TAIPED)
        String datetaipedStr = request.getParameter("dateTaiped");
        java.sql.Date datetaiped = null;
        if (datetaipedStr != null && !datetaipedStr.isEmpty()) {
            try {
    datetaiped = java.sql.Date.valueOf(datetaipedStr);
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
            }
        }


    // Amount
    String amountStr = request.getParameter("AmountDeposit");
    BigDecimal amount = null;
    try {
amount = (amountStr != null && !amountStr.isEmpty()) ? new BigDecimal(amountStr) : null;
    } catch (NumberFormatException e) {
    e.printStackTrace();
    }


    // Dosi
    String dosi = request.getParameter("dosi");

    // Descr
    String descr = request.getParameter("Descr");

    // SAP
    String sap = request.getParameter("SAP");

    // Account number
    String accountID = request.getParameter("Account");

    // Asset ID
        String asset = request.getParameter("Asset");
    int assetID = (asset != null && !asset.isEmpty()) ? Integer.parseInt(asset) : 0;

    // incometype ID
        String incometype = request.getParameter("IncomeType");
    int incometypeID = (incometype != null && !incometype.isEmpty()) ? Integer.parseInt(incometype) : 0;







// If page is called directly from url (not via newIncome.jsp), then all parameters will be null & errorpage.jsp will come up! 
if (datekatathStr == null && amountStr == null && dosi == null && descr == null && accountID == null && asset == null && incometype == null) {
    throw new Exception("Δεν έχουν εισαχθεί δεδομένα στα υποχρεωτικά πεδία (Ημερομηνία κατάθεσης, Ποσό, Δόση, Λογαριασμός κατάθεσης, Π/Σ, Τύπος εσόδου). Παρακαλώ συμπληρώστε ξανά στη <a href='newIncome.jsp'>φόρμα εισαγωγής του νέου εσόδου</a>");
}





// convert variables to UTF-8 to support Greek (GR) characters input
if (dosi != null) {
    dosi = new String(dosi.getBytes("ISO-8859-1"), "UTF-8");
}

if (descr != null) {
    descr = new String(descr.getBytes("ISO-8859-1"), "UTF-8");
}







// variables conditional check 
int countErrors = 0;
List<String> errorsFound = new ArrayList<String>();


if (datekatath == null || datekatath.equals("")) {
    errorsFound.add("Παρακαλώ επιλέξτε ημερομηνία κατάθεσης του εσόδου σε Λογ. του Δημοσίου");
    countErrors++;
    }

if (amount == null || amount.equals("") || amountStr.length() > 23) {
    errorsFound.add("Παρακαλώ εισάγετε το ποσό κατάθεσης του εσόδου (σε μορφή: xxx.xx EUR)");
    countErrors++;
    }

if (dosi == null || dosi.length() > 200 || dosi.equals("")) {
    errorsFound.add("Παρακαλώ εισάγετε τον αριθμό δόσης ή έτος που αφορά το έσοδο");
    countErrors++;
    }

if (descr == null || descr.length() > 2000 || descr.equals("")) {
    errorsFound.add("Παρακαλώ εισάγετε αναλυτική περιγραφή του συγκεκριμένου εσόδου, που δεν έχουν δηλωθεί στα υπόλοιπα πεδία της φόρμας (free-form)");
    countErrors++;
    }

if (sap == null || sap.length() > 20 || sap.equals("")) {
    errorsFound.add("Παρακαλώ εισάγετε τον κωδικό αναγνώρισης του εσόδου στο σύστημα SAP του ΓΛΚ");
    countErrors++;
    }

if (accountID == null || accountID.length() > 10 || accountID.equals("")) {
    errorsFound.add("Παρακαλώ επιλέξτε λογαριασμό κατάθεσης του ποσού του εσόδου");
    countErrors++;
    }
  
if (asset == null || asset.equals("")) {
    errorsFound.add("Παρακαλώ επιλέξτε Π/Σ του νέου εσόδου");
    countErrors++;
    }
  
if (incometype == null || incometype.equals("")) {
    errorsFound.add("Παρακαλώ επιλέξτε τύπο εσόδου");
    countErrors++;
    }


%>








<!DOCTYPE html>
<html>

<head>

    <title>Omadiki5 - Αποτελέσματα εγγραφής νέου εσόδου</title>

<%@include file="components\header.jsp" %>

<%@include file="components\navbar.jsp" %>

</head>


<body class="d-flex flex-column" style="padding-bottom: 77px; padding-top: 110px; margin-left: 100px;">


<!-- login guard (needs an extra - blind - bracket } at the end!) -->
<%@include file="components\loginGuard.jsp" %>



<!-- Part if there are NO errors -->
<% 
Income newIncome = new Income(datekatath, datetaiped, amount, dosi, descr, sap, accountID, assetID, incometypeID);
IncomeService iService = new IncomeService();


// create new income record from the form data
if (countErrors == 0) { 

  try {

iService.insertIncome(newIncome);

} catch (Exception e) {
    e.printStackTrace();
    errorsFound.add("Παρουσιάστηκε σφάλμα κατά την εγγραφή του νέου εσόδου");
    countErrors++;
}

request.setAttribute("successMessage", "Το έσοδο καταχωρήθηκε επιτυχώς!");
%>

<jsp:forward page="index.jsp"/>


<% if (countErrors == 0) { %>

      <!-- message for procedure -->
      <div class="row">
        <div class="col-xs-12">
          <div class="alert alert-success text-center">
            <p>Επιτυχής καταχώρηση νέου εσόδου</p>
          </div>
        </div>
      </div>







<!-- Part if there are errors (at least 1) -->

<% } else { %> 

      <!-- Page Title -->
      <div class="page-header">
        <h1>Υπάρχουν λάθη στη φόρμα εισαγωγής!</h1>
      </div>

      <!-- message for procedure -->
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
        <a href="newIncome.jsp" class="btn btn-info btn-primary">
          <span class="glyphicon glyphicon-menu-left"></span> Πίσω στη φόρμα εισαγωγής</a>
      </div>



<% 
} 
}
%>

<%@include file="components\footer.jsp" %>


<!-- extra - blind - bracket } for loginGuard include! -->
<%   }   %>

    </body>
</html>
