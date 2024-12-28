<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>




<%
// Getting the reference parameters from the form.
Integer incomeTypeID = Integer.parseInt(request.getParameter("IncomeTypeID"));
String incomeTypeName = request.getParameter("IncomeTypeName");
String incomeTypeALE = request.getParameter("ALE");



// If page is called directly from url (not via editIncomeType.jsp), then all parameters will be null & errorpage.jsp will come up! 
if (incomeTypeName == null && incomeTypeALE == null) {
    throw new Exception("Δεν έχουν εισαχθεί δεδομένα σε ολα τα υποχρεωτικά πεδία, παρακαλώ συμπληρώστε ξανά στη <a href='editIncomeType.jsp'>φόρμα επεξεργασίας του τύπου εσόδου</a>");
}



// convert variables to UTF-8 to support Greek (GR) characters input
if (incomeTypeName != null) {
    incomeTypeName = new String(incomeTypeName.getBytes("ISO-8859-1"), "UTF-8");
}




// variables conditional check 
int countErrors = 0;
List<String> errorsFound = new ArrayList<String>();

if (incomeTypeName == null || incomeTypeName.length() > 150 || incomeTypeName.equals("")) {
    errorsFound.add("Παρακαλώ εισάγετε συντομευμένο όνομα τύπου εσόδου");
    countErrors++;
}






// Part if there are errors (at least 1) 
// If there is an error in form data, then add an attribute (with name errorMessage) to request & forward to edit form.
if (countErrors > 0) {
    request.setAttribute("errorMessage", "Form has " + (countErrors == 1 ? "1 error!" : countErrors + " errors!"));
%>
    <jsp:forward page="editIncomeType.jsp?incometypeID=<%= incometypeOnEdit.getIncomeTypeID() %>"/>
<%
    return;
}else{




// Part if there are NO errors 
// Update income type details from user's input (form data).
IncomeType incomeTypeUpdate = new IncomeType(incomeTypeID, incomeTypeName, incomeTypeALE);
IncomeTypeService itService = new IncomeTypeService();
itService.updateIncomeType(incomeTypeUpdate);

request.setAttribute("successMessage", "Το είδος εσόδου με όνομα " + incomeTypeUpdate.getIncomeTypeName() + " ενημερώθηκε επιτυχώς!");
%>

<jsp:forward page="listIncomeTypes.jsp"/>


<%
}
%>
