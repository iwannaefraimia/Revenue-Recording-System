<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>



<%
// Getting the reference parameters from the form.
String aleNum = request.getParameter("ALENumber");
String aleDescr = request.getParameter("ALEDescr");
String oldKAE = request.getParameter("oldKAE");




// If page is called directly from url (not via editALE.jsp), then all parameters will be null & errorpage.jsp will come up! 
if (aleNum == null && aleDescr == null) {
    throw new Exception("Δεν έχουν εισαχθεί δεδομένα σε ολα τα υποχρεωτικά πεδία, παρακαλώ συμπληρώστε ξανά στη <a href='editALE.jsp'>φόρμα επεξεργασίας του Λογαριασμού</a>");
}




// convert variables to UTF-8 to support Greek (GR) characters input
if (aleDescr != null) {
    aleDescr = new String(aleDescr.getBytes("ISO-8859-1"), "UTF-8");
}





// variables conditional check 
int countErrors = 0;
List<String> errorsFound = new ArrayList<String>();

if (aleNum == null || aleNum.length() != 10) {
    errorsFound.add("Παρακαλώ εισάγετε το (επίσημο) όνομα του νέου Λογαριασμού");
    countErrors++;
}

if (aleDescr == null || aleDescr.length() >500) {
    errorsFound.add("Παρακαλώ εισάγετε πλήρη περιγραφή του λογαριασμού");
    countErrors++;
}




// Part if there are errors (at least 1) 
// If there is an error in form data, then add an attribute (with name errorMessage) to request & forward to edit form.
if (countErrors > 0) {
    request.setAttribute("errorMessage", "Form has " + (countErrors == 1 ? "1 error!" : countErrors + " errors!"));
%>
    <jsp:forward page="editALE.jsp"/>
<%
    return;
}else{






// Part if there are NO errors 
// Update ALE details from user's input (form data).
ALE aleUpdate = new ALE(aleNum, aleDescr, oldKAE);
ALEService aleService = new ALEService();
aleService.updateALE(aleUpdate);

request.setAttribute("successMessage", "Ο ΑΛΕ με αριθμό " + aleUpdate.getALENum() + " ενημερώθηκε επιτυχώς!");
%>

<jsp:forward page="listALEs.jsp"/>

<%
}
%>
