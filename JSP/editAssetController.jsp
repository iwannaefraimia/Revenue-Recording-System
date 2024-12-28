<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page errorPage="errorpage.jsp" %>




<%
// Getting the reference parameters from the form.

    String assetIDStr = request.getParameter("AssetID");
    int assetID = -1; 
    if (assetIDStr != null && assetIDStr.matches("\\d+")) {
assetID = Integer.parseInt(assetIDStr);
    }

String assetName = request.getParameter("AssetName");

int assetCatID = Integer.parseInt(request.getParameter("AssetCat"));

BigDecimal assetTimima = new BigDecimal(request.getParameter("AssetTotalTimima"));

String assetDescr = request.getParameter("AssetDescr");








// If page is called directly from url (not via editAsset.jsp), then all parameters will be null & errorpage.jsp will come up! 
if (assetName == null && assetTimima == BigDecimal.ZERO) {
    throw new Exception("Δεν έχουν εισαχθεί δεδομένα σε ολα τα υποχρεωτικά πεδία, παρακαλώ συμπληρώστε ξανά στη φόρμα επεξεργασίας του Π/Σ");
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

if (assetName == null || assetName.length() > 150) {
    errorsFound.add("Παρακαλώ εισάγετε το όνομα του Π/Σ");
    countErrors++;
}

if (assetTimima == null || assetTimima.compareTo(BigDecimal.ZERO) <= 0) {
    errorsFound.add("Παρακαλώ εισάγετε το ποσό της συνολικής αξίας του Π/Σ");
    countErrors++;
}




// Part if there are errors (at least 1) 
// If there is an error in form data, then add an attribute (with name errorMessage) to request & forward to edit form.
if (countErrors > 0) {
    request.setAttribute("errorMessage", "Form has " + (countErrors == 1 ? "1 error!" : countErrors + " errors!"));
%>
    <jsp:forward page="editAsset.jsp?AssetID=<%= assetOnEdit.getAssetID() %>"/>
<%
    return;
}else{




// Part if there are NO errors 
// Update Asset details from user's input (form data).
Asset assetUpdate = new Asset(assetID, assetName, assetDescr, assetTimima, assetCatID);
AssetService aService = new AssetService();
aService.updateAsset(assetUpdate);

// request.setAttribute("successMessage", "Το Π/Σ με όνομα " + assetUpdate.getAssetName() + " ενημερώθηκε επιτυχώς!");
%>

<jsp:forward page="index.jsp"/>

<%
}
%>
