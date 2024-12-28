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

    // Income record key ID
        String incomeIDStr = request.getParameter("incomeID");
        int incomeID = -1; 
        if (incomeIDStr != null && incomeIDStr.matches("\\d+")) {
    incomeID = Integer.parseInt(incomeIDStr);
        }


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
        String datetaipedStr = request.getParameter("DateTaiped");
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
        String assetStr = request.getParameter("Asset");
    int assetID = Integer.parseInt(assetStr);

    // incometype ID
        String incometypeStr = request.getParameter("IncomeType");
    int incometypeID = Integer.parseInt(incometypeStr);







// If page is called directly from url (not via editIncome.jsp), then all parameters will be null & errorpage.jsp will come up! 
if (datekatathStr == null && amountStr == null && dosi == null && descr == null && accountID == null && assetStr == null && incometypeStr == null) {
    throw new Exception("Δεν έχουν εισαχθεί δεδομένα στα υποχρεωτικά πεδία (Ημερομηνία κατάθεσης, Ποσό, Δόση, Λογαριασμός κατάθεσης, Π/Σ, Τύπος εσόδου). Παρακαλώ συμπληρώστε ξανά στη <a href='editIncome.jsp'>φόρμα επεξεργασίας του εσόδου</a>");
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
    
if (assetStr == null || assetStr.equals("")) {
    errorsFound.add("Παρακαλώ επιλέξτε Π/Σ του εσόδου");
    countErrors++;
    }
    
if (incometypeStr == null || incometypeStr.equals("")) {
    errorsFound.add("Παρακαλώ επιλέξτε τύπο εσόδου");
    countErrors++;
    }
    






// Part if there are errors (at least 1) 
// If there is an error in form data, then add an attribute (with name errorMessage) to request & forward to edit form.
if (countErrors > 0) {
    request.setAttribute("errorMessage", "Form has " + (countErrors == 1 ? "1 error!" : countErrors + " errors!"));
%>
    <jsp:forward page="editIncome.jsp?incomeID=<%= incomeOnEdit.getIncomeID() %>"/>
<%
    return;
}else{






// Part if there are NO errors 
// Update income details from user's input (form data).
Income editedIncome = new Income(datekatath, datetaiped, amount, dosi, descr, sap, accountID, assetID, incometypeID);
IncomeService iService = new IncomeService();
iService.updateIncome(editedIncome);

// request.setAttribute("successMessage", "Το έσοδο ενημερώθηκε επιτυχώς!");
%>

<jsp:forward page="index.jsp"/>

<%
}
%>
