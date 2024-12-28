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



// If page is called directly from url (not via editAccount.jsp), then all parameters will be null & errorpage.jsp will come up! 
if (accName == null && accIBAN == null) {
    throw new Exception("Δεν έχουν εισαχθεί δεδομένα σε ολα τα υποχρεωτικά πεδία, παρακαλώ συμπληρώστε ξανά στη <a href='editAccount.jsp'>φόρμα επεξεργασίας του Λογαριασμού</a>");
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

if (accName == null || accName.length() > 200) {
    errorsFound.add("Παρακαλώ εισάγετε το (επίσημο) όνομα του νέου Λογαριασμού");
    countErrors++;
}

if (accIBAN == null || accIBAN.length() != 27) {
    errorsFound.add("Παρακαλώ εισάγετε το IBAN νέου Λογαριασμού (μορφή: GRxxxxxxxxxxxxxx, δηλαδή GR και 25 ψηφία)");
    countErrors++;
}

if (accDescr == null || accDescr.length() > 1000) {
    errorsFound.add("Παρακαλώ εισάγετε πλήρη περιγραφή του λογαριασμού");
    countErrors++;
}





// Part if there are errors (at least 1) 
// If there is an error in form data, then add an attribute (with name errorMessage) to request & forward to edit form.
if (countErrors > 0) {
    request.setAttribute("errorMessage", "Form has " + (countErrors == 1 ? "1 error!" : countErrors + " errors!"));
%>
    <jsp:forward page="editAccount.jsp"/>
<%
    return;
}else{




// Part if there are NO errors 
// Update Account details from user's input (form data).
Account accUpdate = new Account(accNum, accName, accIBAN, accDescr);
AccountService accService = new AccountService();
accService.updateAccount(accUpdate);

request.setAttribute("successMessage", "Ο λογαριασμός με αριθμό " + accUpdate.getAccNum() + " ενημερώθηκε επιτυχώς!");
%>

<jsp:forward page="listAccounts.jsp"/>

<%
}
%>
