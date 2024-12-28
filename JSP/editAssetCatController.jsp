<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>




<%
// Getting the reference parameters from the form.
int assetcatID = Integer.parseInt(request.getParameter("AssetCatID"));
String assetcatName = request.getParameter("AssetCatName");






// If page is called directly from url (not via editAssetCat.jsp), then all parameters will be null & errorpage.jsp will come up! 
if (assetcatName == null) {
    throw new Exception("Δεν έχουν εισαχθεί δεδομένα στο υποχρεωτικό πεδίο (όνομα κατηγορίας Π/Σ), παρακαλώ συμπληρώστε ξανά στη <a href='editAssetCat.jsp'>φόρμα επεξεργασίας της κατηγορίας Π/Σ");
}




// convert variables to UTF-8 to support Greek (GR) characters input
if (assetcatName != null) {
    assetcatName = new String(assetcatName.getBytes("ISO-8859-1"), "UTF-8");
}






// variables conditional check 
int countErrors = 0;
List<String> errorsFound = new ArrayList<String>();

if (assetcatName == null || assetcatName.length() > 150) {
    errorsFound.add("Παρακαλώ εισάγετε το όνομα της κατηγορίας Π/Σ");
    countErrors++;
}






// Part if there are errors (at least 1) 
// If there is an error in form data, then add an attribute (with name errorMessage) to request & forward to edit form.
if (countErrors > 0) {
    request.setAttribute("errorMessage", "Form has " + (countErrors == 1 ? "1 error!" : countErrors + " errors!"));
%>
    <jsp:forward page="editAssetCat.jsp?AssetCatID=<%= assetcatOnEdit.getAssetCatID() %>"/>
<%
    return;
}else{




// Part if there are NO errors 
// Update Asset Category details from user's input (form data).
AssetCat acUpdate = new AssetCat(assetcatID, assetcatName);
AssetCatService acService = new AssetCatService();
acService.updateAssetCat(acUpdate);

request.setAttribute("successMessage", "Η κατηγορία Π/Σ με όνομα " + acUpdate.getAssetCatName() + " ενημερώθηκε επιτυχώς!");
%>

<jsp:forward page="listAssetCats.jsp"/>


<%
}
%>
